# Diagrammes PlantUML - VoyageConnect (Simplifiés)

## Comment visualiser ces diagrammes

### Méthode 1 : Extension VS Code
1. Installer l'extension **PlantUML** (par jebbs)
2. Installer **Java** (requis pour PlantUML)
3. Appuyer sur `Alt+D` pour prévisualiser le diagramme sous le curseur

### Méthode 2 : En ligne
Copier le code et coller sur : http://www.plantuml.com/plantuml/uml/

### Méthode 3 : Exporter en image
- Dans VS Code : Clic droit sur le diagramme → Export Current Diagram → PNG/SVG

---

## 1. Diagramme de Cas d'Utilisation

```plantuml
@startuml
left to right direction
skinparam packageStyle rectangle

actor Visiteur
actor Utilisateur
actor Administrateur

rectangle "VoyageConnect" {
  usecase (S'inscrire) as UC1
  usecase (Se connecter) as UC2
  usecase (Rechercher Services) as UC3
  usecase (Faire Réservation) as UC4
  usecase (Payer) as UC5
  usecase (Consulter Réservations) as UC6
  usecase (Annuler Réservation) as UC7
  usecase (Gérer Profil) as UC8
  usecase (Gérer Catalogue) as UC9
  usecase (Voir Statistiques) as UC10
}

' Relations Visiteur
Visiteur --> UC1
Visiteur --> UC2
Visiteur --> UC3

' Relations Utilisateur (authentifié)
Utilisateur --> UC2
Utilisateur --> UC3
Utilisateur --> UC4
Utilisateur --> UC6
Utilisateur --> UC7
Utilisateur --> UC8

' Relations Admin
Administrateur --> UC2
Administrateur --> UC9
Administrateur --> UC10

' Relations include
UC4 ..> UC5 : <<include>>

' Héritage
Utilisateur -up-|> Visiteur
Administrateur -up-|> Utilisateur

note right of UC4
  Nécessite authentification
  Transaction atomique avec paiement
end note

note right of UC9
  Gérer vols, hôtels, circuits
  Réservé aux administrateurs
end note

@enduml
```

---

## 2. Diagramme de Classes (Simplifié - Entités Principales)

```plantuml
@startuml
skinparam classAttributeIconSize 0

class User {
  -id: Long
  -firstName: String
  -lastName: String
  -email: String
  -password: String
  -role: UserRole
  -active: Boolean
  +login()
  +register()
}

enum UserRole {
  USER
  ADMIN
}

class Reservation {
  -id: Long
  -reservationNumber: String
  -type: ReservationType
  -numberOfPeople: Integer
  -totalAmount: BigDecimal
  -status: ReservationStatus
  +create()
  +cancel()
}

enum ReservationStatus {
  EN_ATTENTE
  CONFIRMEE
  ANNULEE
}

class Payment {
  -id: Long
  -transactionId: String
  -amount: BigDecimal
  -paymentMethod: PaymentMethod
  -status: PaymentStatus
  +processPayment()
}

enum PaymentMethod {
  CARD
  PAYPAL
  BANK_TRANSFER
}

class Flight {
  -id: Long
  -flightNumber: String
  -departureCity: String
  -airline: String
  -price: BigDecimal
  -availableSeats: Integer
  +isAvailable()
}

class Hotel {
  -id: Long
  -name: String
  -stars: Integer
  -pricePerNight: BigDecimal
  -availableRooms: Integer
  +isAvailable()
}

class Circuit {
  -id: Long
  -name: String
  -durationDays: Integer
  -price: BigDecimal
  -availableSpots: Integer
  +isAvailable()
}

class Destination {
  -id: Long
  -name: String
  -country: String
}

' Relations principales
User "1" --> "*" Reservation : possède
User --> UserRole

Reservation "1" --> "1" Payment : nécessite
Reservation --> ReservationStatus
Reservation "0..1" --> "1" Flight
Reservation "0..1" --> "1" Hotel
Reservation "0..1" --> "1" Circuit

Payment --> PaymentMethod

Flight "*" --> "1" Destination
Hotel "*" --> "1" Destination
Circuit "*" --> "1" Destination

note top of User
  Authentification avec
  BCrypt pour le password
end note

note bottom of Reservation
  Transaction atomique :
  Réservation + Paiement
end note

@enduml
```

---

## 3. Diagramme de Classes - Architecture MVC (Simplifié)

