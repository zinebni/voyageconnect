package com.voyageconnect.service;

import com.voyageconnect.dao.*;
import com.voyageconnect.exception.BusinessException;
import com.voyageconnect.model.*;
import com.voyageconnect.util.EmailUtil;
import com.voyageconnect.util.JPAUtil;
import com.voyageconnect.util.ValidationUtil;

import javax.persistence.EntityManager;
import javax.persistence.EntityTransaction;
import java.util.List;
import java.util.logging.Logger;

/**
 * Service d'administration (CRUD sur destinations, vols, hôtels, circuits, promotions, réservations)
 * Réservé aux administrateurs
 */
public class AdminService {

    private static final Logger LOGGER = Logger.getLogger(AdminService.class.getName());

    private final DestinationDAO destinationDAO = new DestinationDAO();
    private final FlightDAO flightDAO = new FlightDAO();
    private final HotelDAO hotelDAO = new HotelDAO();
    private final CircuitDAO circuitDAO = new CircuitDAO();
    private final PromotionDAO promotionDAO = new PromotionDAO();
    private final ReservationDAO reservationDAO = new ReservationDAO();

    // ========== DESTINATIONS ==========

    public Destination createDestination(Destination destination) throws BusinessException {
        EntityManager em = JPAUtil.getEntityManager();
        EntityTransaction tx = em.getTransaction();
        try {
            tx.begin();
            ValidationUtil.validateAndThrow(destination);
            destinationDAO.create(em, destination);
            tx.commit();
            return destination;
        } catch (Exception e) {
            if (tx.isActive()) tx.rollback();
            throw new BusinessException("Erreur création destination : " + e.getMessage(), e);
        } finally {
            JPAUtil.closeEntityManager(em);
        }
    }

    public Destination updateDestination(Destination destination) throws BusinessException {
        EntityManager em = JPAUtil.getEntityManager();
        EntityTransaction tx = em.getTransaction();
        try {
            tx.begin();
            ValidationUtil.validateAndThrow(destination);
            Destination updated = destinationDAO.update(em, destination);
            tx.commit();
            return updated;
        } catch (Exception e) {
            if (tx.isActive()) tx.rollback();
            throw new BusinessException("Erreur mise à jour destination : " + e.getMessage(), e);
        } finally {
            JPAUtil.closeEntityManager(em);
        }
    }

    public void deleteDestination(Long id) throws BusinessException {
        EntityManager em = JPAUtil.getEntityManager();
        EntityTransaction tx = em.getTransaction();
        try {
            tx.begin();
            destinationDAO.deleteById(em, id);
            tx.commit();
        } catch (Exception e) {
            if (tx.isActive()) tx.rollback();
            throw new BusinessException("Erreur suppression destination : " + e.getMessage(), e);
        } finally {
            JPAUtil.closeEntityManager(em);
        }
    }

    public List<Destination> getAllDestinations() {
        EntityManager em = JPAUtil.getEntityManager();
        try {
            return destinationDAO.findAll(em);
        } finally {
            JPAUtil.closeEntityManager(em);
        }
    }

    // ========== VOLS ==========

    public Flight createFlight(Flight flight) throws BusinessException {
        EntityManager em = JPAUtil.getEntityManager();
        EntityTransaction tx = em.getTransaction();
        try {
            tx.begin();
            ValidationUtil.validateAndThrow(flight);
            flightDAO.create(em, flight);
            tx.commit();
            return flight;
        } catch (Exception e) {
            if (tx.isActive()) tx.rollback();
            throw new BusinessException("Erreur création vol : " + e.getMessage(), e);
        } finally {
            JPAUtil.closeEntityManager(em);
        }
    }

    public Flight updateFlight(Flight flight) throws BusinessException {
        EntityManager em = JPAUtil.getEntityManager();
        EntityTransaction tx = em.getTransaction();
        try {
            tx.begin();
            ValidationUtil.validateAndThrow(flight);
            Flight updated = flightDAO.update(em, flight);
            tx.commit();
            return updated;
        } catch (Exception e) {
            if (tx.isActive()) tx.rollback();
            throw new BusinessException("Erreur mise à jour vol : " + e.getMessage(), e);
        } finally {
            JPAUtil.closeEntityManager(em);
        }
    }

