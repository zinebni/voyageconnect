package com.voyageconnect.service;

import com.voyageconnect.dao.*;
import com.voyageconnect.exception.BusinessException;
import com.voyageconnect.model.*;
import com.voyageconnect.util.EmailUtil;
import com.voyageconnect.util.JPAUtil;
import com.voyageconnect.util.ValidationUtil;

import javax.persistence.EntityManager;
import javax.persistence.EntityTransaction;
import java.math.BigDecimal;
import java.time.LocalDateTime;
import java.util.List;
import java.util.Optional;

/**
 * Service pour la gestion des réservations
 * ⚠️ TRANSACTION ATOMIQUE : Toute la réservation (vol/hôtel/circuit + paiement) en UNE SEULE transaction
 */
public class ReservationService {

    private final ReservationDAO reservationDAO = new ReservationDAO();
    private final FlightDAO flightDAO = new FlightDAO();
    private final HotelDAO hotelDAO = new HotelDAO();
    private final CircuitDAO circuitDAO = new CircuitDAO();
    private final PaymentDAO paymentDAO = new PaymentDAO();
    private final UserDAO userDAO = new UserDAO();

    /**
     * Crée une réservation de vol avec paiement
     * ⚠️ TRANSACTION ATOMIQUE : Si le paiement échoue, ROLLBACK de tout
     */
    public Reservation createFlightReservation(Long userId, Long flightId, Integer numberOfPeople,
                                               PaymentMethod paymentMethod) throws BusinessException {
        EntityManager em = JPAUtil.getEntityManager();
        EntityTransaction tx = em.getTransaction();
        
        try {
            tx.begin(); // ===== DÉBUT TRANSACTION =====
            
            // 1. Récupérer l'utilisateur
            User user = userDAO.findById(em, userId)
                    .orElseThrow(() -> new BusinessException("Utilisateur introuvable"));
            
            // 2. Récupérer et vérifier le vol
            Flight flight = flightDAO.findById(em, flightId)
                    .orElseThrow(() -> new BusinessException("Vol introuvable"));
            
            if (!flight.isAvailable(numberOfPeople)) {
                throw new BusinessException("Pas assez de places disponibles");
            }
            
            // 3. Calculer le montant total
            BigDecimal totalAmount = flight.getPrice().multiply(new BigDecimal(numberOfPeople));
            
            // 4. Créer la réservation
            Reservation reservation = new Reservation();
            reservation.setUser(user);
            reservation.setType(ReservationType.FLIGHT);
            reservation.setFlight(flight);
            reservation.setNumberOfPeople(numberOfPeople);
            reservation.setTotalAmount(totalAmount);
            reservation.setStatus(ReservationStatus.EN_ATTENTE);
            
            ValidationUtil.validateAndThrow(reservation);
            reservationDAO.create(em, reservation);
            
            // 5. Créer le paiement (simulation)
            Payment payment = new Payment();
            payment.setReservation(reservation);
            payment.setAmount(totalAmount);
            payment.setPaymentMethod(paymentMethod);
            payment.setStatus(PaymentStatus.PENDING);
            
            // Simulation du traitement du paiement
            boolean paymentSuccess = processPayment(payment);
            
            if (!paymentSuccess) {
                throw new BusinessException("Le paiement a échoué");
            }
            
            payment.setStatus(PaymentStatus.COMPLETED);
            payment.setPaymentDate(LocalDateTime.now());
            paymentDAO.create(em, payment);
            
            // 6. Mettre à jour le statut de la réservation
            reservation.setStatus(ReservationStatus.CONFIRMEE);
            reservation.setPayment(payment);
            
            // 7. Mettre à jour la disponibilité du vol
            flight.setAvailableSeats(flight.getAvailableSeats() - numberOfPeople);
            flightDAO.update(em, flight);
            
            tx.commit(); // ===== COMMIT TRANSACTION =====
            
            // 8. Envoyer email de confirmation (hors transaction)
            String details = "Vol " + flight.getFlightNumber() + " - " + 
                           flight.getDepartureCity() + " → " + flight.getDestination().getName() +
                           "\nDate : " + flight.getDepartureDate() +
                           "\nPassagers : " + numberOfPeople +
                           "\nMontant : " + totalAmount + " €";
            EmailUtil.sendReservationConfirmation(user.getEmail(), user.getFullName(), 
                                                 reservation.getReservationNumber(), details);
            
            return reservation;
            
        } catch (Exception e) {
            if (tx.isActive()) {
                tx.rollback(); // ===== ROLLBACK EN CAS D'ERREUR =====
            }
            throw new BusinessException("Erreur lors de la réservation : " + e.getMessage(), e);
        } finally {
            JPAUtil.closeEntityManager(em);
        }
    }

