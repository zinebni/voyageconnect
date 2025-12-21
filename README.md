# VoyageConnect - Plateforme d'Agence de Voyage ✈️

Application web complète développée en **Java EE pur** (sans Spring, Spring Boot ni @Transactional).  
Architecture MVC stricte avec gestion manuelle des transactions JPA.

---

## 🎯 Caractéristiques principales

- ✅ **Pur Java EE** - Sans Spring Framework
- ✅ **Transactions manuelles** - Gestion explicite avec EntityTransaction (BEGIN/COMMIT/ROLLBACK)
- ✅ **Architecture MVC stricte** - Séparation claire Model-View-Controller
- ✅ **Sécurité personnalisée** - Filtres Servlet (pas de Spring Security)
- ✅ **JPA/Hibernate** - Persistance avec EntityManager
- ✅ **Bean Validation** - Validation automatique des entités

---

## 🛠️ Technologies

### Backend
- **Java EE** : Servlets 4.0, JSP 2.3, JSTL 1.2, Filters
- **JPA** : 2.2 avec Hibernate 5.6.15.Final
- **MySQL** : 8.0 avec JDBC Driver
- **Maven** : Build tool

### Frontend
- **Bootstrap** : 5.3.0 (responsive)
- **JavaScript** : Vanilla JS + Fetch API (AJAX)
- **CSS** : Styles personnalisés

### Sécurité & Utilitaires
- **BCrypt** : jbcrypt 0.4 (hashage mots de passe)
- **JavaMail** : 1.6.2 (notifications)
- **Gson** : 2.10.1 (JSON)
- **Hibernate Validator** : 6.2.5.Final

---

## 📋 Prérequis

| Outil | Version minimale |
|-------|-----------------|
| JDK | 11+ |
| Maven | 3.6+ |
| MySQL | 8.0+ |
| Tomcat | 9.0+ |

---

## 🚀 Installation rapide

### 1. Base de données
```sql
CREATE DATABASE voyageconnect CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
CREATE USER 'voyageconnect'@'localhost' IDENTIFIED BY 'votre_mot_de_passe';
GRANT ALL PRIVILEGES ON voyageconnect.* TO 'voyageconnect'@'localhost';
FLUSH PRIVILEGES;
```

### 2. Configuration
Modifier `src/main/resources/META-INF/persistence.xml` :
```xml
<property name="javax.persistence.jdbc.url" value="jdbc:mysql://localhost:3306/voyageconnect"/>
<property name="javax.persistence.jdbc.user" value="voyageconnect"/>
<property name="javax.persistence.jdbc.password" value="votre_mot_de_passe"/>
```

### 3. Compilation et déploiement
```bash
mvn clean package
cp target/VoyageConnect.war $TOMCAT_HOME/webapps/
```

### 4. Accès
Ouvrir : `http://localhost:8080/VoyageConnect/`

---

## 📦 Structure du projet

```
projetJEEAyaZineb/
├── src/main/java/com/voyageconnect/
│   ├── controller/       # 7 Servlets (Auth, Search, Reservation, User, Admin, Payment, Review)
│   ├── filter/          # 3 Filtres (Encoding, Authentication, Authorization)
│   ├── service/         # 5 Services avec transactions manuelles
│   ├── dao/             # 10 DAOs (GenericDAO + 9 spécialisés)
│   ├── model/           # 9 Entités JPA + 8 Enums
│   ├── util/            # 4 Utilitaires (Password, Email, JPA, Validation)
│   ├── exception/       # 4 Exceptions personnalisées
│   └── dto/             # Data Transfer Objects
├── src/main/resources/META-INF/
│   └── persistence.xml  # Configuration JPA
├── src/main/webapp/
│   ├── WEB-INF/
│   │   ├── web.xml      # Configuration Servlets/Filters
│   │   └── views/       # Pages JSP (auth, user, admin, reservation, common)
│   ├── css/style.css    # Styles personnalisés
│   ├── js/main.js       # JavaScript (AJAX)
│   └── index.jsp        # Page d'accueil
└── pom.xml              # Configuration Maven
```

---

## 🔄 Gestion des transactions (OBLIGATOIRE)

**Pattern utilisé dans TOUS les services :**

```java
public void createReservation(...) throws BusinessException {
    EntityManager em = JPAUtil.getEntityManager();
    EntityTransaction tx = em.getTransaction();
    
    try {
        tx.begin();  // ⚠️ BEGIN explicite
        
        // Opérations métier
        reservationDAO.save(reservation, em);
        paymentDAO.save(payment, em);
        
        tx.commit();  // ✅ COMMIT explicite
    } catch (Exception e) {
        if (tx.isActive()) {
            tx.rollback();  // ❌ ROLLBACK explicite
        }
        throw new BusinessException("Erreur : " + e.getMessage());
    } finally {
        em.close();
    }
}
```

