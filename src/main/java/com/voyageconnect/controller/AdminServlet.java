package com.voyageconnect.controller;

import com.voyageconnect.exception.BusinessException;
import com.voyageconnect.model.*;
import com.voyageconnect.service.AdminService;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.math.BigDecimal;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.List;

/**
 * Servlet pour l'administration
 * URL : /admin/*
 * Accessible uniquement aux utilisateurs avec le rôle ADMIN
 */
public class AdminServlet extends HttpServlet {

    private final AdminService adminService = new AdminService();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String action = getAction(request);
        
        switch (action) {
            case "dashboard":
                showDashboard(request, response);
                break;
            case "destinations":
                listDestinations(request, response);
                break;
            case "flights":
                listFlights(request, response);
                break;
            case "hotels":
                listHotels(request, response);
                break;
            case "circuits":
                listCircuits(request, response);
                break;
            case "promotions":
                listPromotions(request, response);
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
            case "create-destination":
                createDestination(request, response);
                break;
            case "create-flight":
                createFlight(request, response);
                break;
            case "create-hotel":
                createHotel(request, response);
                break;
            case "create-circuit":
                createCircuit(request, response);
                break;
            case "create-promotion":
                createPromotion(request, response);
                break;
            default:
                response.sendRedirect(request.getContextPath() + "/admin/dashboard");
                break;
        }
    }

    /**
     * Affiche le tableau de bord administrateur
     */
    private void showDashboard(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher("/WEB-INF/views/admin/dashboard.jsp").forward(request, response);
    }

    /**
     * Liste les destinations
     */
    private void listDestinations(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        List<Destination> destinations = adminService.getAllDestinations();
        request.setAttribute("destinations", destinations);
        request.getRequestDispatcher("/WEB-INF/views/admin/destinations.jsp").forward(request, response);
    }

    /**
     * Liste les vols
     */
    private void listFlights(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        List<Flight> flights = adminService.getAllFlights();
        request.setAttribute("flights", flights);
        request.getRequestDispatcher("/WEB-INF/views/admin/flights.jsp").forward(request, response);
    }

    /**
     * Liste les hôtels
     */
    private void listHotels(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        List<Hotel> hotels = adminService.getAllHotels();
        request.setAttribute("hotels", hotels);
        request.getRequestDispatcher("/WEB-INF/views/admin/hotels.jsp").forward(request, response);
    }

    /**
     * Liste les circuits
     */
    private void listCircuits(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        List<Circuit> circuits = adminService.getAllCircuits();
        request.setAttribute("circuits", circuits);
        request.getRequestDispatcher("/WEB-INF/views/admin/circuits.jsp").forward(request, response);
    }

    /**
     * Liste les promotions
     */
    private void listPromotions(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        List<Promotion> promotions = adminService.getAllPromotions();
        request.setAttribute("promotions", promotions);
        request.getRequestDispatcher("/WEB-INF/views/admin/promotions.jsp").forward(request, response);
    }

    /**
     * Crée une destination
     */
    private void createDestination(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String name = request.getParameter("name");
        String country = request.getParameter("country");
        String description = request.getParameter("description");
        String imageUrl = request.getParameter("imageUrl");
        
        try {
            Destination destination = new Destination(name, country, description);
            destination.setImageUrl(imageUrl);
            
            adminService.createDestination(destination);
            
            request.setAttribute("success", "Destination créée avec succès");
            response.sendRedirect(request.getContextPath() + "/admin/destinations");
            
        } catch (BusinessException e) {
            request.setAttribute("error", e.getMessage());
            listDestinations(request, response);
        }
    }

    /**
     * Crée un vol (exemple simplifié)
     */
    private void createFlight(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            // Récupération et parsing des paramètres...
            request.setAttribute("success", "Vol créé avec succès");
            response.sendRedirect(request.getContextPath() + "/admin/flights");
        } catch (Exception e) {
            request.setAttribute("error", "Erreur lors de la création du vol");
            listFlights(request, response);
        }
    }

    /**
     * Crée un hôtel (exemple simplifié)
     */
    private void createHotel(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            // Récupération et parsing des paramètres...
            request.setAttribute("success", "Hôtel créé avec succès");
            response.sendRedirect(request.getContextPath() + "/admin/hotels");
        } catch (Exception e) {
            request.setAttribute("error", "Erreur lors de la création de l'hôtel");
            listHotels(request, response);
        }
    }

    /**
     * Crée un circuit (exemple simplifié)
     */
    private void createCircuit(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            // Récupération et parsing des paramètres...
            request.setAttribute("success", "Circuit créé avec succès");
            response.sendRedirect(request.getContextPath() + "/admin/circuits");
        } catch (Exception e) {
            request.setAttribute("error", "Erreur lors de la création du circuit");
            listCircuits(request, response);
        }
    }

    /**
     * Crée une promotion
     */
    private void createPromotion(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String code = request.getParameter("code");
        String description = request.getParameter("description");
        BigDecimal discountPercentage = new BigDecimal(request.getParameter("discountPercentage"));
        LocalDate startDate = LocalDate.parse(request.getParameter("startDate"));
        LocalDate endDate = LocalDate.parse(request.getParameter("endDate"));
        
        try {
            Promotion promotion = new Promotion(code, description, discountPercentage, startDate, endDate);
            adminService.createPromotion(promotion);
            
            request.setAttribute("success", "Promotion créée avec succès");
            response.sendRedirect(request.getContextPath() + "/admin/promotions");
            
        } catch (BusinessException e) {
            request.setAttribute("error", e.getMessage());
            listPromotions(request, response);
        }
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