```plantuml
@startuml
skinparam classAttributeIconSize 0

package "Model" {
  class User
  class Reservation
  class Payment
  class Flight
}

package "Service (Logique Métier)" {
  class UserService {
    +register()
    +login()
  }
  
  class ReservationService {
    +createReservation()
    +cancelReservation()
  }
}

package "Controller (Servlets)" {
  class AuthServlet {
    +doPost()
    +handleLogin()
    +handleRegister()
  }
  
  class ReservationServlet {
    +doPost()
    +createReservation()
  }
}

package "Filter (Sécurité)" {
  class AuthenticationFilter {
    +doFilter()
    +isAuthenticated()
  }
  
  class AdminAuthorizationFilter {
    +doFilter()
    +isAdmin()
  }
}

' Relations
AuthServlet --> UserService : utilise
ReservationServlet --> ReservationService : utilise

UserService --> User : gère
ReservationService --> Reservation : gère
ReservationService --> Payment : gère

AuthenticationFilter --> User : vérifie
AdminAuthorizationFilter --> User : vérifie rôle

note right of AuthenticationFilter
  Intercepte TOUTES les requêtes
  vers pages protégées
end note

note right of ReservationService
  Transaction atomique :
  BEGIN -> COMMIT/ROLLBACK
end note

@enduml
```

---

## 4. Diagramme de Séquence - Inscription (Simplifié)

```plantuml
@startuml
actor Visiteur
participant "AuthServlet" as Servlet
participant "UserService" as Service
participant "PasswordUtil" as Password
participant "Database" as DB

Visiteur -> Servlet: POST /auth?action=register\n(nom, email, password)
activate Servlet

Servlet -> Service: register(data)
activate Service

Service -> DB: Vérifier email existe?
DB --> Service: Non (email libre)

Service -> Password: hashPassword(password)
Password --> Service: passwordHashé

Service -> DB: BEGIN TRANSACTION
Service -> DB: INSERT INTO users
DB --> Service: user (id=1)
Service -> DB: COMMIT

Service --> Servlet: user
deactivate Service

Servlet -> Servlet: Créer session HTTP\nsession.setAttribute("user", user)

Servlet --> Visiteur: Redirection /dashboard
deactivate Servlet

note right of Service
  Mot de passe hashé avec BCrypt
  Role = USER par défaut
end note

@enduml
```

---

## 5. Diagramme de Séquence - Connexion (Simplifié)

```plantuml
@startuml
actor Utilisateur
participant "AuthServlet" as Servlet
participant "UserService" as Service
participant "PasswordUtil" as Password
participant "Database" as DB

Utilisateur -> Servlet: POST /auth?action=login\n(email, password)
activate Servlet

Servlet -> Service: login(email, password)
activate Service

Service -> DB: SELECT * FROM users\nWHERE email = ?
DB --> Service: user

alt Utilisateur trouvé
  Service -> Service: Vérifier user.active == true
  
  Service -> Password: checkPassword(password, user.password)
  Password --> Service: true (correct)
  
  Service --> Servlet: user
  deactivate Service
  
  Servlet -> Servlet: session.setAttribute("user", user)\nsession.setAttribute("userId", id)\nsession.setAttribute("userRole", role)
  
  Servlet --> Utilisateur: Redirection /dashboard
  
else Email ou mot de passe incorrect
  Service --> Servlet: AuthenticationException
  Servlet --> Utilisateur: Message erreur
end

deactivate Servlet

note right of Service
  BCrypt.checkpw() pour vérifier
  le mot de passe hashé
end note

@enduml
```

---

## 6. Diagramme de Séquence - Réservation Vol avec Authentification (Simplifié)

