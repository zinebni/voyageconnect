<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Destinations - VoyageConnect</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
</head>
<body>
    <jsp:include page="/WEB-INF/views/common/navbar.jsp" />
    
    <div class="container">
        <h1>🌍 Nos Destinations</h1>
        
        <div class="destinations-grid">
            <c:forEach var="destination" items="${destinations}">
                <div class="destination-card">
                    <img src="${destination.imageUrl}" alt="${destination.name}">
                    <div class="destination-content">
                        <h2>${destination.name}</h2>
                        <p class="country">📍 ${destination.country}</p>
                        <p class="description">${destination.description}</p>
                        
                        <div class="destination-links">
                            <a href="${pageContext.request.contextPath}/search/flights?destinationId=${destination.id}" 
                               class="btn btn-primary">
                                Vols
                            </a>
                            <a href="${pageContext.request.contextPath}/search/hotels?destinationId=${destination.id}" 
                               class="btn btn-secondary">
                                Hôtels
                            </a>
                            <a href="${pageContext.request.contextPath}/search/circuits?destinationId=${destination.id}" 
                               class="btn btn-secondary">
                                Circuits
                            </a>
                        </div>
                    </div>
                </div>
            </c:forEach>
        </div>
    </div>
    
    <style>
        .destinations-grid {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(380px, 1fr));
            gap: 2.5rem;
            margin-top: 3rem;
        }
        
        .destination-card {
            background: white;
            border-radius: 16px;
            overflow: hidden;
            box-shadow: 0 8px 24px rgba(0, 0, 0, 0.1);
            transition: all 0.4s ease;
            border: 1px solid rgba(0, 0, 0, 0.05);
            position: relative;
        }
        
        .destination-card::after {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            bottom: 0;
            background: linear-gradient(135deg, rgba(102, 126, 234, 0.1) 0%, rgba(118, 75, 162, 0.1) 100%);
            opacity: 0;
            transition: opacity 0.4s ease;
            pointer-events: none;
        }
        
        .destination-card:hover::after {
            opacity: 1;
        }
        
        .destination-card:hover {
            transform: translateY(-12px) scale(1.02);
            box-shadow: 0 20px 48px rgba(0, 0, 0, 0.2);
        }
        
        .destination-card img {
            width: 100%;
            height: 280px;
            object-fit: cover;
            transition: transform 0.4s ease;
        }
        
        .destination-card:hover img {
            transform: scale(1.15);
        }
        
        .destination-content {
            padding: 2rem;
            position: relative;
            z-index: 1;
        }
        
        .destination-content h2 {
            margin: 0 0 0.75rem 0;
            color: #2c3e50;
            font-size: 1.8rem;
            font-weight: 700;
        }
        
        .country {
            color: #666;
            margin: 0.75rem 0;
            font-size: 1.1rem;
            font-weight: 500;
        }
        
        .description {
            color: #555;
            line-height: 1.7;
            margin: 1.5rem 0;
            font-size: 1.05rem;
        }
        
        .destination-links {
            display: flex;
            gap: 0.75rem;
            margin-top: 2rem;
        }
        
        .destination-links .btn {
            flex: 1;
            text-align: center;
            padding: 12px 20px;
            font-size: 0.95rem;
        }
        
        h1 {
            text-align: center;
            font-size: 2.8rem;
            margin: 2rem 0 3rem;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            background-clip: text;
            font-weight: 800;
        }
    </style>
</body>
</html>
