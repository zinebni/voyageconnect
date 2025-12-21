<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.time.format.DateTimeFormatter" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Recherche de Circuits - VoyageConnect</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
</head>
<body>
    <jsp:include page="/WEB-INF/views/common/navbar.jsp" />
    
    <div class="container">
        <h1>🗺️ Recherche de Circuits</h1>
        
        <!-- Formulaire de recherche -->
        <div class="search-form">
            <form method="GET" action="${pageContext.request.contextPath}/search/circuits">
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
                        <label for="minDuration">Durée min (jours)</label>
                        <input type="number" name="minDuration" id="minDuration" 
                               value="${minDuration}" min="1" placeholder="1">
                    </div>
                    
                    <div class="form-group">
                        <label for="maxDuration">Durée max (jours)</label>
                        <input type="number" name="maxDuration" id="maxDuration" 
                               value="${maxDuration}" min="1" placeholder="30">
                    </div>
                </div>
                
                <div class="form-row">
                    <div class="form-group">
                        <label for="participants">Nombre de participants</label>
                        <input type="number" name="participants" id="participants" 
                               value="${participants}" min="1" placeholder="2">
                    </div>
                    
                    <div class="form-group">
                        <label for="maxPrice">Prix maximum</label>
                        <input type="number" name="maxPrice" id="maxPrice" 
                               value="${maxPrice}" step="0.01" placeholder="2000.00">
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
            <h2>Circuits disponibles (${circuits.size()})</h2>
            
            <c:if test="${empty circuits}">
                <p class="no-results">Aucun circuit trouvé avec ces critères.</p>
            </c:if>
            
            <div class="circuits-grid">
                <c:forEach var="circuit" items="${circuits}">
                    <div class="circuit-card">
                        <div class="circuit-header">
                            <h3>${circuit.name}</h3>
                        </div>
                        
                        <p class="location">📍 ${circuit.destination.name}, ${circuit.destination.country}</p>
                        <p class="description">${circuit.description}</p>
                        
                        <div class="circuit-info">
                            <div class="info-item">
                                <span class="icon">📅</span>
                                <span class="text">${circuit.durationDays} jours</span>
                            </div>
                            
                            <div class="info-item">
                                <span class="icon">👥</span>
                                <span class="text">${circuit.availableSpots} / ${circuit.totalSpots} places</span>
                            </div>
                            
                            <div class="info-item">
                                <span class="icon">🗓️</span>
                                <span class="text">
                                    Du <c:out value="${circuit.startDate.format(DateTimeFormatter.ofPattern('dd/MM/yyyy'))}" />
                                    au <c:out value="${circuit.endDate.format(DateTimeFormatter.ofPattern('dd/MM/yyyy'))}" />
                                </span>
                            </div>
                        </div>
                        
                        <div class="circuit-price">
                            <span class="label">Prix par personne:</span>
                            <span class="price">
                                <fmt:formatNumber value="${circuit.price}" type="currency" currencySymbol="€" />
                            </span>
                        </div>
                        
                        <div class="circuit-actions">
                            <a href="${pageContext.request.contextPath}/reservation/new?type=circuit&id=${circuit.id}" 
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
        
        .circuits-grid {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(420px, 1fr));
            gap: 2rem;
        }
        
        .circuit-card {
            background: white;
            padding: 2rem;
            border-radius: 16px;
            box-shadow: 0 4px 16px rgba(0, 0, 0, 0.08);
            transition: all 0.3s ease;
            border: 1px solid rgba(0, 0, 0, 0.05);
        }
        
        .circuit-card:hover {
            transform: translateY(-8px);
            box-shadow: 0 16px 40px rgba(0, 0, 0, 0.15);
        }
        
        .circuit-header h3 {
            margin: 0 0 1.5rem 0;
            color: #2c3e50;
            font-size: 1.6rem;
            font-weight: 700;
        }
        
        .location {
            color: #666;
            margin: 0.75rem 0;
            font-size: 1.05rem;
            font-weight: 500;
        }
        
        .description {
            color: #555;
            line-height: 1.7;
            margin: 1.5rem 0;
            font-size: 1rem;
        }
        
        .circuit-info {
            margin: 2rem 0;
            padding: 1.5rem;
            background: linear-gradient(135deg, #f5f7fa 0%, #e8ecf1 100%);
            border-radius: 12px;
            border-left: 4px solid #667eea;
        }
        
        .info-item {
            display: flex;
            align-items: center;
            margin: 1rem 0;
            padding: 0.5rem 0;
        }
        
        .info-item .icon {
            font-size: 1.5rem;
            margin-right: 1rem;
            min-width: 30px;
            text-align: center;
        }
        
        .info-item .text {
            font-size: 1.05rem;
            color: #2c3e50;
            font-weight: 500;
        }
        
        .circuit-price {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin: 2rem 0;
            padding: 1.5rem;
            background: linear-gradient(135deg, #d4fc79 0%, #96e6a1 100%);
            border-radius: 12px;
            box-shadow: 0 4px 12px rgba(150, 230, 161, 0.3);
        }
        
        .circuit-price .label {
            font-weight: 600;
            font-size: 1.1rem;
            color: #2c3e50;
        }
        
        .circuit-price .price {
            font-size: 2rem;
            font-weight: 800;
            color: #2d7a4d;
        }
        
        .circuit-actions {
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
