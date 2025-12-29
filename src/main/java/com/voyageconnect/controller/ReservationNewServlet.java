package com.voyageconnect.controller;

import java.io.IOException;
import java.time.LocalDateTime;
import java.util.Optional;
import java.util.logging.Level;
import java.util.logging.Logger;

import javax.persistence.EntityManager;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.voyageconnect.dao.CircuitDAO;
import com.voyageconnect.dao.FlightDAO;
import com.voyageconnect.dao.HotelDAO;
import com.voyageconnect.model.Circuit;
import com.voyageconnect.model.Flight;
import com.voyageconnect.model.Hotel;
import com.voyageconnect.model.Reservation;
import com.voyageconnect.model.ReservationStatus;
import com.voyageconnect.model.ReservationType;
import com.voyageconnect.model.User;
import com.voyageconnect.util.JPAUtil;

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

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        // Vérifier que l'utilisateur est connecté
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("userId") == null) {
            response.sendRedirect(request.getContextPath() + "/auth/login");
            return;
        }

        Long userId = (Long) session.getAttribute("userId");
        String type = request.getParameter("type");
        
        LOGGER.info("Soumission de réservation - Type: " + type + ", User ID: " + userId);

        EntityManager em = JPAUtil.getEntityManager();
        try {
            em.getTransaction().begin();

            // Créer la réservation selon le type
            if ("FLIGHT".equalsIgnoreCase(type)) {
                createFlightReservation(request, userId, em);
            } else if ("HOTEL".equalsIgnoreCase(type)) {
                createHotelReservation(request, userId, em);
            } else if ("CIRCUIT".equalsIgnoreCase(type)) {
                createCircuitReservation(request, userId, em);
            } else {
                throw new IllegalArgumentException("Type de réservation invalide: " + type);
            }

            em.getTransaction().commit();
            LOGGER.info("Réservation créée avec succès pour l'utilisateur " + userId);
            
            // Rediriger vers la page de succès
            response.sendRedirect(request.getContextPath() + "/reservation/success");

        } catch (Exception e) {
            if (em.getTransaction().isActive()) {
                em.getTransaction().rollback();
            }
            LOGGER.log(Level.SEVERE, "Erreur lors de la création de la réservation", e);
            request.setAttribute("error", "Erreur lors de la création de la réservation: " + e.getMessage());
            request.getRequestDispatcher("/WEB-INF/views/reservation/error.jsp").forward(request, response);
        } finally {
            em.close();
        }
    }

    private void createFlightReservation(HttpServletRequest request, Long userId, EntityManager em) {
        Long flightId = Long.parseLong(request.getParameter("flightId"));
        int numberOfPassengers = Integer.parseInt(request.getParameter("numberOfPassengers"));
        
        LOGGER.info("Création de réservation vol - Flight ID: " + flightId + ", Passagers: " + numberOfPassengers);
        
        // Récupérer le vol et l'utilisateur
        Flight flight = em.find(Flight.class, flightId);
        User user = em.find(User.class, userId);
        
        if (flight == null) {
            throw new IllegalArgumentException("Vol non trouvé: " + flightId);
        }
        if (user == null) {
            throw new IllegalArgumentException("Utilisateur non trouvé: " + userId);
        }
        
        // Vérifier les places disponibles
        if (flight.getAvailableSeats() < numberOfPassengers) {
            throw new IllegalArgumentException("Pas assez de places disponibles");
        }
        
        // Créer la réservation
        Reservation reservation = new Reservation();
        reservation.setUser(user);
        reservation.setType(ReservationType.FLIGHT);
        reservation.setFlight(flight);
        reservation.setNumberOfPeople(numberOfPassengers);
        reservation.setTotalAmount(flight.getPrice().multiply(new java.math.BigDecimal(numberOfPassengers)));
        reservation.setStatus(ReservationStatus.EN_ATTENTE);
        
        // Mettre à jour les places disponibles
        flight.setAvailableSeats(flight.getAvailableSeats() - numberOfPassengers);
        
        // Persister
        em.persist(reservation);
        em.merge(flight);
        
        LOGGER.info("Réservation vol créée: " + reservation.getReservationNumber());
    }

    private void createHotelReservation(HttpServletRequest request, Long userId, EntityManager em) {
        Long hotelId = Long.parseLong(request.getParameter("hotelId"));
        int numberOfRooms = Integer.parseInt(request.getParameter("numberOfRooms"));
        String checkInStr = request.getParameter("checkInDate");
        String checkOutStr = request.getParameter("checkOutDate");
        
        LOGGER.info("Création de réservation hôtel - Hotel ID: " + hotelId + ", Chambres: " + numberOfRooms);
        
        // Récupérer l'hôtel et l'utilisateur
        Hotel hotel = em.find(Hotel.class, hotelId);
        User user = em.find(User.class, userId);
        
        if (hotel == null) {
            throw new IllegalArgumentException("Hôtel non trouvé: " + hotelId);
        }
        if (user == null) {
            throw new IllegalArgumentException("Utilisateur non trouvé: " + userId);
        }
        
        // Vérifier les chambres disponibles
        if (hotel.getAvailableRooms() < numberOfRooms) {
            throw new IllegalArgumentException("Pas assez de chambres disponibles");
        }
        
        // Parser les dates
        LocalDateTime checkIn = LocalDateTime.parse(checkInStr + "T14:00:00");
        LocalDateTime checkOut = LocalDateTime.parse(checkOutStr + "T12:00:00");
        
        // Calculer le nombre de nuits
        long nights = java.time.Duration.between(checkIn, checkOut).toDays();
        
        // Créer la réservation
        Reservation reservation = new Reservation();
        reservation.setUser(user);
        reservation.setType(ReservationType.HOTEL);
        reservation.setHotel(hotel);
        reservation.setCheckInDate(checkIn);
        reservation.setCheckOutDate(checkOut);
        reservation.setNumberOfPeople(numberOfRooms);
        reservation.setTotalAmount(hotel.getPricePerNight().multiply(new java.math.BigDecimal(numberOfRooms * nights)));
        reservation.setStatus(ReservationStatus.EN_ATTENTE);
        
        // Mettre à jour les chambres disponibles
        hotel.setAvailableRooms(hotel.getAvailableRooms() - numberOfRooms);
        
        // Persister
        em.persist(reservation);
        em.merge(hotel);
        
        LOGGER.info("Réservation hôtel créée: " + reservation.getReservationNumber());
    }

    private void createCircuitReservation(HttpServletRequest request, Long userId, EntityManager em) {
        Long circuitId = Long.parseLong(request.getParameter("circuitId"));
        int numberOfParticipants = Integer.parseInt(request.getParameter("numberOfParticipants"));
        
        LOGGER.info("Création de réservation circuit - Circuit ID: " + circuitId + ", Participants: " + numberOfParticipants);
        
        // Récupérer le circuit et l'utilisateur
        Circuit circuit = em.find(Circuit.class, circuitId);
        User user = em.find(User.class, userId);
        
        if (circuit == null) {
            throw new IllegalArgumentException("Circuit non trouvé: " + circuitId);
        }
        if (user == null) {
            throw new IllegalArgumentException("Utilisateur non trouvé: " + userId);
        }
        
        // Vérifier les places disponibles
        if (circuit.getAvailableSpots() < numberOfParticipants) {
            throw new IllegalArgumentException("Pas assez de places disponibles");
        }
        
        // Créer la réservation
        Reservation reservation = new Reservation();
        reservation.setUser(user);
        reservation.setType(ReservationType.CIRCUIT);
        reservation.setCircuit(circuit);
        reservation.setNumberOfPeople(numberOfParticipants);
        reservation.setTotalAmount(circuit.getPrice().multiply(new java.math.BigDecimal(numberOfParticipants)));
        reservation.setStatus(ReservationStatus.EN_ATTENTE);
        
        // Mettre à jour les places disponibles
        circuit.setAvailableSpots(circuit.getAvailableSpots() - numberOfParticipants);
        
        // Persister
        em.persist(reservation);
        em.merge(circuit);
        
        LOGGER.info("Réservation circuit créée: " + reservation.getReservationNumber());
    }
}
