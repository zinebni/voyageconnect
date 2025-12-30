package com.voyageconnect.controller;

import java.io.IOException;
import java.math.BigDecimal;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.List;
import java.util.Map;
import java.util.logging.Logger;
import java.util.stream.Collectors;

import javax.persistence.EntityManager;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.voyageconnect.dao.CircuitDAO;
import com.voyageconnect.dao.DestinationDAO;
import com.voyageconnect.dao.FlightDAO;
import com.voyageconnect.dao.HotelDAO;
import com.voyageconnect.dao.ReservationDAO;
import com.voyageconnect.dao.UserDAO;
import com.voyageconnect.model.Reservation;
import com.voyageconnect.model.ReservationStatus;
import com.voyageconnect.service.AdminService;
import com.voyageconnect.util.JPAUtil;

/**
 * Servlet pour le tableau de bord administrateur avec statistiques globales
 * et gestion des réservations (confirmation/annulation)
 */
public class AdminDashboardServlet extends HttpServlet {

    private static final Logger LOGGER = Logger.getLogger(AdminDashboardServlet.class.getName());
    
    private final ReservationDAO reservationDAO = new ReservationDAO();
    private final FlightDAO flightDAO = new FlightDAO();
    private final HotelDAO hotelDAO = new HotelDAO();
    private final CircuitDAO circuitDAO = new CircuitDAO();
    private final UserDAO userDAO = new UserDAO();
    private final DestinationDAO destinationDAO = new DestinationDAO();
    private final AdminService adminService = new AdminService();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        EntityManager em = JPAUtil.getEntityManager();

