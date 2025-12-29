package com.voyageconnect.service;

import java.math.BigDecimal;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;

import javax.persistence.EntityManager;

import com.voyageconnect.dao.CircuitDAO;
import com.voyageconnect.dao.DestinationDAO;
import com.voyageconnect.dao.FlightDAO;
import com.voyageconnect.dao.HotelDAO;
import com.voyageconnect.model.Circuit;
import com.voyageconnect.model.Destination;
import com.voyageconnect.model.Flight;
import com.voyageconnect.model.Hotel;
import com.voyageconnect.util.JPAUtil;

/**
 * Service pour la recherche de voyages
 * Pas de transactions nécessaires (lecture seule)
 */
public class SearchService {

    private final FlightDAO flightDAO = new FlightDAO();
    private final HotelDAO hotelDAO = new HotelDAO();
    private final CircuitDAO circuitDAO = new CircuitDAO();
    private final DestinationDAO destinationDAO = new DestinationDAO();

    /**
     * Recherche de vols
     */
    public List<Flight> searchFlights(Long destinationId, String departureCity, 
                                      LocalDateTime departureDate, Integer passengers,
                                      BigDecimal maxPrice) {
        EntityManager em = JPAUtil.getEntityManager();
        try {
            List<Flight> flights = flightDAO.searchAvailableFlights(
                    em, destinationId, departureCity, departureDate, passengers);
            
            // Filtrer par prix si spécifié
            if (maxPrice != null) {
                flights.removeIf(f -> f.getPrice() != null && f.getPrice().compareTo(maxPrice) > 0);
            }
            
            // Forcer l'initialisation des relations lazy avant la fermeture de l'EntityManager
            for (Flight f : flights) {
                if (f.getDestination() != null) {
                    f.getDestination().getName(); // Force l'initialisation
                }
            }
            
            return flights;
        } finally {
            JPAUtil.closeEntityManager(em);
        }
    }

    /**
     * Recherche d'hôtels
     */
    public List<Hotel> searchHotels(Long destinationId, Integer minStars, 
                                    BigDecimal maxPrice, Integer rooms) {
        EntityManager em = JPAUtil.getEntityManager();
        try {
            return hotelDAO.searchAvailableHotels(em, destinationId, minStars, maxPrice, rooms);
        } finally {
            JPAUtil.closeEntityManager(em);
        }
    }

    /**
     * Recherche de circuits
     */
    public List<Circuit> searchCircuits(Long destinationId, Integer minDuration, 
                                        Integer maxDuration, BigDecimal maxPrice, 
                                        Integer persons) {
        EntityManager em = JPAUtil.getEntityManager();
        try {
            return circuitDAO.searchAvailableCircuits(
                    em, destinationId, minDuration, maxDuration, maxPrice, persons);
        } finally {
            JPAUtil.closeEntityManager(em);
        }
    }

    /**
     * Recherche globale (vols + hôtels + circuits)
     */
    public SearchResults searchAll(String destination, BigDecimal maxBudget, Integer persons) {
        EntityManager em = JPAUtil.getEntityManager();
        try {
            SearchResults results = new SearchResults();
            
            // Rechercher la destination
            List<Destination> destinations = destinationDAO.searchByName(em, destination);
            
            if (!destinations.isEmpty()) {
                Long destId = destinations.get(0).getId();
                
                // Rechercher tous les types
                results.setFlights(flightDAO.searchAvailableFlights(
                        em, destId, null, null, persons));
                results.setHotels(hotelDAO.searchAvailableHotels(
                        em, destId, null, maxBudget, persons));
                results.setCircuits(circuitDAO.searchAvailableCircuits(
                        em, destId, null, null, maxBudget, persons));
            }
            
            return results;
        } finally {
            JPAUtil.closeEntityManager(em);
        }
    }

    /**
     * Récupère toutes les destinations actives
     */
    public List<Destination> getActiveDestinations() {
        EntityManager em = JPAUtil.getEntityManager();
        try {
            return destinationDAO.findActiveDestinations(em);
        } finally {
            JPAUtil.closeEntityManager(em);
        }
    }

    /**
     * Récupère les destinations populaires
     */
    public List<Destination> getPopularDestinations(int limit) {
        EntityManager em = JPAUtil.getEntityManager();
        try {
            return destinationDAO.findPopularDestinations(em, limit);
        } finally {
            JPAUtil.closeEntityManager(em);
        }
    }

    /**
     * Classe pour encapsuler les résultats de recherche
     */
    public static class SearchResults {
        private List<Flight> flights = new ArrayList<>();
        private List<Hotel> hotels = new ArrayList<>();
        private List<Circuit> circuits = new ArrayList<>();

        public List<Flight> getFlights() {
            return flights;
        }

        public void setFlights(List<Flight> flights) {
            this.flights = flights;
        }

        public List<Hotel> getHotels() {
            return hotels;
        }

        public void setHotels(List<Hotel> hotels) {
            this.hotels = hotels;
        }

        public List<Circuit> getCircuits() {
            return circuits;
        }

        public void setCircuits(List<Circuit> circuits) {
            this.circuits = circuits;
        }
    }
}
