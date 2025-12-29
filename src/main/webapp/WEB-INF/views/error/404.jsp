<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Page non trouvée - VoyageConnect</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
    <style>
        body {
            background: linear-gradient(135deg, #003580 0%, #0071c2 100%);
            min-height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
            padding: 20px;
        }
        
        .error-container {
            background: white;
            border-radius: 24px;
            padding: 60px;
            max-width: 600px;
            width: 100%;
            box-shadow: 0 20px 60px rgba(0, 0, 0, 0.3);
            text-align: center;
            animation: fadeIn 0.6s ease-out;
        }
        
        .error-icon {
            font-size: 120px;
            margin-bottom: 20px;
            animation: scaleIn 0.5s ease-out 0.2s both;
        }
        
        @keyframes scaleIn {
            from { transform: scale(0); }
            to { transform: scale(1); }
        }
        
        .error-code {
            font-size: 6rem;
            font-weight: 800;
            background: linear-gradient(135deg, #003580 0%, #0071c2 100%);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            background-clip: text;
            margin-bottom: 20px;
        }
        
        h1 {
            color: #003580;
            font-size: 2rem;
            font-weight: 800;
            margin-bottom: 15px;
        }
        
        .error-message {
            color: #4a5568;
            font-size: 1.1rem;
            margin-bottom: 30px;
            line-height: 1.6;
        }
        
        .actions {
            display: flex;
            gap: 15px;
            justify-content: center;
            flex-wrap: wrap;
        }
    </style>
</head>
<body>
    <div class="error-container">
        <div class="error-icon">🔍</div>
        <div class="error-code">404</div>
        <h1>Page non trouvée</h1>
        
        <div class="error-message">
            <p><strong>Oups !</strong> La page que vous recherchez n'existe pas ou a été déplacée.</p>
            <p>Il se peut que l'URL soit incorrecte ou que la page ait été supprimée.</p>
        </div>
        
        <div class="actions">
            <a href="${pageContext.request.contextPath}/" class="btn btn-primary">
                🏠 Accueil
            </a>
            <a href="${pageContext.request.contextPath}/search/flights" class="btn btn-secondary">
                ✈️ Rechercher des vols
            </a>
            <button onclick="window.history.back()" class="btn btn-secondary">
                ← Retour
            </button>
        </div>
    </div>
    
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <script src="${pageContext.request.contextPath}/js/main.js"></script>
</body>
</html>
