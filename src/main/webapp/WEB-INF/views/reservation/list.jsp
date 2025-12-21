<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Mes réservations - VoyageConnect</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
</head>
<body>
    <%@ include file="../common/navbar.jsp" %>
    
    <div class="container mt-4">
        <h1>Mes réservations</h1>
        
        <c:if test="${not empty success}">
            <div class="alert alert-success">${success}</div>
        </c:if>
        
        <div class="card mt-4">
            <div class="card-body">
                <table class="table table-hover">
                    <thead>
                        <tr>
                            <th>ID</th>
                            <th>Type</th>
                            <th>Date de réservation</th>
                            <th>Prix total</th>
                            <th>Statut</th>
                            <th>Actions</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:choose>
                            <c:when test="${not empty reservations}">
                                <c:forEach items="${reservations}" var="reservation">
                                    <tr>
                                        <td>#${reservation.id}</td>
                                        <td>
                                            <span class="badge bg-info">${reservation.type}</span>
                                        </td>
                                        <td>${reservation.createdAt}</td>
                                        <td>${reservation.totalPrice} €</td>
                                        <td>
                                            <c:choose>
                                                <c:when test="${reservation.status == 'CONFIRMED'}">
                                                    <span class="badge bg-success">Confirmée</span>
                                                </c:when>
                                                <c:when test="${reservation.status == 'PENDING'}">
                                                    <span class="badge bg-warning">En attente</span>
                                                </c:when>
                                                <c:when test="${reservation.status == 'CANCELLED'}">
                                                    <span class="badge bg-danger">Annulée</span>
                                                </c:when>
                                            </c:choose>
                                        </td>
                                        <td>
                                            <a href="${pageContext.request.contextPath}/reservation/view?id=${reservation.id}" 
                                               class="btn btn-sm btn-primary">Détails</a>
                                            <c:if test="${reservation.status != 'CANCELLED'}">
                                                <form action="${pageContext.request.contextPath}/reservation/cancel" 
                                                      method="post" style="display:inline;">
                                                    <input type="hidden" name="reservationId" value="${reservation.id}">
                                                    <button type="submit" class="btn btn-sm btn-danger" 
                                                            onclick="return confirm('Confirmer l\'annulation ?')">Annuler</button>
                                                </form>
                                            </c:if>
                                        </td>
                                    </tr>
                                </c:forEach>
                            </c:when>
                            <c:otherwise>
                                <tr>
                                    <td colspan="6" class="text-center">Aucune réservation pour le moment</td>
                                </tr>
                            </c:otherwise>
                        </c:choose>
                    </tbody>
                </table>
            </div>
        </div>
    </div>
    
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
