-- ================================================================
-- Script Seeder pour VoyageConnect
-- Base de données MySQL
-- Date: 27 Décembre 2025
-- ================================================================

-- Désactiver les contraintes de clés étrangères temporairement
SET FOREIGN_KEY_CHECKS = 0;

-- Nettoyer les tables existantes
TRUNCATE TABLE reviews;
TRUNCATE TABLE payments;
TRUNCATE TABLE reservations;
TRUNCATE TABLE circuits;
TRUNCATE TABLE flights;
TRUNCATE TABLE hotels;
TRUNCATE TABLE destinations;
TRUNCATE TABLE promotions;
TRUNCATE TABLE users;

-- Réactiver les contraintes de clés étrangères
SET FOREIGN_KEY_CHECKS = 1;

-- ================================================================
-- TABLE: users
-- ================================================================
INSERT INTO users
(firstName, lastName, email, password, phone, address, role, active, created_at, updated_at)
VALUES
-- Administrateurs
('Admin', 'System', 'admin@voyageconnect.com',
 '$2a$10$N9qo8uLOickgx2ZMRZoMyeIjZAgcfl7p92ldGxad68LJZdL17lhWy',
 '+212600000001', '123 Avenue Mohammed V, Casablanca', 'ADMIN', TRUE, NOW(), NOW()),

('Sarah', 'Admin', 'sarah.admin@voyageconnect.com',
 '$2a$10$N9qo8uLOickgx2ZMRZoMyeIjZAgcfl7p92ldGxad68LJZdL17lhWy',
 '+212600000002', '456 Rue Hassan II, Rabat', 'ADMIN', TRUE, NOW(), NOW()),

-- Utilisateurs réguliers
('Ahmed', 'Bennani', 'ahmed.bennani@gmail.com',
 '$2a$10$N9qo8uLOickgx2ZMRZoMyeIjZAgcfl7p92ldGxad68LJZdL17lhWy',
 '+212661234567', '789 Boulevard Zerktouni, Casablanca', 'USER', TRUE, NOW(), NOW()),

('Fatima', 'Zahra', 'fatima.zahra@gmail.com',
 '$2a$10$N9qo8uLOickgx2ZMRZoMyeIjZAgcfl7p92ldGxad68LJZdL17lhWy',
 '+212662345678', '321 Avenue Mohammed VI, Marrakech', 'USER', TRUE, NOW(), NOW()),

('Youssef', 'Idrissi', 'youssef.idrissi@gmail.com',
 '$2a$10$N9qo8uLOickgx2ZMRZoMyeIjZAgcfl7p92ldGxad68LJZdL17lhWy',
 '+212663456789', '654 Rue Agadir, Agadir', 'USER', TRUE, NOW(), NOW()),

('Meriem', 'Alami', 'meriem.alami@hotmail.com',
 '$2a$10$N9qo8uLOickgx2ZMRZoMyeIjZAgcfl7p92ldGxad68LJZdL17lhWy',
 '+212664567890', '987 Avenue Moulay Youssef, Tanger', 'USER', TRUE, NOW(), NOW()),

('Karim', 'Tazi', 'karim.tazi@yahoo.com',
 '$2a$10$N9qo8uLOickgx2ZMRZoMyeIjZAgcfl7p92ldGxad68LJZdL17lhWy',
 '+212665678901', '147 Rue Ibn Sina, Fès', 'USER', TRUE, NOW(), NOW()),

('Amal', 'Berrada', 'amal.berrada@gmail.com',
 '$2a$10$N9qo8uLOickgx2ZMRZoMyeIjZAgcfl7p92ldGxad68LJZdL17lhWy',
 '+212666789012', '258 Avenue Atlas, Meknès', 'USER', TRUE, NOW(), NOW()),

('Omar', 'Fassi', 'omar.fassi@gmail.com',
 '$2a$10$N9qo8uLOickgx2ZMRZoMyeIjZAgcfl7p92ldGxad68LJZdL17lhWy',
 '+212667890123', '369 Boulevard Hassan II, Oujda', 'USER', TRUE, NOW(), NOW()),

('Zineb', 'Amrani', 'zineb.amrani@outlook.com',
 '$2a$10$N9qo8uLOickgx2ZMRZoMyeIjZAgcfl7p92ldGxad68LJZdL17lhWy',
 '+212668901234', '741 Rue Moulay Ismail, Kenitra', 'USER', TRUE, NOW(), NOW());

-- Mot de passe par défaut pour tous les utilisateurs: "Password123!"

