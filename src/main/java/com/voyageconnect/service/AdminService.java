package com.voyageconnect.service;

import com.voyageconnect.dao.*;
import com.voyageconnect.exception.BusinessException;
import com.voyageconnect.model.*;
import com.voyageconnect.util.JPAUtil;
import com.voyageconnect.util.ValidationUtil;

import javax.persistence.EntityManager;
import javax.persistence.EntityTransaction;
import java.util.List;

/**
 * Service d'administration (CRUD sur destinations, vols, hôtels, circuits, promotions)
 * Réservé aux administrateurs
 */
public class AdminService {

    private final DestinationDAO destinationDAO = new DestinationDAO();
    private final FlightDAO flightDAO = new FlightDAO();
    private final HotelDAO hotelDAO = new HotelDAO();
    private final CircuitDAO circuitDAO = new CircuitDAO();
    private final PromotionDAO promotionDAO = new PromotionDAO();

    // ========== DESTINATIONS ==========

    public Destination createDestination(Destination destination) throws BusinessException {
        EntityManager em = JPAUtil.getEntityManager();
        EntityTransaction tx = em.getTransaction();
        try {
            tx.begin();
            ValidationUtil.validateAndThrow(destination);
            destinationDAO.create(em, destination);
            tx.commit();
            return destination;
        } catch (Exception e) {
            if (tx.isActive()) tx.rollback();
            throw new BusinessException("Erreur création destination : " + e.getMessage(), e);
        } finally {
            JPAUtil.closeEntityManager(em);
        }
    }

    public Destination updateDestination(Destination destination) throws BusinessException {
        EntityManager em = JPAUtil.getEntityManager();
        EntityTransaction tx = em.getTransaction();
        try {
            tx.begin();
            ValidationUtil.validateAndThrow(destination);
            Destination updated = destinationDAO.update(em, destination);
            tx.commit();
            return updated;
        } catch (Exception e) {
            if (tx.isActive()) tx.rollback();
            throw new BusinessException("Erreur mise à jour destination : " + e.getMessage(), e);
        } finally {
            JPAUtil.closeEntityManager(em);
        }
    }

    public void deleteDestination(Long id) throws BusinessException {
        EntityManager em = JPAUtil.getEntityManager();
        EntityTransaction tx = em.getTransaction();
        try {
            tx.begin();
            destinationDAO.deleteById(em, id);
            tx.commit();
        } catch (Exception e) {
            if (tx.isActive()) tx.rollback();
            throw new BusinessException("Erreur suppression destination : " + e.getMessage(), e);
        } finally {
            JPAUtil.closeEntityManager(em);
        }
    }

    public List<Destination> getAllDestinations() {
        EntityManager em = JPAUtil.getEntityManager();
        try {
            return destinationDAO.findAll(em);
        } finally {
            JPAUtil.closeEntityManager(em);
        }
    }

    // ========== VOLS ==========

    public Flight createFlight(Flight flight) throws BusinessException {
        EntityManager em = JPAUtil.getEntityManager();
        EntityTransaction tx = em.getTransaction();
        try {
            tx.begin();
            ValidationUtil.validateAndThrow(flight);
            flightDAO.create(em, flight);
            tx.commit();
            return flight;
        } catch (Exception e) {
            if (tx.isActive()) tx.rollback();
            throw new BusinessException("Erreur création vol : " + e.getMessage(), e);
        } finally {
            JPAUtil.closeEntityManager(em);
        }
    }

    public Flight updateFlight(Flight flight) throws BusinessException {
        EntityManager em = JPAUtil.getEntityManager();
        EntityTransaction tx = em.getTransaction();
        try {
            tx.begin();
            ValidationUtil.validateAndThrow(flight);
            Flight updated = flightDAO.update(em, flight);
            tx.commit();
            return updated;
        } catch (Exception e) {
            if (tx.isActive()) tx.rollback();
            throw new BusinessException("Erreur mise à jour vol : " + e.getMessage(), e);
        } finally {
            JPAUtil.closeEntityManager(em);
        }
    }

    public void deleteFlight(Long id) throws BusinessException {
        EntityManager em = JPAUtil.getEntityManager();
        EntityTransaction tx = em.getTransaction();
        try {
            tx.begin();
            flightDAO.deleteById(em, id);
            tx.commit();
        } catch (Exception e) {
            if (tx.isActive()) tx.rollback();
            throw new BusinessException("Erreur suppression vol : " + e.getMessage(), e);
        } finally {
            JPAUtil.closeEntityManager(em);
        }
    }

    public List<Flight> getAllFlights() {
        EntityManager em = JPAUtil.getEntityManager();
        try {
            return flightDAO.findAll(em);
        } finally {
            JPAUtil.closeEntityManager(em);
        }
    }

    // ========== HÔTELS ==========

    public Hotel createHotel(Hotel hotel) throws BusinessException {
        EntityManager em = JPAUtil.getEntityManager();
        EntityTransaction tx = em.getTransaction();
        try {
            tx.begin();
            ValidationUtil.validateAndThrow(hotel);
            hotelDAO.create(em, hotel);
            tx.commit();
            return hotel;
        } catch (Exception e) {
            if (tx.isActive()) tx.rollback();
            throw new BusinessException("Erreur création hôtel : " + e.getMessage(), e);
        } finally {
            JPAUtil.closeEntityManager(em);
        }
    }

