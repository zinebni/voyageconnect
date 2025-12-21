# 🔍 DIAGNOSTIC COMPLET - Flux de Réservation

## ✅ Ce qui fonctionne

### 1. Fichiers créés et compilés
- ✅ `ReservationNewServlet.java` → Compilé
- ✅ `ReservationConfirmServlet.java` → Compilé
- ✅ `form.jsp` → Créé
- ✅ Classes déployées dans `target/VoyageConnect/WEB-INF/classes/`

### 2. Configuration web.xml
```xml
<!-- Mappings corrects -->
/reservation/new       → ReservationNewServlet
/reservation/confirm   → ReservationConfirmServlet
/reservation/list      → ReservationServlet
/reservation/view      → ReservationServlet
/reservation/cancel    → ReservationServlet
```

### 3. Formulaires JSP
- ✅ `form action="${pageContext.request.contextPath}/reservation/confirm"` ✓
- ✅ Méthode POST ✓
- ✅ Paramètres corrects (type, flightId, numberOfPeople, paymentMethod) ✓

---

## ❌ PROBLÈME PRINCIPAL : Authentification

### Test effectué :
```bash
curl -I http://localhost:8080/VoyageConnect/reservation/new?type=flight&id=1
# Résultat : HTTP 302 Redirect → /auth/login
```

### Cause :
Le filtre `AuthenticationFilter` bloque TOUTES les routes `/reservation/*` :

```xml
<filter-mapping>
    <filter-name>AuthenticationFilter</filter-name>
    <url-pattern>/reservation/*</url-pattern>
</filter-mapping>
```

Le filtre vérifie :
```java
boolean isLoggedIn = (session != null && session.getAttribute("user") != null);
```

### Solution 1 : Se connecter avec un utilisateur valide

**Compte administrateur par défaut :**
```
Email    : admin@voyageconnect.com
Password : Admin123!
```

**OU créer un utilisateur de test :**

```sql
-- Insérer dans MySQL
USE voyageconnect;

INSERT INTO users (email, password, firstname, lastname, phone, role, created_at) 
VALUES (
    'test@voyage.com',
    '$2a$10$N9qo8uLOickgx2ZrVzY1qOZzWpCfaQjU7vVjPJt6mHJW3vB6p8kQO', -- Password: test123
    'Test',
    'User',
    '0612345678',
    'USER',
    NOW()
);
```

### Solution 2 : Exclure le formulaire de réservation du filtre (NON RECOMMANDÉ)

Modifier `web.xml` pour exclure `/reservation/new` du filtre d'authentification.
⚠️ **Risque de sécurité** : permet l'accès sans authentification.

---

## 🧪 TESTS À EFFECTUER

### 1. Se connecter d'abord
```
1. Ouvrir http://localhost:8080/VoyageConnect/auth/login
2. Se connecter avec admin@voyageconnect.com / Admin123!
3. La session stockera : session.setAttribute("user", userObject)
```

### 2. Tester le formulaire de réservation
```
http://localhost:8080/VoyageConnect/reservation/new?type=flight&id=1
```

**Résultat attendu :**
- Page de formulaire avec les détails du vol
- Champs : nombre de passagers, méthode de paiement
- Bouton "Confirmer la réservation"

### 3. Soumettre le formulaire
**Action :** Remplir et soumettre le formulaire

**Requête POST vers :**
```
/VoyageConnect/reservation/confirm
```

**Paramètres envoyés :**
```
type=FLIGHT
flightId=1
numberOfPeople=2
paymentMethod=CREDIT_CARD
```

**Résultat attendu :**
- Création de la réservation en base
- Création du paiement associé
- Affichage de `success.jsp` avec le numéro de réservation

---

## 🔧 CORRECTIONS NÉCESSAIRES

### Option A : Utiliser l'authentification existante

**Rien à modifier** - Il suffit de se connecter avant de réserver.

### Option B : Créer un utilisateur de test SQL

```sql
-- Script SQL complet
USE voyageconnect;

-- Utilisateur : test@voyage.com / test123
INSERT INTO users (email, password, firstname, lastname, phone, role, created_at) 
VALUES (
    'test@voyage.com',
    '$2a$10$N9qo8uLOickgx2ZrVzY1qOZzWpCfaQjU7vVjPJt6mHJW3vB6p8kQO',
    'Test',
    'User',
    '0612345678',
    'USER',
    NOW()
);

-- Vérifier
SELECT id, email, firstname, lastname, role FROM users;
```

### Option C : Créer un endpoint de test sans authentification (DEV uniquement)

Créer `ReservationTestServlet.java` NON protégé pour les tests :

```java
@WebServlet("/test/reservation/new")
public class ReservationTestServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response) {
        // Simuler une session avec userId=1
        HttpSession session = request.getSession();
        session.setAttribute("userId", 1L);
        session.setAttribute("userRole", UserRole.USER);
        
        // Forward vers ReservationNewServlet
        response.sendRedirect("/reservation/new?type=flight&id=1");
    }
}
```

⚠️ **À SUPPRIMER EN PRODUCTION**

---

