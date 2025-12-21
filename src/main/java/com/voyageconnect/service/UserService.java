package com.voyageconnect.service;

import com.voyageconnect.dao.UserDAO;
import com.voyageconnect.exception.AuthenticationException;
import com.voyageconnect.exception.BusinessException;
import com.voyageconnect.model.User;
import com.voyageconnect.model.UserRole;
import com.voyageconnect.util.EmailUtil;
import com.voyageconnect.util.JPAUtil;
import com.voyageconnect.util.PasswordUtil;
import com.voyageconnect.util.ValidationUtil;

import javax.persistence.EntityManager;
import javax.persistence.EntityTransaction;
import java.util.List;
import java.util.Optional;

/**
 * Service pour la gestion des utilisateurs
 * ⚠️ TOUTES LES TRANSACTIONS SONT GÉRÉES MANUELLEMENT (pas de @Transactional)
 */
public class UserService {

    private final UserDAO userDAO = new UserDAO();

    /**
     * Inscription d'un nouvel utilisateur
     * Transaction manuelle : BEGIN -> COMMIT ou ROLLBACK
     */
    public User register(String firstName, String lastName, String email, String password) 
            throws BusinessException {
        EntityManager em = JPAUtil.getEntityManager();
        EntityTransaction tx = em.getTransaction();
        
        try {
            tx.begin();
            
            // Vérifier si l'email existe déjà
            if (userDAO.existsByEmail(em, email)) {
                throw new BusinessException("Un compte avec cet email existe déjà");
            }
            
            // Créer l'utilisateur
            User user = new User();
            user.setFirstName(firstName);
            user.setLastName(lastName);
            user.setEmail(email);
            user.setPassword(PasswordUtil.hashPassword(password));
            user.setRole(UserRole.USER);
            user.setActive(true);
            
            // Valider l'entité
            ValidationUtil.validateAndThrow(user);
            
            // Persister l'utilisateur
            userDAO.create(em, user);
            
            tx.commit();
            
            // Envoyer un email de bienvenue (hors transaction)
            EmailUtil.sendWelcomeEmail(user.getEmail(), user.getFullName());
            
            return user;
            
        } catch (Exception e) {
            if (tx.isActive()) {
                tx.rollback();
            }
            throw new BusinessException("Erreur lors de l'inscription : " + e.getMessage(), e);
        } finally {
            JPAUtil.closeEntityManager(em);
        }
    }

    /**
     * Authentification d'un utilisateur
     * Pas de transaction nécessaire (lecture seule)
     */
    public User login(String email, String password) throws AuthenticationException {
        EntityManager em = JPAUtil.getEntityManager();
        
        try {
            Optional<User> userOpt = userDAO.findByEmail(em, email);
            
            if (!userOpt.isPresent()) {
                throw new AuthenticationException("Email ou mot de passe incorrect");
            }
            
            User user = userOpt.get();
            
            if (!user.getActive()) {
                throw new AuthenticationException("Compte désactivé");
            }
            
            if (!PasswordUtil.checkPassword(password, user.getPassword())) {
                throw new AuthenticationException("Email ou mot de passe incorrect");
            }
            
            return user;
            
        } finally {
            JPAUtil.closeEntityManager(em);
        }
    }

    /**
     * Mise à jour du profil utilisateur
     * Transaction manuelle
     */
    public User updateProfile(Long userId, String firstName, String lastName, 
                              String phone, String address) throws BusinessException {
        EntityManager em = JPAUtil.getEntityManager();
        EntityTransaction tx = em.getTransaction();
        
        try {
            tx.begin();
            
            Optional<User> userOpt = userDAO.findById(em, userId);
            if (!userOpt.isPresent()) {
                throw new BusinessException("Utilisateur introuvable");
            }
            
            User user = userOpt.get();
            user.setFirstName(firstName);
            user.setLastName(lastName);
            user.setPhone(phone);
            user.setAddress(address);
            
            ValidationUtil.validateAndThrow(user);
            
            User updatedUser = userDAO.update(em, user);
            
            tx.commit();
            
            return updatedUser;
            
        } catch (Exception e) {
            if (tx.isActive()) {
                tx.rollback();
            }
            throw new BusinessException("Erreur lors de la mise à jour : " + e.getMessage(), e);
        } finally {
            JPAUtil.closeEntityManager(em);
        }
    }

    /**
     * Changement de mot de passe
     * Transaction manuelle
     */
    public void changePassword(Long userId, String oldPassword, String newPassword) 
            throws BusinessException {
        EntityManager em = JPAUtil.getEntityManager();
        EntityTransaction tx = em.getTransaction();
        
        try {
            tx.begin();
            
            Optional<User> userOpt = userDAO.findById(em, userId);
            if (!userOpt.isPresent()) {
                throw new BusinessException("Utilisateur introuvable");
            }
            
            User user = userOpt.get();
            
            // Vérifier l'ancien mot de passe
            if (!PasswordUtil.checkPassword(oldPassword, user.getPassword())) {
                throw new BusinessException("Mot de passe actuel incorrect");
            }
            
            // Mettre à jour avec le nouveau mot de passe
            user.setPassword(PasswordUtil.hashPassword(newPassword));
            userDAO.update(em, user);
            
            tx.commit();
            
        } catch (Exception e) {
            if (tx.isActive()) {
                tx.rollback();
            }
            throw new BusinessException("Erreur lors du changement de mot de passe : " + e.getMessage(), e);
        } finally {
            JPAUtil.closeEntityManager(em);
        }
    }

    /**
     * Récupère un utilisateur par ID
     */
    public User getUserById(Long userId) throws BusinessException {
        EntityManager em = JPAUtil.getEntityManager();
        
        try {
            Optional<User> userOpt = userDAO.findById(em, userId);
            if (!userOpt.isPresent()) {
                throw new BusinessException("Utilisateur introuvable");
            }
            return userOpt.get();
            
        } finally {
            JPAUtil.closeEntityManager(em);
        }
    }

    /**
     * Récupère tous les utilisateurs (ADMIN uniquement)
     */
    public List<User> getAllUsers() {
        EntityManager em = JPAUtil.getEntityManager();
        
        try {
            return userDAO.findAll(em);
        } finally {
            JPAUtil.closeEntityManager(em);
        }
    }

    /**
     * Désactive un utilisateur (ADMIN uniquement)
     * Transaction manuelle
     */
    public void deactivateUser(Long userId) throws BusinessException {
        EntityManager em = JPAUtil.getEntityManager();
        EntityTransaction tx = em.getTransaction();
        
        try {
            tx.begin();
            
            Optional<User> userOpt = userDAO.findById(em, userId);
            if (!userOpt.isPresent()) {
                throw new BusinessException("Utilisateur introuvable");
            }
            
            User user = userOpt.get();
            user.setActive(false);
            userDAO.update(em, user);
            
            tx.commit();
            
        } catch (Exception e) {
            if (tx.isActive()) {
                tx.rollback();
            }
            throw new BusinessException("Erreur lors de la désactivation : " + e.getMessage(), e);
        } finally {
            JPAUtil.closeEntityManager(em);
        }
    }
}