```plantuml
@startuml
actor Utilisateur
participant "AuthFilter" as Filter
participant "ReservationServlet" as Servlet
participant "ReservationService" as Service
participant "Database" as DB

Utilisateur -> Filter: POST /reservation/create
activate Filter

Filter -> Filter: Vérifier session existe?

alt Authentifié
  Filter -> Servlet: Continuer
  deactivate Filter
  
  activate Servlet
  Servlet -> Servlet: userId = session.getAttribute("userId")
  
  Servlet -> Service: createFlightReservation\n(userId, flightId, nbPeople)
  activate Service
  
  Service -> DB: BEGIN TRANSACTION
  activate DB
  
  Service -> DB: SELECT flight WHERE id = ?
  DB --> Service: flight
  
  Service -> Service: Vérifier availableSeats >= nbPeople
  
  alt Places disponibles
    Service -> DB: INSERT INTO reservations
    DB --> Service: reservation (id)
    
    Service -> Service: Créer Payment (PENDING)
    Service -> Service: processPayment() [simulation]
    
    alt Paiement réussi
      Service -> DB: INSERT INTO payments
      Service -> DB: UPDATE reservations\nSET status = 'CONFIRMEE'
      Service -> DB: UPDATE flights\nSET availableSeats = availableSeats - nbPeople
      
      Service -> DB: COMMIT
      deactivate DB
      
      Service --> Servlet: reservation confirmée
      deactivate Service
      
      Servlet --> Utilisateur: Page confirmation
      
    else Paiement échoué
      Service -> DB: ROLLBACK
      Service --> Servlet: BusinessException
      Servlet --> Utilisateur: Message erreur
    end
    
  else Places insuffisantes
    Service -> DB: ROLLBACK
    Service --> Servlet: BusinessException
    Servlet --> Utilisateur: Message erreur
  end
  
  deactivate Servlet
  
else Non authentifié
  Filter --> Utilisateur: Redirection /auth?action=login
end

note over Service, DB
  Transaction ATOMIQUE :
  Réservation + Paiement + 
  Mise à jour disponibilité
  en un seul bloc
end note

@enduml
```

---

## 7. Diagramme de Séquence - Annulation Réservation (Simplifié)

```plantuml
@startuml
actor Utilisateur
participant "ReservationServlet" as Servlet
participant "ReservationService" as Service
participant "Database" as DB

Utilisateur -> Servlet: POST /reservation/cancel?id=123
activate Servlet

Servlet -> Servlet: userId = session.getAttribute("userId")

Servlet -> Service: cancelReservation(reservationId, userId)
activate Service

Service -> DB: BEGIN TRANSACTION
activate DB

Service -> DB: SELECT * FROM reservations\nWHERE id = ?
DB --> Service: reservation

Service -> Service: Vérifier reservation.userId == userId\n(sécurité propriétaire)

alt Propriétaire correct
  Service -> Service: Vérifier status != ANNULEE
  
  alt Peut annuler
    Service -> DB: UPDATE reservations\nSET status = 'ANNULEE'
    Service -> DB: UPDATE flights\nSET availableSeats += nbPeople
    Service -> DB: COMMIT
    deactivate DB
    
    Service --> Servlet: Succès
    deactivate Service
    
    Servlet --> Utilisateur: Message "Annulation réussie"
    
  else Déjà annulée
    Service -> DB: ROLLBACK
    Service --> Servlet: BusinessException
    Servlet --> Utilisateur: Message erreur
  end
  
else Non propriétaire
  Service -> DB: ROLLBACK
  Service --> Servlet: AuthorizationException
  Servlet --> Utilisateur: Erreur 403 Accès refusé
end

deactivate Servlet

note right of Service
  Vérification sécurité :
  Seul le propriétaire peut
  annuler sa réservation
end note

@enduml
```

---

## 8. Diagramme de Séquence - Administration (Ajout Vol) (Simplifié)

```plantuml
@startuml
actor Admin
participant "AuthFilter" as AuthF
participant "AdminFilter" as AdminF
participant "AdminServlet" as Servlet
participant "AdminService" as Service
participant "Database" as DB

Admin -> AuthF: GET /admin/flights/new
activate AuthF

AuthF -> AuthF: Vérifier session existe?

alt Authentifié
  AuthF -> AdminF: Continuer
  deactivate AuthF
  
  activate AdminF
  AdminF -> AdminF: userRole = session.getAttribute("userRole")
  AdminF -> AdminF: Vérifier role == ADMIN?
  
  alt Est Admin
    AdminF -> Servlet: Autoriser accès
    deactivate AdminF
    
    activate Servlet
    Servlet --> Admin: Formulaire ajout vol
    
    Admin -> Servlet: POST /admin/flights/create\n(données vol)
    
    Servlet -> Service: addFlight(flight)
    activate Service
    
    Service -> DB: BEGIN TRANSACTION
    Service -> DB: INSERT INTO flights
    DB --> Service: flight (id)
    Service -> DB: COMMIT
    
    Service --> Servlet: flight créé
    deactivate Service
    
    Servlet --> Admin: Redirection /admin/flights\nMessage "Vol ajouté"
    deactivate Servlet
    
  else N'est pas Admin
    AdminF --> Admin: Erreur 403 Accès refusé
  end
  
else Non authentifié
  AuthF --> Admin: Redirection /auth?action=login
end

note over AuthF, AdminF
  Double filtre de sécurité :
  1. AuthenticationFilter (session existe?)
  2. AdminAuthorizationFilter (role = ADMIN?)
end note

@enduml
```

