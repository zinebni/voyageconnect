<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>VoyageConnect - Votre agence de voyage en ligne</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
</head>
<body>
    <%@ include file="WEB-INF/views/common/navbar.jsp" %>
    
    <!-- Hero Section -->
    <div class="hero-section bg-primary text-white text-center py-5">
        <div class="container">
            <h1 class="display-4">Bienvenue sur VoyageConnect</h1>
            <p class="lead">Votre partenaire de confiance pour vos voyages inoubliables</p>
            <a href="${pageContext.request.contextPath}/search/flights" class="btn btn-light btn-lg">Commencer à explorer</a>
        </div>
    </div>
    
    <!-- Search Section -->
    <div class="container my-5">
        <div class="card shadow">
            <div class="card-body">
                <h3 class="card-title text-center mb-4">Recherchez votre prochain voyage</h3>
                <form id="searchForm">
                    <div class="row">
                        <div class="col-md-3 mb-3">
                            <label for="searchType" class="form-label">Type</label>
                            <select class="form-select" id="searchType" name="type">
                                <option value="flight">Vol</option>
                                <option value="hotel">Hôtel</option>
                                <option value="circuit">Circuit</option>
                            </select>
                        </div>
                        <div class="col-md-3 mb-3">
                            <label for="destination" class="form-label">Destination</label>
                            <input type="text" class="form-control" id="destination" name="destination" placeholder="Ex: Paris">
                        </div>
                        <div class="col-md-2 mb-3">
                            <label for="departureDate" class="form-label">Départ</label>
                            <input type="date" class="form-control" id="departureDate" name="departureDate">
                        </div>
                        <div class="col-md-2 mb-3">
                            <label for="returnDate" class="form-label">Retour</label>
                            <input type="date" class="form-control" id="returnDate" name="returnDate">
                        </div>
                        <div class="col-md-2 mb-3">
                            <label class="form-label">&nbsp;</label>
                            <button type="submit" class="btn btn-primary w-100">Rechercher</button>
                        </div>
                    </div>
                </form>
            </div>
        </div>
    </div>
    
    <!-- Features Section -->
    <div class="container my-5">
        <h2 class="text-center mb-4">Pourquoi choisir VoyageConnect ?</h2>
        <div class="row">
            <div class="col-md-4">
                <div class="card text-center h-100">
                    <div class="card-body">
                        <h5 class="card-title">🌍 Destinations variées</h5>
                        <p class="card-text">Des centaines de destinations dans le monde entier pour tous les budgets</p>
                    </div>
                </div>
            </div>
            <div class="col-md-4">
                <div class="card text-center h-100">
                    <div class="card-body">
                        <h5 class="card-title">💰 Meilleurs prix</h5>
                        <p class="card-text">Profitez de nos offres exclusives et de nos promotions régulières</p>
                    </div>
                </div>
            </div>
            <div class="col-md-4">
                <div class="card text-center h-100">
                    <div class="card-body">
                        <h5 class="card-title">🛡️ Réservation sécurisée</h5>
                        <p class="card-text">Paiement 100% sécurisé et service client disponible 24/7</p>
                    </div>
                </div>
            </div>
        </div>
    </div>
    
    <!-- Popular Destinations -->
    <div class="container my-5">
        <h2 class="text-center mb-4">Destinations populaires</h2>
        <div class="row">
            <div class="col-md-3 mb-3">
                <div class="card">
                    <img src="data:image/svg+xml,%3Csvg xmlns='http://www.w3.org/2000/svg' width='300' height='200'%3E%3Crect fill='%23667eea' width='300' height='200'/%3E%3Ctext fill='white' font-family='Arial' font-size='18' x='50%25' y='50%25' text-anchor='middle' dy='.3em'%3EParis%3C/text%3E%3C/svg%3E" class="card-img-top" alt="Paris">
                    <div class="card-body">
                        <h5 class="card-title">Paris, France</h5>
                        <p class="card-text">La ville lumière vous attend</p>
                        <a href="${pageContext.request.contextPath}/search/flights?destination=Paris" class="btn btn-primary">Explorer</a>
                    </div>
                </div>
            </div>
            <div class="col-md-3 mb-3">
                <div class="card">
                    <img src="data:image/svg+xml,%3Csvg xmlns='http://www.w3.org/2000/svg' width='300' height='200'%3E%3Crect fill='%23764ba2' width='300' height='200'/%3E%3Ctext fill='white' font-family='Arial' font-size='18' x='50%25' y='50%25' text-anchor='middle' dy='.3em'%3ETokyo%3C/text%3E%3C/svg%3E" class="card-img-top" alt="Tokyo">
                    <div class="card-body">
                        <h5 class="card-title">Tokyo, Japon</h5>
                        <p class="card-text">Tradition et modernité</p>
                        <a href="${pageContext.request.contextPath}/search/flights?destination=Tokyo" class="btn btn-primary">Explorer</a>
                    </div>
                </div>
            </div>
            <div class="col-md-3 mb-3">
                <div class="card">
                    <img src="data:image/svg+xml,%3Csvg xmlns='http://www.w3.org/2000/svg' width='300' height='200'%3E%3Crect fill='%23667eea' width='300' height='200'/%3E%3Ctext fill='white' font-family='Arial' font-size='18' x='50%25' y='50%25' text-anchor='middle' dy='.3em'%3ENew York%3C/text%3E%3C/svg%3E" class="card-img-top" alt="New York">
                    <div class="card-body">
                        <h5 class="card-title">New York, USA</h5>
                        <p class="card-text">La ville qui ne dort jamais</p>
                        <a href="${pageContext.request.contextPath}/search/flights?destination=New York" class="btn btn-primary">Explorer</a>
                    </div>
                </div>
            </div>
            <div class="col-md-3 mb-3">
                <div class="card">
                    <img src="data:image/svg+xml,%3Csvg xmlns='http://www.w3.org/2000/svg' width='300' height='200'%3E%3Crect fill='%23764ba2' width='300' height='200'/%3E%3Ctext fill='white' font-family='Arial' font-size='18' x='50%25' y='50%25' text-anchor='middle' dy='.3em'%3EDubai%3C/text%3E%3C/svg%3E" class="card-img-top" alt="Dubai">
                    <div class="card-body">
                        <h5 class="card-title">Dubai, UAE</h5>
                        <p class="card-text">Luxe et démesure</p>
                        <a href="${pageContext.request.contextPath}/search/flights?destination=Dubai" class="btn btn-primary">Explorer</a>
                    </div>
                </div>
            </div>
        </div>
    </div>
    
    <!-- Footer -->
    <footer class="bg-dark text-white text-center py-4 mt-5">
        <div class="container">
            <p>&copy; 2025 VoyageConnect. Tous droits réservés.</p>
            <p>
                <a href="#" class="text-white me-3">À propos</a>
                <a href="#" class="text-white me-3">Contact</a>
                <a href="#" class="text-white">Conditions générales</a>
            </p>
        </div>
    </footer>
    
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <script src="${pageContext.request.contextPath}/js/main.js"></script>
</body>
</html>