-- ================================================================
-- TABLE: destinations
-- ================================================================
INSERT INTO destinations (name, country, description, image_url, active) VALUES
-- Destinations nationales
('Marrakech', 'Maroc', 'La ville rouge, célèbre pour sa médina, ses souks colorés, le jardin Majorelle et la place Jemaa el-Fna. Une destination incontournable alliant tradition et modernité.', 'https://images.unsplash.com/photo-1597212618440-806262de4f6b', TRUE),
('Casablanca', 'Maroc', 'La capitale économique du Maroc, connue pour la mosquée Hassan II, ses plages et son architecture Art Déco. Une ville moderne et dynamique.', 'https://encrypted-tbn0.gstatic.com/licensed-image?q=tbn:ANd9GcR997WEdoRn7QXDmQrsWM2eZMW-rZbbRLc50_vp7v4au3_RxwhYC9DH_Rmg793N12TUMCXFhQQsuVLEiBnucQlq8hQ&s=19', TRUE),
('Fès', 'Maroc', 'La capitale spirituelle et culturelle du Maroc, abritant la plus ancienne université du monde. Ses médersas et tanneries sont mondialement célèbres.', 'https://images.unsplash.com/photo-1540959733332-eab4deabeeaf', TRUE),
('Agadir', 'Maroc', 'Station balnéaire réputée avec 300 jours de soleil par an, plages de sable fin et activités nautiques. Idéale pour des vacances détente.', 'https://encrypted-tbn0.gstatic.com/licensed-image?q=tbn:ANd9GcQntGE4YRzCt4mZyvmABqBkax0o1ina3gfyZvrNDHSXCID0hnzcENDQA9YRXhCw13WyAH3h7Met2INkXWmwXP9PAus&s=19', TRUE),
('Chefchaouen', 'Maroc', 'La perle bleue du Maroc, nichée dans les montagnes du Rif. Ses ruelles bleues et son atmosphère paisible en font une destination unique.', 'https://lh3.googleusercontent.com/gps-cs-s/AG0ilSyiaPXBnHvvd8LAtD7IEZe8eESStufe_DbgIKgilmDO38-cq9Nl1fsywP86vYSLvLV5xmI-Wwo1PKCSbBGDk8X75h4R-IhFUJiNcinVjLRrCo2HRbsC2Qg_opwXjjCh6fJIAOP-YQ=w675-h390-n-k-no', TRUE),

-- Destinations internationales - Europe
('Paris', 'France', 'La ville lumière, capitale de la mode et de la gastronomie. Tour Eiffel, Louvre, Champs-Élysées... une destination romantique par excellence.', 'https://images.unsplash.com/photo-1502602898657-3e91760cbb34', TRUE),
('Londres', 'Royaume-Uni', 'Capitale britannique mêlant histoire et modernité. Big Ben, Tower Bridge, British Museum et une scène culturelle vibrante.', 'https://images.unsplash.com/photo-1513635269975-59663e0ac1ad', TRUE),
('Rome', 'Italie', 'La ville éternelle regorge de trésors historiques. Colisée, Vatican, Fontaine de Trevi... chaque coin raconte une histoire millénaire.', 'https://images.unsplash.com/photo-1552832230-c0197dd311b5', TRUE),
('Barcelone', 'Espagne', 'Ville catalane vibrant au rythme de Gaudí. Sagrada Familia, Park Güell et plages urbaines font son charme unique.', 'https://images.unsplash.com/photo-1583422409516-2895a77efded', TRUE),
('Istanbul', 'Turquie', 'Pont entre Orient et Occident, Istanbul fascine par ses mosquées, bazars et palais. Une expérience culturelle unique.', 'https://images.unsplash.com/photo-1541432901042-2d8bd64b4a9b', TRUE),

-- Destinations internationales - Asie
('Dubai', 'Émirats Arabes Unis', 'Ville futuriste du désert, symbole de luxe et de démesure. Burj Khalifa, îles artificielles et shopping de classe mondiale.', 'https://images.unsplash.com/photo-1512453979798-5ea266f8880c', TRUE),
('Tokyo', 'Japon', 'Métropole ultra-moderne où tradition et innovation coexistent. Temples zen, quartiers animés et gastronomie exceptionnelle.', 'https://images.unsplash.com/photo-1540959733332-eab4deabeeaf', TRUE),
('Bangkok', 'Thaïlande', 'Capitale thaïlandaise vibrante de vie, temples dorés, marchés flottants et street food délicieuse. Une aventure asiatique authentique.', 'https://images.unsplash.com/photo-1563492065599-3520f775eeed', TRUE),

-- Destinations internationales - Afrique
('Le Caire', 'Égypte', 'Porte d''entrée vers les pyramides de Gizeh et le Sphinx. Histoire ancienne, musées fascinants et Nil majestueux.', 'https://images.unsplash.com/photo-1572252009286-268acec5ca0a', TRUE),
('Dakar', 'Sénégal', 'Capitale dynamique ouest-africaine, riche en culture, musique et hospitalité. Plages magnifiques et île de Gorée historique.', 'https://lh3.googleusercontent.com/gps-cs-s/AG0ilSyvNGciQysAQGGU_YIxQxAOSaO4HPu9leTLpuUmeSs3L2qTZxX9c-uSGLb1X6Y8qEB5v0ffVWaD_gabctNLpZeTFKGIKBvL1v7y-yDajCR9cv6QZN9yTNXONddChVIWVRmbMkmBtA=w675-h390-n-k-no', TRUE);

-- ================================================================
-- TABLE: hotels
-- ================================================================
INSERT INTO hotels (name, destination_id, address, stars, description, price_per_night, available_rooms, total_rooms, image_url, wifi, pool, restaurant, parking, active) VALUES
-- Marrakech (ID: 1)
('La Mamounia', 1, 'Avenue Bab Jdid, Marrakech 40040', 5, 'Palace légendaire au cœur de Marrakech, jardins luxuriants, spa de renommée mondiale et restaurants gastronomiques.', 450.00, 135, 135, 'https://images.unsplash.com/photo-1566073771259-6a8506099945', TRUE, TRUE, TRUE, TRUE, TRUE),
('Riad Yasmine', 1, 'Derb Sidi Bouamar, Médina, Marrakech', 4, 'Riad traditionnel au cœur de la médina, décoration authentique, patio avec fontaine et terrasse panoramique.', 120.00, 8, 8, 'https://images.unsplash.com/photo-1564501049412-61c2a3083791', TRUE, TRUE, TRUE, FALSE, TRUE),
('Kenzi Club Agdal Medina', 1, 'Route de l''Ourika, Marrakech', 5, 'Complexe hôtelier avec plusieurs piscines, spa, golf et animations quotidiennes. Parfait pour les familles.', 180.00, 250, 250, 'https://images.unsplash.com/photo-1571896349842-33c89424de2d', TRUE, TRUE, TRUE, TRUE, TRUE),