    public void deleteFlight(Long id) throws BusinessException {
        EntityManager em = JPAUtil.getEntityManager();
        EntityTransaction tx = em.getTransaction();
        try {
            tx.begin();
            flightDAO.deleteById(em, id);
            tx.commit();
        } catch (Exception e) {
            if (tx.isActive()) tx.rollback();
            throw new BusinessException("Erreur suppression vol : " + e.getMessage(), e);
        } finally {
            JPAUtil.closeEntityManager(em);
        }
    }

    public List<Flight> getAllFlights() {
        EntityManager em = JPAUtil.getEntityManager();
        try {
            return flightDAO.findAll(em);
        } finally {
            JPAUtil.closeEntityManager(em);
        }
    }

    // ========== HÔTELS ==========

    public Hotel createHotel(Hotel hotel) throws BusinessException {
        EntityManager em = JPAUtil.getEntityManager();
        EntityTransaction tx = em.getTransaction();
        try {
            tx.begin();
            ValidationUtil.validateAndThrow(hotel);
            hotelDAO.create(em, hotel);
            tx.commit();
            return hotel;
        } catch (Exception e) {
            if (tx.isActive()) tx.rollback();
            throw new BusinessException("Erreur création hôtel : " + e.getMessage(), e);
        } finally {
            JPAUtil.closeEntityManager(em);
        }
    }

    public Hotel updateHotel(Hotel hotel) throws BusinessException {
        EntityManager em = JPAUtil.getEntityManager();
        EntityTransaction tx = em.getTransaction();
        try {
            tx.begin();
            ValidationUtil.validateAndThrow(hotel);
            Hotel updated = hotelDAO.update(em, hotel);
            tx.commit();
            return updated;
        } catch (Exception e) {
            if (tx.isActive()) tx.rollback();
            throw new BusinessException("Erreur mise à jour hôtel : " + e.getMessage(), e);
        } finally {
            JPAUtil.closeEntityManager(em);
        }
    }

    public void deleteHotel(Long id) throws BusinessException {
        EntityManager em = JPAUtil.getEntityManager();
        EntityTransaction tx = em.getTransaction();
        try {
            tx.begin();
            hotelDAO.deleteById(em, id);
            tx.commit();
        } catch (Exception e) {
            if (tx.isActive()) tx.rollback();
            throw new BusinessException("Erreur suppression hôtel : " + e.getMessage(), e);
        } finally {
            JPAUtil.closeEntityManager(em);
        }
    }

    public List<Hotel> getAllHotels() {
        EntityManager em = JPAUtil.getEntityManager();
        try {
            return hotelDAO.findAll(em);
        } finally {
            JPAUtil.closeEntityManager(em);
        }
    }

    // ========== CIRCUITS ==========

    public Circuit createCircuit(Circuit circuit) throws BusinessException {
        EntityManager em = JPAUtil.getEntityManager();
        EntityTransaction tx = em.getTransaction();
        try {
            tx.begin();
            ValidationUtil.validateAndThrow(circuit);
            circuitDAO.create(em, circuit);
            tx.commit();
            return circuit;
        } catch (Exception e) {
            if (tx.isActive()) tx.rollback();
            throw new BusinessException("Erreur création circuit : " + e.getMessage(), e);
        } finally {
            JPAUtil.closeEntityManager(em);
        }
    }

    public Circuit updateCircuit(Circuit circuit) throws BusinessException {
        EntityManager em = JPAUtil.getEntityManager();
        EntityTransaction tx = em.getTransaction();
        try {
            tx.begin();
            ValidationUtil.validateAndThrow(circuit);
            Circuit updated = circuitDAO.update(em, circuit);
            tx.commit();
            return updated;
        } catch (Exception e) {
            if (tx.isActive()) tx.rollback();
            throw new BusinessException("Erreur mise à jour circuit : " + e.getMessage(), e);
        } finally {
            JPAUtil.closeEntityManager(em);
        }
    }

    public void deleteCircuit(Long id) throws BusinessException {
        EntityManager em = JPAUtil.getEntityManager();
        EntityTransaction tx = em.getTransaction();
        try {
            tx.begin();
            circuitDAO.deleteById(em, id);
            tx.commit();
        } catch (Exception e) {
            if (tx.isActive()) tx.rollback();
            throw new BusinessException("Erreur suppression circuit : " + e.getMessage(), e);
        } finally {
            JPAUtil.closeEntityManager(em);
        }
    }