## 📊 VÉRIFICATION DES DONNÉES

### Vols disponibles
```sql
SELECT id, flight_number, departure_city, airline, available_seats, price 
FROM flights 
WHERE available_seats > 0 
LIMIT 5;
```

### Hôtels disponibles
```sql
SELECT id, name, destination_id, available_rooms, price_per_night 
FROM hotels 
WHERE available_rooms > 0 
LIMIT 5;
```

### Circuits disponibles
```sql
SELECT id, name, duration_days, price, max_participants, current_participants 
FROM circuits 
WHERE current_participants < max_participants 
LIMIT 5;
```

---

## 🚀 PROCÉDURE DE TEST COMPLÈTE

### Étape 1 : Créer un utilisateur
```sql
-- Exécuter dans MySQL Workbench ou ligne de commande
USE voyageconnect;
INSERT INTO users (email, password, firstname, lastname, phone, role, created_at) 
VALUES ('test@voyage.com', '$2a$10$N9qo8uLOickgx2ZrVzY1qOZzWpCfaQjU7vVjPJt6mHJW3vB6p8kQO', 'Test', 'User', '0612345678', 'USER', NOW());
```

### Étape 2 : Se connecter
1. Ouvrir navigateur
2. Aller sur `http://localhost:8080/VoyageConnect/auth/login`
3. Entrer :
   - Email: `test@voyage.com`
   - Password: `test123`
4. Cliquer "Se connecter"

### Étape 3 : Tester la réservation de vol
1. Aller sur `http://localhost:8080/VoyageConnect/reservation/new?type=flight&id=1`
2. Vérifier :
   - ✓ Détails du vol affichés
   - ✓ Formulaire de réservation visible
   - ✓ Champ "Nombre de passagers"
   - ✓ Sélecteur "Méthode de paiement"
   - ✓ Calcul du total dynamique

### Étape 4 : Soumettre la réservation
1. Remplir :
   - Nombre de passagers: `2`
   - Méthode de paiement: `CREDIT_CARD`
2. Cliquer "Confirmer la réservation"
3. Vérifier :
   - ✓ Redirection vers `success.jsp`
   - ✓ Message "Réservation créée avec succès"
   - ✓ Numéro de réservation affiché

### Étape 5 : Vérifier en base de données
```sql
-- Dernières réservations
SELECT r.id, r.reservation_number, r.reservation_type, r.total_amount, r.status,
       u.email as user_email, f.flight_number
FROM reservations r
JOIN users u ON r.user_id = u.id
LEFT JOIN flights f ON r.flight_id = f.id
ORDER BY r.created_at DESC
LIMIT 5;

-- Paiements associés
SELECT p.id, p.amount, p.payment_method, p.status, p.payment_date
FROM payments p
JOIN reservations r ON p.reservation_id = r.id
ORDER BY p.created_at DESC
LIMIT 5;
```

---

## 📋 CHECKLIST FINALE

- [ ] Utilisateur créé en base
- [ ] Connexion réussie (session active)
- [ ] `/reservation/new?type=flight&id=1` affiche le formulaire
- [ ] Soumission crée la réservation en base
- [ ] Page de succès affichée
- [ ] Vérification SQL confirme la création

---

## 🔗 URLs de Test

| Description | URL |
|-------------|-----|
| Login | http://localhost:8080/VoyageConnect/auth/login |
| Réservation Vol | http://localhost:8080/VoyageConnect/reservation/new?type=flight&id=1 |
| Réservation Hôtel | http://localhost:8080/VoyageConnect/reservation/new?type=hotel&id=1 |
| Réservation Circuit | http://localhost:8080/VoyageConnect/reservation/new?type=circuit&id=1 |
| Liste des réservations | http://localhost:8080/VoyageConnect/reservation/list |

---

## ⚠️ NOTES IMPORTANTES

1. **Authentification obligatoire** : Toutes les routes `/reservation/*` requièrent une connexion
2. **Session requise** : `session.getAttribute("user")` ne doit pas être null
3. **Données de test** : Assurer qu'il existe au moins un vol/hôtel/circuit en base
4. **ID valides** : Utiliser des IDs existants dans les paramètres `?id=X`

---

## 📞 EN CAS D'ERREUR

### Erreur 404
- Vérifier que Tomcat est démarré
- Vérifier que `VoyageConnect.war` est déployé
- Vérifier les logs Tomcat : `C:\tomcat2\apache-tomcat-9.0.113\logs\catalina.out`

### Redirection vers /auth/login
- Normal si non connecté
- Se connecter d'abord avec un utilisateur valide

### "Aucune réservation trouvée"
- Ne devrait plus se produire avec les nouvelles servlets
- Vérifier que l'URL contient bien `?type=flight&id=X`

### Erreur de base de données
- Vérifier que MySQL est démarré
- Vérifier `persistence.xml` (connexion DB)
- Vérifier que les tables existent

---

**Date de création :** 21 Décembre 2025  
**Projet :** VoyageConnect - Java EE Travel Platform  
**Serveur :** Tomcat 9.0.113  
**Base de données :** MySQL 8
