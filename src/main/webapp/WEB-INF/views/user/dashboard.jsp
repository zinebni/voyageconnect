<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Tableau de bord - VoyageConnect</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }
        
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background: #f5f7fa;
            min-height: 100vh;
        }
        
        .dashboard-container {
            max-width: 1400px;
            margin: 0 auto;
            padding: 30px 20px;
        }
        
        .welcome-section {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            border-radius: 20px;
            padding: 40px;
            color: white;
            margin-bottom: 40px;
            box-shadow: 0 10px 40px rgba(102, 126, 234, 0.3);
        }
        
        .welcome-section h1 {
            font-size: 36px;
            margin-bottom: 10px;
        }
        
        .welcome-section p {
            font-size: 18px;
            opacity: 0.9;
        }
        
        .stats-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
            gap: 20px;
            margin-bottom: 40px;
        }
        
        .stat-card {
            background: white;
            border-radius: 16px;
            padding: 25px;
            box-shadow: 0 4px 20px rgba(0,0,0,0.08);
            transition: transform 0.3s ease, box-shadow 0.3s ease;
        }
        
        .stat-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 8px 30px rgba(0,0,0,0.12);
        }
        
        .stat-card .icon {
            font-size: 40px;
            margin-bottom: 15px;
        }
        
        .stat-card .value {
            font-size: 32px;
            font-weight: bold;
            color: #2c3e50;
            margin-bottom: 5px;
        }
        
        .stat-card .label {
            color: #7f8c8d;
            font-size: 14px;
        }
        
        .section {
            background: white;
            border-radius: 20px;
            padding: 30px;
            margin-bottom: 30px;
            box-shadow: 0 4px 20px rgba(0,0,0,0.08);
        }
        
        .section-title {
            font-size: 24px;
            color: #2c3e50;
            margin-bottom: 25px;
            padding-bottom: 15px;
            border-bottom: 2px solid #f0f0f0;
        }
        
        .reservation-card {
            display: flex;
            align-items: center;
            padding: 20px;
            border: 1px solid #e9ecef;
            border-radius: 12px;
            margin-bottom: 15px;
            transition: all 0.3s ease;
        }
        
        .reservation-card:hover {
            border-color: #667eea;
            box-shadow: 0 4px 15px rgba(102, 126, 234, 0.1);
        }
        
        .reservation-icon {
            font-size: 36px;
            margin-right: 20px;
            width: 60px;
            height: 60px;
            display: flex;
            align-items: center;
            justify-content: center;
            background: linear-gradient(135deg, rgba(102, 126, 234, 0.1) 0%, rgba(118, 75, 162, 0.1) 100%);
            border-radius: 12px;
        }
        
        .reservation-details {
            flex: 1;
        }
        
        .reservation-details h4 {
            color: #2c3e50;
            margin-bottom: 5px;
        }
        
        .reservation-details p {
            color: #7f8c8d;
            font-size: 14px;
        }
        
        .reservation-status {
            padding: 6px 16px;
            border-radius: 20px;
            font-size: 13px;
            font-weight: 600;
        }
        
        .status-confirmed {
            background: #d4edda;
            color: #155724;
        }
        
        .status-pending {
            background: #fff3cd;
            color: #856404;
        }
        
        .status-cancelled {
            background: #f8d7da;
            color: #721c24;
        }
        
        .btn {
            padding: 12px 24px;
            border: none;
            border-radius: 50px;
            font-size: 15px;
            font-weight: 600;
            cursor: pointer;
            text-decoration: none;
            display: inline-block;
            transition: all 0.3s ease;
        }
        
        .btn-primary {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
        }
        
        .btn-primary:hover {
            transform: translateY(-2px);
            box-shadow: 0 6px 20px rgba(102, 126, 234, 0.3);
        }
        
        .btn-outline {
            background: white;
            color: #667eea;
            border: 2px solid #667eea;
        }
        
        .btn-outline:hover {
            background: #667eea;
            color: white;
        }
        
        .recommendations {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(300px, 1fr));
            gap: 20px;
        }
        
        .recommendation-card {
            background: linear-gradient(135deg, rgba(102, 126, 234, 0.05) 0%, rgba(118, 75, 162, 0.05) 100%);
            border-radius: 16px;
            padding: 25px;
            border: 2px solid transparent;
            transition: all 0.3s ease;
        }
        
        .recommendation-card:hover {
            border-color: #667eea;
            transform: translateY(-5px);
        }
        
        .recommendation-card h4 {
            color: #667eea;
            margin-bottom: 10px;
        }
        
        .recommendation-card p {
            color: #7f8c8d;
            margin-bottom: 15px;
        }
        
        .empty-state {
            text-align: center;
            padding: 60px 20px;
            color: #7f8c8d;
        }
        
        .empty-state .icon {
            font-size: 80px;
            margin-bottom: 20px;
            opacity: 0.3;
        }
    </style>
