package com.voyageconnect.service;

import com.voyageconnect.dao.ReviewDAO;
import com.voyageconnect.exception.BusinessException;
import com.voyageconnect.model.Review;
import com.voyageconnect.util.JPAUtil;
import com.voyageconnect.util.ValidationUtil;

import javax.persistence.EntityManager;
import javax.persistence.EntityTransaction;
import java.util.List;

/**
 * Service pour la gestion des avis
 */
public class ReviewService {

    private final ReviewDAO reviewDAO = new ReviewDAO();

    /**
     * Crée un avis
     */
    public Review createReview(Review review) throws BusinessException {
        EntityManager em = JPAUtil.getEntityManager();
        EntityTransaction tx = em.getTransaction();
        try {
            tx.begin();
            ValidationUtil.validateAndThrow(review);
            reviewDAO.create(em, review);
            tx.commit();
            return review;
        } catch (Exception e) {
            if (tx.isActive()) tx.rollback();
            throw new BusinessException("Erreur création avis : " + e.getMessage(), e);
        } finally {
            JPAUtil.closeEntityManager(em);
        }
    }

    /**
     * Récupère les avis d'un utilisateur
     */
    public List<Review> getUserReviews(Long userId) {
        EntityManager em = JPAUtil.getEntityManager();
        try {
            return reviewDAO.findByUserId(em, userId);
        } finally {
            JPAUtil.closeEntityManager(em);
        }
    }

    /**
     * Récupère les avis d'un vol
     */
    public List<Review> getFlightReviews(Long flightId) {
        EntityManager em = JPAUtil.getEntityManager();
        try {
            return reviewDAO.findByFlightId(em, flightId);
        } finally {
            JPAUtil.closeEntityManager(em);
        }
    }

    /**
     * Récupère les avis d'un hôtel
     */
    public List<Review> getHotelReviews(Long hotelId) {
        EntityManager em = JPAUtil.getEntityManager();
        try {
            return reviewDAO.findByHotelId(em, hotelId);
        } finally {
            JPAUtil.closeEntityManager(em);
        }
    }

    /**
     * Récupère les avis d'un circuit
     */
    public List<Review> getCircuitReviews(Long circuitId) {
        EntityManager em = JPAUtil.getEntityManager();
        try {
            return reviewDAO.findByCircuitId(em, circuitId);
        } finally {
            JPAUtil.closeEntityManager(em);
        }
    }
}
