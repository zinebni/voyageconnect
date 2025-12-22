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
        * { margin: 0; padding: 0; box-sizing: border-box; }
        
        body {
            font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', 'Roboto', sans-serif;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            min-height: 100vh;
        }
        
        .dashboard-wrapper {
            min-height: 100vh;
            background: #f8f9fc;
            padding-top: 80px;
        }
        
        .dashboard-header {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            position: fixed;
            top: 0;
            left: 0;
            right: 0;
            z-index: 1000;
            box-shadow: 0 10px 40px rgba(102, 126, 234, 0.3);
        }
        
        .header-content {
            max-width: 1400px;
            margin: 0 auto;
            padding: 25px 30px;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }
        
        .header-left { display: flex; align-items: center; gap: 20px; }
        
        .user-avatar {
            width: 60px;
            height: 60px;
            border-radius: 50%;
            background: linear-gradient(135deg, #f093fb 0%, #f5576c 100%);
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 28px;
            font-weight: 700;
            color: white;
            box-shadow: 0 8px 20px rgba(240, 147, 251, 0.4);
            border: 4px solid rgba(255, 255, 255, 0.3);
        }
        
        .welcome-text { color: white; }
        .welcome-text h1 {
            font-size: 32px;
            font-weight: 800;
            margin-bottom: 5px;
            color: white;
            background: none;
            -webkit-text-fill-color: white;
        }
        
        .welcome-text p { font-size: 16px; opacity: 0.95; font-weight: 500; }
        
        .header-actions { display: flex; gap: 15px; }
        
        .header-btn {
            padding: 12px 28px;
            border-radius: 50px;
            font-weight: 600;
            text-decoration: none;
            transition: all 0.3s ease;
            font-size: 15px;
        }
        
        .btn-white {
            background: white;
            color: #667eea;
            box-shadow: 0 4px 15px rgba(255, 255, 255, 0.3);
        }
        
        .btn-white:hover {
            transform: translateY(-3px);
            box-shadow: 0 8px 25px rgba(255, 255, 255, 0.5);
        }
        
        .btn-outline {
            background: transparent;
            color: white;
            border: 2px solid rgba(255, 255, 255, 0.5);
        }
        
        .btn-outline:hover {
            background: rgba(255, 255, 255, 0.2);
            border-color: white;
        }
        
        .dashboard-container { max-width: 1400px; margin: 0 auto; padding: 40px 30px; }
        
        .stats-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(280px, 1fr));
            gap: 25px;
            margin-bottom: 40px;
        }
        
        .stat-card {
            background: white;
            border-radius: 20px;
            padding: 30px;
            box-shadow: 0 10px 40px rgba(0, 0, 0, 0.08);
            transition: all 0.3s ease;
        }
        
        .stat-card::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            height: 5px;
            background: linear-gradient(90deg, #667eea, #764ba2);
        }
        
        .stat-card:hover { transform: translateY(-10px); box-shadow: 0 20px 60px rgba(0, 0, 0, 0.15); }
        
        .stat-icon { font-size: 48px; margin-bottom: 15px; }
        
        .stat-value {
            font-size: 42px;
            font-weight: 800;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            margin-bottom: 8px;
        }
        
        .stat-label {
            font-size: 15px;
            color: #6c757d;
            font-weight: 600;
            text-transform: uppercase;
        }
        
        .section {
            background: white;
            border-radius: 24px;
            padding: 35px;
            margin-bottom: 30px;
            box-shadow: 0 10px 40px rgba(0, 0, 0, 0.08);
        }
        
        .section-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 30px;
            padding-bottom: 20px;
            border-bottom: 2px solid #f0f0f0;
        }
        
        .section-title {
            font-size: 26px;
            font-weight: 800;
            color: #212529;
            display: flex;
            align-items: center;
            gap: 12px;
        }
        
        .reservations-grid {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(350px, 1fr));
            gap: 25px;
        }
        
        .reservation-card {
            background: linear-gradient(135deg, #f8f9fc 0%, #ffffff 100%);
            border-radius: 16px;
            padding: 25px;
            border: 2px solid #e9ecef;
            transition: all 0.3s ease;
        }
        
        .reservation-card:hover {
            border-color: #667eea;
            transform: translateY(-5px);
            box-shadow: 0 15px 40px rgba(102, 126, 234, 0.15);
        }
        
        .reservation-header {
            display: flex;
            justify-content: space-between;
            margin-bottom: 20px;
        }
        
        .reservation-type { font-size: 32px; }
        
        .reservation-status {
            padding: 6px 16px;
            border-radius: 20px;
            font-size: 12px;
            font-weight: 700;
            text-transform: uppercase;
        }
        
        .status-confirmed { background: linear-gradient(135deg, #11998e 0%, #38ef7d 100%); color: white; }
        .status-pending { background: linear-gradient(135deg, #f2994a 0%, #f2c94c 100%); color: white; }
        .status-cancelled { background: linear-gradient(135deg, #eb3349 0%, #f45c43 100%); color: white; }
        
        .reservation-info h3 { font-size: 18px; font-weight: 700; margin-bottom: 12px; }
        
        .reservation-detail {
            display: flex;
            gap: 8px;
            margin-bottom: 8px;
            font-size: 14px;
            color: #6c757d;
        }
        
        .reservation-price {
            font-size: 24px;
            font-weight: 800;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            margin-top: 15px;
        }
        
        .recommendations-grid {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(300px, 1fr));
            gap: 25px;
        }
        
        .recommendation-card {
            background: white;
            border-radius: 16px;
            overflow: hidden;
            box-shadow: 0 8px 30px rgba(0, 0, 0, 0.1);
            transition: all 0.3s ease;
        }
        
        .recommendation-card:hover {
            transform: translateY(-8px);
            box-shadow: 0 15px 50px rgba(0, 0, 0, 0.2);
        }
        
        .recommendation-image { width: 100%; height: 200px; object-fit: cover; }
        .recommendation-content { padding: 25px; }
        .recommendation-title { font-size: 20px; font-weight: 700; margin-bottom: 10px; }
        .recommendation-desc { font-size: 14px; color: #6c757d; margin-bottom: 15px; line-height: 1.6; }
        
        .recommendation-price {
            font-size: 28px;
            font-weight: 800;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            margin-bottom: 15px;
        }
        
        .btn-discover {
            width: 100%;
            padding: 14px;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            border: none;
            border-radius: 50px;
            font-weight: 700;
            cursor: pointer;
            text-decoration: none;
            display: block;
            text-align: center;
        }
        
        .btn-discover:hover { transform: translateY(-3px); box-shadow: 0 10px 30px rgba(102, 126, 234, 0.4); }
        
        .quick-actions {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
            gap: 20px;
        }
        
        .action-btn {
            padding: 20px;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            border-radius: 16px;
            text-decoration: none;
            font-weight: 700;
            text-align: center;
            transition: all 0.3s ease;
            box-shadow: 0 8px 20px rgba(102, 126, 234, 0.3);
        }
        
        .action-btn:hover { transform: translateY(-5px); box-shadow: 0 15px 40px rgba(102, 126, 234, 0.5); }
        
        .action-btn.secondary {
            background: linear-gradient(135deg, #f093fb 0%, #f5576c 100%);
            box-shadow: 0 8px 20px rgba(240, 147, 251, 0.3);
        }
        
        .action-btn.success {
            background: linear-gradient(135deg, #11998e 0%, #38ef7d 100%);
            box-shadow: 0 8px 20px rgba(17, 153, 142, 0.3);
        }
        
        .empty-state { text-align: center; padding: 60px 20px; color: #6c757d; }
        .empty-state-icon { font-size: 80px; margin-bottom: 20px; opacity: 0.5; }
        
        @media (max-width: 768px) {
            .dashboard-wrapper { padding-top: 200px; }
            .header-content { flex-direction: column; gap: 20px; }
            .header-actions { width: 100%; flex-direction: column; }
            .header-btn { width: 100%; }
            .stats-grid, .reservations-grid, .recommendations-grid { grid-template-columns: 1fr; }
        }
    </style>
</head>
<body>
    <div class="dashboard-wrapper">
        <div class="dashboard-header">
            <div class="header-content">
                <div class="header-left">
                    <div class="user-avatar">
                        ${sessionScope.user.firstName.substring(0,1).toUpperCase()}
                    </div>
                    <div class="welcome-text">
                        <h1>👋 Bonjour, ${sessionScope.user.firstName} !</h1>
                        <p>✨ Bienvenue sur votre tableau de bord</p>
                    </div>
                </div>
                <div class="header-actions">
                    <a href="${pageContext.request.contextPath}/search/flights" class="header-btn btn-white">✈️ Rechercher</a>
                    <a href="${pageContext.request.contextPath}/user/profile" class="header-btn btn-outline">👤 Profil</a>
                    <a href="${pageContext.request.contextPath}/auth/logout" class="header-btn btn-outline">🚪 Déconnexion</a>
                </div>
            </div>
        </div>

        <div class="dashboard-container">
            <div class="stats-grid">
                <div class="stat-card">
                    <div class="stat-icon">📋</div>
                    <div class="stat-value">${totalReservations}</div>
                    <div class="stat-label">Total Réservations</div>
                </div>
                <div class="stat-card">
                    <div class="stat-icon">✅</div>
                    <div class="stat-value">${confirmedReservations}</div>
                    <div class="stat-label">Confirmées</div>
                </div>
                <div class="stat-card">
                    <div class="stat-icon">💰</div>
                    <div class="stat-value"><fmt:formatNumber value="${totalSpent}" pattern="#,##0" /> €</div>
                    <div class="stat-label">Total Dépensé</div>
                </div>
                <div class="stat-card">
                    <div class="stat-icon">⭐</div>
                    <div class="stat-value">${favoriteType != null ? favoriteType : 'N/A'}</div>
                    <div class="stat-label">Type Préféré</div>
                </div>
            </div>

            <div class="section">
                <div class="section-header">
                    <h2 class="section-title">🎫 Mes Réservations</h2>
                    <a href="${pageContext.request.contextPath}/reservation/list" class="btn-white" style="padding: 10px 20px; border-radius: 50px; text-decoration: none; font-weight: 600;">Voir tout</a>
                </div>
                
                <c:choose>
                    <c:when test="${not empty recentReservations}">
                        <div class="reservations-grid">
                            <c:forEach items="${recentReservations}" var="r">
                                <div class="reservation-card">
                                    <div class="reservation-header">
                                        <span class="reservation-type">
                                            <c:choose>
                                                <c:when test="${r.type == 'FLIGHT'}">✈️</c:when>
                                                <c:when test="${r.type == 'HOTEL'}">🏨</c:when>
                                                <c:otherwise>🗺️</c:otherwise>
                                            </c:choose>
                                        </span>
                                        <span class="reservation-status 
                                            <c:choose>
                                                <c:when test="${r.status == 'CONFIRMEE'}">status-confirmed</c:when>
                                                <c:when test="${r.status == 'EN_ATTENTE'}">status-pending</c:when>
                                                <c:otherwise>status-cancelled</c:otherwise>
                                            </c:choose>">
                                            ${r.status}
                                        </span>
                                    </div>
                                    <div class="reservation-info">
                                        <h3>Réservation #${r.id}</h3>
                                        <div class="reservation-detail">📅 ${r.createdAt.toString().substring(0, 10)}</div>
                                        <div class="reservation-detail">👥 ${r.numberOfPeople} personne(s)</div>
                                        <div class="reservation-price">
                                            <c:if test="${r.payment != null}">
                                                <fmt:formatNumber value="${r.payment.amount}" pattern="#,##0.00" /> €
                                            </c:if>
                                        </div>
                                    </div>
                                </div>
                            </c:forEach>
                        </div>
                    </c:when>
                    <c:otherwise>
                        <div class="empty-state">
                            <div class="empty-state-icon">📭</div>
                            <h3>Aucune réservation</h3>
                            <p>Commencez votre aventure maintenant !</p>
                            <a href="${pageContext.request.contextPath}/search/flights" class="btn-white" style="display: inline-block; padding: 12px 30px; border-radius: 50px; text-decoration: none; font-weight: 600;">Rechercher</a>
                        </div>
                    </c:otherwise>
                </c:choose>
            </div>

            <div class="section">
                <div class="section-header">
                    <h2 class="section-title">🌟 Recommandations</h2>
                </div>
                <div class="recommendations-grid">
                    <div class="recommendation-card">
                        <img src="https://images.unsplash.com/photo-1436491865332-7a61a109cc05?w=400" alt="Vol" class="recommendation-image">
                        <div class="recommendation-content">
                            <h3 class="recommendation-title">✈️ Vols dernière minute</h3>
                            <p class="recommendation-desc">Offres exceptionnelles vers les destinations prisées</p>
                            <div class="recommendation-price">À partir de 99€</div>
                            <a href="${pageContext.request.contextPath}/search/flights" class="btn-discover">Découvrir</a>
                        </div>
                    </div>
                    <div class="recommendation-card">
                        <img src="https://images.unsplash.com/photo-1566073771259-6a8506099945?w=400" alt="Hôtel" class="recommendation-image">
                        <div class="recommendation-content">
                            <h3 class="recommendation-title">🏨 Hôtels de luxe</h3>
                            <p class="recommendation-desc">Réductions jusqu'à -30% sur nos plus beaux établissements</p>
                            <div class="recommendation-price">À partir de 150€/nuit</div>
                            <a href="${pageContext.request.contextPath}/search/hotels" class="btn-discover">Découvrir</a>
                        </div>
                    </div>
                    <div class="recommendation-card">
                        <img src="https://images.unsplash.com/photo-1469854523086-cc02fe5d8800?w=400" alt="Circuit" class="recommendation-image">
                        <div class="recommendation-content">
                            <h3 class="recommendation-title">🗺️ Circuits organisés</h3>
                            <p class="recommendation-desc">Aventures tout compris vers des destinations uniques</p>
                            <div class="recommendation-price">À partir de 890€</div>
                            <a href="${pageContext.request.contextPath}/search/circuits" class="btn-discover">Découvrir</a>
                        </div>
                    </div>
                </div>
            </div>

            <div class="section">
                <div class="section-header">
                    <h2 class="section-title">⚡ Actions Rapides</h2>
                </div>
                <div class="quick-actions">
                    <a href="${pageContext.request.contextPath}/search/flights" class="action-btn">✈️ Rechercher un Vol</a>
                    <a href="${pageContext.request.contextPath}/search/hotels" class="action-btn secondary">🏨 Trouver un Hôtel</a>
                    <a href="${pageContext.request.contextPath}/search/circuits" class="action-btn success">🗺️ Explorer les Circuits</a>
                    <a href="${pageContext.request.contextPath}/reservation/list" class="action-btn">📋 Mes Réservations</a>
                </div>
            </div>
        </div>
    </div>
</body>
</html>
