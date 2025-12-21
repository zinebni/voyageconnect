package com.voyageconnect.dao;

import com.voyageconnect.model.Payment;
import com.voyageconnect.model.PaymentStatus;

import javax.persistence.EntityManager;
import javax.persistence.TypedQuery;
import java.util.List;
import java.util.Optional;

/**
 * DAO pour l'entité Payment
 */
public class PaymentDAO extends GenericDAO<Payment> {

    public PaymentDAO() {
        super(Payment.class);
    }

    /**
     * Trouve un paiement par ID de transaction
     * @param em EntityManager
     * @param transactionId ID de transaction
     * @return Optional contenant le paiement si trouvé
     */
    public Optional<Payment> findByTransactionId(EntityManager em, String transactionId) {
        try {
            TypedQuery<Payment> query = em.createQuery(
                    "SELECT p FROM Payment p WHERE p.transactionId = :txId", Payment.class);
            query.setParameter("txId", transactionId);
            return Optional.of(query.getSingleResult());
        } catch (Exception e) {
            return Optional.empty();
        }
    }

    /**
     * Trouve un paiement par ID de réservation
     * @param em EntityManager
     * @param reservationId ID de réservation
     * @return Optional contenant le paiement si trouvé
     */
    public Optional<Payment> findByReservationId(EntityManager em, Long reservationId) {
        try {
            TypedQuery<Payment> query = em.createQuery(
                    "SELECT p FROM Payment p WHERE p.reservation.id = :resId", Payment.class);
            query.setParameter("resId", reservationId);
            return Optional.of(query.getSingleResult());
        } catch (Exception e) {
            return Optional.empty();
        }
    }

    /**
     * Récupère les paiements par statut
     * @param em EntityManager
     * @param status Statut du paiement
     * @return Liste des paiements avec ce statut
     */
    public List<Payment> findByStatus(EntityManager em, PaymentStatus status) {
        TypedQuery<Payment> query = em.createQuery(
                "SELECT p FROM Payment p WHERE p.status = :status " +
                "ORDER BY p.createdAt DESC", Payment.class);
        query.setParameter("status", status);
        return query.getResultList();
    }
}
