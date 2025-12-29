package com.voyageconnect.controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.voyageconnect.exception.BusinessException;
import com.voyageconnect.model.User;
import com.voyageconnect.service.UserService;

/**
 * Servlet pour la gestion du profil utilisateur
 * URL : /user/*
 */
public class UserServlet extends HttpServlet {

    private final UserService userService = new UserService();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String action = getAction(request);
        
        System.out.println("=== UserServlet GET ===");
        System.out.println("Action: " + action);
        System.out.println("PathInfo: " + request.getPathInfo());
        System.out.println("RequestURI: " + request.getRequestURI());
        
        switch (action) {
            case "dashboard":
                showDashboard(request, response);
                break;
            case "profile":
                showProfile(request, response);
                break;
            case "edit-profile":
                showEditProfile(request, response);
                break;
            case "change-password":
                showChangePassword(request, response);
                break;
            default:
                showDashboard(request, response);
                break;
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String action = getAction(request);
        
        switch (action) {
            case "update-profile":
                updateProfile(request, response);
                break;
            case "change-password":
                changePassword(request, response);
                break;
            default:
                response.sendRedirect(request.getContextPath() + "/user/dashboard");
                break;
        }
    }

    /**
     * Affiche le tableau de bord utilisateur
     */
    private void showDashboard(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        System.out.println(">>> Affichage du dashboard");
        request.getRequestDispatcher("/WEB-INF/views/user/dashboard.jsp").forward(request, response);
    }

    /**
     * Affiche le profil utilisateur
     */
    private void showProfile(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        System.out.println(">>> Affichage du profil");
        
        Long userId = getUserIdFromSession(request);
        
        System.out.println("User ID from session: " + userId);
        
        // Vérifier si l'utilisateur est connecté
        if (userId == null) {
            System.out.println("ERROR: userId est null - redirection vers login");
            response.sendRedirect(request.getContextPath() + "/auth/login");
            return;
        }
        
        try {
            System.out.println("Récupération de l'utilisateur avec ID: " + userId);
            User user = userService.getUserById(userId);
            
            System.out.println("Utilisateur trouvé: " + user.getEmail());
            System.out.println("Forward vers: /WEB-INF/views/user/profile.jsp");
            
            request.setAttribute("user", user);
            request.getRequestDispatcher("/WEB-INF/views/user/profile.jsp").forward(request, response);
            
            System.out.println("Forward réussi");
            
        } catch (BusinessException e) {
            System.out.println("ERROR BusinessException: " + e.getMessage());
            e.printStackTrace();
            
            // Mettre l'erreur en session pour l'afficher sur le dashboard
            HttpSession session = request.getSession();
            session.setAttribute("error", "Erreur lors du chargement du profil: " + e.getMessage());
            
            response.sendRedirect(request.getContextPath() + "/user/dashboard");
        } catch (Exception e) {
            System.out.println("ERROR Exception: " + e.getMessage());
            e.printStackTrace();
            
            HttpSession session = request.getSession();
            session.setAttribute("error", "Erreur inattendue: " + e.getMessage());
            
            response.sendRedirect(request.getContextPath() + "/user/dashboard");
        }
    }

    /**
     * Affiche le formulaire de modification du profil
     */
    private void showEditProfile(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        System.out.println(">>> Affichage du formulaire d'édition");
        
        Long userId = getUserIdFromSession(request);
        
        if (userId == null) {
            response.sendRedirect(request.getContextPath() + "/auth/login");
            return;
        }
        
        try {
            User user = userService.getUserById(userId);
            request.setAttribute("user", user);
            request.getRequestDispatcher("/WEB-INF/views/user/edit-profile.jsp").forward(request, response);
        } catch (BusinessException e) {
            e.printStackTrace();
            HttpSession session = request.getSession();
            session.setAttribute("error", e.getMessage());
            response.sendRedirect(request.getContextPath() + "/user/dashboard");
        }
    }