-- Casablanca (ID: 2)
('Four Seasons Casablanca', 2, 'Boulevard de la Corniche, Casablanca', 5, 'Luxe moderne face à l''océan, spa exceptionnel, restaurants étoilés et service impeccable.', 350.00, 180, 185, 'https://images.unsplash.com/photo-1582719508461-905c673771fd', TRUE, TRUE, TRUE, TRUE, TRUE),
('Kenzi Tower Hotel', 2, 'Twin Center, Boulevard Zerktouni', 5, 'Hôtel d''affaires moderne dans les tours jumelles, rooftop avec vue panoramique.', 200.00, 220, 237, 'https://images.unsplash.com/photo-1551882547-ff40c63fe5fa', TRUE, TRUE, TRUE, TRUE, TRUE),

-- Fès (ID: 3)
('Palais Faraj Suites & Spa', 3, 'Bab Ziat, Quartier Ziat, Fès', 5, 'Palace restauré avec vue sur la médina, spa traditionnel et restaurant gastronomique.', 280.00, 19, 20, 'https://images.unsplash.com/photo-1578683010236-d716f9a3f461', TRUE, TRUE, TRUE, TRUE, TRUE),
('Riad Fès', 3, 'Derb Ben Slimane, Médina, Fès', 5, 'Riad de luxe alliant architecture traditionnelle et confort moderne, bibliothèque et jardin andalou.', 220.00, 27, 30, 'https://images.unsplash.com/photo-1562790351-d273a961e0e9', TRUE, TRUE, TRUE, FALSE, TRUE),

-- Agadir (ID: 4)
('Sofitel Agadir Royal Bay Resort', 4, 'Baie des Palmiers, Agadir', 5, 'Resort balnéaire de luxe, plage privée, thalasso et cuisine française raffinée.', 320.00, 265, 273, 'https://images.unsplash.com/photo-1520250497591-112f2f40a3f4', TRUE, TRUE, TRUE, TRUE, TRUE),
('Atlantic Hotel Agadir', 4, 'Boulevard Mohammed V, Agadir', 4, 'Hôtel moderne face à la plage, animations variées et ambiance familiale.', 95.00, 340, 350, 'https://images.unsplash.com/photo-1566665797739-1674de7a421a', TRUE, TRUE, TRUE, TRUE, TRUE),

-- Paris (ID: 6)
('Le Meurice', 6, '228 Rue de Rivoli, Paris 75001', 5, 'Palace parisien face aux Tuileries, décor somptueux, restaurant triplement étoilé.', 850.00, 155, 160, 'https://images.unsplash.com/photo-1551882547-ff40c63fe5fa', TRUE, FALSE, TRUE, TRUE, TRUE),
('Hotel Le Marais', 6, '45 Rue du Temple, Paris 75004', 3, 'Hôtel boutique dans le Marais, quartier branché, décoration contemporaine.', 150.00, 35, 38, 'https://images.unsplash.com/photo-1596436889106-be35e843f974', TRUE, FALSE, TRUE, FALSE, TRUE),

-- Londres (ID: 7)
('The Savoy', 7, 'Strand, Westminster, London WC2R 0EZ', 5, 'Hôtel légendaire au bord de la Tamise, luxe britannique et service impeccable depuis 1889.', 650.00, 263, 267, 'https://images.unsplash.com/photo-1555854877-bab0e564b8d5', TRUE, TRUE, TRUE, TRUE, TRUE),
('Premier Inn London City', 7, '1 Tower Hill, London EC3N 4AB', 3, 'Hôtel moderne près de Tower Bridge, excellent rapport qualité-prix au cœur de Londres.', 120.00, 312, 320, 'https://images.unsplash.com/photo-1542314831-068cd1dbfeeb', TRUE, FALSE, TRUE, FALSE, TRUE),

-- Dubai (ID: 11)
('Burj Al Arab', 11, 'Jumeirah Street, Dubai', 7, 'Icône de Dubai, hôtel sept étoiles sur île artificielle, luxe absolu et service de majordome.', 1500.00, 195, 202, 'https://images.unsplash.com/photo-1582719508461-905c673771fd', TRUE, TRUE, TRUE, TRUE, TRUE),
('Atlantis The Palm', 11, 'Crescent Road, The Palm, Dubai', 5, 'Resort spectaculaire avec parc aquatique, aquarium et plages privées.', 450.00, 1539, 1548, 'https://images.unsplash.com/photo-1512917774080-9991f1c4c750', TRUE, TRUE, TRUE, TRUE, TRUE);

