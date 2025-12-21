package com.voyageconnect.filter;

import com.voyageconnect.model.User;
import com.voyageconnect.model.UserRole;

import javax.servlet.*;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

/**
 * Filtre d'autorisation pour les pages d'administration
 * Vérifie que l'utilisateur connecté a le rôle ADMIN
 * S'applique aux URLs : /admin/*
 */
public class AdminAuthorizationFilter implements Filter {

    @Override
    public void init(FilterConfig filterConfig) throws ServletException {
        // Initialisation si nécessaire
    }

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, ServletException {
        
        HttpServletRequest httpRequest = (HttpServletRequest) request;
        HttpServletResponse httpResponse = (HttpServletResponse) response;
        
        HttpSession session = httpRequest.getSession(false);
        
        if (session == null) {
            // Pas de session, rediriger vers login
            httpResponse.sendRedirect(httpRequest.getContextPath() + "/auth/login");
            return;
        }
        
        User user = (User) session.getAttribute("user");
        
        if (user == null) {
            // Utilisateur non connecté, rediriger vers login
            httpResponse.sendRedirect(httpRequest.getContextPath() + "/auth/login");
            return;
        }
        
        if (user.getRole() != UserRole.ADMIN) {
            // Utilisateur connecté mais pas ADMIN, afficher erreur 403
            httpResponse.sendError(HttpServletResponse.SC_FORBIDDEN, 
                    "Accès refusé. Vous devez être administrateur.");
            return;
        }
        
        // L'utilisateur est ADMIN, continuer
        chain.doFilter(request, response);
    }

    @Override
    public void destroy() {
        // Nettoyage si nécessaire
    }
}
