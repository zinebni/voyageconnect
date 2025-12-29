<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Erreur de Réservation - VoyageConnect</title>
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
    <style>
        /* Error Page Styles */
        body {
            background: linear-gradient(135deg, #003580 0%, #0071c2 100%);
            min-height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
            padding: 2rem;
        }
        
        .error-container {
            background: white;
            border-radius: 24px;
            padding: 3rem;
            max-width: 650px;
            width: 100%;
            box-shadow: 0 20px 60px rgba(0, 0, 0, 0.3);
            text-align: center;
            animation: fadeIn 0.6s ease-out;
        }
        
        @keyframes fadeIn {
            from {
                opacity: 0;
                transform: translateY(-20px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }
        
        /* Error Icon */
        .error-icon-wrapper {
            position: relative;
            width: 140px;
            height: 140px;
            margin: 0 auto 2rem;
        }
        
        .error-icon {
            width: 140px;
            height: 140px;
            background: linear-gradient(135deg, #dc3545 0%, #c82333 100%);
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 4rem;
            color: white;
            animation: shake 0.5s ease-in-out, scaleIn 0.5s ease-out;
            box-shadow: 0 10px 30px rgba(220, 53, 69, 0.4);
            position: relative;
        }
        
        .error-icon::before {
            content: '';
            position: absolute;
            width: 160px;
            height: 160px;
            border: 3px solid rgba(220, 53, 69, 0.3);
            border-radius: 50%;
            animation: pulse 2s ease-out infinite;
        }
        
        @keyframes scaleIn {
            from {
                transform: scale(0);
            }
            to {
                transform: scale(1);
            }
        }
        
        @keyframes shake {
            0%, 100% { transform: translateX(0); }
            25% { transform: translateX(-10px) rotate(-5deg); }
            50% { transform: translateX(10px) rotate(5deg); }
            75% { transform: translateX(-10px) rotate(-5deg); }
        }
        
        @keyframes pulse {
            0% {
                transform: scale(1);
                opacity: 1;
            }
            100% {
                transform: scale(1.2);
                opacity: 0;
            }
        }
        
        /* Typography */
        .error-title {
            color: #003580;
            font-size: 2.5rem;
            font-weight: 800;
            margin-bottom: 1rem;
            line-height: 1.2;
        }
        
        .error-subtitle {
            color: #6b7280;
            font-size: 1.125rem;
            margin-bottom: 2rem;
            line-height: 1.7;
        }
        
        /* Error Message Box */
        .error-message-box {
            background: linear-gradient(135deg, #fee2e2 0%, #fecaca 100%);
            border: 2px solid #fca5a5;
            border-left: 4px solid #dc3545;
            padding: 1.5rem;
            margin: 2rem 0;
            text-align: left;
            border-radius: 12px;
            animation: slideDown 0.5s ease-out 0.3s both;
        }
        
        @keyframes slideDown {
            from {
                opacity: 0;
                transform: translateY(-20px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }
        
        .error-message-header {
            display: flex;
            align-items: center;
            gap: 0.75rem;
            margin-bottom: 1rem;
        }
        
        .error-message-header i {
            color: #dc3545;
            font-size: 1.5rem;
        }
        
        .error-message-header strong {
            color: #991b1b;
            font-size: 1.125rem;
        }
        
        .error-message-content {
            color: #7f1d1d;
            line-height: 1.7;
            margin: 0;
            padding-left: 2.25rem;
        }
        
        /* Help Section */
        .help-section {
            background: #f3f4f6;
            border-radius: 12px;
            padding: 1.5rem;
            margin: 2rem 0;
            text-align: left;
        }
        
        .help-title {
            color: #003580;
            font-weight: 700;
            font-size: 1rem;
            margin-bottom: 1rem;
            display: flex;
            align-items: center;
            gap: 0.5rem;
        }
        
        .help-title i {
            color: #0071c2;
        }
        
        .help-list {
            list-style: none;
            padding: 0;
            margin: 0;
        }
        
        .help-list li {
            display: flex;
            align-items: center;
            gap: 0.75rem;
            padding: 0.5rem 0;
            color: #4b5563;
        }
        
        .help-list li i {
            color: #0071c2;
            width: 20px;
            text-align: center;
        }
        
        /* Actions */
        .actions {
            display: flex;
            gap: 1rem;
            justify-content: center;
            flex-wrap: wrap;
            margin-top: 2.5rem;
        }
        
        .btn {
            display: inline-flex;
            align-items: center;
            gap: 0.5rem;
            padding: 0.875rem 1.5rem;
            font-weight: 600;
            border-radius: 8px;
            text-decoration: none;
            transition: all 0.25s ease;
            border: none;
            cursor: pointer;
        }
        
        .btn-highlight {
            background: linear-gradient(135deg, #003580 0%, #0057b8 100%);
            color: white;
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
        }
        
        .btn-highlight:hover {
            background: linear-gradient(135deg, #0071c2 0%, #003580 100%);
            box-shadow: 0 10px 15px rgba(0, 0, 0, 0.2);
            transform: translateY(-2px);
            color: white;
        }
        
        .btn-outline {
            background: white;
            color: #003580;
            border: 2px solid #e5e7eb;
        }
        
        .btn-outline:hover {
            background: #f9fafb;
            border-color: #0071c2;
            color: #0071c2;
        }
        
        /* Support Banner */
        .support-banner {
            background: linear-gradient(135deg, #eff6ff 0%, #dbeafe 100%);
            border: 2px solid #bfdbfe;
            border-radius: 12px;
            padding: 1.25rem;
            margin-top: 2rem;
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 0.75rem;
        }
        
        .support-banner i {
            color: #0071c2;
            font-size: 1.5rem;
        }
        
        .support-banner span {
            color: #1e40af;
            font-weight: 600;
        }
        
        .support-banner a {
            color: #0071c2;
            font-weight: 700;
            text-decoration: underline;
        }
        
        .support-banner a:hover {
            color: #003580;
        }
        
        /* Responsive */
        @media (max-width: 768px) {
            body {
                padding: 1rem;
            }
            
            .error-container {
                padding: 2rem 1.5rem;
            }
            
            .error-title {
                font-size: 2rem;
            }
            
            .error-icon-wrapper {
                width: 100px;
                height: 100px;
            }
            
            .error-icon {
                width: 100px;
                height: 100px;
                font-size: 3rem;
            }
            
            .error-icon::before {
                width: 120px;
                height: 120px;
            }
            
            .actions {
                flex-direction: column;
            }
            
            .actions .btn {
                width: 100%;
                justify-content: center;
            }
            
            .error-message-content {
                padding-left: 0;
            }
        }
    </style>
</head>
<body>
    <div class="error-container">
        <!-- Error Icon -->
        <div class="error-icon-wrapper">
            <div class="error-icon">
                <i class="fas fa-exclamation-triangle"></i>
            </div>
        </div>
        
        <!-- Title -->
        <h1 class="error-title">Oups ! Une erreur est survenue</h1>
        
        <p class="error-subtitle">
            Nous n'avons pas pu traiter votre réservation
        </p>
        
        <!-- Error Message -->
        <div class="error-message-box">
            <div class="error-message-header">
                <i class="fas fa-circle-exclamation"></i>
                <strong>Détails de l'erreur</strong>
            </div>
            <p class="error-message-content">
                <c:choose>
                    <c:when test="${not empty error}">
                        ${error}
                    </c:when>
                    <c:otherwise>
                        Une erreur inattendue s'est produite lors du traitement de votre réservation. 
                        Veuillez réessayer ou contacter notre support si le problème persiste.
                    </c:otherwise>
                </c:choose>
            </p>
        </div>
        
        <!-- Help Section -->
        <div class="help-section">
            <div class="help-title">
                <i class="fas fa-lightbulb"></i>
                Que faire maintenant ?
            </div>
            <ul class="help-list">
                <li>
                    <i class="fas fa-check-circle"></i>
                    <span>Vérifiez votre connexion internet</span>
                </li>
                <li>
                    <i class="fas fa-check-circle"></i>
                    <span>Assurez-vous que les informations saisies sont correctes</span>
                </li>
                <li>
                    <i class="fas fa-check-circle"></i>
                    <span>Vérifiez la disponibilité des places</span>
                </li>
                <li>
                    <i class="fas fa-check-circle"></i>
                    <span>Essayez de rafraîchir la page et réessayez</span>
                </li>
            </ul>
        </div>
        
        <!-- Action Buttons -->
        <div class="actions">
            <button onclick="window.history.back()" class="btn btn-highlight">
                <i class="fas fa-arrow-left"></i> Retour
            </button>
            <a href="${pageContext.request.contextPath}/search/flights" class="btn btn-outline">
                <i class="fas fa-plane"></i> Rechercher des vols
            </a>
            <a href="${pageContext.request.contextPath}/search/hotels" class="btn btn-outline">
                <i class="fas fa-hotel"></i> Rechercher des hôtels
            </a>
        </div>
        
        <!-- Support Banner -->
        <div class="support-banner">
            <i class="fas fa-headset"></i>
            <span>Besoin d'aide ? <a href="${pageContext.request.contextPath}/contact">Contactez notre support</a></span>
        </div>
    </div>
</body>
</html>
