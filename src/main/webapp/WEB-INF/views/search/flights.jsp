<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.time.format.DateTimeFormatter" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Recherche de Vols - VoyageConnect</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
</head>
<body>
    <jsp:include page="/WEB-INF/views/common/navbar.jsp" />
    
    <div class="container">
        <h1>🛫 Recherche de Vols</h1>
        
        <!-- Formulaire de recherche -->
        <div class="search-form">
            <form method="GET" action="${pageContext.request.contextPath}/search/flights">
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
                        <label for="departureCity">Ville de départ</label>
                        <input type="text" name="departureCity" id="departureCity" 
                               value="${departureCity}" placeholder="Ex: Paris">
                    </div>
                    
                    <div class="form-group">
                        <label for="departureDate">Date de départ</label>
                        <input type="date" name="departureDate" id="departureDate" 
                               value="${departureDate}">
                    </div>
                </div>
                
                <div class="form-row">
                    <div class="form-group">
                        <label for="passengers">Nombre de passagers</label>
                        <input type="number" name="passengers" id="passengers" 
                               value="${passengers}" min="1" max="10" placeholder="1">
                    </div>
                    
                    <div class="form-group">
                        <label for="maxPrice">Prix maximum</label>
                        <input type="number" name="maxPrice" id="maxPrice" 
                               value="${maxPrice}" step="0.01" placeholder="1000.00">
                    </div>
                    
                    <div class="form-group">
                        <label>&nbsp;</label>
                        <button type="submit" class="btn btn-primary">Rechercher</button>
                    </div>
                </div>
            </form>
        </div>
        
        <c:if test="${not empty error}">
            <div class="alert alert-error">${error}</div>
        </c:if>
        
        <!-- Résultats -->
        <div class="results">
            <h2>Vols disponibles (${flights.size()})</h2>
            
            <c:if test="${empty flights}">
                <p class="no-results">Aucun vol trouvé avec ces critères.</p>
            </c:if>
            
            <div class="flights-list">
                <c:forEach var="flight" items="${flights}">
                    <div class="flight-card">
                        <div class="flight-header">
                            <h3>${flight.flightNumber} - ${flight.airline}</h3>
                            <span class="flight-class ${flight.flightClass}">${flight.flightClass}</span>
                        </div>
                        
                        <div class="flight-route">
                            <div class="route-info">
                                <span class="city">${flight.departureCity}</span>
                                <span class="time">
                                    <c:out value="${flight.departureDate.format(DateTimeFormatter.ofPattern('dd/MM/yyyy HH:mm'))}" />
                                </span>
                            </div>
                            
                            <div class="route-arrow">✈️</div>
                            
                            <div class="route-info">
                                <span class="city">${flight.destination.name}</span>
                                <span class="time">
                                    <c:out value="${flight.arrivalDate.format(DateTimeFormatter.ofPattern('dd/MM/yyyy HH:mm'))}" />
                                </span>
                            </div>
                        </div>
                        
                        <div class="flight-details">
                            <div class="detail-item">
                                <span class="label">Places disponibles:</span>
                                <span class="value">${flight.availableSeats} / ${flight.totalSeats}</span>
                            </div>
                            
                            <div class="detail-item">
                                <span class="label">Prix:</span>
                                <span class="value price">
                                    <fmt:formatNumber value="${flight.price}" type="currency" currencySymbol="€" />
                                </span>
                            </div>
                        </div>
                        
                        <div class="flight-actions">
                            <a href="${pageContext.request.contextPath}/reservation/new?type=flight&id=${flight.id}" 
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
            border: 1px solid rgba(0, 0, 0, 0.05);
        }
        
        .form-row {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(220px, 1fr));
            gap: 1.5rem;
            margin-bottom: 1rem;
        }
        
        .form-group {
            display: flex;
            flex-direction: column;
        }
        
        .form-group label {
            display: block;
            margin-bottom: 0.5rem;
            font-weight: 600;
            color: #495057;
            font-size: 0.95rem;
        }
        
        .form-group input,
        .form-group select {
            width: 100%;
            padding: 12px 16px;
            border: 2px solid #e0e0e0;
            border-radius: 8px;
            font-size: 1rem;
            transition: all 0.3s ease;
        }
        
        .form-group input:focus,
        .form-group select:focus {
            border-color: #667eea;
            outline: none;
            box-shadow: 0 0 0 4px rgba(102, 126, 234, 0.1);
        }
        
        .results h2 {
            font-size: 1.75rem;
            margin-bottom: 2rem;
            color: #2c3e50;
            font-weight: 700;
        }
        
        .flights-list {
            display: grid;
            gap: 1.5rem;
        }
        
        .flight-card {
            background: white;
            padding: 2rem;
            border-radius: 16px;
            box-shadow: 0 4px 16px rgba(0, 0, 0, 0.08);
            transition: all 0.3s ease;
            border: 1px solid rgba(0, 0, 0, 0.05);
        }
        
        .flight-card:hover {
            transform: translateY(-4px);
            box-shadow: 0 12px 32px rgba(0, 0, 0, 0.15);
        }
        
        .flight-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 1.5rem;
            padding-bottom: 1.5rem;
            border-bottom: 2px solid #f0f0f0;
        }
        
        .flight-header h3 {
            margin: 0;
            color: #2c3e50;
            font-size: 1.5rem;
            font-weight: 700;
        }
        
        .flight-class {
            padding: 0.5rem 1rem;
            border-radius: 20px;
            font-size: 0.85rem;
            font-weight: 700;
            text-transform: uppercase;
            letter-spacing: 0.5px;
        }
        
        .flight-class.ECONOMY {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
        }
        
        .flight-class.BUSINESS {
            background: linear-gradient(135deg, #f093fb 0%, #f5576c 100%);
            color: white;
        }
        
        .flight-class.FIRST {
            background: linear-gradient(135deg, #ffecd2 0%, #fcb69f 100%);
            color: #333;
        }
        
        .flight-route {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin: 2rem 0;
            padding: 1.5rem;
            background: linear-gradient(135deg, #f5f7fa 0%, #c3cfe2 20%);
            border-radius: 12px;
        }
        
        .route-info {
            flex: 1;
            text-align: center;
        }
        
        .route-info .city {
            display: block;
            font-size: 1.5rem;
            font-weight: 700;
            margin-bottom: 0.5rem;
            color: #2c3e50;
        }
        
        .route-info .time {
            display: block;
            font-size: 1rem;
            color: #666;
            font-weight: 500;
        }
        
        .route-arrow {
            font-size: 2.5rem;
            margin: 0 2rem;
            animation: float 3s ease-in-out infinite;
        }
        
        @keyframes float {
            0%, 100% { transform: translateY(0); }
            50% { transform: translateY(-10px); }
        }
        
        .flight-details {
            display: flex;
            justify-content: space-around;
            margin: 2rem 0;
            padding: 1.5rem 0;
            border-top: 2px solid #f0f0f0;
            border-bottom: 2px solid #f0f0f0;
        }
        
        .detail-item {
            text-align: center;
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
            font-size: 2rem;
            font-weight: 800;
        }
        
        .flight-actions {
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
        
        .alert {
            padding: 1rem 1.5rem;
            border-radius: 12px;
            margin-bottom: 1.5rem;
            font-weight: 500;
        }
        
        .alert-error {
            background: #fee;
            color: #c62828;
            border-left: 4px solid #c62828;
        }
    </style>
</body>
</html>