    /**
     * Crée une réservation d'hôtel avec paiement
     * ⚠️ TRANSACTION ATOMIQUE
     */
    public Reservation createHotelReservation(Long userId, Long hotelId, Integer numberOfRooms,
                                             LocalDateTime checkIn, LocalDateTime checkOut,
                                             PaymentMethod paymentMethod) throws BusinessException {
        EntityManager em = JPAUtil.getEntityManager();
        EntityTransaction tx = em.getTransaction();
        
        try {
            tx.begin();
            
            User user = userDAO.findById(em, userId)
                    .orElseThrow(() -> new BusinessException("Utilisateur introuvable"));
            
            Hotel hotel = hotelDAO.findById(em, hotelId)
                    .orElseThrow(() -> new BusinessException("Hôtel introuvable"));
            
            if (!hotel.isAvailable(numberOfRooms)) {
                throw new BusinessException("Pas assez de chambres disponibles");
            }
            
            // Calculer le nombre de nuits
            long nights = java.time.Duration.between(checkIn, checkOut).toDays();
            BigDecimal totalAmount = hotel.getPricePerNight()
                    .multiply(new BigDecimal(numberOfRooms))
                    .multiply(new BigDecimal(nights));
            
            Reservation reservation = new Reservation();
            reservation.setUser(user);
            reservation.setType(ReservationType.HOTEL);
            reservation.setHotel(hotel);
            reservation.setCheckInDate(checkIn);
            reservation.setCheckOutDate(checkOut);
            reservation.setNumberOfPeople(numberOfRooms);
            reservation.setTotalAmount(totalAmount);
            reservation.setStatus(ReservationStatus.EN_ATTENTE);
            
            ValidationUtil.validateAndThrow(reservation);
            reservationDAO.create(em, reservation);
            
            // Paiement
            Payment payment = new Payment();
            payment.setReservation(reservation);
            payment.setAmount(totalAmount);
            payment.setPaymentMethod(paymentMethod);
            payment.setStatus(PaymentStatus.PENDING);
            
            if (!processPayment(payment)) {
                throw new BusinessException("Le paiement a échoué");
            }
            
            payment.setStatus(PaymentStatus.COMPLETED);
            payment.setPaymentDate(LocalDateTime.now());
            paymentDAO.create(em, payment);
            
            reservation.setStatus(ReservationStatus.CONFIRMEE);
            reservation.setPayment(payment);
            
            hotel.setAvailableRooms(hotel.getAvailableRooms() - numberOfRooms);
            hotelDAO.update(em, hotel);
            
            tx.commit();
            
            // Email
            String details = "Hôtel " + hotel.getName() + " (" + hotel.getStars() + " étoiles)\n" +
                           "Check-in : " + checkIn + "\nCheck-out : " + checkOut +
                           "\nChambres : " + numberOfRooms + "\nMontant : " + totalAmount + " €";
            EmailUtil.sendReservationConfirmation(user.getEmail(), user.getFullName(), 
                                                 reservation.getReservationNumber(), details);
            
            return reservation;
            
        } catch (Exception e) {
            if (tx.isActive()) {
                tx.rollback();
            }
            throw new BusinessException("Erreur lors de la réservation : " + e.getMessage(), e);
        } finally {
            JPAUtil.closeEntityManager(em);
        }
    }

    /**
     * Crée une réservation de circuit avec paiement
     * ⚠️ TRANSACTION ATOMIQUE
     */
    public Reservation createCircuitReservation(Long userId, Long circuitId, Integer numberOfPeople,
                                               PaymentMethod paymentMethod) throws BusinessException {
        EntityManager em = JPAUtil.getEntityManager();
        EntityTransaction tx = em.getTransaction();
        
        try {
            tx.begin();
            
            User user = userDAO.findById(em, userId)
                    .orElseThrow(() -> new BusinessException("Utilisateur introuvable"));
            
            Circuit circuit = circuitDAO.findById(em, circuitId)
                    .orElseThrow(() -> new BusinessException("Circuit introuvable"));
            
            if (!circuit.isAvailable(numberOfPeople)) {
                throw new BusinessException("Pas assez de places disponibles");
            }
            
            BigDecimal totalAmount = circuit.getPrice().multiply(new BigDecimal(numberOfPeople));
            
            Reservation reservation = new Reservation();
            reservation.setUser(user);
            reservation.setType(ReservationType.CIRCUIT);
            reservation.setCircuit(circuit);
            reservation.setNumberOfPeople(numberOfPeople);
            reservation.setTotalAmount(totalAmount);
            reservation.setStatus(ReservationStatus.EN_ATTENTE);
            
            ValidationUtil.validateAndThrow(reservation);
            reservationDAO.create(em, reservation);
            
            // Paiement
            Payment payment = new Payment();
            payment.setReservation(reservation);
            payment.setAmount(totalAmount);
            payment.setPaymentMethod(paymentMethod);
            payment.setStatus(PaymentStatus.PENDING);
            
            if (!processPayment(payment)) {
                throw new BusinessException("Le paiement a échoué");
            }
            
            payment.setStatus(PaymentStatus.COMPLETED);
            payment.setPaymentDate(LocalDateTime.now());
            paymentDAO.create(em, payment);
            
            reservation.setStatus(ReservationStatus.CONFIRMEE);
            reservation.setPayment(payment);
            
            circuit.setAvailableSpots(circuit.getAvailableSpots() - numberOfPeople);
            circuitDAO.update(em, circuit);
            
            tx.commit();
            
            // Email
            String details = "Circuit " + circuit.getName() + " (" + circuit.getDurationDays() + " jours)\n" +
                           "Départ : " + circuit.getStartDate() +
                           "\nPersonnes : " + numberOfPeople + "\nMontant : " + totalAmount + " €";
            EmailUtil.sendReservationConfirmation(user.getEmail(), user.getFullName(), 
                                                 reservation.getReservationNumber(), details);
            
            return reservation;
            
        } catch (Exception e) {
            if (tx.isActive()) {
                tx.rollback();
            }
            throw new BusinessException("Erreur lors de la réservation : " + e.getMessage(), e);
        } finally {
            JPAUtil.closeEntityManager(em);
        }
    }