    /**
     * Affiche le formulaire de changement de mot de passe
     */
    private void showChangePassword(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher("/WEB-INF/views/user/change-password.jsp").forward(request, response);
    }

    /**
     * Met à jour le profil utilisateur
     */
    private void updateProfile(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        Long userId = getUserIdFromSession(request);
        
        if (userId == null) {
            response.sendRedirect(request.getContextPath() + "/auth/login");
            return;
        }
        
        String firstName = request.getParameter("firstName");
        String lastName = request.getParameter("lastName");
        String phone = request.getParameter("phone");
        String address = request.getParameter("address");
        
        try {
            User updatedUser = userService.updateProfile(userId, firstName, lastName, phone, address);
            
            // Mettre à jour la session
            HttpSession session = request.getSession();
            session.setAttribute("user", updatedUser);
            session.setAttribute("userId", updatedUser.getId());
            
            request.setAttribute("success", "Profil mis à jour avec succès");
            request.setAttribute("user", updatedUser);
            request.getRequestDispatcher("/WEB-INF/views/user/profile.jsp").forward(request, response);
            
        } catch (BusinessException e) {
            e.printStackTrace();
            request.setAttribute("error", e.getMessage());
            
            // Re-charger l'utilisateur pour le formulaire
            try {
                User user = userService.getUserById(userId);
                request.setAttribute("user", user);
            } catch (BusinessException ex) {
                // Ignore
            }
            
            request.getRequestDispatcher("/WEB-INF/views/user/edit-profile.jsp").forward(request, response);
        }
    }

    /**
     * Change le mot de passe
     */
    private void changePassword(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        Long userId = getUserIdFromSession(request);
        
        if (userId == null) {
            response.sendRedirect(request.getContextPath() + "/auth/login");
            return;
        }
        
        String oldPassword = request.getParameter("oldPassword");
        String newPassword = request.getParameter("newPassword");
        String confirmPassword = request.getParameter("confirmPassword");
        
        if (!newPassword.equals(confirmPassword)) {
            request.setAttribute("error", "Les mots de passe ne correspondent pas");
            request.getRequestDispatcher("/WEB-INF/views/user/change-password.jsp").forward(request, response);
            return;
        }
        
        try {
            userService.changePassword(userId, oldPassword, newPassword);
            
            HttpSession session = request.getSession();
            session.setAttribute("success", "Mot de passe modifié avec succès");
            
            response.sendRedirect(request.getContextPath() + "/user/dashboard");
            
        } catch (BusinessException e) {
            e.printStackTrace();
            request.setAttribute("error", e.getMessage());
            request.getRequestDispatcher("/WEB-INF/views/user/change-password.jsp").forward(request, response);
        }
    }

    /**
     * Récupère l'ID de l'utilisateur depuis la session
     */
    private Long getUserIdFromSession(HttpServletRequest request) {
        HttpSession session = request.getSession(false);
        
        System.out.println("=== getUserIdFromSession ===");
        
        if (session == null) {
            System.out.println("Session est null");
            return null;
        }
        
        System.out.println("Session ID: " + session.getId());
        
        // Essayer d'abord avec userId
        Object userIdObj = session.getAttribute("userId");
        System.out.println("userId attribute: " + userIdObj);
        
        if (userIdObj != null) {
            return (Long) userIdObj;
        }
        
        // Sinon essayer avec user.getId()
        Object userObj = session.getAttribute("user");
        System.out.println("user attribute: " + userObj);
        
        if (userObj != null && userObj instanceof User) {
            User user = (User) userObj;
            Long id = user.getId();
            System.out.println("user.getId(): " + id);
            return id;
        }
        
        System.out.println("Aucun userId trouvé dans la session");
        return null;
    }

    /**
     * Extrait l'action de l'URL
     */
    private String getAction(HttpServletRequest request) {
        String pathInfo = request.getPathInfo();
        if (pathInfo == null || pathInfo.equals("/")) {
            return "dashboard";
        }
        return pathInfo.substring(1);
    }
}