**RÈGLES STRICTES** :
- ✅ Transactions au niveau SERVICE uniquement
- ❌ JAMAIS de transactions dans les DAO
- ✅ BEGIN/COMMIT/ROLLBACK explicites
- ❌ PAS d'annotation @Transactional (Spring)

---

## 🔒 Sécurité

### Authentification
- **BCrypt** : Hashage des mots de passe (10 rounds)
- **HttpSession** : Gestion de l'état utilisateur
- **AuthenticationFilter** : Protection `/user/*` et `/reservation/*`

### Autorisation
- **AdminAuthorizationFilter** : Vérification rôle ADMIN pour `/admin/*`
- **UserRole** : ADMIN, USER

---

## 📊 Modèle de données

### Entités (9)
| Entité | Description | Relations |
|--------|-------------|-----------|
| **User** | Utilisateurs (ADMIN/USER) | → Reservation, Review |
| **Destination** | Pays/villes | ← Flight, Hotel, Circuit |
| **Flight** | Vols (ECONOMY/BUSINESS/FIRST) | → Destination, ← Reservation |
| **Hotel** | Hôtels (étoiles, équipements) | → Destination, ← Reservation |
| **Circuit** | Circuits touristiques | → Destination, ← Reservation |
| **Reservation** | Réservations | → User, Flight/Hotel/Circuit, Payment |
| **Payment** | Paiements (CARD/PAYPAL/BANK) | → Reservation |
| **Review** | Avis (1-5 étoiles) | → User, Flight/Hotel/Circuit |
| **Promotion** | Codes promo | - |

---

## 📋 Fonctionnalités

### Utilisateurs 👤
- ✅ Inscription / Connexion sécurisées
- ✅ Recherche AJAX (vols, hôtels, circuits)
- ✅ Réservation avec paiement intégré
- ✅ Gestion du profil
- ✅ Historique des réservations
- ✅ Ajout d'avis

### Administration 👨‍💼
- ✅ Tableau de bord
- ✅ CRUD Destinations / Vols / Hôtels / Circuits
- ✅ Gestion des promotions
- ✅ Vue sur toutes les réservations

---

## 🌐 Endpoints principaux

| Méthode | URL | Description |
|---------|-----|-------------|
| POST | `/auth/login` | Connexion |
| POST | `/auth/register` | Inscription |
| GET | `/auth/logout` | Déconnexion |
| GET | `/search/flights` | Recherche vols (JSON) |
| POST | `/reservation/flight` | Réserver un vol |
| GET | `/user/dashboard` | Dashboard utilisateur |
| GET | `/admin/destinations` | Gestion destinations |

---

## 🧪 Commandes utiles

```bash
# Compilation
mvn clean compile

# Création du WAR
mvn clean package

# Vérifier les dépendances
mvn dependency:tree

# Lancer les tests
mvn test
```

---

## 🔧 Dépannage

### Erreur : "Table doesn't exist"
```xml
<!-- Dans persistence.xml : -->
<property name="hibernate.hbm2ddl.auto" value="create"/>
<!-- Redémarrer Tomcat, puis remettre à "update" -->
```

### Erreur de connexion MySQL
```bash
sudo service mysql status
mysql -u voyageconnect -p
```

---

## 👥 Compte administrateur

Créer manuellement en base :
```sql
INSERT INTO users (email, password, first_name, last_name, role, created_at) 
VALUES ('admin@voyageconnect.com', 
        '$2a$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', 
        'Admin', 
        'VoyageConnect', 
        'ADMIN', 
        NOW());
```
🔑 Mot de passe : `password` (à changer !)

Ou modifier un compte existant :
```sql
UPDATE users SET role = 'ADMIN' WHERE email = 'votre@email.com';
```

---

## 📚 Documentation

- [Java EE](https://javaee.github.io/)
- [JPA 2.2](https://jcp.org/en/jsr/detail?id=338)
- [Hibernate](https://hibernate.org/orm/documentation/)
- [Bootstrap 5](https://getbootstrap.com/docs/5.3/)

---

## ✍️ Auteurs

**Aya & Zineb** - Projet JEE 2025

---

## 📄 Licence

Projet académique - Usage éducatif uniquement
- ✅ Avis et recommandations
- ✅ Notifications par email

## 👥 Rôles

- **USER**: Recherche, réservation, gestion du profil
- **ADMIN**: Gestion complète (destinations, vols, hôtels, circuits, promotions)

## 📧 Contact

Projet réalisé en Java EE sans Spring/Spring Boot.
