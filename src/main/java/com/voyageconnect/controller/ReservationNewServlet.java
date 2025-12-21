package com.voyageconnect.controller;

import com.voyageconnect.dao.CircuitDAO;
import com.voyageconnect.dao.FlightDAO;
import com.voyageconnect.dao.HotelDAO;
import com.voyageconnect.model.Circuit;
import com.voyageconnect.model.Flight;
import com.voyageconnect.model.Hotel;
import com.voyageconnect.util.JPAUtil;

import javax.persistence.EntityManager;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.Optional;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 * Servlet pour afficher le formulaire de nouvelle réservation
 * URL : /reservation/new?type=flight&id=15
 */
public class ReservationNewServlet extends HttpServlet {

    private static final Logger LOGGER = Logger.getLogger(ReservationNewServlet.class.getName());
    
    private final FlightDAO flightDAO = new FlightDAO();
    private final HotelDAO hotelDAO = new HotelDAO();
    private final CircuitDAO circuitDAO = new CircuitDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Vérifier que l'utilisateur est connecté
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("userId") == null) {
            LOGGER.warning("Tentative d'accès sans session - Redirection vers login");
            response.sendRedirect(request.getContextPath() + "/auth/login");
            return;
        }

        String type = request.getParameter("type");
        String idStr = request.getParameter("id");
        
        LOGGER.info("Demande de réservation - Type: " + type + ", ID: " + idStr);

        if (type == null || idStr == null) {
            request.setAttribute("error", "Paramètres manquants : type et id requis");
            request.getRequestDispatcher("/WEB-INF/views/reservation/error.jsp").forward(request, response);
            return;
        }

        EntityManager em = JPAUtil.getEntityManager();
        try {
            Long id = Long.parseLong(idStr);

            switch (type.toLowerCase()) {
                case "flight":
                    showFlightReservationForm(request, response, em, id);
                    break;
                case "hotel":
                    showHotelReservationForm(request, response, em, id);
                    break;
                case "circuit":
                    showCircuitReservationForm(request, response, em, id);
                    break;
                default:
                    request.setAttribute("error", "Type de réservation invalide : " + type);
                    request.getRequestDispatcher("/WEB-INF/views/reservation/error.jsp").forward(request, response);
                    break;
            }
        } catch (NumberFormatException e) {
            LOGGER.log(Level.WARNING, "ID invalide: " + idStr, e);
            request.setAttribute("error", "ID invalide: '" + idStr + "'. Veuillez vérifier le lien.");
            request.getRequestDispatcher("/WEB-INF/views/reservation/error.jsp").forward(request, response);
        } catch (Exception e) {
            LOGGER.log(Level.SEVERE, "Erreur inattendue lors de l'affichage du formulaire", e);
            request.setAttribute("error", "Erreur technique: " + e.getMessage());
            request.getRequestDispatcher("/WEB-INF/views/reservation/error.jsp").forward(request, response);
        } finally {
            if (em != null && em.isOpen()) {
                em.close();
            }
        }
    }

    /**
     * Affiche le formulaire de réservation de vol
     */
    private void showFlightReservationForm(HttpServletRequest request, HttpServletResponse response,
                                           EntityManager em, Long flightId)
            throws ServletException, IOException {

        LOGGER.info("Recherche du vol avec ID: " + flightId);
        Optional<Flight> flightOpt = flightDAO.findById(em, flightId);
        
        if (!flightOpt.isPresent()) {
            LOGGER.warning("Vol introuvable avec ID: " + flightId);
            request.setAttribute("error", 
                "Vol introuvable (ID: " + flightId + "). Ce vol n'existe pas ou a été supprimé. " +
                "Veuillez rechercher un autre vol.");
            request.getRequestDispatcher("/WEB-INF/views/reservation/error.jsp").forward(request, response);
            return;
        }

        Flight flight = flightOpt.get();
        
        if (!flight.getActive()) {
            LOGGER.warning("Tentative de réservation d'un vol inactif: " + flightId);
            request.setAttribute("error", 
                "Ce vol n'est plus disponible (ID: " + flightId + "). " +
                "Veuillez rechercher un autre vol.");
            request.getRequestDispatcher("/WEB-INF/views/reservation/error.jsp").forward(request, response);
            return;
        }
        
        if (flight.getAvailableSeats() <= 0) {
            LOGGER.warning("Vol complet: " + flightId);
            request.setAttribute("error", 
                "Ce vol est complet (ID: " + flightId + "). " +
                "Veuillez rechercher un autre vol.");
            request.getRequestDispatcher("/WEB-INF/views/reservation/error.jsp").forward(request, response);
            return;
        }
        
        LOGGER.info("Vol trouvé: " + flight.getFlightNumber() + " - " + flight.getAirline());
        request.setAttribute("flight", flight);
        request.setAttribute("reservationType", "FLIGHT");
        request.getRequestDispatcher("/WEB-INF/views/reservation/form.jsp").forward(request, response);
    }

    /**
     * Affiche le formulaire de réservation d'hôtel
     */
    private void showHotelReservationForm(HttpServletRequest request, HttpServletResponse response,
                                          EntityManager em, Long hotelId)
            throws ServletException, IOException {

        LOGGER.info("Recherche de l'hôtel avec ID: " + hotelId);
        Optional<Hotel> hotelOpt = hotelDAO.findById(em, hotelId);
        
        if (!hotelOpt.isPresent()) {
            LOGGER.warning("Hôtel introuvable avec ID: " + hotelId);
            request.setAttribute("error", 
                "Hôtel introuvable (ID: " + hotelId + "). Cet hôtel n'existe pas ou a été supprimé. " +
                "Veuillez rechercher un autre hôtel.");
            request.getRequestDispatcher("/WEB-INF/views/reservation/error.jsp").forward(request, response);
            return;
        }

        Hotel hotel = hotelOpt.get();
        
        if (!hotel.getActive()) {
            LOGGER.warning("Tentative de réservation d'un hôtel inactif: " + hotelId);
            request.setAttribute("error", 
                "Cet hôtel n'est plus disponible (ID: " + hotelId + "). " +
                "Veuillez rechercher un autre hôtel.");
            request.getRequestDispatcher("/WEB-INF/views/reservation/error.jsp").forward(request, response);
            return;
        }
        
        LOGGER.info("Hôtel trouvé: " + hotel.getName());
        request.setAttribute("hotel", hotel);
        request.setAttribute("reservationType", "HOTEL");
        request.getRequestDispatcher("/WEB-INF/views/reservation/form.jsp").forward(request, response);
    }

    /**
     * Affiche le formulaire de réservation de circuit
     */
    private void showCircuitReservationForm(HttpServletRequest request, HttpServletResponse response,
                                            EntityManager em, Long circuitId)
            throws ServletException, IOException {

        LOGGER.info("Recherche du circuit avec ID: " + circuitId);
        Optional<Circuit> circuitOpt = circuitDAO.findById(em, circuitId);
        
        if (!circuitOpt.isPresent()) {
            LOGGER.warning("Circuit introuvable avec ID: " + circuitId);
            request.setAttribute("error", 
                "Circuit introuvable (ID: " + circuitId + "). Ce circuit n'existe pas ou a été supprimé. " +
                "Veuillez rechercher un autre circuit.");
            request.getRequestDispatcher("/WEB-INF/views/reservation/error.jsp").forward(request, response);
            return;
        }

        Circuit circuit = circuitOpt.get();
        
        if (!circuit.getActive()) {
            LOGGER.warning("Tentative de réservation d'un circuit inactif: " + circuitId);
            request.setAttribute("error", 
                "Ce circuit n'est plus disponible (ID: " + circuitId + "). " +
                "Veuillez rechercher un autre circuit.");
            request.getRequestDispatcher("/WEB-INF/views/reservation/error.jsp").forward(request, response);
            return;
        }
        
        if (circuit.getAvailableSpots() <= 0) {
            LOGGER.warning("Circuit complet: " + circuitId);
            request.setAttribute("error", 
                "Ce circuit est complet (ID: " + circuitId + "). " +
                "Veuillez rechercher un autre circuit.");
            request.getRequestDispatcher("/WEB-INF/views/reservation/error.jsp").forward(request, response);
            return;
        }
        
        LOGGER.info("Circuit trouvé: " + circuit.getName());
        request.setAttribute("circuit", circuit);
        request.setAttribute("reservationType", "CIRCUIT");
        request.getRequestDispatcher("/WEB-INF/views/reservation/form.jsp").forward(request, response);
    }
}
