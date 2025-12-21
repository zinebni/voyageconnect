package com.voyageconnect.dao;

import javax.persistence.EntityManager;
import javax.persistence.TypedQuery;
import java.util.List;
import java.util.Optional;

/**
 * Classe abstraite générique pour les DAO
 * Implémente les opérations CRUD de base
 * @param <T> Type de l'entité
 */
public abstract class GenericDAO<T> {

    private final Class<T> entityClass;

    protected GenericDAO(Class<T> entityClass) {
        this.entityClass = entityClass;
    }

    /**
     * Crée une nouvelle entité
     * ATTENTION : Cette méthode ne gère PAS la transaction
     * @param em EntityManager (doit être dans une transaction)
     * @param entity Entité à créer
     * @return Entité créée
     */
    public T create(EntityManager em, T entity) {
        em.persist(entity);
        return entity;
    }

    /**
     * Met à jour une entité existante
     * ATTENTION : Cette méthode ne gère PAS la transaction
     * @param em EntityManager (doit être dans une transaction)
     * @param entity Entité à mettre à jour
     * @return Entité mise à jour
     */
    public T update(EntityManager em, T entity) {
        return em.merge(entity);
    }

    /**
     * Supprime une entité
     * ATTENTION : Cette méthode ne gère PAS la transaction
     * @param em EntityManager (doit être dans une transaction)
     * @param entity Entité à supprimer
     */
    public void delete(EntityManager em, T entity) {
        em.remove(em.contains(entity) ? entity : em.merge(entity));
    }

    /**
     * Supprime une entité par son ID
     * ATTENTION : Cette méthode ne gère PAS la transaction
     * @param em EntityManager (doit être dans une transaction)
     * @param id ID de l'entité à supprimer
     */
    public void deleteById(EntityManager em, Long id) {
        T entity = em.find(entityClass, id);
        if (entity != null) {
            em.remove(entity);
        }
    }

    /**
     * Trouve une entité par son ID
     * @param em EntityManager
     * @param id ID de l'entité
     * @return Optional contenant l'entité si trouvée
     */
    public Optional<T> findById(EntityManager em, Long id) {
        T entity = em.find(entityClass, id);
        return Optional.ofNullable(entity);
    }

    /**
     * Récupère toutes les entités
     * @param em EntityManager
     * @return Liste de toutes les entités
     */
    public List<T> findAll(EntityManager em) {
        String jpql = "SELECT e FROM " + entityClass.getSimpleName() + " e";
        TypedQuery<T> query = em.createQuery(jpql, entityClass);
        return query.getResultList();
    }

    /**
     * Compte le nombre total d'entités
     * @param em EntityManager
     * @return Nombre d'entités
     */
    public long count(EntityManager em) {
        String jpql = "SELECT COUNT(e) FROM " + entityClass.getSimpleName() + " e";
        return em.createQuery(jpql, Long.class).getSingleResult();
    }

    /**
     * Vérifie si une entité existe par son ID
     * @param em EntityManager
     * @param id ID de l'entité
     * @return true si l'entité existe, false sinon
     */
    public boolean existsById(EntityManager em, Long id) {
        return findById(em, id).isPresent();
    }

    protected Class<T> getEntityClass() {
        return entityClass;
    }
}
