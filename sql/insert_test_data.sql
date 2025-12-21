-- =====================================================
-- Script d'insertion de données de test pour VoyageConnect
-- =====================================================

USE voyageconnect;

-- =====================================================
-- 1. DESTINATIONS
-- =====================================================

INSERT INTO destinations (name, country, description, imageUrl, active, createdAt) VALUES
('Paris', 'France', 'La Ville Lumière - Capitale de la culture et de la romance. Découvrez la Tour Eiffel, le Louvre et Montmartre.', 'https://images.unsplash.com/photo-1502602898657-3e91760cbb34', true, NOW()),
('Tokyo', 'Japon', 'Entre tradition et modernité - Temples anciens, gratte-ciels futuristes et cuisine exceptionnelle.', 'https://images.unsplash.com/photo-1540959733332-eab4deabeeaf', true, NOW()),
('New York', 'USA', 'La ville qui ne dort jamais - Times Square, Central Park et la Statue de la Liberté.', 'https://images.unsplash.com/photo-1496442226666-8d4d0e62e6e9', true, NOW()),
('Marrakech', 'Maroc', 'La perle du sud - Souks colorés, riads authentiques et jardins luxuriants.', 'https://images.unsplash.com/photo-1597212618440-806262de4f6b', true, NOW()),
('Barcelone', 'Espagne', 'Architecture de Gaudí - Plages méditerranéennes, tapas et vie nocturne animée.', 'https://images.unsplash.com/photo-1562883676-8c7feb83f09b', true, NOW()),
('Dubai', 'EAU', 'Luxe et démesure - Burj Khalifa, centres commerciaux géants et désert.', 'https://images.unsplash.com/photo-1512453979798-5ea266f8880c', true, NOW());

-- =====================================================
-- 2. VOLS
-- =====================================================

INSERT INTO flights (flightNumber, origin, destination_id, departureTime, arrivalTime, price, availableSeats, flightClass, active, createdAt) VALUES
('AF1234', 'Casablanca', 1, '2025-01-15 08:00:00', '2025-01-15 11:30:00', 250.00, 120, 'ECONOMY', true, NOW()),
('AF1235', 'Casablanca', 1, '2025-01-20 14:00:00', '2025-01-20 17:30:00', 450.00, 30, 'BUSINESS', true, NOW()),
('JL5678', 'Paris', 2, '2025-02-10 22:00:00', '2025-02-11 16:00:00', 850.00, 200, 'ECONOMY', true, NOW()),
('JL5679', 'Paris', 2, '2025-02-15 10:00:00', '2025-02-16 04:00:00', 1200.00, 20, 'FIRST', true, NOW()),
('UA9012', 'Casablanca', 3, '2025-03-05 18:00:00', '2025-03-06 02:00:00', 650.00, 180, 'ECONOMY', true, NOW()),
('UA9013', 'Paris', 3, '2025-03-10 09:00:00', '2025-03-10 17:00:00', 950.00, 40, 'BUSINESS', true, NOW()),
('RAM3456', 'Paris', 4, '2025-01-25 07:00:00', '2025-01-25 10:30:00', 180.00, 150, 'ECONOMY', true, NOW()),
('VY7890', 'Casablanca', 5, '2025-02-20 12:00:00', '2025-02-20 14:30:00', 120.00, 180, 'ECONOMY', true, NOW()),
('EK4567', 'Paris', 6, '2025-03-15 23:00:00', '2025-03-16 07:00:00', 550.00, 250, 'ECONOMY', true, NOW()),
('EK4568', 'Casablanca', 6, '2025-03-20 15:00:00', '2025-03-20 23:00:00', 850.00, 50, 'BUSINESS', true, NOW());

-- =====================================================
-- 3. HÔTELS
-- =====================================================