    public Hotel updateHotel(Hotel hotel) throws BusinessException {
        EntityManager em = JPAUtil.getEntityManager();
        EntityTransaction tx = em.getTransaction();
        try {
            tx.begin();
            ValidationUtil.validateAndThrow(hotel);
            Hotel updated = hotelDAO.update(em, hotel);
            tx.commit();
            return updated;
        } catch (Exception e) {
            if (tx.isActive()) tx.rollback();
            throw new BusinessException("Erreur mise à jour hôtel : " + e.getMessage(), e);
        } finally {
            JPAUtil.closeEntityManager(em);
        }
    }

    public void deleteHotel(Long id) throws BusinessException {
        EntityManager em = JPAUtil.getEntityManager();
        EntityTransaction tx = em.getTransaction();
        try {
            tx.begin();
            hotelDAO.deleteById(em, id);
            tx.commit();
        } catch (Exception e) {
            if (tx.isActive()) tx.rollback();
            throw new BusinessException("Erreur suppression hôtel : " + e.getMessage(), e);
        } finally {
            JPAUtil.closeEntityManager(em);
        }
    }

    public List<Hotel> getAllHotels() {
        EntityManager em = JPAUtil.getEntityManager();
        try {
            return hotelDAO.findAll(em);
        } finally {
            JPAUtil.closeEntityManager(em);
        }
    }

    // ========== CIRCUITS ==========

    public Circuit createCircuit(Circuit circuit) throws BusinessException {
        EntityManager em = JPAUtil.getEntityManager();
        EntityTransaction tx = em.getTransaction();
        try {
            tx.begin();
            ValidationUtil.validateAndThrow(circuit);
            circuitDAO.create(em, circuit);
            tx.commit();
            return circuit;
        } catch (Exception e) {
            if (tx.isActive()) tx.rollback();
            throw new BusinessException("Erreur création circuit : " + e.getMessage(), e);
        } finally {
            JPAUtil.closeEntityManager(em);
        }
    }

    public Circuit updateCircuit(Circuit circuit) throws BusinessException {
        EntityManager em = JPAUtil.getEntityManager();
        EntityTransaction tx = em.getTransaction();
        try {
            tx.begin();
            ValidationUtil.validateAndThrow(circuit);
            Circuit updated = circuitDAO.update(em, circuit);
            tx.commit();
            return updated;
        } catch (Exception e) {
            if (tx.isActive()) tx.rollback();
            throw new BusinessException("Erreur mise à jour circuit : " + e.getMessage(), e);
        } finally {
            JPAUtil.closeEntityManager(em);
        }
    }

    public void deleteCircuit(Long id) throws BusinessException {
        EntityManager em = JPAUtil.getEntityManager();
        EntityTransaction tx = em.getTransaction();
        try {
            tx.begin();
            circuitDAO.deleteById(em, id);
            tx.commit();
        } catch (Exception e) {
            if (tx.isActive()) tx.rollback();
            throw new BusinessException("Erreur suppression circuit : " + e.getMessage(), e);
        } finally {
            JPAUtil.closeEntityManager(em);
        }
    }

    public List<Circuit> getAllCircuits() {
        EntityManager em = JPAUtil.getEntityManager();
        try {
            return circuitDAO.findAll(em);
        } finally {
            JPAUtil.closeEntityManager(em);
        }
    }

    // ========== PROMOTIONS ==========

    public Promotion createPromotion(Promotion promotion) throws BusinessException {
        EntityManager em = JPAUtil.getEntityManager();
        EntityTransaction tx = em.getTransaction();
        try {
            tx.begin();
            ValidationUtil.validateAndThrow(promotion);
            promotionDAO.create(em, promotion);
            tx.commit();
            return promotion;
        } catch (Exception e) {
            if (tx.isActive()) tx.rollback();
            throw new BusinessException("Erreur création promotion : " + e.getMessage(), e);
        } finally {
            JPAUtil.closeEntityManager(em);
        }
    }

    public Promotion updatePromotion(Promotion promotion) throws BusinessException {
        EntityManager em = JPAUtil.getEntityManager();
        EntityTransaction tx = em.getTransaction();
        try {
            tx.begin();
            ValidationUtil.validateAndThrow(promotion);
            Promotion updated = promotionDAO.update(em, promotion);
            tx.commit();
            return updated;
        } catch (Exception e) {
            if (tx.isActive()) tx.rollback();
            throw new BusinessException("Erreur mise à jour promotion : " + e.getMessage(), e);
        } finally {
            JPAUtil.closeEntityManager(em);
        }
    }

    public void deletePromotion(Long id) throws BusinessException {
        EntityManager em = JPAUtil.getEntityManager();
        EntityTransaction tx = em.getTransaction();
        try {
            tx.begin();
            promotionDAO.deleteById(em, id);
            tx.commit();
        } catch (Exception e) {
            if (tx.isActive()) tx.rollback();
            throw new BusinessException("Erreur suppression promotion : " + e.getMessage(), e);
        } finally {
            JPAUtil.closeEntityManager(em);
        }
    }

    public List<Promotion> getAllPromotions() {
        EntityManager em = JPAUtil.getEntityManager();
        try {
            return promotionDAO.findAll(em);
        } finally {
            JPAUtil.closeEntityManager(em);
        }
    }
}
