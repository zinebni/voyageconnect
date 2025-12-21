<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Mon profil - VoyageConnect</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
</head>
<body>
    <%@ include file="../common/navbar.jsp" %>
    
    <div class="container mt-4">
        <h1>Mon profil</h1>
        
        <c:if test="${not empty success}">
            <div class="alert alert-success alert-dismissible fade show">
                ${success}
                <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
            </div>
        </c:if>
        
        <div class="row mt-4">
            <div class="col-md-8">
                <div class="card">
                    <div class="card-body">
                        <h5 class="card-title">Informations personnelles</h5>
                        <table class="table">
                            <tr>
                                <th>Prénom</th>
                                <td>${user.firstName}</td>
                            </tr>
                            <tr>
                                <th>Nom</th>
                                <td>${user.lastName}</td>
                            </tr>
                            <tr>
                                <th>Email</th>
                                <td>${user.email}</td>
                            </tr>
                            <tr>
                                <th>Téléphone</th>
                                <td>${user.phone}</td>
                            </tr>
                            <tr>
                                <th>Adresse</th>
                                <td>${user.address}</td>
                            </tr>
                            <tr>
                                <th>Date d'inscription</th>
                                <td>${user.createdAt}</td>
                            </tr>
                        </table>
                        
                        <div class="mt-3">
                            <a href="${pageContext.request.contextPath}/user/edit-profile" class="btn btn-primary">Modifier mon profil</a>
                            <a href="${pageContext.request.contextPath}/user/change-password" class="btn btn-secondary">Changer le mot de passe</a>
                        </div>
                    </div>
                </div>
            </div>
            
            <div class="col-md-4">
                <div class="card">
                    <div class="card-body">
                        <h5 class="card-title">Statistiques</h5>
                        <p><strong>Réservations totales:</strong> 12</p>
                        <p><strong>Avis postés:</strong> 5</p>
                        <p><strong>Membre depuis:</strong> 2024</p>
                    </div>
                </div>
            </div>
        </div>
    </div>
    
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