-- ================================================================
-- TABLE: flights
-- ================================================================
INSERT INTO flights (flight_number, departure_city, destination_id, departure_date, arrival_date, airline, price, available_seats, total_seats, class_type, active) VALUES
-- Vols nationaux
('RAM101', 'Casablanca', 1, '2025-01-15 08:00:00', '2025-01-15 09:00:00', 'Royal Air Maroc', 89.00, 148, 150, 'ECONOMY', TRUE),
('RAM102', 'Casablanca', 3, '2025-01-15 10:30:00', '2025-01-15 11:40:00', 'Royal Air Maroc', 95.00, 145, 150, 'ECONOMY', TRUE),
('RAM103', 'Casablanca', 4, '2025-01-16 14:00:00', '2025-01-16 14:45:00', 'Royal Air Maroc', 79.00, 175, 180, 'ECONOMY', TRUE),
('AMS301', 'Rabat', 1, '2025-01-17 07:30:00', '2025-01-17 08:30:00', 'Air Arabia Maroc', 69.00, 177, 180, 'ECONOMY', TRUE),
('AMS302', 'Tanger', 1, '2025-01-18 16:00:00', '2025-01-18 17:15:00', 'Air Arabia Maroc', 99.00, 143, 150, 'ECONOMY', TRUE),

-- Vols internationaux - Europe
('RAM201', 'Casablanca', 6, '2025-01-20 06:00:00', '2025-01-20 10:30:00', 'Royal Air Maroc', 249.00, 235, 250, 'ECONOMY', TRUE),
('RAM202', 'Casablanca', 6, '2025-01-20 15:00:00', '2025-01-20 19:30:00', 'Royal Air Maroc', 1250.00, 28, 30, 'BUSINESS', TRUE),
('AF500', 'Paris', 2, '2025-01-22 11:00:00', '2025-01-22 15:45:00', 'Air France', 289.00, 218, 230, 'ECONOMY', TRUE),
('RAM203', 'Casablanca', 7, '2025-01-21 08:30:00', '2025-01-21 12:00:00', 'Royal Air Maroc', 269.00, 242, 250, 'ECONOMY', TRUE),
('BA401', 'Londres', 2, '2025-01-23 13:30:00', '2025-01-23 18:15:00', 'British Airways', 299.00, 268, 280, 'ECONOMY', TRUE),
('RAM204', 'Casablanca', 8, '2025-01-24 09:00:00', '2025-01-24 13:15:00', 'Royal Air Maroc', 259.00, 196, 200, 'ECONOMY', TRUE),
('RAM205', 'Casablanca', 9, '2025-01-25 10:00:00', '2025-01-25 14:00:00', 'Royal Air Maroc', 229.00, 188, 200, 'ECONOMY', TRUE),
('TK600', 'Istanbul', 2, '2025-01-26 16:00:00', '2025-01-26 20:45:00', 'Turkish Airlines', 319.00, 271, 280, 'ECONOMY', TRUE),
('RAM206', 'Casablanca', 10, '2025-01-27 07:00:00', '2025-01-27 11:45:00', 'Royal Air Maroc', 279.00, 235, 250, 'ECONOMY', TRUE),

-- Vols internationaux - Moyen-Orient & Asie
('EK701', 'Dubai', 2, '2025-01-28 02:00:00', '2025-01-28 08:30:00', 'Emirates', 459.00, 342, 360, 'ECONOMY', TRUE),
('RAM207', 'Casablanca', 11, '2025-01-28 22:00:00', '2025-01-29 07:30:00', 'Royal Air Maroc', 549.00, 188, 200, 'ECONOMY', TRUE),
('EK702', 'Dubai', 2, '2025-01-28 09:00:00', '2025-01-28 15:30:00', 'Emirates', 2850.00, 12, 12, 'FIRST_CLASS', TRUE),
('TG800', 'Bangkok', 2, '2025-02-01 18:00:00', '2025-02-02 13:30:00', 'Thai Airways', 689.00, 267, 280, 'ECONOMY', TRUE),

-- Vols internationaux - Afrique
('RAM208', 'Casablanca', 14, '2025-02-05 11:00:00', '2025-02-05 15:30:00', 'Royal Air Maroc', 189.00, 143, 150, 'ECONOMY', TRUE),
('MS900', 'Le Caire', 2, '2025-02-06 14:00:00', '2025-02-06 19:00:00', 'EgyptAir', 329.00, 235, 250, 'ECONOMY', TRUE),
('RAM209', 'Casablanca', 15, '2025-02-08 08:00:00', '2025-02-08 11:00:00', 'Royal Air Maroc', 159.00, 173, 180, 'ECONOMY', TRUE);

-- ================================================================
-- TABLE: circuits
-- ================================================================
INSERT INTO circuits (name, destination_id, description, durationDays, price, start_date, end_date, available_spots, total_spots, included, excluded, image_url, active) VALUES
-- Circuits Maroc
('Circuit Impérial', 3, 'Découverte des villes impériales: Rabat, Meknès, Fès et Marrakech. Visite des médinas, monuments historiques et souks traditionnels.', 7, 890.00, '2025-02-01', '2025-02-07', 18, 20, 'Transport, Guide francophone, Hébergement en riad, 14 repas', 'Vols internationaux, Boissons, Pourboires', 'https://images.unsplash.com/photo-1597212618440-806262de4f6b', TRUE),

('Grand Sud Marocain', 1, 'Aventure dans le désert: Marrakech, vallée du Dadès, gorges du Todra, Merzouga et nuit dans le désert sous les étoiles.', 5, 650.00, '2025-02-10', '2025-02-14', 23, 25, 'Transport 4x4, Guide, Hébergement, Tous les repas, Balade en chameau', 'Vols, Boissons alcoolisées', 'https://images.unsplash.com/photo-1558221851-d71a0ae488f4', TRUE),

