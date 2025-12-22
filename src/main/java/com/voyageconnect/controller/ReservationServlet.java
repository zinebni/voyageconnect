package com.voyageconnect.controller;

import com.voyageconnect.exception.BusinessException;
import com.voyageconnect.model.*;
import com.voyageconnect.service.ReservationService;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.List;
import java.util.logging.Logger;

/**
 * Servlet pour la gestion des réservations
 * URL : /reservation/*
 */
public class ReservationServlet extends HttpServlet {

    private static final Logger LOGGER = Logger.getLogger(ReservationServlet.class.getName());
    private final ReservationService reservationService = new ReservationService();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        LOGGER.info("ReservationServlet.doGet appelé - ServletPath: " + request.getServletPath() + ", PathInfo: " + request.getPathInfo());
        
        String action = getAction(request);
        LOGGER.info("Action extraite: " + action);
        
        switch (action) {
            case "list":
                listReservations(request, response);
                break;
            case "view":
                viewReservation(request, response);
                break;
            case "cancel":
                showCancelConfirmation(request, response);
                break;
            default:
                listReservations(request, response);
                break;
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String action = getAction(request);
        
        switch (action) {
            case "flight":
                createFlightReservation(request, response);
                break;
            case "hotel":
                createHotelReservation(request, response);
                break;
            case "circuit":
                createCircuitReservation(request, response);
                break;
            case "cancel":
                cancelReservation(request, response);
                break;
            default:
                response.sendRedirect(request.getContextPath() + "/reservation/list");
                break;
        }
    }

    /**
     * Liste les réservations de l'utilisateur
     */
    private void listReservations(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        LOGGER.info("listReservations appelée");
        
        Long userId = getUserIdFromSession(request);
        LOGGER.info("User ID from session: " + userId);
        
        List<Reservation> reservations = reservationService.getUserReservations(userId);
        LOGGER.info("Nombre de réservations trouvées: " + (reservations != null ? reservations.size() : 0));
        
        request.setAttribute("reservations", reservations);
        request.getRequestDispatcher("/WEB-INF/views/reservation/list.jsp").forward(request, response);
    }

    /**
     * Affiche les détails d'une réservation
     */
    private void viewReservation(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        try {
            Long reservationId = Long.parseLong(request.getParameter("id"));
            Reservation reservation = reservationService.getReservationById(reservationId);
            
            request.setAttribute("reservation", reservation);
            request.getRequestDispatcher("/WEB-INF/views/reservation/view.jsp").forward(request, response);
            
        } catch (BusinessException e) {
            request.setAttribute("error", e.getMessage());
            response.sendRedirect(request.getContextPath() + "/reservation/list");
        }
    }

    /**
     * Crée une réservation de vol
     */
    private void createFlightReservation(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        try {
            Long userId = getUserIdFromSession(request);
            Long flightId = Long.parseLong(request.getParameter("flightId"));
            Integer numberOfPeople = Integer.parseInt(request.getParameter("numberOfPeople"));
            String paymentMethodStr = request.getParameter("paymentMethod");
            PaymentMethod paymentMethod = PaymentMethod.valueOf(paymentMethodStr);
            
            Reservation reservation = reservationService.createFlightReservation(
                    userId, flightId, numberOfPeople, paymentMethod);
            
            request.setAttribute("success", "Réservation créée avec succès !");
            request.setAttribute("reservation", reservation);
            request.getRequestDispatcher("/WEB-INF/views/reservation/success.jsp").forward(request, response);
            
        } catch (BusinessException e) {
            request.setAttribute("error", e.getMessage());
            request.getRequestDispatcher("/WEB-INF/views/reservation/error.jsp").forward(request, response);
        } catch (Exception e) {
            request.setAttribute("error", "Erreur lors de la réservation");
            request.getRequestDispatcher("/WEB-INF/views/reservation/error.jsp").forward(request, response);
        }
    }

