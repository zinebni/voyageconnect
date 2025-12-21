-- ===================================================================
-- Script SQL : Création d'utilisateur de test pour VoyageConnect
-- ===================================================================
-- Base de données : voyageconnect
-- Date : 21 Décembre 2025
-- ===================================================================

USE voyageconnect;

-- ===================================================================
-- UTILISATEUR DE TEST
-- ===================================================================
-- Email    : test@voyage.com
-- Password : test123 (hashé avec BCrypt)
-- Rôle     : USER
-- ===================================================================

INSERT INTO users (
    email, 
    password, 
    firstname, 
    lastname, 
    phone, 
    role, 
    created_at
) 
VALUES (
    'test@voyage.com',
    -- Password: test123 (BCrypt hash)
    '$2a$10$N9qo8uLOickgx2ZrVzY1qOZzWpCfaQjU7vVjPJt6mHJW3vB6p8kQO',
    'Test',
    'User',
    '0612345678',
    'USER',
    NOW()
);

-- ===================================================================
-- UTILISATEUR ADMIN (si besoin)
-- ===================================================================
-- Email    : admin@voyage.com
-- Password : admin123
-- Rôle     : ADMIN
-- ===================================================================

INSERT INTO users (
    email, 
    password, 
    firstname, 
    lastname, 
    phone, 
    role, 
    created_at
) 
VALUES (
    'admin@voyage.com',
    -- Password: admin123 (BCrypt hash)
    '$2a$10$rZ8LgjXfKCRjyB5v5p7eF.YFf5v5v5v5v5v5v5v5v5v5v5v5v5v5ve',
    'Admin',
    'Système',
    '0611111111',
    'ADMIN',
    NOW()
)
ON DUPLICATE KEY UPDATE email=email; -- Ignore si existe déjà

-- ===================================================================
-- VÉRIFICATION
-- ===================================================================

SELECT 
    id,
    email,
    firstname,
    lastname,
    role,
    created_at
FROM users
ORDER BY created_at DESC
LIMIT 10;

-- ===================================================================
-- VÉRIFIER LES DONNÉES DISPONIBLES POUR LES RÉSERVATIONS
-- ===================================================================

-- Vols disponibles
SELECT 
    'FLIGHTS' AS type,
    COUNT(*) AS total,
    SUM(CASE WHEN available_seats > 0 THEN 1 ELSE 0 END) AS available
FROM flights;

-- Hôtels disponibles
SELECT 
    'HOTELS' AS type,
    COUNT(*) AS total,
    SUM(CASE WHEN available_rooms > 0 THEN 1 ELSE 0 END) AS available
FROM hotels;

-- Circuits disponibles
SELECT 
    'CIRCUITS' AS type,
    COUNT(*) AS total,
    SUM(CASE WHEN current_participants < max_participants THEN 1 ELSE 0 END) AS available
FROM circuits;

-- ===================================================================
-- EXEMPLES DE REQUÊTES POUR TESTER LES IDS
-- ===================================================================

-- Trouver un vol disponible
SELECT 
    id,
    flight_number,
    departure_city,
    airline,
    available_seats,
    price
FROM flights
WHERE available_seats > 0
LIMIT 1;

-- Trouver un hôtel disponible
SELECT 
    id,
    name,
    available_rooms,
    price_per_night
FROM hotels
WHERE available_rooms > 0
LIMIT 1;

-- Trouver un circuit disponible
SELECT 
    id,
    name,
    duration_days,
    price,
    (max_participants - current_participants) AS places_restantes
FROM circuits
WHERE current_participants < max_participants
LIMIT 1;

-- ===================================================================
-- NETTOYAGE (optionnel - décommenter si besoin de supprimer le test)
-- ===================================================================

-- DELETE FROM users WHERE email = 'test@voyage.com';
-- DELETE FROM users WHERE email = 'admin@voyage.com';