('Merveilles du Nord', 5, 'Circuit culturel: Tanger, Tétouan, Chefchaouen et Asilah. Découverte des villes bleues et blanches du Rif.', 4, 520.00, '2025-02-15', '2025-02-18', 15, 16, 'Transport, Guide, Hôtels 4*, Petit-déjeuner', 'Déjeuners, Dîners, Entrées monuments', 'https://images.unsplash.com/photo-1565098772267-60af42b81ef2', TRUE),

('Route des Kasbahs', 1, 'Exploration des kasbahs fortifiées: Aït Ben Haddou, vallée des Roses, palmeraies et villages berbères authentiques.', 6, 780.00, '2025-02-20', '2025-02-25', 16, 18, 'Transport, Guide berbère, Hébergement, 2 repas par jour', 'Vols, Déjeuners, Boissons', 'https://images.unsplash.com/photo-1511739001486-6bfe10ce785f', TRUE),

-- Circuits Europe
('Paris Romantique', 6, 'Séjour de charme à Paris: Tour Eiffel, Louvre, Montmartre, croisière sur la Seine et dîner gastronomique.', 4, 1250.00, '2025-02-12', '2025-02-15', 11, 12, 'Hôtel 4*, Petit-déjeuner, Visites guidées, Métro illimité, Croisière', 'Vols, Déjeuners, Dîners (sauf 1)', 'https://images.unsplash.com/photo-1502602898657-3e91760cbb34', TRUE),

('Capitales Européennes', 7, 'Circuit Londres-Paris-Bruxelles: 3 capitales, monuments iconiques, shopping et gastronomie.', 8, 1890.00, '2025-03-01', '2025-03-08', 19, 22, 'Transport Eurostar, Hôtels 4*, Visites guidées, 16 repas', 'Vols, Extras personnels', 'https://images.unsplash.com/photo-1513635269975-59663e0ac1ad', TRUE),

('La Dolce Vita', 8, 'L''Italie de Rome à Florence: Colisée, Vatican, Toscane, dégustation de vins et cours de cuisine italienne.', 7, 1680.00, '2025-03-10', '2025-03-16', 13, 15, 'Train, Guide italien, Hôtels de charme, 14 repas, Dégustations', 'Vols, Déjeuners en ville', 'https://images.unsplash.com/photo-1552832230-c0197dd311b5', TRUE),

('Espagne Flamboyante', 9, 'Circuit Barcelone-Madrid-Séville: Gaudí, musées, flamenco et tapas. Immersion dans la culture espagnole.', 8, 1450.00, '2025-03-15', '2025-03-22', 17, 20, 'Train AVE, Hôtels 4*, Spectacles, 16 repas, Visites guidées', 'Vols, Boissons aux repas', 'https://images.unsplash.com/photo-1583422409516-2895a77efded', TRUE),

-- Circuits Moyen-Orient & Asie
('Mille et Une Nuits Dubai', 11, 'Luxe à Dubai: Burj Khalifa, safari désert, croisière dhow, Dubai Mall et Palm Jumeirah.', 5, 1850.00, '2025-03-20', '2025-03-24', 14, 16, 'Hôtel 5*, Transferts, Excursions, Breakfast, Safari', 'Vols, Déjeuners et dîners', 'https://images.unsplash.com/photo-1512453979798-5ea266f8880c', TRUE),

('Trésors du Japon', 12, 'Tokyo-Kyoto-Osaka: temples zen, jardins japonais, Mont Fuji, cérémonie du thé et sushi experience.', 10, 3250.00, '2025-04-01', '2025-04-10', 11, 12, 'Shinkansen, Guide francophone, Ryokan + Hôtels, 20 repas, Visites', 'Vols, Extras, Certains repas', 'https://images.unsplash.com/photo-1540959733332-eab4deabeeaf', TRUE),

-- Circuits Afrique
('Splendeurs d''Égypte', 14, 'Croisière sur le Nil: Pyramides, Louxor, Assouan, temples pharaoniques et tombeau de Toutânkhamon.', 8, 1580.00, '2025-04-05', '2025-04-12', 27, 30, 'Croisière 5*, Vol interne, Tous les repas, Visites, Égyptologue', 'Vols internationaux, Pourboires', 'https://images.unsplash.com/photo-1572252009286-268acec5ca0a', TRUE);

-- ================================================================
-- TABLE: promotions
-- ================================================================
INSERT INTO promotions (code, description, discount_percentage, start_date, end_date, active, promo_type) VALUES
('WELCOME2025', 'Promotion de bienvenue - 15% de réduction sur votre première réservation', 15.00, '2025-01-01', '2025-03-31', TRUE, 'ALL'),
('SUMMER2025', 'Promo été 2025 - 20% sur tous les circuits', 20.00, '2025-06-01', '2025-08-31', TRUE, 'CIRCUIT'),
('FLASH48H', 'Vente flash 48h - 25% sur les vols sélectionnés', 25.00, '2025-01-27', '2025-01-29', TRUE, 'FLIGHT'),
('HOTEL10', 'Réduction hôtels - 10% sur les séjours de plus de 3 nuits', 10.00, '2025-01-15', '2025-12-31', TRUE, 'HOTEL'),
('EARLYBIRD', 'Réservation anticipée - 18% de réduction pour les réservations 60 jours à l''avance', 18.00, '2025-01-01', '2025-12-15', TRUE, 'ALL'),
('FAMILY20', 'Offre famille - 20% pour les groupes de 4 personnes et plus', 20.00, '2025-02-01', '2025-04-30', TRUE, 'CIRCUIT'),
('LUXE30', 'Séjour luxe - 30% sur les hôtels 5 étoiles', 30.00, '2025-01-20', '2025-02-28', TRUE, 'HOTEL'),
('WEEKEND15', 'Week-end escapade - 15% sur les vols week-end', 15.00, '2025-01-01', '2025-06-30', TRUE, 'FLIGHT');