    /**
     * Annule une réservation et rembourse
     * ⚠️ TRANSACTION ATOMIQUE
     */
    public void cancelReservation(Long reservationId, Long userId) throws BusinessException {
        EntityManager em = JPAUtil.getEntityManager();
        EntityTransaction tx = em.getTransaction();
        
        try {
            tx.begin();
            
            Reservation reservation = reservationDAO.findById(em, reservationId)
                    .orElseThrow(() -> new BusinessException("Réservation introuvable"));
            
            if (!reservation.getUser().getId().equals(userId)) {
                throw new BusinessException("Vous n'êtes pas autorisé à annuler cette réservation");
            }
            
            if (reservation.getStatus() == ReservationStatus.ANNULEE) {
                throw new BusinessException("Cette réservation est déjà annulée");
            }
            
            // Mettre à jour le statut
            reservation.setStatus(ReservationStatus.ANNULEE);
            
            // Restaurer la disponibilité
            if (reservation.getFlight() != null) {
                Flight flight = reservation.getFlight();
                flight.setAvailableSeats(flight.getAvailableSeats() + reservation.getNumberOfPeople());
                flightDAO.update(em, flight);
            } else if (reservation.getHotel() != null) {
                Hotel hotel = reservation.getHotel();
                hotel.setAvailableRooms(hotel.getAvailableRooms() + reservation.getNumberOfPeople());
                hotelDAO.update(em, hotel);
            } else if (reservation.getCircuit() != null) {
                Circuit circuit = reservation.getCircuit();
                circuit.setAvailableSpots(circuit.getAvailableSpots() + reservation.getNumberOfPeople());
                circuitDAO.update(em, circuit);
            }
            
            // Rembourser le paiement
            if (reservation.getPayment() != null) {
                Payment payment = reservation.getPayment();
                payment.setStatus(PaymentStatus.REFUNDED);
                paymentDAO.update(em, payment);
            }
            
            tx.commit();
            
            // Email d'annulation
            EmailUtil.sendReservationCancellation(reservation.getUser().getEmail(),
                    reservation.getUser().getFullName(), reservation.getReservationNumber());
            
        } catch (Exception e) {
            if (tx.isActive()) {
                tx.rollback();
            }
            throw new BusinessException("Erreur lors de l'annulation : " + e.getMessage(), e);
        } finally {
            JPAUtil.closeEntityManager(em);
        }
    }

    /**
     * Récupère les réservations d'un utilisateur
     */
    public List<Reservation> getUserReservations(Long userId) {
        EntityManager em = JPAUtil.getEntityManager();
        try {
            return reservationDAO.findByUserId(em, userId);
        } finally {
            JPAUtil.closeEntityManager(em);
        }
    }

    /**
     * Récupère une réservation par ID
     */
    public Reservation getReservationById(Long reservationId) throws BusinessException {
        EntityManager em = JPAUtil.getEntityManager();
        try {
            return reservationDAO.findById(em, reservationId)
                    .orElseThrow(() -> new BusinessException("Réservation introuvable"));
        } finally {
            JPAUtil.closeEntityManager(em);
        }
    }

    /**
     * Simulation du traitement du paiement
     * Dans un cas réel, cela appellerait l'API Stripe/PayPal
     */
    private boolean processPayment(Payment payment) {
        // Simulation : 95% de succès
        return Math.random() < 0.95;
    }
}