</head>
<body>
    <%@ include file="../common/navbar.jsp" %>
    
    <div class="dashboard-container">
        <!-- Welcome Section -->
        <div class="welcome-section">
            <h1>👋 Bienvenue ${sessionScope.user.firstName} !</h1>
            <p>Gérez vos voyages et découvrez de nouvelles destinations</p>
        </div>
        
        <!-- Statistics Cards -->
        <div class="stats-grid">
            <div class="stat-card">
                <div class="icon">📊</div>
                <div class="value">${totalReservations}</div>
                <div class="label">Réservations totales</div>
            </div>
            
            <div class="stat-card">
                <div class="icon">✅</div>
                <div class="value">${confirmedCount}</div>
                <div class="label">Réservations confirmées</div>
            </div>
            
            <div class="stat-card">
                <div class="icon">💰</div>
                <div class="value">
                    <fmt:formatNumber value="${totalSpent}" type="currency" currencySymbol="" maxFractionDigits="0"/> MAD
                </div>
                <div class="label">Total dépensé</div>
            </div>
            
            <div class="stat-card">
                <div class="icon">
                    <c:choose>
                        <c:when test="${favoriteType == 'FLIGHT'}">✈️</c:when>
                        <c:when test="${favoriteType == 'HOTEL'}">🏨</c:when>
                        <c:when test="${favoriteType == 'CIRCUIT'}">🗺️</c:when>
                    </c:choose>
                </div>
                <div class="value">${favoriteType}</div>
                <div class="label">Type préféré</div>
            </div>
        </div>
        
        <!-- Recent Reservations -->
        <div class="section">
            <h2 class="section-title">📅 Mes Dernières Réservations</h2>
            
            <c:choose>
                <c:when test="${not empty recentReservations}">
                    <c:forEach items="${recentReservations}" var="res">
                        <div class="reservation-card">
                            <div class="reservation-icon">
                                <c:choose>
                                    <c:when test="${res.type == 'FLIGHT'}">✈️</c:when>
                                    <c:when test="${res.type == 'HOTEL'}">🏨</c:when>
                                    <c:when test="${res.type == 'CIRCUIT'}">🗺️</c:when>
                                </c:choose>
                            </div>
                            <div class="reservation-details">
                                <h4>Réservation #${res.id} - ${res.type}</h4>
                                <p>
                                    <fmt:formatDate value="${res.createdAt}" pattern="dd/MM/yyyy à HH:mm"/> • 
                                    <c:if test="${not empty res.payment}">
                                        <fmt:formatNumber value="${res.payment.amount}" type="currency" currencySymbol=""/> MAD
                                    </c:if>
                                </p>
                            </div>
                            <span class="reservation-status status-${res.status.name().toLowerCase()}">
                                <c:choose>
                                    <c:when test="${res.status == 'CONFIRMEE'}">✓ Confirmée</c:when>
                                    <c:when test="${res.status == 'EN_ATTENTE'}">⏳ En attente</c:when>
                                    <c:when test="${res.status == 'ANNULEE'}">✕ Annulée</c:when>
                                </c:choose>
                            </span>
                        </div>
                    </c:forEach>
                    
                    <div style="text-align: center; margin-top: 20px;">
                        <a href="${pageContext.request.contextPath}/reservation/list" class="btn btn-outline">
                            Voir toutes mes réservations →
                        </a>
                    </div>
                </c:when>
                <c:otherwise>
                    <div class="empty-state">
                        <div class="icon">📭</div>
                        <h3>Aucune réservation</h3>
                        <p>Commencez votre aventure en réservant votre premier voyage !</p>
                        <a href="${pageContext.request.contextPath}/search/flights" class="btn btn-primary">
                            Rechercher un vol
                        </a>
                    </div>
                </c:otherwise>
            </c:choose>
        </div>
        
        <!-- Recommendations -->
        <div class="section">
            <h2 class="section-title">💡 Recommandations pour vous</h2>
            <div class="recommendations">
                <div class="recommendation-card">
                    <h4>✈️ Vols Populaires</h4>
                    <p>Découvrez nos vols les plus réservés vers des destinations exotiques</p>
                    <a href="${pageContext.request.contextPath}/search/flights" class="btn btn-primary">
                        Explorer
                    </a>
                </div>
                
                <div class="recommendation-card">
                    <h4>🏨 Hôtels de Luxe</h4>
                    <p>Séjournez dans les meilleurs hôtels avec des offres exclusives</p>
                    <a href="${pageContext.request.contextPath}/search/hotels" class="btn btn-primary">
                        Découvrir
                    </a>
                </div>
                
                <div class="recommendation-card">
                    <h4>🗺️ Circuits Guidés</h4>
                    <p>Explorez le monde avec nos circuits organisés et guides experts</p>
                    <a href="${pageContext.request.contextPath}/search/circuits" class="btn btn-primary">
                        Voir les circuits
                    </a>
                </div>
            </div>
        </div>
        
        <!-- Quick Actions -->
        <div class="section">
            <h2 class="section-title">⚡ Actions Rapides</h2>
            <div style="display: flex; gap: 15px; flex-wrap: wrap;">
                <a href="${pageContext.request.contextPath}/user/profile" class="btn btn-outline">
                    👤 Mon Profil
                </a>
                <a href="${pageContext.request.contextPath}/reservation/list" class="btn btn-outline">
                    📋 Mes Réservations
                </a>
                <a href="${pageContext.request.contextPath}/search/destinations" class="btn btn-outline">
                    🌍 Destinations
                </a>
                <a href="${pageContext.request.contextPath}/review/my-reviews" class="btn btn-outline">
                    ⭐ Mes Avis
                </a>
            </div>
        </div>
    </div>
</body>
</html>