-- ================================================================
-- TABLE: reservations
-- ================================================================
INSERT INTO reservations (reservation_number, user_id, reservation_type, flight_id, hotel_id, circuit_id, check_in_date, check_out_date, number_of_people, total_amount, status, created_at, updated_at) VALUES
-- Réservations de vols
('RES-1704024001', 3, 'FLIGHT', 1, NULL, NULL, NULL, NULL, 2, 178.00, 'CONFIRMEE', DATE_SUB(NOW(), INTERVAL 15 DAY), DATE_SUB(NOW(), INTERVAL 15 DAY)),
('RES-1704024002', 4, 'FLIGHT', 6, NULL, NULL, NULL, NULL, 1, 249.00, 'CONFIRMEE', DATE_SUB(NOW(), INTERVAL 12 DAY), DATE_SUB(NOW(), INTERVAL 12 DAY)),
('RES-1704024003', 5, 'FLIGHT', 14, NULL, NULL, NULL, NULL, 2, 918.00, 'EN_ATTENTE', DATE_SUB(NOW(), INTERVAL 5 DAY), DATE_SUB(NOW(), INTERVAL 5 DAY)),
('RES-1704024004', 7, 'FLIGHT', 7, NULL, NULL, NULL, NULL, 1, 1250.00, 'CONFIRMEE', DATE_SUB(NOW(), INTERVAL 8 DAY), DATE_SUB(NOW(), INTERVAL 8 DAY)),

-- Réservations d'hôtels
('RES-1704024005', 3, 'HOTEL', NULL, 3, NULL, '2025-02-10 14:00:00', '2025-02-15 11:00:00', 2, 900.00, 'CONFIRMEE', DATE_SUB(NOW(), INTERVAL 10 DAY), DATE_SUB(NOW(), INTERVAL 10 DAY)),
('RES-1704024006', 6, 'HOTEL', NULL, 1, NULL, '2025-02-20 15:00:00', '2025-02-23 12:00:00', 2, 1350.00, 'CONFIRMEE', DATE_SUB(NOW(), INTERVAL 7 DAY), DATE_SUB(NOW(), INTERVAL 7 DAY)),
('RES-1704024007', 8, 'HOTEL', NULL, 9, NULL, '2025-03-01 14:00:00', '2025-03-05 11:00:00', 4, 2400.00, 'EN_ATTENTE', DATE_SUB(NOW(), INTERVAL 3 DAY), DATE_SUB(NOW(), INTERVAL 3 DAY)),
('RES-1704024008', 4, 'HOTEL', NULL, 11, NULL, '2025-03-10 16:00:00', '2025-03-12 12:00:00', 2, 300.00, 'CONFIRMEE', DATE_SUB(NOW(), INTERVAL 6 DAY), DATE_SUB(NOW(), INTERVAL 6 DAY)),

-- Réservations de circuits
('RES-1704024009', 5, 'CIRCUIT', NULL, NULL, 1, '2025-02-01 09:00:00', '2025-02-07 18:00:00', 2, 1780.00, 'CONFIRMEE', DATE_SUB(NOW(), INTERVAL 20 DAY), DATE_SUB(NOW(), INTERVAL 20 DAY)),
('RES-1704024010', 9, 'CIRCUIT', NULL, NULL, 2, '2025-02-10 08:00:00', '2025-02-14 19:00:00', 3, 1950.00, 'CONFIRMEE', DATE_SUB(NOW(), INTERVAL 18 DAY), DATE_SUB(NOW(), INTERVAL 18 DAY)),
('RES-1704024011', 7, 'CIRCUIT', NULL, NULL, 5, '2025-02-12 10:00:00', '2025-02-15 20:00:00', 2, 2500.00, 'EN_ATTENTE', DATE_SUB(NOW(), INTERVAL 4 DAY), DATE_SUB(NOW(), INTERVAL 4 DAY)),
('RES-1704024012', 10, 'CIRCUIT', NULL, NULL, 3, '2025-02-15 09:00:00', '2025-02-18 18:00:00', 4, 2080.00, 'CONFIRMEE', DATE_SUB(NOW(), INTERVAL 14 DAY), DATE_SUB(NOW(), INTERVAL 14 DAY)),

-- Réservations package (vol + hôtel)
('RES-1704024013', 6, 'PACKAGE', 6, 9, NULL, '2025-02-22 14:00:00', '2025-02-27 11:00:00', 2, 4298.00, 'CONFIRMEE', DATE_SUB(NOW(), INTERVAL 9 DAY), DATE_SUB(NOW(), INTERVAL 9 DAY)),
('RES-1704024014', 8, 'PACKAGE', 14, 15, NULL, '2025-03-05 15:00:00', '2025-03-10 12:00:00', 2, 7918.00, 'CONFIRMEE', DATE_SUB(NOW(), INTERVAL 11 DAY), DATE_SUB(NOW(), INTERVAL 11 DAY)),
('RES-1704024015', 10, 'PACKAGE', 9, 11, NULL, '2025-03-15 14:00:00', '2025-03-18 11:00:00', 2, 898.00, 'EN_ATTENTE', DATE_SUB(NOW(), INTERVAL 2 DAY), DATE_SUB(NOW(), INTERVAL 2 DAY));

