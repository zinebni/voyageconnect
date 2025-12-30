package com.voyageconnect.controller;

import java.io.IOException;
import java.time.format.DateTimeFormatter;
import java.util.logging.Logger;

import javax.persistence.EntityManager;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.voyageconnect.dao.ReservationDAO;
import com.voyageconnect.model.Reservation;
import com.voyageconnect.service.AdminService;
import com.voyageconnect.util.JPAUtil;

/**
 * Servlet pour afficher les détails d'une réservation côté admin
 * Permet de confirmer ou annuler la réservation avec envoi d'email
 */
public class AdminReservationViewServlet extends HttpServlet {

    private static final Logger LOGGER = Logger.getLogger(AdminReservationViewServlet.class.getName());
    
    private final ReservationDAO reservationDAO = new ReservationDAO();
    private final AdminService adminService = new AdminService();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String idParam = request.getParameter("id");
        
        if (idParam == null || idParam.isEmpty()) {
            request.getSession().setAttribute("error", "ID de réservation manquant");
            response.sendRedirect(request.getContextPath() + "/admin/dashboard");
            return;
        }
        
        EntityManager em = JPAUtil.getEntityManager();
        
        try {
            Long reservationId = Long.parseLong(idParam);
            Reservation reservation = reservationDAO.findById(em, reservationId).orElse(null);
            
            if (reservation == null) {
                request.getSession().setAttribute("error", "Réservation non trouvée");
                response.sendRedirect(request.getContextPath() + "/admin/dashboard");
                return;
            }
            
            // Formater les dates pour l'affichage
            DateTimeFormatter formatter = DateTimeFormatter.ofPattern("dd/MM/yyyy HH:mm");
            if (reservation.getCreatedAt() != null) {
                reservation.setCreatedAtFormatted(reservation.getCreatedAt().format(formatter));
            }
            
            // Formater les dates du vol si présent
            if (reservation.getFlight() != null) {
                DateTimeFormatter flightFormatter = DateTimeFormatter.ofPattern("dd/MM/yyyy HH:mm");
                if (reservation.getFlight().getDepartureDate() != null) {
                    reservation.getFlight().setDepartureDateFormatted(
                        reservation.getFlight().getDepartureDate().format(flightFormatter)
                    );
                }
                if (reservation.getFlight().getArrivalDate() != null) {
                    reservation.getFlight().setArrivalDateFormatted(
                        reservation.getFlight().getArrivalDate().format(flightFormatter)
                    );
                }
            }
            
            request.setAttribute("reservation", reservation);
            
            LOGGER.info("Admin - Affichage détails réservation: " + reservation.getReservationNumber());
            
            request.getRequestDispatcher("/WEB-INF/views/admin/reservation-view.jsp").forward(request, response);
            
        } catch (NumberFormatException e) {
            request.getSession().setAttribute("error", "ID de réservation invalide");
            response.sendRedirect(request.getContextPath() + "/admin/dashboard");
        } catch (Exception e) {
            LOGGER.severe("Erreur chargement détails réservation: " + e.getMessage());
            e.printStackTrace();
            request.getSession().setAttribute("error", "Erreur: " + e.getMessage());
            response.sendRedirect(request.getContextPath() + "/admin/dashboard");
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
            
            LOGGER.info("Admin - Action " + action + " sur réservation " + reservationId + " - Email: " + emailSent);
            
            // Rediriger vers la page de détails pour voir le nouveau statut
            response.sendRedirect(request.getContextPath() + "/admin/reservation/view?id=" + reservationId);
            
        } catch (NumberFormatException e) {
            request.getSession().setAttribute("error", "ID de réservation invalide");
            response.sendRedirect(request.getContextPath() + "/admin/dashboard");
        } catch (Exception e) {
            LOGGER.severe("Erreur action réservation: " + e.getMessage());
            request.getSession().setAttribute("error", "Erreur: " + e.getMessage());
            response.sendRedirect(request.getContextPath() + "/admin/dashboard");
        }
    }
}
