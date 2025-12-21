package com.voyageconnect.dao;

import com.voyageconnect.model.Hotel;

import javax.persistence.EntityManager;
import javax.persistence.TypedQuery;
import java.math.BigDecimal;
import java.util.List;

/**
 * DAO pour l'entité Hotel
 */
public class HotelDAO extends GenericDAO<Hotel> {

    public HotelDAO() {
        super(Hotel.class);
    }

    /**
     * Recherche des hôtels disponibles
     * @param em EntityManager
     * @param destinationId ID de la destination
     * @param minStars Nombre minimum d'étoiles
     * @param maxPrice Prix maximum par nuit
     * @param minRooms Nombre minimum de chambres disponibles
     * @return Liste des hôtels disponibles
     */
    public List<Hotel> searchAvailableHotels(EntityManager em, Long destinationId, 
                                             Integer minStars, BigDecimal maxPrice, 
                                             Integer minRooms) {
        StringBuilder jpql = new StringBuilder(
                "SELECT h FROM Hotel h WHERE h.active = true ");
        
        if (destinationId != null) {
            jpql.append("AND h.destination.id = :destinationId ");
        }
        if (minStars != null && minStars > 0) {
            jpql.append("AND h.stars >= :stars ");
        }
        if (maxPrice != null) {
            jpql.append("AND h.pricePerNight <= :price ");
        }
        if (minRooms != null && minRooms > 0) {
            jpql.append("AND h.availableRooms >= :rooms ");
        }
        
        jpql.append("ORDER BY h.stars DESC, h.pricePerNight ASC");
        
        TypedQuery<Hotel> query = em.createQuery(jpql.toString(), Hotel.class);
        
        if (destinationId != null) {
            query.setParameter("destinationId", destinationId);
        }
        if (minStars != null && minStars > 0) {
            query.setParameter("stars", minStars);
        }
        if (maxPrice != null) {
            query.setParameter("price", maxPrice);
        }
        if (minRooms != null && minRooms > 0) {
            query.setParameter("rooms", minRooms);
        }
        
        return query.getResultList();
    }

    /**
     * Récupère les hôtels par nombre d'étoiles
     * @param em EntityManager
     * @param stars Nombre d'étoiles
     * @return Liste des hôtels avec ce nombre d'étoiles
     */
    public List<Hotel> findByStars(EntityManager em, Integer stars) {
        TypedQuery<Hotel> query = em.createQuery(
                "SELECT h FROM Hotel h WHERE h.stars = :stars " +
                "AND h.active = true " +
                "ORDER BY h.pricePerNight ASC", Hotel.class);
        query.setParameter("stars", stars);
        return query.getResultList();
    }

    /**
     * Récupère les hôtels d'une destination
     * @param em EntityManager
     * @param destinationId ID de la destination
     * @return Liste des hôtels de cette destination
     */
    public List<Hotel> findByDestination(EntityManager em, Long destinationId) {
        TypedQuery<Hotel> query = em.createQuery(
                "SELECT h FROM Hotel h WHERE h.destination.id = :destId " +
                "AND h.active = true " +
                "ORDER BY h.stars DESC", Hotel.class);
        query.setParameter("destId", destinationId);
        return query.getResultList();
    }

    /**
     * Recherche des hôtels avec des équipements spécifiques
     * @param em EntityManager
     * @param wifi WiFi requis
     * @param pool Piscine requise
     * @param restaurant Restaurant requis
     * @param parking Parking requis
     * @return Liste des hôtels avec les équipements demandés
     */
    public List<Hotel> findByAmenities(EntityManager em, Boolean wifi, Boolean pool, 
                                       Boolean restaurant, Boolean parking) {
        StringBuilder jpql = new StringBuilder("SELECT h FROM Hotel h WHERE h.active = true ");
        
        if (wifi != null && wifi) {
            jpql.append("AND h.wifi = true ");
        }
        if (pool != null && pool) {
            jpql.append("AND h.pool = true ");
        }
        if (restaurant != null && restaurant) {
            jpql.append("AND h.restaurant = true ");
        }
        if (parking != null && parking) {
            jpql.append("AND h.parking = true ");
        }
        
        jpql.append("ORDER BY h.stars DESC");
        
        return em.createQuery(jpql.toString(), Hotel.class).getResultList();
    }
}
