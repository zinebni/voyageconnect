# 📋 Architecture VoyageConnect - Séparation MVC / API

## ✅ PROBLÈME RÉSOLU

**Avant** : L'URL `/search/flights` retournait du JSON brut dans le navigateur  
**Après** : L'URL `/search/flights` affiche une belle page HTML avec formulaire et résultats

---

## 🏗️ Architecture finale

### 1️⃣ Routes MVC (HTML / JSP)

Ces routes affichent des **pages HTML** via des JSP :

| URL | Servlet | JSP | Description |
|-----|---------|-----|-------------|
| `/search` | SearchViewController | `/WEB-INF/views/search/index.jsp` | Page d'accueil recherche |
| `/search/flights` | SearchViewController | `/WEB-INF/views/search/flights.jsp` | Recherche de vols (HTML) |
| `/search/hotels` | SearchViewController | `/WEB-INF/views/search/hotels.jsp` | Recherche d'hôtels (HTML) |
| `/search/circuits` | SearchViewController | `/WEB-INF/views/search/circuits.jsp` | Recherche de circuits (HTML) |
| `/search/destinations` | SearchViewController | `/WEB-INF/views/search/destinations.jsp` | Liste des destinations |

**Utilisation** : Accès direct depuis le navigateur

---

### 2️⃣ Routes API (JSON)

Ces routes retournent du **JSON pur** (pour AJAX / JavaScript) :

| URL | Servlet | Retour | Description |
|-----|---------|--------|-------------|
| `/api/search/flights` | SearchServlet | JSON | API vols |
| `/api/search/hotels` | SearchServlet | JSON | API hôtels |
| `/api/search/circuits` | SearchServlet | JSON | API circuits |
| `/api/search/destinations` | SearchServlet | JSON | API destinations |

**Utilisation** : Appels AJAX depuis JavaScript

---

## 📂 Structure des fichiers

```
src/main/
├── java/com/voyageconnect/controller/
│   ├── SearchViewController.java    ← Servlet MVC (renvoie des JSP)
│   └── SearchServlet.java           ← API REST (renvoie du JSON)
│
└── webapp/
    ├── WEB-INF/
    │   ├── web.xml                  ← Configuration des routes
    │   └── views/search/
    │       ├── index.jsp            ← Page accueil recherche
    │       ├── flights.jsp          ← Page recherche vols
    │       ├── hotels.jsp           ← Page recherche hôtels
    │       ├── circuits.jsp         ← Page recherche circuits
    │       └── destinations.jsp     ← Page liste destinations
    └── css/
        └── style.css
```

---

## 🔄 Flux MVC vs API

### Flux MVC (utilisateur → navigateur)
```
Navigateur
  ↓ GET /search/flights
SearchViewController
  ↓ appelle SearchService.searchFlights()
  ↓ récupère List<Flight>
  ↓ request.setAttribute("flights", flights)
  ↓ forward vers flights.jsp
JSP affiche HTML avec JSTL
  ↓
Navigateur affiche la page HTML
```

### Flux API (JavaScript → JSON)
```
JavaScript fetch()
  ↓ GET /api/search/flights
SearchServlet
  ↓ appelle SearchService.searchFlights()
  ↓ récupère List<Flight>
  ↓ Gson.toJson(flights)
  ↓ response.getWriter().print(json)
  ↓
JavaScript reçoit JSON
  ↓ parse et affiche dans le DOM
```

---

## 🎯 Exemples d'utilisation

### Depuis un navigateur (utilisateur)
```
http://localhost:8080/VoyageConnect/search/flights
→ Affiche une page HTML avec formulaire et résultats
```

### Depuis JavaScript (AJAX)
```javascript
fetch('/VoyageConnect/api/search/flights?destinationId=1')
  .then(response => response.json())
  .then(flights => {
    console.log(flights); // Array d'objets Flight
  });
```

---

## ⚙️ Configuration web.xml

```xml
<!-- Servlet MVC (vues HTML/JSP) -->
<servlet>
    <servlet-name>SearchViewController</servlet-name>
    <servlet-class>com.voyageconnect.controller.SearchViewController</servlet-class>
</servlet>
<servlet-mapping>
    <servlet-name>SearchViewController</servlet-name>
    <url-pattern>/search/*</url-pattern>
</servlet-mapping>

<!-- Servlet API (JSON) -->
<servlet>
    <servlet-name>SearchServlet</servlet-name>
    <servlet-class>com.voyageconnect.controller.SearchServlet</servlet-class>
</servlet>
<servlet-mapping>
    <servlet-name>SearchServlet</servlet-name>
    <url-pattern>/api/search/*</url-pattern>
</servlet-mapping>
```

---

## 📝 Checklist de maintenance

### ✅ Quand ajouter une nouvelle route MVC (HTML) :
1. Ajouter une méthode dans `SearchViewController`
2. Créer la JSP correspondante dans `/WEB-INF/views/search/`
3. Utiliser `request.setAttribute()` et `forward()`

### ✅ Quand ajouter une nouvelle route API (JSON) :
1. Ajouter une méthode dans `SearchServlet`
2. Utiliser `Gson.toJson()` et `response.getWriter().print()`
3. Configurer l'ExclusionStrategy si nécessaire

### ❌ Ne JAMAIS faire :
- ❌ Mélanger JSON et JSP dans la même servlet
- ❌ Faire un `forward()` dans SearchServlet (API)
- ❌ Retourner du JSON dans SearchViewController (MVC)
- ❌ Oublier l'ExclusionStrategy pour Hibernate (LazyInitializationException)

---

## 🔧 Corrections apportées

### 1. Gson + Hibernate LazyInitializationException
**Problème** : Gson essayait de sérialiser les collections Hibernate lazy  
**Solution** : ExclusionStrategy pour ignorer `flights`, `hotels`, `circuits`, `reservations`, `user`

### 2. Gson + java.time (LocalDateTime / LocalDate)
**Problème** : Module Java 9+ bloquait l'accès réflexif  
**Solution** : TypeAdapters personnalisés avec DateTimeFormatter

### 3. Routes confuses (MVC vs API)
**Problème** : `/search/flights` retournait du JSON au lieu de HTML  
**Solution** : Séparation `/search/*` (MVC) et `/api/search/*` (API)

---

## 🎉 Résultat final

✅ **Navigation utilisateur** : Pages HTML complètes avec formulaires et affichage  
✅ **API REST** : Endpoints JSON pour intégrations JavaScript  
✅ **Architecture propre** : Séparation claire des responsabilités  
✅ **Java EE pur** : Aucun framework externe (pas de Spring)  
✅ **Performance** : Collections Hibernate optimisées  

---

**Date de mise à jour** : 21 décembre 2025  
**Version** : VoyageConnect 1.0.0
