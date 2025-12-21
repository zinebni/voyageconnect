package com.voyageconnect.exception;

/**
 * Exception levée lors d'erreurs d'autorisation (accès non autorisé)
 */
public class AuthorizationException extends BusinessException {

    private static final long serialVersionUID = 1L;

    public AuthorizationException(String message) {
        super(message);
    }
}