        try {
            // Statistiques globales
            long totalUsers = userDAO.count(em);
            long totalFlights = flightDAO.countAll(em);
            long totalHotels = hotelDAO.countAll(em);
            long totalCircuits = circuitDAO.countAll(em);
            long totalDestinations = destinationDAO.countAll(em);
            
            // Réservations
            List<Reservation> allReservations = reservationDAO.findAll(em);
            int totalReservations = allReservations.size();
            
            long confirmedReservations = allReservations.stream()
                    .filter(r -> r.getStatus() == ReservationStatus.CONFIRMEE)
                    .count();
            
            long pendingReservations = allReservations.stream()
                    .filter(r -> r.getStatus() == ReservationStatus.EN_ATTENTE)
                    .count();
            
            long cancelledReservations = allReservations.stream()
                    .filter(r -> r.getStatus() == ReservationStatus.ANNULEE)
                    .count();
            
            // Revenus totaux
            BigDecimal totalRevenue = allReservations.stream()
                    .filter(r -> r.getPayment() != null && r.getStatus() == ReservationStatus.CONFIRMEE)
                    .map(r -> r.getPayment().getAmount())
                    .reduce(BigDecimal.ZERO, BigDecimal::add);
            
            // Revenus ce mois
            LocalDateTime startOfMonth = LocalDateTime.now().withDayOfMonth(1).withHour(0).withMinute(0);
            BigDecimal monthlyRevenue = allReservations.stream()
                    .filter(r -> r.getCreatedAt().isAfter(startOfMonth))
                    .filter(r -> r.getPayment() != null && r.getStatus() == ReservationStatus.CONFIRMEE)
                    .map(r -> r.getPayment().getAmount())
                    .reduce(BigDecimal.ZERO, BigDecimal::add);
            
            // Réservations par type
            Map<String, Long> reservationsByType = allReservations.stream()
                    .collect(Collectors.groupingBy(r -> r.getType().name(), Collectors.counting()));
            
            // Dernières réservations (10 max)
            List<Reservation> recentReservations = allReservations.stream()
                    .sorted((r1, r2) -> r2.getCreatedAt().compareTo(r1.getCreatedAt()))
                    .limit(10)
                    .collect(Collectors.toList());

            //format date in jsp
            // Formatage date pour la JSP (JSP ne supporte pas LocalDateTime)

            DateTimeFormatter formatter = DateTimeFormatter.ofPattern("dd/MM/yyyy HH:mm");
            for (Reservation r : recentReservations) {
                if (r.getCreatedAt() != null) {
                        r.setCreatedAtFormatted(r.getCreatedAt().format(formatter));
                } else {
                        r.setCreatedAtFormatted("");
                }
           }



                    
            
            // Destinations populaires (par nombre de réservations)
            Map<String, Long> popularDestinations = allReservations.stream()
                    .filter(r -> r.getFlight() != null && r.getFlight().getDestination() != null)
                    .collect(Collectors.groupingBy(
                            r -> r.getFlight().getDestination().getName(),
                            Collectors.counting()
                    ));
            
            // Passer les données à la JSP
            request.setAttribute("totalUsers", totalUsers);
            request.setAttribute("totalFlights", totalFlights);
            request.setAttribute("totalHotels", totalHotels);
            request.setAttribute("totalCircuits", totalCircuits);
            request.setAttribute("totalDestinations", totalDestinations);
            request.setAttribute("totalReservations", totalReservations);
            request.setAttribute("confirmedReservations", confirmedReservations);
            request.setAttribute("pendingReservations", pendingReservations);
            request.setAttribute("cancelledReservations", cancelledReservations);
            request.setAttribute("totalRevenue", totalRevenue);
            request.setAttribute("monthlyRevenue", monthlyRevenue);
            request.setAttribute("reservationsByType", reservationsByType);
            request.setAttribute("recentReservations", recentReservations);
            request.setAttribute("popularDestinations", popularDestinations);
            
            LOGGER.info("Dashboard admin chargé - " + totalReservations + " réservations totales");
            
            request.getRequestDispatcher("/WEB-INF/views/admin/dashboard.jsp").forward(request, response);
            
        } catch (Exception e) {
            LOGGER.severe("Erreur chargement dashboard admin: " + e.getMessage());
            e.printStackTrace();
            request.setAttribute("error", "Erreur lors du chargement des statistiques");
            request.getRequestDispatcher("/WEB-INF/views/error.jsp").forward(request, response);
        } finally {
            if (em != null && em.isOpen()) {
                em.close();
            }
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String action = request.getParameter("action");
        String reservationIdStr = request.getParameter("reservationId");
        
        if (action == null || reservationIdStr == null) {
            request.getSession().setAttribute("error", "Paramètres manquants");
            response.sendRedirect(request.getContextPath() + "/admin/dashboard");
            return;
        }
        
        try {
            Long reservationId = Long.parseLong(reservationIdStr);
            boolean emailSent = false;
            String message = "";
            
            switch (action) {
                case "confirm":
                    emailSent = adminService.confirmReservation(reservationId);
                    if (emailSent) {
                        message = "Réservation confirmée avec succès ! Email de confirmation envoyé au client.";
                    } else {
                        message = "Réservation confirmée, mais l'envoi de l'email a échoué.";
                    }
                    request.getSession().setAttribute("success", message);
                    break;
                    
                case "cancel":
                    emailSent = adminService.cancelReservation(reservationId);
                    if (emailSent) {
                        message = "Réservation annulée avec succès ! Email d'annulation envoyé au client.";
                    } else {
                        message = "Réservation annulée, mais l'envoi de l'email a échoué.";
                    }
                    request.getSession().setAttribute("success", message);
                    break;
                    
                default:
                    request.getSession().setAttribute("error", "Action non reconnue");
            }
            
            LOGGER.info("Action " + action + " effectuée sur la réservation " + reservationId + " - Email envoyé: " + emailSent);
            
        } catch (NumberFormatException e) {
            request.getSession().setAttribute("error", "ID de réservation invalide");
        } catch (Exception e) {
            LOGGER.severe("Erreur lors de l'action sur la réservation: " + e.getMessage());
            request.getSession().setAttribute("error", "Erreur: " + e.getMessage());
        }
        
        response.sendRedirect(request.getContextPath() + "/admin/dashboard");
    }
}