    public List<Circuit> getAllCircuits() {
        EntityManager em = JPAUtil.getEntityManager();
        try {
            return circuitDAO.findAll(em);
        } finally {
            JPAUtil.closeEntityManager(em);
        }
    }

    // ========== PROMOTIONS ==========

    public Promotion createPromotion(Promotion promotion) throws BusinessException {
        EntityManager em = JPAUtil.getEntityManager();
        EntityTransaction tx = em.getTransaction();
        try {
            tx.begin();
            ValidationUtil.validateAndThrow(promotion);
            promotionDAO.create(em, promotion);
            tx.commit();
            return promotion;
        } catch (Exception e) {
            if (tx.isActive()) tx.rollback();
            throw new BusinessException("Erreur création promotion : " + e.getMessage(), e);
        } finally {
            JPAUtil.closeEntityManager(em);
        }
    }

    public Promotion updatePromotion(Promotion promotion) throws BusinessException {
        EntityManager em = JPAUtil.getEntityManager();
        EntityTransaction tx = em.getTransaction();
        try {
            tx.begin();
            ValidationUtil.validateAndThrow(promotion);
            Promotion updated = promotionDAO.update(em, promotion);
            tx.commit();
            return updated;
        } catch (Exception e) {
            if (tx.isActive()) tx.rollback();
            throw new BusinessException("Erreur mise à jour promotion : " + e.getMessage(), e);
        } finally {
            JPAUtil.closeEntityManager(em);
        }
    }

    public void deletePromotion(Long id) throws BusinessException {
        EntityManager em = JPAUtil.getEntityManager();
        EntityTransaction tx = em.getTransaction();
        try {
            tx.begin();
            promotionDAO.deleteById(em, id);
            tx.commit();
        } catch (Exception e) {
            if (tx.isActive()) tx.rollback();
            throw new BusinessException("Erreur suppression promotion : " + e.getMessage(), e);
        } finally {
            JPAUtil.closeEntityManager(em);
        }
    }

    public List<Promotion> getAllPromotions() {
        EntityManager em = JPAUtil.getEntityManager();
        try {
            return promotionDAO.findAll(em);
        } finally {
            JPAUtil.closeEntityManager(em);
        }
    }

    // ========== RESERVATIONS ==========

    /**
     * Récupère toutes les réservations
     */
    public List<Reservation> getAllReservations() {
        EntityManager em = JPAUtil.getEntityManager();
        try {
            return reservationDAO.findAll(em);
        } finally {
            JPAUtil.closeEntityManager(em);
        }
    }

    /**
     * Récupère une réservation par son ID
     */
    public Reservation getReservationById(Long id) {
        EntityManager em = JPAUtil.getEntityManager();
        try {
            return reservationDAO.findById(em, id).orElse(null);
        } finally {
            JPAUtil.closeEntityManager(em);
        }
    }

    /**
     * Confirme une réservation et envoie un email de confirmation au client
     */
    public boolean confirmReservation(Long reservationId) throws BusinessException {
        EntityManager em = JPAUtil.getEntityManager();
        EntityTransaction tx = em.getTransaction();
        try {
            tx.begin();
            
            Reservation reservation = reservationDAO.findById(em, reservationId)
                    .orElseThrow(() -> new BusinessException("Réservation non trouvée"));
            
            if (reservation.getStatus() == ReservationStatus.CONFIRMEE) {
                throw new BusinessException("Cette réservation est déjà confirmée");
            }
            
            reservation.setStatus(ReservationStatus.CONFIRMEE);
            reservationDAO.update(em, reservation);
            
            tx.commit();
            
            // Envoyer l'email de confirmation
            String userEmail = reservation.getUser().getEmail();
            String userName = reservation.getUser().getFirstName() + " " + reservation.getUser().getLastName();
            String reservationNumber = reservation.getReservationNumber();
            String reservationType = reservation.getType().name();
            String details = buildReservationDetails(reservation);
            
            boolean emailSent = EmailUtil.sendAdminReservationConfirmation(
                    userEmail, userName, reservationNumber, reservationType, details);
            
            if (emailSent) {
                LOGGER.info("Email de confirmation envoyé à " + userEmail + " pour la réservation " + reservationNumber);
            } else {
                LOGGER.warning("Échec de l'envoi de l'email de confirmation à " + userEmail);
            }
            
            return emailSent;
            
        } catch (BusinessException e) {
            if (tx.isActive()) tx.rollback();
            throw e;
        } catch (Exception e) {
            if (tx.isActive()) tx.rollback();
            throw new BusinessException("Erreur lors de la confirmation : " + e.getMessage(), e);
        } finally {
            JPAUtil.closeEntityManager(em);
        }
    }

