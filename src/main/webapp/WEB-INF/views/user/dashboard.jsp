<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Tableau de bord - VoyageConnect</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
</head>
<body>
    <%@ include file="../common/navbar.jsp" %>
    
    <div class="container mt-4">
        <h1>Bienvenue ${sessionScope.user.firstName}</h1>
        
        <div class="row mt-4">
            <div class="col-md-4">
                <div class="card">
                    <div class="card-body">
                        <h5 class="card-title">Mon Profil</h5>
                        <p class="card-text">Gérez vos informations personnelles</p>
                        <a href="${pageContext.request.contextPath}/user/profile" class="btn btn-primary">Voir mon profil</a>
                    </div>
                </div>
            </div>
            
            <div class="col-md-4">
                <div class="card">
                    <div class="card-body">
                        <h5 class="card-title">Mes Réservations</h5>
                        <p class="card-text">Consultez et gérez vos réservations</p>
                        <a href="${pageContext.request.contextPath}/reservation/list" class="btn btn-primary">Voir mes réservations</a>
                    </div>
                </div>
            </div>
            
            <div class="col-md-4">
                <div class="card">
                    <div class="card-body">
                        <h5 class="card-title">Mes Avis</h5>
                        <p class="card-text">Consultez vos avis et évaluations</p>
                        <a href="${pageContext.request.contextPath}/review/my-reviews" class="btn btn-primary">Voir mes avis</a>
                    </div>
                </div>
            </div>
        </div>
        
        <div class="row mt-4">
            <div class="col-12">
                <div class="card">
                    <div class="card-body">
                        <h5 class="card-title">Rechercher un voyage</h5>
                        <form action="${pageContext.request.contextPath}/search/flights" method="get">
                            <div class="row">
                                <div class="col-md-3">
                                    <input type="text" class="form-control" name="origin" placeholder="Origine">
                                </div>
                                <div class="col-md-3">
                                    <input type="text" class="form-control" name="destination" placeholder="Destination">
                                </div>
                                <div class="col-md-3">
                                    <input type="date" class="form-control" name="departureDate">
                                </div>
                                <div class="col-md-3">
                                    <button type="submit" class="btn btn-success w-100">Rechercher</button>
                                </div>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </div>
    
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
