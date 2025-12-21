package com.voyageconnect.util;

import javax.persistence.EntityManager;
import javax.persistence.EntityManagerFactory;
import javax.persistence.Persistence;

/**
 * Gestionnaire de l'EntityManager JPA
 * Pattern Singleton pour gérer l'EntityManagerFactory
 */
public class JPAUtil {

    private static final String PERSISTENCE_UNIT_NAME = "VoyageConnectPU";
    private static EntityManagerFactory entityManagerFactory;

    static {
        try {
            entityManagerFactory = Persistence.createEntityManagerFactory(PERSISTENCE_UNIT_NAME);
        } catch (Exception e) {
            throw new ExceptionInInitializerError("Échec de l'initialisation de JPA : " + e.getMessage());
        }
    }

    /**
     * Retourne l'EntityManagerFactory
     * @return EntityManagerFactory
     */
    public static EntityManagerFactory getEntityManagerFactory() {
        return entityManagerFactory;
    }

    /**
     * Crée et retourne un nouvel EntityManager
     * @return EntityManager
     */
    public static EntityManager getEntityManager() {
        if (entityManagerFactory == null) {
            throw new IllegalStateException("EntityManagerFactory n'est pas initialisé");
        }
        return entityManagerFactory.createEntityManager();
    }

    /**
     * Ferme l'EntityManager en toute sécurité
     * @param em EntityManager à fermer
     */
    public static void closeEntityManager(EntityManager em) {
        if (em != null && em.isOpen()) {
            try {
                em.close();
            } catch (Exception e) {
                // Log l'erreur mais ne propage pas l'exception
                System.err.println("Erreur lors de la fermeture de l'EntityManager : " + e.getMessage());
            }
        }
    }

    /**
     * Ferme l'EntityManagerFactory (à appeler lors de l'arrêt de l'application)
     */
    public static void closeEntityManagerFactory() {
        if (entityManagerFactory != null && entityManagerFactory.isOpen()) {
            try {
                entityManagerFactory.close();
            } catch (Exception e) {
                System.err.println("Erreur lors de la fermeture de l'EntityManagerFactory : " + e.getMessage());
            }
        }
    }

    /**
     * Empêche l'instanciation de cette classe utilitaire
     */
    private JPAUtil() {
        throw new AssertionError("Cette classe ne doit pas être instanciée");
    }
}
