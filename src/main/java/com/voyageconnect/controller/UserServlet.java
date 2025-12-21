package com.voyageconnect.controller;

import com.voyageconnect.exception.BusinessException;
import com.voyageconnect.model.User;
import com.voyageconnect.service.UserService;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

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
        request.getRequestDispatcher("/WEB-INF/views/user/dashboard.jsp").forward(request, response);
    }

    /**
     * Affiche le profil utilisateur
     */
    private void showProfile(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        Long userId = getUserIdFromSession(request);
        try {
            User user = userService.getUserById(userId);
            request.setAttribute("user", user);
            request.getRequestDispatcher("/WEB-INF/views/user/profile.jsp").forward(request, response);
        } catch (BusinessException e) {
            request.setAttribute("error", e.getMessage());
            response.sendRedirect(request.getContextPath() + "/user/dashboard");
        }
    }

    /**
     * Affiche le formulaire de modification du profil
     */
    private void showEditProfile(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        Long userId = getUserIdFromSession(request);
        try {
            User user = userService.getUserById(userId);
            request.setAttribute("user", user);
            request.getRequestDispatcher("/WEB-INF/views/user/edit-profile.jsp").forward(request, response);
        } catch (BusinessException e) {
            request.setAttribute("error", e.getMessage());
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
        String firstName = request.getParameter("firstName");
        String lastName = request.getParameter("lastName");
        String phone = request.getParameter("phone");
        String address = request.getParameter("address");
        
        try {
            User updatedUser = userService.updateProfile(userId, firstName, lastName, phone, address);
            
            // Mettre à jour la session
            HttpSession session = request.getSession();
            session.setAttribute("user", updatedUser);
            
            request.setAttribute("success", "Profil mis à jour avec succès");
            request.setAttribute("user", updatedUser);
            request.getRequestDispatcher("/WEB-INF/views/user/profile.jsp").forward(request, response);
            
        } catch (BusinessException e) {
            request.setAttribute("error", e.getMessage());
            request.getRequestDispatcher("/WEB-INF/views/user/edit-profile.jsp").forward(request, response);
        }
    }

    /**
     * Change le mot de passe
     */
    private void changePassword(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        Long userId = getUserIdFromSession(request);
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
            request.setAttribute("success", "Mot de passe modifié avec succès");
            request.getRequestDispatcher("/WEB-INF/views/user/dashboard.jsp").forward(request, response);
            
        } catch (BusinessException e) {
            request.setAttribute("error", e.getMessage());
            request.getRequestDispatcher("/WEB-INF/views/user/change-password.jsp").forward(request, response);
        }
    }

    /**
     * Récupère l'ID de l'utilisateur depuis la session
     */
    private Long getUserIdFromSession(HttpServletRequest request) {
        HttpSession session = request.getSession();
        return (Long) session.getAttribute("userId");
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
