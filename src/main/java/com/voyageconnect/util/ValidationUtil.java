package com.voyageconnect.util;

import javax.validation.ConstraintViolation;
import javax.validation.Validation;
import javax.validation.Validator;
import javax.validation.ValidatorFactory;
import java.util.Set;
import java.util.stream.Collectors;

/**
 * Utilitaire pour la validation des entités avec Bean Validation
 */
public class ValidationUtil {

    private static final ValidatorFactory validatorFactory = Validation.buildDefaultValidatorFactory();
    private static final Validator validator = validatorFactory.getValidator();

    /**
     * Valide une entité
     * @param entity Entité à valider
     * @return Set des violations de contraintes
     */
    public static <T> Set<ConstraintViolation<T>> validate(T entity) {
        return validator.validate(entity);
    }

    /**
     * Valide une entité et retourne true si valide
     * @param entity Entité à valider
     * @return true si l'entité est valide, false sinon
     */
    public static <T> boolean isValid(T entity) {
        return validate(entity).isEmpty();
    }

    /**
     * Valide une entité et lève une exception si invalide
     * @param entity Entité à valider
     * @throws IllegalArgumentException si l'entité est invalide
     */
    public static <T> void validateAndThrow(T entity) {
        Set<ConstraintViolation<T>> violations = validate(entity);
        if (!violations.isEmpty()) {
            String errors = violations.stream()
                    .map(v -> v.getPropertyPath() + ": " + v.getMessage())
                    .collect(Collectors.joining(", "));
            throw new IllegalArgumentException("Validation échouée : " + errors);
        }
    }

    /**
     * Retourne les messages d'erreur de validation
     * @param entity Entité à valider
     * @return String contenant tous les messages d'erreur
     */
    public static <T> String getValidationErrors(T entity) {
        Set<ConstraintViolation<T>> violations = validate(entity);
        return violations.stream()
                .map(ConstraintViolation::getMessage)
                .collect(Collectors.joining(", "));
    }

    /**
     * Ferme le ValidatorFactory (à appeler lors de l'arrêt de l'application)
     */
    public static void close() {
        if (validatorFactory != null) {
            validatorFactory.close();
        }
    }

    private ValidationUtil() {
        throw new AssertionError("Cette classe ne doit pas être instanciée");
    }
}