-- ================================================================
-- TABLE: payments
-- ================================================================
INSERT INTO payments (reservation_id, transaction_id, amount, payment_method, status, payment_date, created_at) VALUES
-- Paiements complétés
(1, 'TXN-1704024001', 178.00, 'CREDIT_CARD', 'COMPLETED', DATE_SUB(NOW(), INTERVAL 15 DAY), DATE_SUB(NOW(), INTERVAL 15 DAY)),
(2, 'TXN-1704024002', 249.00, 'PAYPAL', 'COMPLETED', DATE_SUB(NOW(), INTERVAL 12 DAY), DATE_SUB(NOW(), INTERVAL 12 DAY)),
(4, 'TXN-1704024004', 1250.00, 'STRIPE', 'COMPLETED', DATE_SUB(NOW(), INTERVAL 8 DAY), DATE_SUB(NOW(), INTERVAL 8 DAY)),
(5, 'TXN-1704024005', 900.00, 'CREDIT_CARD', 'COMPLETED', DATE_SUB(NOW(), INTERVAL 10 DAY), DATE_SUB(NOW(), INTERVAL 10 DAY)),
(6, 'TXN-1704024006', 1350.00, 'CREDIT_CARD', 'COMPLETED', DATE_SUB(NOW(), INTERVAL 7 DAY), DATE_SUB(NOW(), INTERVAL 7 DAY)),
(8, 'TXN-1704024008', 300.00, 'PAYPAL', 'COMPLETED', DATE_SUB(NOW(), INTERVAL 6 DAY), DATE_SUB(NOW(), INTERVAL 6 DAY)),
(9, 'TXN-1704024009', 1780.00, 'CREDIT_CARD', 'COMPLETED', DATE_SUB(NOW(), INTERVAL 20 DAY), DATE_SUB(NOW(), INTERVAL 20 DAY)),
(10, 'TXN-1704024010', 1950.00, 'STRIPE', 'COMPLETED', DATE_SUB(NOW(), INTERVAL 18 DAY), DATE_SUB(NOW(), INTERVAL 18 DAY)),
(12, 'TXN-1704024012', 2080.00, 'CREDIT_CARD', 'COMPLETED', DATE_SUB(NOW(), INTERVAL 14 DAY), DATE_SUB(NOW(), INTERVAL 14 DAY)),
(13, 'TXN-1704024013', 4298.00, 'CREDIT_CARD', 'COMPLETED', DATE_SUB(NOW(), INTERVAL 9 DAY), DATE_SUB(NOW(), INTERVAL 9 DAY)),
(14, 'TXN-1704024014', 7918.00, 'BANK_TRANSFER', 'COMPLETED', DATE_SUB(NOW(), INTERVAL 11 DAY), DATE_SUB(NOW(), INTERVAL 11 DAY)),

-- Paiements en attente
(3, 'TXN-1704024003', 918.00, 'CREDIT_CARD', 'PENDING', NULL, DATE_SUB(NOW(), INTERVAL 5 DAY)),
(7, 'TXN-1704024007', 2400.00, 'PAYPAL', 'PENDING', NULL, DATE_SUB(NOW(), INTERVAL 3 DAY)),
(11, 'TXN-1704024011', 2500.00, 'STRIPE', 'PENDING', NULL, DATE_SUB(NOW(), INTERVAL 4 DAY)),
(15, 'TXN-1704024015', 898.00, 'CREDIT_CARD', 'PENDING', NULL, DATE_SUB(NOW(), INTERVAL 2 DAY));

-- ================================================================
-- TABLE: reviews
-- ================================================================
INSERT INTO reviews (user_id, review_type, flight_id, hotel_id, circuit_id, rating, comment, created_at) VALUES
-- Avis sur les vols
(3, 'FLIGHT', 1, NULL, NULL, 5, 'Vol excellent avec Royal Air Maroc. Personnel très professionnel et ponctuel. Je recommande vivement!', DATE_SUB(NOW(), INTERVAL 13 DAY)),
(4, 'FLIGHT', 6, NULL, NULL, 4, 'Bon vol vers Paris, confortable et repas correct. Petit retard au départ mais bien géré.', DATE_SUB(NOW(), INTERVAL 10 DAY)),
(7, 'FLIGHT', 7, NULL, NULL, 5, 'Classe affaires exceptionnelle! Service impeccable, sièges confortables. Expérience premium.', DATE_SUB(NOW(), INTERVAL 6 DAY)),

