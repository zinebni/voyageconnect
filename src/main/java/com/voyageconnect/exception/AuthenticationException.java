package com.voyageconnect.exception;

/**
 * Exception levée lors d'erreurs d'authentification
 */
public class AuthenticationException extends BusinessException {

    private static final long serialVersionUID = 1L;

    public AuthenticationException(String message) {
        super(message);
    }

    public AuthenticationException(String message, Throwable cause) {
        super(message, cause);
    }
}