    /**
     * Crée une réservation d'hôtel
     */
    private void createHotelReservation(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        try {
            Long userId = getUserIdFromSession(request);
            Long hotelId = Long.parseLong(request.getParameter("hotelId"));
            Integer numberOfRooms = Integer.parseInt(request.getParameter("numberOfRooms"));
            String checkInStr = request.getParameter("checkIn");
            String checkOutStr = request.getParameter("checkOut");
            String paymentMethodStr = request.getParameter("paymentMethod");
            
            LocalDateTime checkIn = LocalDateTime.parse(checkInStr, DateTimeFormatter.ISO_DATE_TIME);
            LocalDateTime checkOut = LocalDateTime.parse(checkOutStr, DateTimeFormatter.ISO_DATE_TIME);
            PaymentMethod paymentMethod = PaymentMethod.valueOf(paymentMethodStr);
            
            Reservation reservation = reservationService.createHotelReservation(
                    userId, hotelId, numberOfRooms, checkIn, checkOut, paymentMethod);
            
            request.setAttribute("success", "Réservation créée avec succès !");
            request.setAttribute("reservation", reservation);
            request.getRequestDispatcher("/WEB-INF/views/reservation/success.jsp").forward(request, response);
            
        } catch (BusinessException e) {
            request.setAttribute("error", e.getMessage());
            request.getRequestDispatcher("/WEB-INF/views/reservation/error.jsp").forward(request, response);
        } catch (Exception e) {
            request.setAttribute("error", "Erreur lors de la réservation");
            request.getRequestDispatcher("/WEB-INF/views/reservation/error.jsp").forward(request, response);
        }
    }

    /**
     * Crée une réservation de circuit
     */
    private void createCircuitReservation(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        try {
            Long userId = getUserIdFromSession(request);
            Long circuitId = Long.parseLong(request.getParameter("circuitId"));
            Integer numberOfPeople = Integer.parseInt(request.getParameter("numberOfPeople"));
            String paymentMethodStr = request.getParameter("paymentMethod");
            PaymentMethod paymentMethod = PaymentMethod.valueOf(paymentMethodStr);
            
            Reservation reservation = reservationService.createCircuitReservation(
                    userId, circuitId, numberOfPeople, paymentMethod);
            
            request.setAttribute("success", "Réservation créée avec succès !");
            request.setAttribute("reservation", reservation);
            request.getRequestDispatcher("/WEB-INF/views/reservation/success.jsp").forward(request, response);
            
        } catch (BusinessException e) {
            request.setAttribute("error", e.getMessage());
            request.getRequestDispatcher("/WEB-INF/views/reservation/error.jsp").forward(request, response);
        } catch (Exception e) {
            request.setAttribute("error", "Erreur lors de la réservation");
            request.getRequestDispatcher("/WEB-INF/views/reservation/error.jsp").forward(request, response);
        }
    }

    /**
     * Affiche la confirmation d'annulation
     */
    private void showCancelConfirmation(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        try {
            Long reservationId = Long.parseLong(request.getParameter("id"));
            Reservation reservation = reservationService.getReservationById(reservationId);
            
            request.setAttribute("reservation", reservation);
            request.getRequestDispatcher("/WEB-INF/views/reservation/cancel.jsp").forward(request, response);
            
        } catch (BusinessException e) {
            request.setAttribute("error", e.getMessage());
            response.sendRedirect(request.getContextPath() + "/reservation/list");
        }
    }

    /**
     * Annule une réservation
     */
    private void cancelReservation(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        try {
            Long userId = getUserIdFromSession(request);
            Long reservationId = Long.parseLong(request.getParameter("reservationId"));
            
            reservationService.cancelReservation(reservationId, userId);
            
            request.setAttribute("success", "Réservation annulée avec succès");
            response.sendRedirect(request.getContextPath() + "/reservation/list");
            
        } catch (BusinessException e) {
            request.setAttribute("error", e.getMessage());
            response.sendRedirect(request.getContextPath() + "/reservation/list");
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
        String servletPath = request.getServletPath();
        // /reservations/list -> list
        // /reservations/view -> view
        // /reservations/cancel -> cancel
        if (servletPath.contains("/")) {
            int lastSlash = servletPath.lastIndexOf("/");
            return servletPath.substring(lastSlash + 1);
        }
        return "list";
    }
}