-- Avis sur les hôtels
(3, 'HOTEL', NULL, 3, NULL, 5, 'Séjour magnifique au Kenzi Club! Piscines superbes, personnel accueillant, animations variées. Parfait pour les familles.', DATE_SUB(NOW(), INTERVAL 8 DAY)),
(6, 'HOTEL', NULL, 1, NULL, 5, 'La Mamounia est un véritable palace! Luxe, raffinement, jardins splendides. Une expérience inoubliable.', DATE_SUB(NOW(), INTERVAL 5 DAY)),
(4, 'HOTEL', NULL, 11, NULL, 4, 'Très bon hôtel à Londres, bien situé près de Tower Bridge. Chambre propre et petit-déjeuner copieux.', DATE_SUB(NOW(), INTERVAL 4 DAY)),
(8, 'HOTEL', NULL, 15, NULL, 5, 'Burj Al Arab est au-delà de toutes nos attentes! Service de majordome exceptionnel, luxe absolu. Inoubliable!', DATE_SUB(NOW(), INTERVAL 9 DAY)),

-- Avis sur les circuits
(5, 'CIRCUIT', NULL, NULL, 1, 5, 'Circuit Impérial fantastique! Guide très compétent, riads authentiques, découverte culturelle enrichissante.', DATE_SUB(NOW(), INTERVAL 15 DAY)),
(9, 'CIRCUIT', NULL, NULL, 2, 5, 'Aventure incroyable dans le désert! Nuit sous les étoiles magique, paysages à couper le souffle. À faire absolument!', DATE_SUB(NOW(), INTERVAL 12 DAY)),
(10, 'CIRCUIT', NULL, NULL, 3, 4, 'Beau circuit dans le Nord. Chefchaouen est magnifique! Aurait aimé plus de temps libre dans certaines villes.', DATE_SUB(NOW(), INTERVAL 10 DAY)),
(6, 'CIRCUIT', NULL, NULL, 5, 5, 'Paris romantique à souhait! Tour Eiffel, Louvre, croisière sur la Seine... tout était parfait! Merci VoyageConnect.', DATE_SUB(NOW(), INTERVAL 7 DAY)),

-- Avis additionnels
(5, 'HOTEL', NULL, 5, NULL, 4, 'Kenzi Tower Hotel très bien pour un séjour d''affaires. Moderne, bien équipé, rooftop agréable.', DATE_SUB(NOW(), INTERVAL 11 DAY)),
(7, 'FLIGHT', 14, NULL, NULL, 5, 'Emirates Airlines toujours au top! Confort, divertissement à bord, service exemplaire.', DATE_SUB(NOW(), INTERVAL 14 DAY)),
(9, 'HOTEL', NULL, 10, NULL, 3, 'Hotel Le Marais correct pour le prix. Bien situé dans un quartier sympa mais chambres un peu petites.', DATE_SUB(NOW(), INTERVAL 6 DAY)),
(10, 'FLIGHT', 3, NULL, NULL, 4, 'Vol Casablanca-Agadir rapide et efficace. Personnel aimable. Bon rapport qualité-prix.', DATE_SUB(NOW(), INTERVAL 9 DAY));

-- ================================================================
-- Mise à jour des disponibilités
-- ================================================================

-- Mise à jour des places disponibles pour les vols réservés
UPDATE flights SET available_seats = available_seats - 2 WHERE id = 1;
UPDATE flights SET available_seats = available_seats - 1 WHERE id = 6;
UPDATE flights SET available_seats = available_seats - 2 WHERE id = 14;
UPDATE flights SET available_seats = available_seats - 1 WHERE id = 7;
UPDATE flights SET available_seats = available_seats - 2 WHERE id = 9;

-- Mise à jour des chambres disponibles pour les hôtels réservés
UPDATE hotels SET available_rooms = available_rooms - 1 WHERE id = 3;
UPDATE hotels SET available_rooms = available_rooms - 1 WHERE id = 1;
UPDATE hotels SET available_rooms = available_rooms - 2 WHERE id = 9;
UPDATE hotels SET available_rooms = available_rooms - 1 WHERE id = 11;
UPDATE hotels SET available_rooms = available_rooms - 1 WHERE id = 15;

-- Mise à jour des places disponibles pour les circuits réservés
UPDATE circuits SET available_spots = available_spots - 2 WHERE id = 1;
UPDATE circuits SET available_spots = available_spots - 3 WHERE id = 2;
UPDATE circuits SET available_spots = available_spots - 2 WHERE id = 5;
UPDATE circuits SET available_spots = available_spots - 4 WHERE id = 3;

-- ================================================================
-- Vérifications et statistiques
-- ================================================================

-- Afficher le nombre d'enregistrements par table
SELECT 'users' AS table_name, COUNT(*) AS count FROM users
UNION ALL
SELECT 'destinations', COUNT(*) FROM destinations
UNION ALL
SELECT 'hotels', COUNT(*) FROM hotels
UNION ALL
SELECT 'flights', COUNT(*) FROM flights
UNION ALL
SELECT 'circuits', COUNT(*) FROM circuits
UNION ALL
SELECT 'promotions', COUNT(*) FROM promotions
UNION ALL
SELECT 'reservations', COUNT(*) FROM reservations
UNION ALL
SELECT 'payments', COUNT(*) FROM payments
UNION ALL
SELECT 'reviews', COUNT(*) FROM reviews;

-- ================================================================
-- FIN DU SCRIPT SEEDER
-- ================================================================

-- Message de confirmation
SELECT 'Base de données initialisée avec succès!' AS message,
       '10 utilisateurs' AS users,
       '15 destinations' AS destinations,
       '15 hôtels' AS hotels,
       '20 vols' AS flights,
       '11 circuits' AS circuits,
       '8 promotions' AS promotions,
       '15 réservations' AS reservations,
       '15 paiements' AS payments,
       '15 avis' AS reviews;
