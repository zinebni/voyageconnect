package com.voyageconnect.dao;

import com.voyageconnect.model.Circuit;

import javax.persistence.EntityManager;
import javax.persistence.TypedQuery;
import java.math.BigDecimal;
import java.time.LocalDate;
import java.util.List;

/**
 * DAO pour l'entité Circuit
 */
public class CircuitDAO extends GenericDAO<Circuit> {

    public CircuitDAO() {
        super(Circuit.class);
    }

    /**
     * Recherche des circuits disponibles
     * @param em EntityManager
     * @param destinationId ID de la destination
     * @param minDuration Durée minimale en jours
     * @param maxDuration Durée maximale en jours
     * @param maxPrice Prix maximum
     * @param minSpots Nombre minimum de places disponibles
     * @return Liste des circuits disponibles
     */
    public List<Circuit> searchAvailableCircuits(EntityManager em, Long destinationId, 
                                                  Integer minDuration, Integer maxDuration,
                                                  BigDecimal maxPrice, Integer minSpots) {
        StringBuilder jpql = new StringBuilder(
                "SELECT c FROM Circuit c WHERE c.active = true ");
        
        if (destinationId != null) {
            jpql.append("AND c.destination.id = :destinationId ");
        }
        if (minDuration != null && minDuration > 0) {
            jpql.append("AND c.durationDays >= :minDur ");
        }
        if (maxDuration != null && maxDuration > 0) {
            jpql.append("AND c.durationDays <= :maxDur ");
        }
        if (maxPrice != null) {
            jpql.append("AND c.price <= :price ");
        }
        if (minSpots != null && minSpots > 0) {
            jpql.append("AND c.availableSpots >= :spots ");
        }
        
        jpql.append("ORDER BY c.startDate ASC");
        
        TypedQuery<Circuit> query = em.createQuery(jpql.toString(), Circuit.class);
        
        if (destinationId != null) {
            query.setParameter("destinationId", destinationId);
        }
        if (minDuration != null && minDuration > 0) {
            query.setParameter("minDur", minDuration);
        }
        if (maxDuration != null && maxDuration > 0) {
            query.setParameter("maxDur", maxDuration);
        }
        if (maxPrice != null) {
            query.setParameter("price", maxPrice);
        }
        if (minSpots != null && minSpots > 0) {
            query.setParameter("spots", minSpots);
        }
        
        return query.getResultList();
    }

    /**
     * Récupère les circuits d'une destination
     * @param em EntityManager
     * @param destinationId ID de la destination
     * @return Liste des circuits de cette destination
     */
    public List<Circuit> findByDestination(EntityManager em, Long destinationId) {
        TypedQuery<Circuit> query = em.createQuery(
                "SELECT c FROM Circuit c WHERE c.destination.id = :destId " +
                "AND c.active = true " +
                "ORDER BY c.startDate ASC", Circuit.class);
        query.setParameter("destId", destinationId);
        return query.getResultList();
    }

    /**
     * Récupère les circuits disponibles à partir d'une date
     * @param em EntityManager
     * @param fromDate Date de début
     * @return Liste des circuits à partir de cette date
     */
    public List<Circuit> findUpcomingCircuits(EntityManager em, LocalDate fromDate) {
        TypedQuery<Circuit> query = em.createQuery(
                "SELECT c FROM Circuit c WHERE c.startDate >= :date " +
                "AND c.active = true " +
                "ORDER BY c.startDate ASC", Circuit.class);
        query.setParameter("date", fromDate);
        return query.getResultList();
    }

    /**
     * Récupère les circuits par durée
     * @param em EntityManager
     * @param durationDays Durée en jours
     * @return Liste des circuits de cette durée
     */
    public List<Circuit> findByDuration(EntityManager em, Integer durationDays) {
        TypedQuery<Circuit> query = em.createQuery(
                "SELECT c FROM Circuit c WHERE c.durationDays = :duration " +
                "AND c.active = true " +
                "ORDER BY c.startDate ASC", Circuit.class);
        query.setParameter("duration", durationDays);
        return query.getResultList();
    }
}
