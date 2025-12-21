package com.voyageconnect.dao;

import com.voyageconnect.model.Promotion;
import com.voyageconnect.model.PromotionType;

import javax.persistence.EntityManager;
import javax.persistence.NoResultException;
import javax.persistence.TypedQuery;
import java.time.LocalDate;
import java.util.List;
import java.util.Optional;

/**
 * DAO pour l'entité Promotion
 */
public class PromotionDAO extends GenericDAO<Promotion> {

    public PromotionDAO() {
        super(Promotion.class);
    }

    /**
     * Trouve une promotion par code
     * @param em EntityManager
     * @param code Code de la promotion
     * @return Optional contenant la promotion si trouvée
     */
    public Optional<Promotion> findByCode(EntityManager em, String code) {
        try {
            TypedQuery<Promotion> query = em.createQuery(
                    "SELECT p FROM Promotion p WHERE p.code = :code", Promotion.class);
            query.setParameter("code", code);
            return Optional.of(query.getSingleResult());
        } catch (NoResultException e) {
            return Optional.empty();
        }
    }

    /**
     * Récupère toutes les promotions actives et valides
     * @param em EntityManager
     * @return Liste des promotions valides
     */
    public List<Promotion> findActivePromotions(EntityManager em) {
        LocalDate today = LocalDate.now();
        TypedQuery<Promotion> query = em.createQuery(
                "SELECT p FROM Promotion p WHERE p.active = true " +
                "AND p.startDate <= :today AND p.endDate >= :today", Promotion.class);
        query.setParameter("today", today);
        return query.getResultList();
    }

    /**
     * Récupère les promotions par type
     * @param em EntityManager
     * @param type Type de promotion
     * @return Liste des promotions de ce type
     */
    public List<Promotion> findByType(EntityManager em, PromotionType type) {
        LocalDate today = LocalDate.now();
        TypedQuery<Promotion> query = em.createQuery(
                "SELECT p FROM Promotion p WHERE p.type = :type " +
                "AND p.active = true " +
                "AND p.startDate <= :today AND p.endDate >= :today", Promotion.class);
        query.setParameter("type", type);
        query.setParameter("today", today);
        return query.getResultList();
    }

    /**
     * Vérifie si un code promo est valide
     * @param em EntityManager
     * @param code Code de la promotion
     * @return true si la promotion est valide, false sinon
     */
    public boolean isValidPromoCode(EntityManager em, String code) {
        LocalDate today = LocalDate.now();
        Long count = em.createQuery(
                "SELECT COUNT(p) FROM Promotion p WHERE p.code = :code " +
                "AND p.active = true " +
                "AND p.startDate <= :today AND p.endDate >= :today", Long.class)
                .setParameter("code", code)
                .setParameter("today", today)
                .getSingleResult();
        return count > 0;
    }
}
