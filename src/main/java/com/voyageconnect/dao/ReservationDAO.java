package com.voyageconnect.dao;

import com.voyageconnect.model.Reservation;
import com.voyageconnect.model.ReservationStatus;

import javax.persistence.EntityManager;
import javax.persistence.TypedQuery;
import java.util.List;
import java.util.Optional;

/**
 * DAO pour l'entité Reservation
 */
public class ReservationDAO extends GenericDAO<Reservation> {

    public ReservationDAO() {
        super(Reservation.class);
    }

    /**
     * Trouve une réservation par son numéro
     * @param em EntityManager
     * @param reservationNumber Numéro de réservation
     * @return Optional contenant la réservation si trouvée
     */
    public Optional<Reservation> findByReservationNumber(EntityManager em, String reservationNumber) {
        try {
            TypedQuery<Reservation> query = em.createQuery(
                    "SELECT r FROM Reservation r WHERE r.reservationNumber = :number", 
                    Reservation.class);
            query.setParameter("number", reservationNumber);
            return Optional.of(query.getSingleResult());
        } catch (Exception e) {
            return Optional.empty();
        }
    }

    /**
     * Récupère toutes les réservations d'un utilisateur
     * @param em EntityManager
     * @param userId ID de l'utilisateur
     * @return Liste des réservations de l'utilisateur
     */
    public List<Reservation> findByUserId(EntityManager em, Long userId) {
        TypedQuery<Reservation> query = em.createQuery(
                "SELECT r FROM Reservation r WHERE r.user.id = :userId " +
                "ORDER BY r.createdAt DESC", Reservation.class);
        query.setParameter("userId", userId);
        return query.getResultList();
    }

    /**
     * Récupère les réservations par statut
     * @param em EntityManager
     * @param status Statut de réservation
     * @return Liste des réservations avec ce statut
     */
    public List<Reservation> findByStatus(EntityManager em, ReservationStatus status) {
        TypedQuery<Reservation> query = em.createQuery(
                "SELECT r FROM Reservation r WHERE r.status = :status " +
                "ORDER BY r.createdAt DESC", Reservation.class);
        query.setParameter("status", status);
        return query.getResultList();
    }

    /**
     * Récupère les réservations d'un utilisateur par statut
     * @param em EntityManager
     * @param userId ID de l'utilisateur
     * @param status Statut de réservation
     * @return Liste des réservations
     */
    public List<Reservation> findByUserIdAndStatus(EntityManager em, Long userId, 
                                                    ReservationStatus status) {
        TypedQuery<Reservation> query = em.createQuery(
                "SELECT r FROM Reservation r WHERE r.user.id = :userId " +
                "AND r.status = :status " +
                "ORDER BY r.createdAt DESC", Reservation.class);
        query.setParameter("userId", userId);
        query.setParameter("status", status);
        return query.getResultList();
    }

    /**
     * Compte les réservations d'un utilisateur
     * @param em EntityManager
     * @param userId ID de l'utilisateur
     * @return Nombre de réservations
     */
    public long countByUserId(EntityManager em, Long userId) {
        return em.createQuery(
                "SELECT COUNT(r) FROM Reservation r WHERE r.user.id = :userId", Long.class)
                .setParameter("userId", userId)
                .getSingleResult();
    }

    /**
     * Récupère les dernières réservations
     * @param em EntityManager
     * @param limit Nombre maximum de réservations
     * @return Liste des dernières réservations
     */
    public List<Reservation> findLatestReservations(EntityManager em, int limit) {
        TypedQuery<Reservation> query = em.createQuery(
                "SELECT r FROM Reservation r ORDER BY r.createdAt DESC", Reservation.class);
        query.setMaxResults(limit);
        return query.getResultList();
    }
}