INSERT INTO hotels (name, destination_id, address, rating, pricePerNight, availableRooms, amenities, imageUrl, active, createdAt) VALUES
('Le Meurice Paris', 1, '228 Rue de Rivoli, 75001 Paris', 5, 550.00, 50, 'Wi-Fi gratuit, Spa, Restaurant gastronomique, Salle de sport, Piscine intérieure, Service en chambre 24h/24', 'https://images.unsplash.com/photo-1551882547-ff40c63fe5fa', true, NOW()),
('Hôtel Plaza Athénée', 1, '25 Avenue Montaigne, 75008 Paris', 5, 650.00, 30, 'Wi-Fi gratuit, Spa Dior, Restaurant 3 étoiles Michelin, Bar champagne, Terrasse, Concierge', 'https://images.unsplash.com/photo-1520250497591-112f2f40a3f4', true, NOW()),
('Park Hyatt Tokyo', 2, '3-7-1-2 Nishi Shinjuku, Tokyo', 5, 480.00, 60, 'Wi-Fi gratuit, Spa, Piscine, Restaurant japonais, Bar panoramique, Salle de sport', 'https://images.unsplash.com/photo-1564501049412-61c2a3083791', true, NOW()),
('Mandarin Oriental Tokyo', 2, '2-1-1 Nihonbashi Muromachi, Tokyo', 5, 520.00, 40, 'Wi-Fi gratuit, Spa primé, Piscine, 10 restaurants, Vue sur Tokyo, Service majordome', 'https://images.unsplash.com/photo-1567073544764-de2ed5e87ca7', true, NOW()),
('The Plaza New York', 3, '768 5th Avenue, New York, NY', 5, 700.00, 80, 'Wi-Fi gratuit, Spa Guerlain, Restaurant étoilé, Champagne Bar, Vue Central Park, Shopping', 'https://images.unsplash.com/photo-1542314831-068cd1dbfeeb', true, NOW()),
('Riad Yasmine Marrakech', 4, 'Derb Lalla Azzouna, Médina, Marrakech', 4, 120.00, 15, 'Wi-Fi gratuit, Piscine sur toit, Restaurant traditionnel, Hammam, Terrasse panoramique', 'https://images.unsplash.com/photo-1561501900-3701fa6a0864', true, NOW()),
('La Mamounia', 4, 'Avenue Bab Jdid, Marrakech', 5, 380.00, 70, 'Wi-Fi gratuit, Spa, 4 piscines, Jardins 7 hectares, 4 restaurants, Golf, Casino', 'https://images.unsplash.com/photo-1566073771259-6a8506099945', true, NOW()),
('W Barcelona', 5, 'Placa de la Rosa dels Vents 1, Barcelona', 4, 320.00, 100, 'Wi-Fi gratuit, Piscine plage, Spa, 3 restaurants, Bar rooftop, Accès plage direct', 'https://images.unsplash.com/photo-1551882547-ff40c63fe5fa', true, NOW()),
('Burj Al Arab Jumeirah', 6, 'Jumeirah Street, Dubai', 5, 1200.00, 50, 'Wi-Fi gratuit, Spa Talise, 9 restaurants, Piscines infinies, Butler 24h/24, Hélicoptère', 'https://images.unsplash.com/photo-1582719478250-c89cae4dc85b', true, NOW()),
('Atlantis The Palm', 6, 'Crescent Road, The Palm, Dubai', 5, 450.00, 150, 'Wi-Fi gratuit, Aquaventure, The Lost Chambers, 35 restaurants, Spa, Plage privée', 'https://images.unsplash.com/photo-1512453979798-5ea266f8880c', true, NOW());

-- =====================================================
-- 4. CIRCUITS
-- =====================================================

INSERT INTO circuits (name, destination_id, duration, price, availableSpots, itinerary, highlights, imageUrl, active, createdAt) VALUES
('Circuit Découverte Paris', 1, 5, 890.00, 30, 
'Jour 1: Arrivée + Tour Eiffel | Jour 2: Louvre + Champs-Élysées | Jour 3: Versailles | Jour 4: Montmartre + Sacré-Cœur | Jour 5: Quartier Latin + départ',
'Tour Eiffel, Louvre, Versailles, Croisière Seine, Dégustation fromages et vins', 
'https://images.unsplash.com/photo-1502602898657-3e91760cbb34', true, NOW()),

