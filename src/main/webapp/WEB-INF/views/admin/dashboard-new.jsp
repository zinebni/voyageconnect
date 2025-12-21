<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Dashboard Admin - VoyageConnect</title>
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
        
        .admin-container {
            max-width: 1600px;
            margin: 0 auto;
            padding: 30px 20px;
        }
        
        .admin-header {
            background: linear-gradient(135deg, #e74c3c 0%, #c0392b 100%);
            border-radius: 20px;
            padding: 40px;
            color: white;
            margin-bottom: 40px;
            box-shadow: 0 10px 40px rgba(231, 76, 60, 0.3);
        }
        
        .admin-header h1 {
            font-size: 36px;
            margin-bottom: 10px;
        }
        
        .stats-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
            gap: 20px;
            margin-bottom: 40px;
        }
        
        .stat-card {
            background: white;
            border-radius: 16px;
            padding: 25px;
            box-shadow: 0 4px 20px rgba(0,0,0,0.08);
            transition: all 0.3s ease;
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
            margin-bottom: 5px;
        }
        
        .stat-card .label {
            color: #7f8c8d;
            font-size: 14px;
        }
        
        .stat-card.primary { color: #3498db; }
        .stat-card.success { color: #27ae60; }
        .stat-card.warning { color: #f39c12; }
        .stat-card.danger { color: #e74c3c; }
        .stat-card.info { color: #9b59b6; }
        
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
        
        .chart-container {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(350px, 1fr));
            gap: 20px;
        }
        
        .chart-box {
            background: #f8f9fa;
            border-radius: 12px;
            padding: 20px;
        }
        
        .chart-box h4 {
            color: #2c3e50;
            margin-bottom: 15px;
        }
        
        .bar-item {
            display: flex;
            align-items: center;
            margin-bottom: 15px;
        }
        
        .bar-label {
            min-width: 120px;
            font-weight: 600;
            color: #2c3e50;
        }
        
        .bar {
            flex: 1;
            height: 30px;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            border-radius: 15px;
            position: relative;
            overflow: hidden;
        }
        
        .bar-value {
            position: absolute;
            right: 10px;
            top: 50%;
            transform: translateY(-50%);
            color: white;
            font-weight: bold;
            font-size: 13px;
        }
        
        table {
            width: 100%;
            border-collapse: collapse;
        }
        
        th, td {
            padding: 15px;
            text-align: left;
            border-bottom: 1px solid #e9ecef;
        }
        
        th {
            background: #f8f9fa;
            color: #2c3e50;
            font-weight: 600;
        }
        
        tr:hover {
            background: #f8f9fa;
        }
        
        .badge {
            padding: 6px 12px;
            border-radius: 20px;
            font-size: 12px;
            font-weight: 600;
        }
        
        .badge-success {
            background: #d4edda;
            color: #155724;
        }
        
        .badge-warning {
            background: #fff3cd;
            color: #856404;
        }
        
        .badge-danger {
            background: #f8d7da;
            color: #721c24;
        }
        
        .btn {
            padding: 10px 20px;
            border: none;
            border-radius: 50px;
            font-size: 14px;
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
    </style>
</head>
<body>
    <%@ include file="../common/navbar.jsp" %>
    
    <div class="admin-container">
        <!-- Admin Header -->
        <div class="admin-header">
            <h1>🛠️ Tableau de bord Administrateur</h1>
            <p>Vue d'ensemble de la plateforme VoyageConnect</p>
        </div>
        
        <!-- Main Statistics -->
        <div class="stats-grid">
            <div class="stat-card primary">
                <div class="icon">👥</div>
                <div class="value">${totalUsers}</div>
                <div class="label">Utilisateurs</div>
            </div>
            
            <div class="stat-card success">
                <div class="icon">✈️</div>
                <div class="value">${totalFlights}</div>
                <div class="label">Vols</div>
            </div>
            
            <div class="stat-card warning">
                <div class="icon">🏨</div>
                <div class="value">${totalHotels}</div>
                <div class="label">Hôtels</div>
            </div>
            
            <div class="stat-card danger">
                <div class="icon">🗺️</div>
                <div class="value">${totalCircuits}</div>
                <div class="label">Circuits</div>
            </div>
            
            <div class="stat-card info">
                <div class="icon">🌍</div>
                <div class="value">${totalDestinations}</div>
                <div class="label">Destinations</div>
            </div>
        </div>
        
        <!-- Reservations Statistics -->
        <div class="stats-grid">
            <div class="stat-card success">
                <div class="icon">📊</div>
                <div class="value">${totalReservations}</div>
                <div class="label">Réservations totales</div>
            </div>
            
            <div class="stat-card success">
                <div class="icon">✅</div>
                <div class="value">${confirmedReservations}</div>
                <div class="label">Confirmées</div>
            </div>
            
            <div class="stat-card warning">
                <div class="icon">⏳</div>
                <div class="value">${pendingReservations}</div>
                <div class="label">En attente</div>
            </div>
            
            <div class="stat-card danger">
                <div class="icon">❌</div>
                <div class="value">${cancelledReservations}</div>
                <div class="label">Annulées</div>
            </div>
        </div>
        
        <!-- Revenue Statistics -->
        <div class="section">
            <h2 class="section-title">💰 Revenus</h2>
            <div class="stats-grid">
                <div class="stat-card primary">
                    <div class="icon">💵</div>
                    <div class="value">
                        <fmt:formatNumber value="${totalRevenue}" type="currency" currencySymbol="" maxFractionDigits="0"/> MAD
                    </div>
                    <div class="label">Revenus totaux</div>
                </div>
                
                <div class="stat-card success">
                    <div class="icon">📈</div>
                    <div class="value">
                        <fmt:formatNumber value="${monthlyRevenue}" type="currency" currencySymbol="" maxFractionDigits="0"/> MAD
                    </div>
                    <div class="label">Revenus ce mois</div>
                </div>
            </div>
        </div>
        
        <!-- Charts Section -->
        <div class="section">
            <h2 class="section-title">📊 Statistiques détaillées</h2>
            <div class="chart-container">
                <!-- Reservations by Type -->
                <div class="chart-box">
                    <h4>Réservations par type</h4>
                    <c:forEach items="${reservationsByType}" var="entry">
                        <c:set var="percentage" value="${(entry.value / totalReservations) * 100}" />
                        <div class="bar-item">
                            <span class="bar-label">${entry.key}</span>
                            <div class="bar" data-width="${percentage}">
                                <span class="bar-value">${entry.value}</span>
                            </div>
                        </div>
                    </c:forEach>
                </div>
                
                <!-- Popular Destinations -->
                <div class="chart-box">
                    <h4>Destinations populaires</h4>
                    <c:forEach items="${popularDestinations}" var="entry" varStatus="status">
                        <c:if test="${status.index < 5}">
                            <c:set var="destPercentage" value="${(entry.value / totalReservations) * 100 * 3}" />
                            <div class="bar-item">
                                <span class="bar-label">${entry.key}</span>
                                <div class="bar" data-width="${destPercentage}">
                                    <span class="bar-value">${entry.value}</span>
                                </div>
                            </div>
                        </c:if>
                    </c:forEach>
                </div>
            </div>
        </div>
        
        <!-- Recent Reservations -->
        <div class="section">
            <h2 class="section-title">📋 Dernières Réservations</h2>
            <table>
                <thead>
                    <tr>
                        <th>#</th>
                        <th>Type</th>
                        <th>Client</th>
                        <th>Date</th>
                        <th>Montant</th>
                        <th>Statut</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach items="${recentReservations}" var="res">
                        <tr>
                            <td>#${res.id}</td>
                            <td>
                                <c:choose>
                                    <c:when test="${res.type == 'FLIGHT'}">✈️ Vol</c:when>
                                    <c:when test="${res.type == 'HOTEL'}">🏨 Hôtel</c:when>
                                    <c:when test="${res.type == 'CIRCUIT'}">🗺️ Circuit</c:when>
                                </c:choose>
                            </td>
                            <td>${res.user.firstName} ${res.user.lastName}</td>
                            <td><fmt:formatDate value="${res.createdAt}" pattern="dd/MM/yyyy HH:mm"/></td>
                            <td>
                                <c:if test="${not empty res.payment}">
                                    <fmt:formatNumber value="${res.payment.amount}" type="currency" currencySymbol="" maxFractionDigits="0"/> MAD
                                </c:if>
                            </td>
                            <td>
                                <span class="badge badge-${res.status.name().toLowerCase().replace('_', '')}">
                                    <c:choose>
                                        <c:when test="${res.status == 'CONFIRMEE'}">✓ Confirmée</c:when>
                                        <c:when test="${res.status == 'EN_ATTENTE'}">⏳ En attente</c:when>
                                        <c:when test="${res.status == 'ANNULEE'}">✕ Annulée</c:when>
                                    </c:choose>
                                </span>
                            </td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
        </div>
        
        <!-- Quick Actions -->
        <div class="section">
            <h2 class="section-title">⚡ Actions Rapides</h2>
            <div style="display: flex; gap: 15px; flex-wrap: wrap;">
                <a href="${pageContext.request.contextPath}/admin/destinations" class="btn btn-primary">
                    🌍 Gérer Destinations
                </a>
                <a href="${pageContext.request.contextPath}/admin/flights" class="btn btn-primary">
                    ✈️ Gérer Vols
                </a>
                <a href="${pageContext.request.contextPath}/admin/hotels" class="btn btn-primary">
                    🏨 Gérer Hôtels
                </a>
                <a href="${pageContext.request.contextPath}/admin/circuits" class="btn btn-primary">
                    🗺️ Gérer Circuits
                </a>
            </div>
        </div>
    </div>
    
    <script>
        // Appliquer les largeurs des barres depuis data-width
        document.addEventListener('DOMContentLoaded', function() {
            document.querySelectorAll('.bar[data-width]').forEach(function(bar) {
                var width = parseFloat(bar.getAttribute('data-width'));
                // Limiter à 100%
                width = Math.min(width, 100);
                bar.style.width = width + '%';
            });
        });
    </script>
</body>
</html>
