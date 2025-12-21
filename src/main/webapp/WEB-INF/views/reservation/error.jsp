<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Erreur de Réservation - VoyageConnect</title>
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }
        
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            min-height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
            padding: 20px;
        }
        
        .error-container {
            background: white;
            border-radius: 20px;
            box-shadow: 0 20px 60px rgba(0,0,0,0.3);
            padding: 50px;
            max-width: 600px;
            text-align: center;
            animation: slideUp 0.5s ease-out;
        }
        
        @keyframes slideUp {
            from {
                opacity: 0;
                transform: translateY(30px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }
        
        .error-icon {
            font-size: 80px;
            color: #e74c3c;
            margin-bottom: 20px;
            animation: shake 0.5s ease-in-out;
        }
        
        @keyframes shake {
            0%, 100% { transform: translateX(0); }
            25% { transform: translateX(-10px); }
            75% { transform: translateX(10px); }
        }
        
        h1 {
            color: #2c3e50;
            font-size: 32px;
            margin-bottom: 20px;
        }
        
        .error-message {
            background: #fee;
            border-left: 4px solid #e74c3c;
            padding: 20px;
            margin: 30px 0;
            text-align: left;
            border-radius: 5px;
        }
        
        .error-message strong {
            color: #c0392b;
            display: block;
            margin-bottom: 10px;
            font-size: 18px;
        }
        
        .error-message p {
            color: #555;
            line-height: 1.6;
        }
        
        .actions {
            display: flex;
            gap: 15px;
            justify-content: center;
            flex-wrap: wrap;
            margin-top: 30px;
        }
        
        .btn {
            padding: 15px 30px;
            border: none;
            border-radius: 50px;
            font-size: 16px;
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
            box-shadow: 0 10px 20px rgba(102, 126, 234, 0.3);
        }
        
        .btn-secondary {
            background: #ecf0f1;
            color: #2c3e50;
        }
        
        .btn-secondary:hover {
            background: #bdc3c7;
        }
        
        .help-text {
            margin-top: 30px;
            color: #7f8c8d;
            font-size: 14px;
        }
        
        .debug-info {
            background: #f8f9fa;
            border: 1px solid #dee2e6;
            border-radius: 5px;
            padding: 15px;
            margin-top: 20px;
            text-align: left;
            font-family: 'Courier New', monospace;
            font-size: 12px;
            color: #495057;
        }
        
        .debug-info strong {
            display: block;
            margin-bottom: 5px;
            color: #212529;
        }
    </style>
</head>
<body>
    <div class="error-container">
        <div class="error-icon">⚠️</div>
        <h1>Erreur de Réservation</h1>
        
        <div class="error-message">
            <strong>Impossible de traiter votre demande</strong>
            <p>
                <c:choose>
                    <c:when test="${not empty error}">
                        ${error}
                    </c:when>
                    <c:otherwise>
                        Une erreur inattendue s'est produite lors du traitement de votre réservation.
                    </c:otherwise>
                </c:choose>
            </p>
        </div>
        
        <c:if test="${not empty param.type && not empty param.id}">
            <div class="debug-info">
                <strong>Informations de la demande :</strong>
                Type : ${param.type}<br>
                ID : ${param.id}
            </div>
        </c:if>
        
        <div class="actions">
            <a href="${pageContext.request.contextPath}/search/flights" class="btn btn-primary">
                🔍 Rechercher des vols
            </a>
            <a href="${pageContext.request.contextPath}/search/hotels" class="btn btn-secondary">
                🏨 Rechercher des hôtels
            </a>
            <button onclick="window.history.back()" class="btn btn-secondary">
                ← Retour
            </button>
        </div>
        
        <p class="help-text">
            Besoin d'aide ? Contactez notre service client au 
            <strong>+212 5 XX XX XX XX</strong>
        </p>
    </div>
</body>
</html>
