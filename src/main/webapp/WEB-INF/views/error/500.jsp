<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Erreur serveur - VoyageConnect</title>
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
            color: #e63946;
            margin-bottom: 20px;
        }
        
        h1 {
            color: #e63946;
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
        <div class="error-icon">⚠️</div>
        <div class="error-code">500</div>
        <h1>Erreur serveur</h1>
        
        <div class="error-message">
            <p><strong>Désolé !</strong> Une erreur interne s'est produite sur le serveur.</p>
            <p>Notre équipe technique a été notifiée et travaille à résoudre le problème.</p>
            <p>Veuillez réessayer dans quelques instants.</p>
        </div>
        
        <div class="actions">
            <a href="${pageContext.request.contextPath}/" class="btn btn-primary">
                🏠 Retour à l'accueil
            </a>
            <button onclick="window.location.reload()" class="btn btn-secondary">
                🔄 Réessayer
            </button>
            <button onclick="window.history.back()" class="btn btn-secondary">
                ← Retour
            </button>
        </div>
    </div>
    
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <script src="${pageContext.request.contextPath}/js/main.js"></script>
</body>
</html>