    /**
     * Annule une réservation et envoie un email d'annulation au client
     */
    public boolean cancelReservation(Long reservationId) throws BusinessException {
        EntityManager em = JPAUtil.getEntityManager();
        EntityTransaction tx = em.getTransaction();
        try {
            tx.begin();
            
            Reservation reservation = reservationDAO.findById(em, reservationId)
                    .orElseThrow(() -> new BusinessException("Réservation non trouvée"));
            
            if (reservation.getStatus() == ReservationStatus.ANNULEE) {
                throw new BusinessException("Cette réservation est déjà annulée");
            }
            
            reservation.setStatus(ReservationStatus.ANNULEE);
            reservationDAO.update(em, reservation);
            
            tx.commit();
            
            // Envoyer l'email d'annulation
            String userEmail = reservation.getUser().getEmail();
            String userName = reservation.getUser().getFirstName() + " " + reservation.getUser().getLastName();
            String reservationNumber = reservation.getReservationNumber();
            String reservationType = reservation.getType().name();
            
            boolean emailSent = EmailUtil.sendAdminReservationCancellation(
                    userEmail, userName, reservationNumber, reservationType);
            
            if (emailSent) {
                LOGGER.info("Email d'annulation envoyé à " + userEmail + " pour la réservation " + reservationNumber);
            } else {
                LOGGER.warning("Échec de l'envoi de l'email d'annulation à " + userEmail);
            }
            
            return emailSent;
            
        } catch (BusinessException e) {
            if (tx.isActive()) tx.rollback();
            throw e;
        } catch (Exception e) {
            if (tx.isActive()) tx.rollback();
            throw new BusinessException("Erreur lors de l'annulation : " + e.getMessage(), e);
        } finally {
            JPAUtil.closeEntityManager(em);
        }
    }

    /**
     * Construit les détails de la réservation pour l'email
     */
    private String buildReservationDetails(Reservation reservation) {
        StringBuilder details = new StringBuilder();
        
        switch (reservation.getType()) {
            case FLIGHT:
                if (reservation.getFlight() != null) {
                    Flight flight = reservation.getFlight();
                    details.append("Vol ").append(flight.getFlightNumber())
                           .append(" - ").append(flight.getDepartureCity())
                           .append(" → ").append(flight.getDestination() != null ? flight.getDestination().getName() : "")
                           .append("<br>Compagnie: ").append(flight.getAirline())
                           .append("<br>Classe: ").append(flight.getFlightClass());
                }
                break;
            case HOTEL:
                if (reservation.getHotel() != null) {
                    Hotel hotel = reservation.getHotel();
                    details.append("Hôtel ").append(hotel.getName())
                           .append(" (").append(hotel.getStars()).append("★)")
                           .append("<br>Adresse: ").append(hotel.getAddress());
                    if (reservation.getCheckInDate() != null && reservation.getCheckOutDate() != null) {
                        details.append("<br>Du ").append(reservation.getCheckInDate().toLocalDate())
                               .append(" au ").append(reservation.getCheckOutDate().toLocalDate());
                    }
                }
                break;
            case CIRCUIT:
                if (reservation.getCircuit() != null) {
                    Circuit circuit = reservation.getCircuit();
                    details.append("Circuit: ").append(circuit.getName())
                           .append("<br>Durée: ").append(circuit.getDurationDays()).append(" jours")
                           .append("<br>Destination: ").append(circuit.getDestination() != null ? circuit.getDestination().getName() : "");
                }
                break;
            case PACKAGE:
                details.append("Package voyage");
                if (reservation.getFlight() != null) {
                    details.append("<br>Vol: ").append(reservation.getFlight().getFlightNumber());
                }
                if (reservation.getHotel() != null) {
                    details.append("<br>Hôtel: ").append(reservation.getHotel().getName());
                }
                break;
            default:
                details.append("Réservation ").append(reservation.getType());
        }
        
        details.append("<br><br>Nombre de personnes: ").append(reservation.getNumberOfPeople())
               .append("<br>Montant total: ").append(reservation.getTotalAmount()).append(" MAD");
        
        return details.toString();
    }
}
