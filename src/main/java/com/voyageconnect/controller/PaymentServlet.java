package com.voyageconnect.controller;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

/**
 * Servlet pour gérer les paiements (simulation)
 * URL : /payment/*
 */
public class PaymentServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String action = getAction(request);
        
        switch (action) {
            case "success":
                showPaymentSuccess(request, response);
                break;
            case "failure":
                showPaymentFailure(request, response);
                break;
            default:
                response.sendRedirect(request.getContextPath() + "/");
                break;
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Simulation de traitement du paiement
        processPayment(request, response);
    }

    /**
     * Affiche la page de succès du paiement
     */
    private void showPaymentSuccess(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher("/WEB-INF/views/payment/success.jsp").forward(request, response);
    }

    /**
     * Affiche la page d'échec du paiement
     */
    private void showPaymentFailure(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher("/WEB-INF/views/payment/failure.jsp").forward(request, response);
    }

    /**
     * Traite le paiement (simulation)
     */
    private void processPayment(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        // Dans un cas réel, on appellerait ici l'API Stripe/PayPal
        // Pour la simulation, on considère que le paiement réussit
        
        String reservationId = request.getParameter("reservationId");
        String paymentMethod = request.getParameter("paymentMethod");
        String amount = request.getParameter("amount");
        
        // Simulation : 95% de succès
        boolean success = Math.random() < 0.95;
        
        if (success) {
            request.setAttribute("reservationId", reservationId);
            request.setAttribute("amount", amount);
            showPaymentSuccess(request, response);
        } else {
            request.setAttribute("error", "Le paiement a échoué. Veuillez réessayer.");
            showPaymentFailure(request, response);
        }
    }

    /**
     * Extrait l'action de l'URL
     */
    private String getAction(HttpServletRequest request) {
        String pathInfo = request.getPathInfo();
        if (pathInfo == null || pathInfo.equals("/")) {
            return "process";
        }
        return pathInfo.substring(1);
    }
}
