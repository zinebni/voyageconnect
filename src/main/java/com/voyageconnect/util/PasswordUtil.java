package com.voyageconnect.util;

import org.mindrot.jbcrypt.BCrypt;

/**
 * Utilitaire pour le hashage et la vérification des mots de passe avec BCrypt
 */
public class PasswordUtil {

    private static final int WORKLOAD = 12; // Facteur de complexité BCrypt

    /**
     * Hash un mot de passe en utilisant BCrypt
     * @param plainPassword Mot de passe en clair
     * @return Mot de passe hashé
     */
    public static String hashPassword(String plainPassword) {
        if (plainPassword == null || plainPassword.isEmpty()) {
            throw new IllegalArgumentException("Le mot de passe ne peut pas être vide");
        }
        return BCrypt.hashpw(plainPassword, BCrypt.gensalt(WORKLOAD));
    }

    /**
     * Vérifie si un mot de passe en clair correspond au hash
     * @param plainPassword Mot de passe en clair
     * @param hashedPassword Mot de passe hashé
     * @return true si le mot de passe correspond, false sinon
     */
    public static boolean checkPassword(String plainPassword, String hashedPassword) {
        if (plainPassword == null || hashedPassword == null) {
            return false;
        }
        try {
            return BCrypt.checkpw(plainPassword, hashedPassword);
        } catch (Exception e) {
            return false;
        }
    }
}
