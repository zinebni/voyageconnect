package com.voyageconnect.dao;

import com.voyageconnect.model.User;
import com.voyageconnect.model.UserRole;

import javax.persistence.EntityManager;
import javax.persistence.NoResultException;
import javax.persistence.TypedQuery;
import java.util.List;
import java.util.Optional;

/**
 * DAO pour l'entité User
 */
public class UserDAO extends GenericDAO<User> {

    public UserDAO() {
        super(User.class);
    }

    /**
     * Trouve un utilisateur par email
     * @param em EntityManager
     * @param email Email de l'utilisateur
     * @return Optional contenant l'utilisateur si trouvé
     */
    public Optional<User> findByEmail(EntityManager em, String email) {
        try {
            TypedQuery<User> query = em.createQuery(
                    "SELECT u FROM User u WHERE u.email = :email", User.class);
            query.setParameter("email", email);
            return Optional.of(query.getSingleResult());
        } catch (NoResultException e) {
            return Optional.empty();
        }
    }

    /**
     * Vérifie si un email existe déjà
     * @param em EntityManager
     * @param email Email à vérifier
     * @return true si l'email existe, false sinon
     */
    public boolean existsByEmail(EntityManager em, String email) {
        Long count = em.createQuery(
                "SELECT COUNT(u) FROM User u WHERE u.email = :email", Long.class)
                .setParameter("email", email)
                .getSingleResult();
        return count > 0;
    }

    /**
     * Récupère tous les utilisateurs par rôle
     * @param em EntityManager
     * @param role Rôle des utilisateurs
     * @return Liste des utilisateurs ayant ce rôle
     */
    public List<User> findByRole(EntityManager em, UserRole role) {
        TypedQuery<User> query = em.createQuery(
                "SELECT u FROM User u WHERE u.role = :role", User.class);
        query.setParameter("role", role);
        return query.getResultList();
    }

    /**
     * Récupère tous les utilisateurs actifs
     * @param em EntityManager
     * @return Liste des utilisateurs actifs
     */
    public List<User> findActiveUsers(EntityManager em) {
        TypedQuery<User> query = em.createQuery(
                "SELECT u FROM User u WHERE u.active = true", User.class);
        return query.getResultList();
    }

    /**
     * Recherche des utilisateurs par nom ou prénom
     * @param em EntityManager
     * @param searchTerm Terme de recherche
     * @return Liste des utilisateurs correspondants
     */
    public List<User> searchByName(EntityManager em, String searchTerm) {
        TypedQuery<User> query = em.createQuery(
                "SELECT u FROM User u WHERE LOWER(u.firstName) LIKE LOWER(:term) " +
                "OR LOWER(u.lastName) LIKE LOWER(:term)", User.class);
        query.setParameter("term", "%" + searchTerm + "%");
        return query.getResultList();
    }
}
