package com.voyageconnect.dao;

import java.math.BigDecimal;
import java.time.LocalDateTime;
import java.util.List;

import javax.persistence.EntityManager;
import javax.persistence.TypedQuery;

import com.voyageconnect.model.Flight;
import com.voyageconnect.model.FlightClass;

/**
 * DAO pour l'entité Flight
 */
public class FlightDAO extends GenericDAO<Flight> {

    public FlightDAO() {
        super(Flight.class);
    }

    /**
     * Compte le nombre total de vols
     */
    public long countAll(EntityManager em) {
        return count(em);
    }

    /**
     * Recherche des vols disponibles
     * @param em EntityManager
     * @param destinationId ID de la destination
     * @param departureCity Ville de départ
     * @param departureDate Date de départ (peut être null)
     * @param minSeats Nombre minimum de places
     * @return Liste des vols disponibles
     */
    public List<Flight> searchAvailableFlights(EntityManager em, Long destinationId, 
                                                String departureCity, LocalDateTime departureDate, 
                                                Integer minSeats) {
        StringBuilder jpql = new StringBuilder(
                "SELECT DISTINCT f FROM Flight f "
                + "LEFT JOIN FETCH f.destination d "
                + "WHERE f.active = true ");
        
        if (destinationId != null) {
            jpql.append("AND f.destination.id = :destinationId ");
        }
        if (departureCity != null && !departureCity.isEmpty()) {
            jpql.append("AND LOWER(f.departureCity) LIKE LOWER(:city) ");
        }
        if (departureDate != null) {
            jpql.append("AND f.departureDate >= :date ");
        }
        if (minSeats != null && minSeats > 0) {
            jpql.append("AND f.availableSeats >= :seats ");
        }
        
        jpql.append("ORDER BY f.departureDate ASC");
        
        TypedQuery<Flight> query = em.createQuery(jpql.toString(), Flight.class);
        
        if (destinationId != null) {
            query.setParameter("destinationId", destinationId);
        }
        if (departureCity != null && !departureCity.isEmpty()) {
            query.setParameter("city", "%" + departureCity + "%");
        }
        if (departureDate != null) {
            query.setParameter("date", departureDate);
        }
        if (minSeats != null && minSeats > 0) {
            query.setParameter("seats", minSeats);
        }
        
        return query.getResultList();
    }

    /**
     * Recherche des vols par fourchette de prix
     * @param em EntityManager
     * @param minPrice Prix minimum
     * @param maxPrice Prix maximum
     * @return Liste des vols dans la fourchette de prix
     */
    public List<Flight> findByPriceRange(EntityManager em, BigDecimal minPrice, BigDecimal maxPrice) {
        TypedQuery<Flight> query = em.createQuery(
                "SELECT DISTINCT f FROM Flight f " +
                "LEFT JOIN FETCH f.destination d " +
                "WHERE f.active = true " +
                "AND f.price BETWEEN :min AND :max " +
                "ORDER BY f.price ASC", Flight.class);
        query.setParameter("min", minPrice);
        query.setParameter("max", maxPrice);
        return query.getResultList();
    }

    /**
     * Récupère les vols d'une compagnie aérienne
     * @param em EntityManager
     * @param airline Nom de la compagnie
     * @return Liste des vols de la compagnie
     */
    public List<Flight> findByAirline(EntityManager em, String airline) {
        TypedQuery<Flight> query = em.createQuery(
                "SELECT DISTINCT f FROM Flight f " +
                "LEFT JOIN FETCH f.destination d " +
                "WHERE f.active = true " +
                "AND LOWER(f.airline) = LOWER(:airline) " +
                "ORDER BY f.departureDate ASC", Flight.class);
        query.setParameter("airline", airline);
        return query.getResultList();
    }

    /**
     * Récupère les vols par classe
     * @param em EntityManager
     * @param flightClass Classe de vol
     * @return Liste des vols de cette classe
     */
    public List<Flight> findByClass(EntityManager em, FlightClass flightClass) {
        TypedQuery<Flight> query = em.createQuery(
                "SELECT DISTINCT f FROM Flight f " +
                "LEFT JOIN FETCH f.destination d " +
                "WHERE f.active = true " +
                "AND f.flightClass = :class " +
                "ORDER BY f.departureDate ASC", Flight.class);
        query.setParameter("class", flightClass);
        return query.getResultList();
    }

    /**
     * Récupère les vols disponibles pour une destination
     * @param em EntityManager
     * @param destinationId ID de la destination
     * @return Liste des vols vers cette destination
     */
    public List<Flight> findByDestination(EntityManager em, Long destinationId) {
        TypedQuery<Flight> query = em.createQuery(
                "SELECT DISTINCT f FROM Flight f " +
                "LEFT JOIN FETCH f.destination d " +
                "WHERE f.destination.id = :destId " +
                "AND f.active = true " +
                "ORDER BY f.departureDate ASC", Flight.class);
        query.setParameter("destId", destinationId);
        return query.getResultList();
    }
}