---

## 9. Diagramme d'Activité - Processus Réservation Complète (Bonus)

```plantuml
@startuml
start

:Utilisateur recherche un vol;

if (Utilisateur connecté?) then (Non)
  :Redirection vers connexion;
  :Saisir email/password;
  :Authentification;
  stop
else (Oui)
  :Afficher résultats recherche;
  :Sélectionner un vol;
  
  if (Places disponibles?) then (Non)
    :Afficher "Complet";
    stop
  else (Oui)
    :Saisir nombre de passagers;
    :Calculer montant total;
    :Choisir méthode paiement;
    
    fork
      :Créer réservation (EN_ATTENTE);
    fork again
      :Créer paiement (PENDING);
    end fork
    
    :Traiter paiement (simulation);
    
    if (Paiement réussi?) then (Oui)
      fork
        :Réservation -> CONFIRMEE;
      fork again
        :Paiement -> COMPLETED;
      fork again
        :Mettre à jour disponibilité vol;
      end fork
      
      :COMMIT transaction;
      :Envoyer email confirmation;
      :Afficher page succès;
      stop
      
    else (Non)
      :ROLLBACK transaction;
      :Afficher erreur paiement;
      stop
    endif
  endif
endif

@enduml
```

---

## 10. Diagramme de Déploiement (Architecture Physique) (Bonus)

```plantuml
@startuml
!define ICONURL https://raw.githubusercontent.com/tupadr3/plantuml-icon-font-sprites/v2.4.0

node "Poste Client" {
  [Navigateur Web] as Browser
}

node "Serveur Tomcat" {
  [Servlets\n(Contrôleurs)] as Servlets
  [Services\n(Logique Métier)] as Services
  [DAOs\n(Accès Données)] as DAOs
  [Filtres\n(Sécurité)] as Filters
}

database "MySQL\nBase de Données" {
  [Tables] as Tables
}

Browser -down-> Filters : HTTP/HTTPS
Filters -down-> Servlets : Requêtes autorisées
Servlets -down-> Services : Appels métier
Services -down-> DAOs : CRUD
DAOs -down-> Tables : JDBC

note right of Filters
  AuthenticationFilter
  AdminAuthorizationFilter
  EncodingFilter (UTF-8)
end note

note right of Services
  UserService
  ReservationService
  SearchService
  AdminService
end note

note bottom of Tables
  users, reservations,
  payments, flights,
  hotels, circuits,
  destinations
end note

@enduml
```

---

## Résumé des Simplifications

### ✅ Ce qui a été gardé (Essentiel)
- **Authentification** : Login, Register avec BCrypt
- **Filtres de sécurité** : AuthenticationFilter, AdminAuthorizationFilter
- **Transactions atomiques** : BEGIN/COMMIT/ROLLBACK
- **Relations principales** : User-Reservation-Payment-Flight
- **Flux critiques** : Réservation avec paiement

### ❌ Ce qui a été retiré (Détails)
- Classes DAO individuelles (regroupées)
- Tous les enums secondaires
- Méthodes auxiliaires
- Validations détaillées
- EmailUtil, ValidationUtil (mentionnés mais pas détaillés)
- Review, Promotion (entités secondaires)

### 📊 Avantages de PlantUML vs Mermaid
- ✅ Rendu plus professionnel et lisible
- ✅ Export facile en PNG/SVG/PDF
- ✅ Meilleure gestion des notes et annotations
- ✅ Syntaxe plus standard UML
- ✅ Diagrammes d'activité et de déploiement disponibles

### 🎨 Pour personnaliser l'apparence
Ajouter au début de chaque diagramme :
```plantuml
skinparam backgroundColor #FEFEFE
skinparam classBackgroundColor #E8F5E9
skinparam classBorderColor #4CAF50
skinparam arrowColor #1976D2
```

Les diagrammes sont maintenant **simplifiés et concentrés sur l'essentiel** ! 🚀
