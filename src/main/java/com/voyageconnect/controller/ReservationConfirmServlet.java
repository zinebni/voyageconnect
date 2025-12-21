package com.voyageconnect.controller;

import com.voyageconnect.exception.BusinessException;
import com.voyageconnect.model.PaymentMethod;
import com.voyageconnect.model.Reservation;
import com.voyageconnect.service.ReservationService;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.LocalTime;
import java.time.format.DateTimeFormatter;
import java.time.format.DateTimeParseException;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 * Servlet pour confirmer et créer une réservation
 * URL : /reservation/confirm (POST uniquement)
 */
public class ReservationConfirmServlet extends HttpServlet {

    private static final Logger LOGGER = Logger.getLogger(ReservationConfirmServlet.class.getName());
    private final ReservationService reservationService = new ReservationService();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Vérifier que l'utilisateur est connecté
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("userId") == null) {
            LOGGER.warning("Tentative de confirmation sans session");
            response.sendRedirect(request.getContextPath() + "/auth/login");
            return;
        }

        Long userId = (Long) session.getAttribute("userId");
        String type = request.getParameter("type");
        
        LOGGER.info("Confirmation de réservation - UserID: " + userId + ", Type: " + type);

        if (type == null || type.trim().isEmpty()) {
            LOGGER.warning("Type de réservation manquant");
            request.setAttribute("error", "Type de réservation manquant. Veuillez recommencer.");
            request.getRequestDispatcher("/WEB-INF/views/reservation/error.jsp").forward(request, response);
            return;
        }

        try {
            switch (type.toUpperCase()) {
                case "FLIGHT":
                    confirmFlightReservation(request, response, userId);
                    break;
                case "HOTEL":
                    confirmHotelReservation(request, response, userId);
                    break;
                case "CIRCUIT":
                    confirmCircuitReservation(request, response, userId);
                    break;
                default:
                    request.setAttribute("error", "Type de réservation invalide");
                    request.getRequestDispatcher("/WEB-INF/views/reservation/error.jsp").forward(request, response);
                    break;
            }
        } catch (BusinessException e) {
            LOGGER.log(Level.WARNING, "Erreur métier lors de la réservation", e);
            request.setAttribute("error", e.getMessage());
            request.getRequestDispatcher("/WEB-INF/views/reservation/error.jsp").forward(request, response);
        } catch (IllegalArgumentException e) {
            LOGGER.log(Level.WARNING, "Paramètres invalides", e);
            request.setAttribute("error", "Paramètres invalides: " + e.getMessage());
            request.getRequestDispatcher("/WEB-INF/views/reservation/error.jsp").forward(request, response);
        } catch (Exception e) {
            LOGGER.log(Level.SEVERE, "Erreur inattendue lors de la confirmation", e);
            request.setAttribute("error", "Erreur technique: " + e.getMessage() + ". Veuillez réessayer.");
            request.getRequestDispatcher("/WEB-INF/views/reservation/error.jsp").forward(request, response);
        }
    }

    /**
     * Confirme une réservation de vol
     */
    private void confirmFlightReservation(HttpServletRequest request, HttpServletResponse response, Long userId)
            throws BusinessException, ServletException, IOException {

        try {
            Long flightId = Long.parseLong(request.getParameter("flightId"));
            Integer numberOfPeople = Integer.parseInt(request.getParameter("numberOfPeople"));
            String paymentMethodStr = request.getParameter("paymentMethod");
            
            LOGGER.info("Vol: " + flightId + ", Personnes: " + numberOfPeople + ", Paiement: " + paymentMethodStr);
            
            if (numberOfPeople <= 0 || numberOfPeople > 20) {
                throw new BusinessException("Nombre de personnes invalide (1-20 autorisés)");
            }
            
            PaymentMethod paymentMethod = PaymentMethod.valueOf(paymentMethodStr);

            Reservation reservation = reservationService.createFlightReservation(
                    userId, flightId, numberOfPeople, paymentMethod);
            
            LOGGER.info("Réservation de vol créée avec succès - ID: " + reservation.getId());
            request.setAttribute("success", "Réservation de vol créée avec succès !");
            request.setAttribute("reservation", reservation);
            request.getRequestDispatcher("/WEB-INF/views/reservation/success.jsp").forward(request, response);
            
        } catch (NumberFormatException e) {
            LOGGER.log(Level.WARNING, "Paramètres numériques invalides", e);
            throw new BusinessException("Paramètres invalides. Vérifiez le formulaire.");
        } catch (IllegalArgumentException e) {
            LOGGER.log(Level.WARNING, "Méthode de paiement invalide", e);
            throw new BusinessException("Méthode de paiement invalide");
        }
    }

    /**
     * Confirme une réservation d'hôtel
     */
    private void confirmHotelReservation(HttpServletRequest request, HttpServletResponse response, Long userId)
            throws BusinessException, ServletException, IOException {

        try {
            Long hotelId = Long.parseLong(request.getParameter("hotelId"));
            Integer numberOfRooms = Integer.parseInt(request.getParameter("numberOfRooms"));
            String checkInStr = request.getParameter("checkIn");
            String checkOutStr = request.getParameter("checkOut");
            String paymentMethodStr = request.getParameter("paymentMethod");
            
            LOGGER.info("Hôtel: " + hotelId + ", Chambres: " + numberOfRooms + ", Check-in: " + checkInStr + ", Check-out: " + checkOutStr);
            
            if (numberOfRooms <= 0 || numberOfRooms > 10) {
                throw new BusinessException("Nombre de chambres invalide (1-10 autorisées)");
            }

            // Convertir les dates (format: yyyy-MM-dd)
            LocalDateTime checkIn = parseDate(checkInStr);
            LocalDateTime checkOut = parseDate(checkOutStr);
            
            if (checkOut.isBefore(checkIn)) {
                throw new BusinessException("La date de départ doit être après la date d'arrivée");
            }
            
            PaymentMethod paymentMethod = PaymentMethod.valueOf(paymentMethodStr);

            Reservation reservation = reservationService.createHotelReservation(
                    userId, hotelId, numberOfRooms, checkIn, checkOut, paymentMethod);
            
            LOGGER.info("Réservation d'hôtel créée avec succès - ID: " + reservation.getId());
            request.setAttribute("success", "Réservation d'hôtel créée avec succès !");
            request.setAttribute("reservation", reservation);
            request.getRequestDispatcher("/WEB-INF/views/reservation/success.jsp").forward(request, response);
            
        } catch (NumberFormatException e) {
            LOGGER.log(Level.WARNING, "Paramètres numériques invalides", e);
            throw new BusinessException("Paramètres invalides. Vérifiez le formulaire.");
        } catch (IllegalArgumentException e) {
            LOGGER.log(Level.WARNING, "Méthode de paiement invalide", e);
            throw new BusinessException("Méthode de paiement invalide");
        }
    }

    /**
     * Confirme une réservation de circuit
     */
    private void confirmCircuitReservation(HttpServletRequest request, HttpServletResponse response, Long userId)
            throws BusinessException, ServletException, IOException {

        try {
            Long circuitId = Long.parseLong(request.getParameter("circuitId"));
            Integer numberOfPeople = Integer.parseInt(request.getParameter("numberOfPeople"));
            String paymentMethodStr = request.getParameter("paymentMethod");
            
            LOGGER.info("Circuit: " + circuitId + ", Personnes: " + numberOfPeople + ", Paiement: " + paymentMethodStr);
            
            if (numberOfPeople <= 0 || numberOfPeople > 20) {
                throw new BusinessException("Nombre de personnes invalide (1-20 autorisés)");
            }
            
            PaymentMethod paymentMethod = PaymentMethod.valueOf(paymentMethodStr);

            Reservation reservation = reservationService.createCircuitReservation(
                    userId, circuitId, numberOfPeople, paymentMethod);
            
            LOGGER.info("Réservation de circuit créée avec succès - ID: " + reservation.getId());
            request.setAttribute("success", "Réservation de circuit créée avec succès !");
            request.setAttribute("reservation", reservation);
            request.getRequestDispatcher("/WEB-INF/views/reservation/success.jsp").forward(request, response);
            
        } catch (NumberFormatException e) {
            LOGGER.log(Level.WARNING, "Paramètres numériques invalides", e);
            throw new BusinessException("Paramètres invalides. Vérifiez le formulaire.");
        } catch (IllegalArgumentException e) {
            LOGGER.log(Level.WARNING, "Méthode de paiement invalide", e);
            throw new BusinessException("Méthode de paiement invalide");
        }
    }

    /**
     * Convertit une date string (yyyy-MM-dd) en LocalDateTime (à 14h00 par défaut)
     */
    private LocalDateTime parseDate(String dateStr) throws BusinessException {
        try {
            LocalDate date = LocalDate.parse(dateStr, DateTimeFormatter.ISO_LOCAL_DATE);
            return LocalDateTime.of(date, LocalTime.of(14, 0)); // 14:00 par défaut
        } catch (DateTimeParseException e) {
            throw new BusinessException("Format de date invalide. Format attendu : YYYY-MM-DD");
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Rediriger vers la page de recherche si accès direct en GET
        response.sendRedirect(request.getContextPath() + "/search/flights");
    }
}
