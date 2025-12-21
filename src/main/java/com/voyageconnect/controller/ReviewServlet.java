package com.voyageconnect.controller;

import com.voyageconnect.exception.BusinessException;
import com.voyageconnect.model.*;
import com.voyageconnect.service.ReviewService;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.List;

/**
 * Servlet pour la gestion des avis
 * URL : /review/*
 */
public class ReviewServlet extends HttpServlet {

    private final ReviewService reviewService = new ReviewService();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String action = getAction(request);
        
        switch (action) {
            case "my-reviews":
                showMyReviews(request, response);
                break;
            case "create":
                showCreateReviewForm(request, response);
                break;
            default:
                response.sendRedirect(request.getContextPath() + "/");
                break;
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String action = getAction(request);
        
        if ("create".equals(action)) {
            createReview(request, response);
        } else {
            response.sendRedirect(request.getContextPath() + "/");
        }
    }

    /**
     * Affiche les avis de l'utilisateur
     */
    private void showMyReviews(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        Long userId = getUserIdFromSession(request);
        List<Review> reviews = reviewService.getUserReviews(userId);
        
        request.setAttribute("reviews", reviews);
        request.getRequestDispatcher("/WEB-INF/views/review/my-reviews.jsp").forward(request, response);
    }

    /**
     * Affiche le formulaire de création d'avis
     */
    private void showCreateReviewForm(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher("/WEB-INF/views/review/create.jsp").forward(request, response);
    }

    /**
     * Crée un avis
     */
    private void createReview(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        try {
            String typeStr = request.getParameter("type");
            Integer rating = Integer.parseInt(request.getParameter("rating"));
            String comment = request.getParameter("comment");
            
            ReviewType type = ReviewType.valueOf(typeStr);
            
            Review review = new Review();
            review.setType(type);
            review.setRating(rating);
            review.setComment(comment);
            
            // Associer l'utilisateur (à compléter avec la récupération de l'entité User)
            // review.setUser(user);
            
            // Associer le vol/hôtel/circuit selon le type
            // (à compléter selon le contexte)
            
            reviewService.createReview(review);
            
            request.setAttribute("success", "Avis créé avec succès");
            showMyReviews(request, response);
            
        } catch (BusinessException e) {
            request.setAttribute("error", e.getMessage());
            showCreateReviewForm(request, response);
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
            return "my-reviews";
        }
        return pathInfo.substring(1);
    }
}
