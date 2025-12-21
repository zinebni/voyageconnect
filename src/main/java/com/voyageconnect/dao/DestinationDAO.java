package com.voyageconnect.dao;

import com.voyageconnect.model.Destination;

import javax.persistence.EntityManager;
import javax.persistence.TypedQuery;
import java.util.List;

/**
 * DAO pour l'entité Destination
 */
public class DestinationDAO extends GenericDAO<Destination> {

    public DestinationDAO() {
        super(Destination.class);
    }

    /**
     * Compte le nombre total de destinations
     */
    public long countAll(EntityManager em) {
        return count(em);
    }

    /**
     * Récupère toutes les destinations actives
     * @param em EntityManager
     * @return Liste des destinations actives
     */
    public List<Destination> findActiveDestinations(EntityManager em) {
        TypedQuery<Destination> query = em.createQuery(
                "SELECT d FROM Destination d WHERE d.active = true", Destination.class);
        return query.getResultList();
    }

    /**
     * Recherche des destinations par pays
     * @param em EntityManager
     * @param country Pays
     * @return Liste des destinations du pays
     */
    public List<Destination> findByCountry(EntityManager em, String country) {
        TypedQuery<Destination> query = em.createQuery(
                "SELECT d FROM Destination d WHERE LOWER(d.country) = LOWER(:country) " +
                "AND d.active = true", Destination.class);
        query.setParameter("country", country);
        return query.getResultList();
    }

    /**
     * Recherche des destinations par nom
     * @param em EntityManager
     * @param searchTerm Terme de recherche
     * @return Liste des destinations correspondantes
     */
    public List<Destination> searchByName(EntityManager em, String searchTerm) {
        TypedQuery<Destination> query = em.createQuery(
                "SELECT d FROM Destination d WHERE LOWER(d.name) LIKE LOWER(:term) " +
                "AND d.active = true", Destination.class);
        query.setParameter("term", "%" + searchTerm + "%");
        return query.getResultList();
    }

    /**
     * Récupère les destinations les plus populaires (avec le plus de réservations)
     * @param em EntityManager
     * @param limit Nombre maximum de destinations à retourner
     * @return Liste des destinations populaires
     */
    public List<Destination> findPopularDestinations(EntityManager em, int limit) {
        TypedQuery<Destination> query = em.createQuery(
                "SELECT DISTINCT d FROM Destination d " +
                "LEFT JOIN d.flights f " +
                "LEFT JOIN f.reservations r " +
                "WHERE d.active = true " +
                "GROUP BY d.id " +
                "ORDER BY COUNT(r.id) DESC", Destination.class);
        query.setMaxResults(limit);
        return query.getResultList();
    }
}
