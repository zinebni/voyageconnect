<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Recherche - VoyageConnect</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
</head>
<body>
    <jsp:include page="/WEB-INF/views/common/navbar.jsp" />
    
    <div class="container">
        <h1>Recherche de Voyages</h1>
        
        <div class="search-options">
            <div class="option-card">
                <h2>🛫 Vols</h2>
                <p>Trouvez les meilleurs vols vers votre destination</p>
                <a href="${pageContext.request.contextPath}/search/flights" class="btn btn-primary">
                    Rechercher des vols
                </a>
            </div>
            
            <div class="option-card">
                <h2>🏨 Hôtels</h2>
                <p>Réservez votre hébergement idéal</p>
                <a href="${pageContext.request.contextPath}/search/hotels" class="btn btn-primary">
                    Rechercher des hôtels
                </a>
            </div>
            
            <div class="option-card">
                <h2>🗺️ Circuits</h2>
                <p>Découvrez nos circuits organisés</p>
                <a href="${pageContext.request.contextPath}/search/circuits" class="btn btn-primary">
                    Rechercher des circuits
                </a>
            </div>
        </div>
        
        <hr>
        
        <h2>Destinations populaires</h2>
        <div class="destinations-grid">
            <c:forEach var="destination" items="${destinations}">
                <div class="destination-card">
                    <img src="${destination.imageUrl}" alt="${destination.name}">
                    <h3>${destination.name}</h3>
                    <p class="country">${destination.country}</p>
                    <p class="description">${destination.description}</p>
                    <a href="${pageContext.request.contextPath}/search/flights?destinationId=${destination.id}" 
                       class="btn btn-secondary">
                        Explorer
                    </a>
                </div>
            </c:forEach>
        </div>
    </div>
    
    <style>
        .search-options {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(280px, 1fr));
            gap: 2rem;
            margin: 3rem 0;
        }
        
        .option-card {
            background: white;
            padding: 2.5rem;
            border-radius: 16px;
            box-shadow: 0 8px 24px rgba(0, 0, 0, 0.1);
            text-align: center;
            transition: all 0.4s ease;
            border: 2px solid transparent;
            position: relative;
            overflow: hidden;
        }
        
        .option-card::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            height: 4px;
            background: linear-gradient(90deg, #667eea 0%, #764ba2 100%);
            transform: scaleX(0);
            transition: transform 0.4s ease;
        }
        
        .option-card:hover::before {
            transform: scaleX(1);
        }
        
        .option-card:hover {
            transform: translateY(-12px);
            box-shadow: 0 16px 48px rgba(0, 0, 0, 0.15);
            border-color: #667eea;
        }
        
        .option-card h2 {
            font-size: 3rem;
            margin-bottom: 1rem;
            animation: bounce 2s ease-in-out infinite;
        }
        
        @keyframes bounce {
            0%, 100% { transform: translateY(0); }
            50% { transform: translateY(-10px); }
        }
        
        .option-card p {
            color: #666;
            font-size: 1.1rem;
            margin: 1.5rem 0;
            line-height: 1.6;
        }
        
        .destinations-grid {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(320px, 1fr));
            gap: 2rem;
            margin-top: 2rem;
        }
        
        .destination-card {
            background: white;
            border-radius: 16px;
            overflow: hidden;
            box-shadow: 0 8px 24px rgba(0, 0, 0, 0.1);
            transition: all 0.4s ease;
            border: 1px solid rgba(0, 0, 0, 0.05);
        }
        
        .destination-card:hover {
            transform: translateY(-12px) scale(1.02);
            box-shadow: 0 20px 48px rgba(0, 0, 0, 0.2);
        }
        
        .destination-card img {
            width: 100%;
            height: 250px;
            object-fit: cover;
            transition: transform 0.4s ease;
        }
        
        .destination-card:hover img {
            transform: scale(1.1);
        }
        
        .destination-card h3 {
            padding: 1.5rem 1.5rem 0.5rem;
            margin: 0;
            font-size: 1.6rem;
            font-weight: 700;
            color: #2c3e50;
        }
        
        .destination-card .country {
            padding: 0 1.5rem;
            color: #666;
            font-size: 1.05rem;
            font-weight: 500;
        }
        
        .destination-card .description {
            padding: 0.75rem 1.5rem 1.5rem;
            color: #555;
            font-size: 1rem;
            line-height: 1.6;
        }
        
        .destination-card .btn {
            margin: 0 1.5rem 1.5rem;
            display: inline-block;
        }
        
        hr {
            border: none;
            height: 2px;
            background: linear-gradient(90deg, transparent, #667eea, transparent);
            margin: 4rem 0;
        }
        
        h2 {
            font-size: 2.2rem;
            text-align: center;
            margin: 3rem 0 2rem;
            color: #2c3e50;
            font-weight: 700;
        }
    </style>
</body>
</html>
