<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Mes réservations - VoyageConnect</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
    <style>
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            min-height: 100vh;
            padding: 20px;
        }
        
        .container {
            max-width: 1200px;
            margin: 0 auto;
            background: white;
            border-radius: 10px;
            box-shadow: 0 10px 30px rgba(0, 0, 0, 0.2);
            padding: 30px;
        }
        
        h1 {
            color: #667eea;
            margin-bottom: 30px;
            text-align: center;
        }
        
        .nav-links {
            margin-bottom: 20px;
            text-align: center;
        }
        
        .nav-links a {
            margin: 0 10px;
            padding: 10px 20px;
            background: #667eea;
            color: white;
            text-decoration: none;
            border-radius: 5px;
            transition: all 0.3s;
        }
        
        .nav-links a:hover {
            background: #764ba2;
            transform: translateY(-2px);
        }
        
        .alert {
            padding: 15px;
            margin-bottom: 20px;
            border-radius: 5px;
            font-weight: bold;
        }
        
        .alert-success {
            background: #d4edda;
            color: #155724;
            border: 1px solid #c3e6cb;
        }
        
        .alert-info {
            background: #d1ecf1;
            color: #0c5460;
            border: 1px solid #bee5eb;
        }
        
        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
            background: white;
        }
        
        thead {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
        }
        
        th, td {
            padding: 15px;
            text-align: left;
            border-bottom: 1px solid #ddd;
        }
        
        tbody tr:hover {
            background: #f5f5f5;
        }
        
        .badge {
            display: inline-block;
            padding: 5px 10px;
            border-radius: 15px;
            font-size: 0.9rem;
            font-weight: bold;
        }
        
        .badge-info {
            background: #17a2b8;
            color: white;
        }
        
        .badge-success {
            background: #28a745;
            color: white;
        }
        
        .badge-warning {
            background: #ffc107;
            color: #333;
        }
        
        .badge-danger {
            background: #dc3545;
            color: white;
        }
        
        .btn {
            padding: 8px 15px;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            text-decoration: none;
            display: inline-block;
            margin: 2px;
            font-size: 0.9rem;
            transition: all 0.2s;
        }
        
        .btn-primary {
            background: #667eea;
            color: white;
        }
        
        .btn-primary:hover {
            background: #5568d3;
            transform: translateY(-2px);
        }
        
        .btn-danger {
            background: #dc3545;
            color: white;
        }
        
        .btn-danger:hover {
            background: #c82333;
        }
        
        .empty-state {
            text-align: center;
            padding: 60px 20px;
            color: #666;
        }
        
        .empty-state h2 {
            color: #999;
            margin-bottom: 20px;
        }
    </style>
</head>
<body>
    <div class="container">
        <div class="nav-links">
            <a href="${pageContext.request.contextPath}/user/dashboard">🏠 Tableau de bord</a>
            <a href="${pageContext.request.contextPath}/search/flights">✈️ Rechercher un vol</a>
            <a href="${pageContext.request.contextPath}/search/hotels">🏨 Rechercher un hôtel</a>
            <a href="${pageContext.request.contextPath}/search/circuits">🗺️ Circuits</a>
        </div>
        
        <h1>📋 Mes réservations</h1>
        
        <c:if test="${not empty success}">
            <div class="alert alert-success">✅ ${success}</div>
        </c:if>
        
        <c:choose>
            <c:when test="${not empty reservations}">
                <table>
                    <thead>
                        <tr>
                            <th>N° Réservation</th>
                            <th>Type</th>
                            <th>Date</th>
                            <th>Personnes</th>
                            <th>Montant</th>
                            <th>Statut</th>
                            <th>Actions</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach items="${reservations}" var="r">
                            <tr>
                                <td><strong>#${r.id}</strong></td>
                                <td>
                                    <c:choose>
                                        <c:when test="${r.type == 'FLIGHT'}">
                                            <span class="badge badge-info">✈️ Vol</span>
                                        </c:when>
                                        <c:when test="${r.type == 'HOTEL'}">
                                            <span class="badge badge-info">🏨 Hôtel</span>
                                        </c:when>
                                        <c:when test="${r.type == 'CIRCUIT'}">
                                            <span class="badge badge-info">🗺️ Circuit</span>
                                        </c:when>
                                        <c:otherwise>
                                            <span class="badge badge-info">${r.type}</span>
                                        </c:otherwise>
                                    </c:choose>
                                </td>
                                <td>📅 ${r.createdAt.toString().substring(0, 10)}</td>
                                <td>👥 ${r.numberOfPeople}</td>
                                <td><strong>${r.totalAmount} €</strong></td>
                                <td>
                                    <c:choose>
                                        <c:when test="${r.status == 'CONFIRMEE'}">
                                            <span class="badge badge-success">✅ Confirmée</span>
                                        </c:when>
                                        <c:when test="${r.status == 'EN_ATTENTE'}">
                                            <span class="badge badge-warning">⏳ En attente</span>
                                        </c:when>
                                        <c:when test="${r.status == 'ANNULEE'}">
                                            <span class="badge badge-danger">❌ Annulée</span>
                                        </c:when>
                                        <c:otherwise>
                                            <span class="badge badge-warning">${r.status}</span>
                                        </c:otherwise>
                                    </c:choose>
                                </td>
                                <td>
                                    <a href="${pageContext.request.contextPath}/reservation/view?id=${r.id}" 
                                       class="btn btn-primary">👁️ Détails</a>
                                    <c:if test="${r.status != 'ANNULEE'}">
                                        <form action="${pageContext.request.contextPath}/reservation/cancel" 
                                              method="post" style="display:inline;">
                                            <input type="hidden" name="reservationId" value="${r.id}">
                                            <button type="submit" class="btn btn-danger" 
                                                    onclick="return confirm('❗ Confirmer l\'annulation de cette réservation ?')">
                                                🗑️ Annuler
                                            </button>
                                        </form>
                                    </c:if>
                                </td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
                
                <div class="alert alert-info" style="margin-top: 20px;">
                    ℹ️ Vous avez <strong>${reservations.size()}</strong> réservation(s) au total
                </div>
            </c:when>
            <c:otherwise>
                <div class="empty-state">
                    <h2>📭 Aucune réservation</h2>
                    <p>Vous n'avez pas encore de réservation.</p>
                    <p>Commencez par rechercher un vol, un hôtel ou un circuit !</p>
                    <div style="margin-top: 30px;">
                        <a href="${pageContext.request.contextPath}/search/flights" class="btn btn-primary">
                            ✈️ Rechercher un vol
                        </a>
                        <a href="${pageContext.request.contextPath}/search/hotels" class="btn btn-primary">
                            🏨 Rechercher un hôtel
                        </a>
                        <a href="${pageContext.request.contextPath}/search/circuits" class="btn btn-primary">
                            🗺️ Circuits
                        </a>
                    </div>
                </div>
            </c:otherwise>
        </c:choose>
    </div>
</body>
</html>
