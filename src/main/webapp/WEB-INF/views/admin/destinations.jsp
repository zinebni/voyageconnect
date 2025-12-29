<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Gestion des destinations - VoyageConnect</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
    <style>
        .page-header {
            background: linear-gradient(135deg, #003580 0%, #0071c2 100%);
            color: white;
            padding: 60px 0;
            margin-bottom: 40px;
            text-align: center;
        }
        
        .page-header h1 {
            color: white;
            font-size: 2.5rem;
            font-weight: 800;
        }
        
        .admin-card {
            background: white;
            border-radius: 16px;
            padding: 30px;
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.07);
            margin-bottom: 25px;
        }
    </style>
</head>
<body>
    <jsp:include page="/WEB-INF/views/common/navbar.jsp" />
    
    <div class="page-header">
        <div class="container">
            <h1>🌍 Gestion des Destinations</h1>
            <p style="font-size: 1.2rem; opacity: 0.9;">Ajoutez et gérez les destinations disponibles</p>
        </div>
    </div>
    
    <div class="container">
        <c:if test="${not empty success}">
            <div class="alert alert-success alert-dismissible fade show">
                ${success}
                <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
            </div>
        </c:if>
        <c:if test="${not empty error}">
            <div class="alert alert-danger alert-dismissible fade show">
                ${error}
                <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
            </div>
        </c:if>
        
        <div class="admin-card mb-4">
            <h5 style="color: #003580; font-weight: 700; margin-bottom: 20px;">➕ Ajouter une nouvelle destination</h5>
            <form action="${pageContext.request.contextPath}/admin/create-destination" method="post">
                <div class="row g-3">
                    <div class="col-md-6">
                        <label for="name" class="form-label">Nom</label>
                        <input type="text" class="form-control" id="name" name="name" required>
                    </div>
                    <div class="col-md-6">
                        <label for="country" class="form-label">Pays</label>
                        <input type="text" class="form-control" id="country" name="country" required>
                    </div>
                    <div class="col-12">
                        <label for="description" class="form-label">Description</label>
                        <textarea class="form-control" id="description" name="description" rows="3" required></textarea>
                    </div>
                    <div class="col-12">
                        <label for="imageUrl" class="form-label">URL de l'image</label>
                        <input type="url" class="form-control" id="imageUrl" name="imageUrl">
                    </div>
                    <div class="col-12">
                        <button type="submit" class="btn btn-highlight">Ajouter</button>
                    </div>
                </div>
            </form>
        </div>
        
        <div class="admin-card">
            <h5 style="color: #003580; font-weight: 700; margin-bottom: 20px;">📋 Liste des destinations</h5>
            <div class="table-responsive">
                <table class="table">
                    <thead>
                        <tr>
                            <th>ID</th>
                            <th>Nom</th>
                            <th>Pays</th>
                            <th>Description</th>
                            <th>Actions</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach items="${destinations}" var="destination">
                            <tr>
                                <td>${destination.id}</td>
                                <td><strong>${destination.name}</strong></td>
                                <td>${destination.country}</td>
                                <td style="max-width: 300px; overflow: hidden; text-overflow: ellipsis;">${destination.description}</td>
                                <td>
                                    <button class="btn btn-warning btn-sm">Modifier</button>
                                    <button class="btn btn-danger btn-sm">Supprimer</button>
                                </td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
            </div>
        </div>
    </div>
    
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <script src="${pageContext.request.contextPath}/js/main.js"></script>
</body>
</html>