('Circuit Grand Japon', 2, 12, 2850.00, 20, 
'Tokyo (4j): Shibuya, Asakusa, Akihabara | Kyoto (4j): Temples, Geishas, Arashiyama | Osaka (2j): Château, Street food | Hiroshima (2j): Mémorial, Miyajima',
'Cérémonie du thé, Temples UNESCO, Mont Fuji, Gastronomie traditionnelle, Train Shinkansen', 
'https://images.unsplash.com/photo-1540959733332-eab4deabeeaf', true, NOW()),

('New York Essentiel', 3, 6, 1450.00, 25, 
'Jour 1-2: Manhattan (Statue Liberté, Times Square) | Jour 3: Brooklyn + Central Park | Jour 4-5: Musées (MET, MoMA) | Jour 6: Shopping + Broadway',
'Statue de la Liberté, Empire State, Central Park, Broadway show, Brooklyn Bridge', 
'https://images.unsplash.com/photo-1496442226666-8d4d0e62e6e9', true, NOW()),

('Circuit Impérial Maroc', 4, 8, 1280.00, 35, 
'Marrakech (3j): Médina, Souks, Jardin Majorelle | Essaouira (2j): Plage, Port | Désert Agafay (2j): Dromadaires, Nuit berbère | Retour Marrakech (1j)',
'Médina UNESCO, Souks colorés, Nuit désert, Cuisine marocaine, Hammam traditionnel', 
'https://images.unsplash.com/photo-1597212618440-806262de4f6b', true, NOW()),

('Barcelone & Costa Brava', 5, 7, 1150.00, 28, 
'Barcelone (4j): Sagrada Familia, Park Güell, Ramblas | Costa Brava (3j): Tossa de Mar, Cadaqués, Plages',
'Œuvres Gaudí, Plages méditerranéennes, Tapas tour, Camp Nou, Villages médiévaux', 
'https://images.unsplash.com/photo-1562883676-8c7feb83f09b', true, NOW()),

('Dubai Luxe & Désert', 6, 5, 1980.00, 15, 
'Jour 1-2: Dubai (Burj Khalifa, Dubai Mall) | Jour 3: Safari désert + BBQ | Jour 4: Abu Dhabi (Grande Mosquée) | Jour 5: Plage + Souk',
'Burj Khalifa, Safari 4x4, Grande Mosquée, Ski Dubai, Souks or, Croisière dhow', 
'https://images.unsplash.com/photo-1512453979798-5ea266f8880c', true, NOW());

-- =====================================================
-- 5. PROMOTIONS
-- =====================================================

INSERT INTO promotions (name, description, discountPercentage, startDate, endDate, type, active, createdAt) VALUES
('Early Bird 2025', 'Réservez 3 mois à l''avance et économisez 15% sur tous les vols', 15, '2025-01-01', '2025-03-31', 'FLIGHT', true, NOW()),
('Séjour Romantique', 'Offre spéciale couples : -20% sur les hôtels 4-5 étoiles pour la Saint-Valentin', 20, '2025-02-10', '2025-02-20', 'HOTEL', true, NOW()),
('Circuit Aventure', 'Découverte du Japon : -10% sur le circuit Grand Japon', 10, '2025-01-15', '2025-04-30', 'CIRCUIT', true, NOW()),
('Flash Weekend', 'Vols dernière minute : -25% ce weekend uniquement!', 25, '2025-01-24', '2025-01-26', 'FLIGHT', true, NOW()),
('Summer Escape', 'Réservez votre été maintenant : -12% sur tous les circuits méditerranéens', 12, '2025-03-01', '2025-05-31', 'CIRCUIT', true, NOW());

-- =====================================================
-- STATISTIQUES
-- =====================================================

SELECT 
    'Destinations' as Type, 
    COUNT(*) as Total 
FROM destinations
UNION ALL
SELECT 
    'Vols', 
    COUNT(*) 
FROM flights
UNION ALL
SELECT 
    'Hôtels', 
    COUNT(*) 
FROM hotels
UNION ALL
SELECT 
    'Circuits', 
    COUNT(*) 
FROM circuits
UNION ALL
SELECT 
    'Promotions', 
    COUNT(*) 
FROM promotions;

-- =====================================================
-- FIN DU SCRIPT
-- =====================================================

COMMIT;
