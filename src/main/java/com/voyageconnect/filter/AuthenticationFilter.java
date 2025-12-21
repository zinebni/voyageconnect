package com.voyageconnect.filter;

import com.voyageconnect.model.User;

import javax.servlet.*;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

/**
 * Filtre d'authentification
 * Vérifie que l'utilisateur est connecté pour accéder aux pages protégées
 * S'applique aux URLs : /user/*, /reservation/*
 */
public class AuthenticationFilter implements Filter {

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
        boolean isLoggedIn = (session != null && session.getAttribute("user") != null);
        
        String loginURI = httpRequest.getContextPath() + "/auth/login";
        String requestURI = httpRequest.getRequestURI();
        
        // Si l'utilisateur n'est pas connecté et n'est pas sur la page de login
        if (!isLoggedIn && !requestURI.equals(loginURI)) {
            // Sauvegarder l'URL demandée pour redirection après login
            session = httpRequest.getSession(true);
            session.setAttribute("redirectAfterLogin", requestURI);
            
            // Rediriger vers la page de login
            httpResponse.sendRedirect(loginURI);
        } else {
            // L'utilisateur est connecté, continuer
            chain.doFilter(request, response);
        }
    }

    @Override
    public void destroy() {
        // Nettoyage si nécessaire
    }
}
