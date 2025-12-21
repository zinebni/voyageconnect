<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Recherche d'Hôtels - VoyageConnect</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
</head>
<body>
    <jsp:include page="/WEB-INF/views/common/navbar.jsp" />
    
    <div class="container">
        <h1>🏨 Recherche d'Hôtels</h1>
        
        <!-- Formulaire de recherche -->
        <div class="search-form">
            <form method="GET" action="${pageContext.request.contextPath}/search/hotels">
                <div class="form-row">
                    <div class="form-group">
                        <label for="destinationId">Destination</label>
                        <select name="destinationId" id="destinationId">
                            <option value="">-- Toutes les destinations --</option>
                            <c:forEach var="destination" items="${destinations}">
                                <option value="${destination.id}" 
                                        ${selectedDestinationId == destination.id ? 'selected' : ''}>
                                    ${destination.name}, ${destination.country}
                                </option>
                            </c:forEach>
                        </select>
                    </div>
                    
                    <div class="form-group">
                        <label for="minStars">Étoiles minimum</label>
                        <input type="number" name="minStars" id="minStars" 
                               value="${minStars}" min="1" max="5" placeholder="3">
                    </div>
                    
                    <div class="form-group">
                        <label for="maxPrice">Prix max par nuit</label>
                        <input type="number" name="maxPrice" id="maxPrice" 
                               value="${maxPrice}" step="0.01" placeholder="200.00">
                    </div>
                </div>
                
                <div class="form-row">
                    <div class="form-group">
                        <label for="rooms">Nombre de chambres</label>
                        <input type="number" name="rooms" id="rooms" 
                               value="${rooms}" min="1" placeholder="1">
                    </div>
                    
                    <div class="form-group">
                        <label>&nbsp;</label>
                        <button type="submit" class="btn btn-primary">Rechercher</button>
                    </div>
                </div>
            </form>
        </div>
        
        <!-- Résultats -->
        <div class="results">
            <h2>Hôtels disponibles (${hotels.size()})</h2>
            
            <c:if test="${empty hotels}">
                <p class="no-results">Aucun hôtel trouvé avec ces critères.</p>
            </c:if>
            
            <div class="hotels-grid">
                <c:forEach var="hotel" items="${hotels}">
                    <div class="hotel-card">
                        <div class="hotel-header">
                            <h3>${hotel.name}</h3>
                            <div class="stars">
                                <c:forEach begin="1" end="${hotel.stars}">⭐</c:forEach>
                            </div>
                        </div>
                        
                        <p class="location">📍 ${hotel.destination.name}, ${hotel.destination.country}</p>
                        <p class="address">${hotel.address}</p>
                        
                        <div class="amenities">
                            <c:if test="${hotel.wifi}">
                                <span class="amenity">📶 WiFi</span>
                            </c:if>
                            <c:if test="${hotel.pool}">
                                <span class="amenity">🏊 Piscine</span>
                            </c:if>
                            <c:if test="${hotel.restaurant}">
                                <span class="amenity">🍽️ Restaurant</span>
                            </c:if>
                            <c:if test="${hotel.parking}">
                                <span class="amenity">🅿️ Parking</span>
                            </c:if>
                        </div>
                        
                        <div class="hotel-details">
                            <div class="detail-item">
                                <span class="label">Chambres disponibles:</span>
                                <span class="value">${hotel.availableRooms} / ${hotel.totalRooms}</span>
                            </div>
                            
                            <div class="detail-item">
                                <span class="label">Prix par nuit:</span>
                                <span class="value price">
                                    <fmt:formatNumber value="${hotel.pricePerNight}" type="currency" currencySymbol="€" />
                                </span>
                            </div>
                        </div>
                        
                        <div class="hotel-actions">
                            <a href="${pageContext.request.contextPath}/reservation/new?type=hotel&id=${hotel.id}" 
                               class="btn btn-primary">
                                Réserver
                            </a>
                        </div>
                    </div>
                </c:forEach>
            </div>
        </div>
    </div>
    
    <style>
        .search-form {
            background: white;
            padding: 2.5rem;
            border-radius: 16px;
            box-shadow: 0 8px 24px rgba(0, 0, 0, 0.12);
            margin-bottom: 3rem;
        }
        
        .form-row {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(220px, 1fr));
            gap: 1.5rem;
            margin-bottom: 1rem;
        }
        
        .hotels-grid {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(380px, 1fr));
            gap: 2rem;
        }
        
        .hotel-card {
            background: white;
            padding: 2rem;
            border-radius: 16px;
            box-shadow: 0 4px 16px rgba(0, 0, 0, 0.08);
            transition: all 0.3s ease;
            border: 1px solid rgba(0, 0, 0, 0.05);
        }
        
        .hotel-card:hover {
            transform: translateY(-8px);
            box-shadow: 0 16px 40px rgba(0, 0, 0, 0.15);
        }
        
        .hotel-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 1.5rem;
        }
        
        .hotel-header h3 {
            margin: 0;
            font-size: 1.5rem;
            font-weight: 700;
            color: #2c3e50;
        }
        
        .stars {
            font-size: 1.1rem;
            filter: drop-shadow(0 2px 4px rgba(255, 193, 7, 0.3));
        }
        
        .location {
            color: #666;
            margin: 0.75rem 0;
            font-size: 1.05rem;
            font-weight: 500;
        }
        
        .address {
            color: #888;
            font-size: 0.95rem;
            margin-bottom: 1.5rem;
            line-height: 1.5;
        }
        
        .amenities {
            display: flex;
            flex-wrap: wrap;
            gap: 0.75rem;
            margin: 1.5rem 0;
            padding: 1rem;
            background: linear-gradient(135deg, #f5f7fa 0%, #e8ecf1 100%);
            border-radius: 12px;
        }
        
        .amenity {
            background: white;
            padding: 0.5rem 1rem;
            border-radius: 20px;
            font-size: 0.9rem;
            font-weight: 600;
            box-shadow: 0 2px 8px rgba(0, 0, 0, 0.08);
            transition: all 0.3s ease;
        }
        
        .amenity:hover {
            transform: translateY(-2px);
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.15);
        }
        
        .hotel-details {
            display: flex;
            justify-content: space-between;
            margin: 2rem 0;
            padding: 1.5rem 0;
            border-top: 2px solid #f0f0f0;
        }
        
        .detail-item .label {
            display: block;
            font-size: 0.9rem;
            color: #666;
            margin-bottom: 0.5rem;
            font-weight: 500;
        }
        
        .detail-item .value {
            display: block;
            font-size: 1.2rem;
            font-weight: 700;
            color: #2c3e50;
        }
        
        .detail-item .price {
            color: #10b981;
            font-size: 1.8rem;
            font-weight: 800;
        }
        
        .hotel-actions {
            text-align: right;
            margin-top: 1.5rem;
        }
        
        .no-results {
            text-align: center;
            padding: 5rem 2rem;
            color: #666;
            font-size: 1.3rem;
            background: white;
            border-radius: 16px;
            box-shadow: 0 4px 16px rgba(0, 0, 0, 0.08);
        }
    </style>
</body>
</html>
