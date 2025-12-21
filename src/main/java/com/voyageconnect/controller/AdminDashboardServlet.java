package com.voyageconnect.controller;

import com.voyageconnect.dao.*;
import com.voyageconnect.model.Reservation;
import com.voyageconnect.model.ReservationStatus;
import com.voyageconnect.util.JPAUtil;

import javax.persistence.EntityManager;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.math.BigDecimal;
import java.time.LocalDateTime;
import java.util.List;
import java.util.Map;
import java.util.logging.Logger;
import java.util.stream.Collectors;

/**
 * Servlet pour le tableau de bord administrateur avec statistiques globales
 */
public class AdminDashboardServlet extends HttpServlet {

    private static final Logger LOGGER = Logger.getLogger(AdminDashboardServlet.class.getName());
    
    private final ReservationDAO reservationDAO = new ReservationDAO();
    private final FlightDAO flightDAO = new FlightDAO();
    private final HotelDAO hotelDAO = new HotelDAO();
    private final CircuitDAO circuitDAO = new CircuitDAO();
    private final UserDAO userDAO = new UserDAO();
    private final DestinationDAO destinationDAO = new DestinationDAO();

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
}
