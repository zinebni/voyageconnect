package com.voyageconnect.controller;

import com.voyageconnect.dao.ReservationDAO;
import com.voyageconnect.model.Reservation;
import com.voyageconnect.model.ReservationType;
import com.voyageconnect.util.JPAUtil;

import javax.persistence.EntityManager;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.math.BigDecimal;
import java.util.List;
import java.util.Map;
import java.util.logging.Logger;
import java.util.stream.Collectors;

/**
 * Servlet pour le tableau de bord utilisateur avec statistiques et recommandations
 */
public class UserDashboardServlet extends HttpServlet {

    private static final Logger LOGGER = Logger.getLogger(UserDashboardServlet.class.getName());
    private final ReservationDAO reservationDAO = new ReservationDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("userId") == null) {
            response.sendRedirect(request.getContextPath() + "/auth/login");
            return;
        }

        Long userId = (Long) session.getAttribute("userId");
        EntityManager em = JPAUtil.getEntityManager();

        try {
            // Récupérer toutes les réservations de l'utilisateur
            List<Reservation> allReservations = reservationDAO.findByUserId(em, userId);
            
            // Statistiques générales
            int totalReservations = allReservations.size();
            long confirmedCount = allReservations.stream()
                    .filter(r -> r.getStatus().name().equals("CONFIRMEE"))
                    .count();
            
            // Total dépensé
            BigDecimal totalSpent = allReservations.stream()
                    .filter(r -> r.getPayment() != null)
                    .map(r -> r.getPayment().getAmount())
                    .reduce(BigDecimal.ZERO, BigDecimal::add);
            
            // Réservations par type
            Map<ReservationType, Long> reservationsByType = allReservations.stream()
                    .collect(Collectors.groupingBy(Reservation::getType, Collectors.counting()));
            
            // Dernières réservations (5 max)
            List<Reservation> recentReservations = allReservations.stream()
                    .sorted((r1, r2) -> r2.getCreatedAt().compareTo(r1.getCreatedAt()))
                    .limit(5)
                    .collect(Collectors.toList());
            
            // Type de voyage préféré (pour recommandations)
            ReservationType favoriteType = reservationsByType.entrySet().stream()
                    .max(Map.Entry.comparingByValue())
                    .map(Map.Entry::getKey)
                    .orElse(ReservationType.FLIGHT);
            
            // Passer les données à la JSP
            request.setAttribute("totalReservations", totalReservations);
            request.setAttribute("confirmedCount", confirmedCount);
            request.setAttribute("totalSpent", totalSpent);
            request.setAttribute("reservationsByType", reservationsByType);
            request.setAttribute("recentReservations", recentReservations);
            request.setAttribute("favoriteType", favoriteType);
            
            LOGGER.info("Dashboard chargé pour user " + userId + " - " + totalReservations + " réservations");
            
            request.getRequestDispatcher("/WEB-INF/views/user/dashboard.jsp").forward(request, response);
            
        } catch (Exception e) {
            LOGGER.severe("Erreur chargement dashboard: " + e.getMessage());
            request.setAttribute("error", "Erreur lors du chargement du tableau de bord");
            request.getRequestDispatcher("/WEB-INF/views/error.jsp").forward(request, response);
        } finally {
            if (em != null && em.isOpen()) {
                em.close();
            }
        }
    }
}
