package com.voyageconnect.dao;

import com.voyageconnect.model.Review;

import javax.persistence.EntityManager;
import javax.persistence.TypedQuery;
import java.util.List;

/**
 * DAO pour l'entité Review
 */
public class ReviewDAO extends GenericDAO<Review> {

    public ReviewDAO() {
        super(Review.class);
    }

    /**
     * Récupère les avis d'un utilisateur
     * @param em EntityManager
     * @param userId ID de l'utilisateur
     * @return Liste des avis de l'utilisateur
     */
    public List<Review> findByUserId(EntityManager em, Long userId) {
        TypedQuery<Review> query = em.createQuery(
                "SELECT r FROM Review r WHERE r.user.id = :userId " +
                "ORDER BY r.createdAt DESC", Review.class);
        query.setParameter("userId", userId);
        return query.getResultList();
    }

    /**
     * Récupère les avis pour un vol
     * @param em EntityManager
     * @param flightId ID du vol
     * @return Liste des avis du vol
     */
    public List<Review> findByFlightId(EntityManager em, Long flightId) {
        TypedQuery<Review> query = em.createQuery(
                "SELECT r FROM Review r WHERE r.flight.id = :flightId " +
                "ORDER BY r.createdAt DESC", Review.class);
        query.setParameter("flightId", flightId);
        return query.getResultList();
    }

    /**
     * Récupère les avis pour un hôtel
     * @param em EntityManager
     * @param hotelId ID de l'hôtel
     * @return Liste des avis de l'hôtel
     */
    public List<Review> findByHotelId(EntityManager em, Long hotelId) {
        TypedQuery<Review> query = em.createQuery(
                "SELECT r FROM Review r WHERE r.hotel.id = :hotelId " +
                "ORDER BY r.createdAt DESC", Review.class);
        query.setParameter("hotelId", hotelId);
        return query.getResultList();
    }

    /**
     * Récupère les avis pour un circuit
     * @param em EntityManager
     * @param circuitId ID du circuit
     * @return Liste des avis du circuit
     */
    public List<Review> findByCircuitId(EntityManager em, Long circuitId) {
        TypedQuery<Review> query = em.createQuery(
                "SELECT r FROM Review r WHERE r.circuit.id = :circuitId " +
                "ORDER BY r.createdAt DESC", Review.class);
        query.setParameter("circuitId", circuitId);
        return query.getResultList();
    }

    /**
     * Calcule la note moyenne pour un vol
     * @param em EntityManager
     * @param flightId ID du vol
     * @return Note moyenne
     */
    public Double getAverageRatingForFlight(EntityManager em, Long flightId) {
        return em.createQuery(
                "SELECT AVG(r.rating) FROM Review r WHERE r.flight.id = :flightId", Double.class)
                .setParameter("flightId", flightId)
                .getSingleResult();
    }

    /**
     * Calcule la note moyenne pour un hôtel
     * @param em EntityManager
     * @param hotelId ID de l'hôtel
     * @return Note moyenne
     */
    public Double getAverageRatingForHotel(EntityManager em, Long hotelId) {
        return em.createQuery(
                "SELECT AVG(r.rating) FROM Review r WHERE r.hotel.id = :hotelId", Double.class)
                .setParameter("hotelId", hotelId)
                .getSingleResult();
    }

    /**
     * Calcule la note moyenne pour un circuit
     * @param em EntityManager
     * @param circuitId ID du circuit
     * @return Note moyenne
     */
    public Double getAverageRatingForCircuit(EntityManager em, Long circuitId) {
        return em.createQuery(
                "SELECT AVG(r.rating) FROM Review r WHERE r.circuit.id = :circuitId", Double.class)
                .setParameter("circuitId", circuitId)
                .getSingleResult();
    }
}
