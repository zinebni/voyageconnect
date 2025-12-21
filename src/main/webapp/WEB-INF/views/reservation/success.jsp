<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Réservation Confirmée - VoyageConnect</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
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
        
        .success-container {
            background: white;
            border-radius: 24px;
            box-shadow: 0 20px 60px rgba(0,0,0,0.3);
            padding: 60px;
            max-width: 700px;
            text-align: center;
            animation: slideUp 0.6s ease-out;
        }
        
        @keyframes slideUp {
            from {
                opacity: 0;
                transform: translateY(40px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }
        
        .success-icon {
            width: 120px;
            height: 120px;
            margin: 0 auto 30px;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            animation: scaleIn 0.5s ease-out 0.3s both;
        }
        
        @keyframes scaleIn {
            from {
                transform: scale(0);
            }
            to {
                transform: scale(1);
            }
        }
        
        .success-icon::after {
            content: '✓';
            color: white;
            font-size: 72px;
            font-weight: bold;
        }
        
        h1 {
            color: #2c3e50;
            font-size: 36px;
            margin-bottom: 15px;
        }
        
        .success-message {
            color: #7f8c8d;
            font-size: 18px;
            margin-bottom: 40px;
            line-height: 1.6;
        }
        
        .reservation-details {
            background: #f8f9fa;
            border-radius: 16px;
            padding: 30px;
            margin: 30px 0;
            text-align: left;
        }
        
        .detail-row {
            display: flex;
            justify-content: space-between;
            padding: 15px 0;
            border-bottom: 1px solid #e9ecef;
        }
        
        .detail-row:last-child {
            border-bottom: none;
        }
        
        .detail-label {
            color: #6c757d;
            font-weight: 500;
        }
        
        .detail-value {
            color: #2c3e50;
            font-weight: 600;
        }
        
        .price-highlight {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            background-clip: text;
            font-size: 24px;
        }
        
        .actions {
            display: flex;
            gap: 15px;
            justify-content: center;
            flex-wrap: wrap;
            margin-top: 40px;
        }
        
        .btn {
            padding: 16px 32px;
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
            box-shadow: 0 4px 15px rgba(102, 126, 234, 0.3);
        }
        
        .btn-primary:hover {
            transform: translateY(-2px);
            box-shadow: 0 6px 20px rgba(102, 126, 234, 0.4);
        }
        
        .btn-secondary {
            background: white;
            color: #667eea;
            border: 2px solid #667eea;
        }
        
        .btn-secondary:hover {
            background: #667eea;
            color: white;
        }
        
        .email-notice {
            background: #e3f2fd;
            border-left: 4px solid #2196f3;
            padding: 15px 20px;
            border-radius: 8px;
            margin-top: 30px;
            text-align: left;
        }
        
        .email-notice p {
            color: #1976d2;
            margin: 0;
            display: flex;
            align-items: center;
            gap: 10px;
        }
        
        .email-notice::before {
            content: '📧';
            font-size: 24px;
        }
        
        @media (max-width: 768px) {
            .success-container {
                padding: 40px 30px;
            }
            
            h1 {
                font-size: 28px;
            }
            
            .actions {
                flex-direction: column;
            }
            
            .btn {
                width: 100%;
            }
        }
    </style>
</head>
<body>
    <div class="success-container">
        <div class="success-icon"></div>
        
        <h1>Réservation Confirmée !</h1>
        
        <p class="success-message">
            Félicitations ! Votre réservation a été enregistrée avec succès.<br>
            Un email de confirmation vous a été envoyé.
        </p>
        
        <c:if test="${not empty reservation}">
            <div class="reservation-details">
                <div class="detail-row">
                    <span class="detail-label">Numéro de réservation</span>
                    <span class="detail-value">#${reservation.id}</span>
                </div>
                
                <div class="detail-row">
                    <span class="detail-label">Type</span>
                    <span class="detail-value">
                        <c:choose>
                            <c:when test="${reservation.type == 'FLIGHT'}">Vol ✈️</c:when>
                            <c:when test="${reservation.type == 'HOTEL'}">Hôtel 🏨</c:when>
                            <c:when test="${reservation.type == 'CIRCUIT'}">Circuit 🗺️</c:when>
                        </c:choose>
                    </span>
                </div>
                
                <div class="detail-row">
                    <span class="detail-label">Date de réservation</span>
                    <span class="detail-value">
                        <fmt:formatDate value="${reservation.createdAt}" pattern="dd/MM/yyyy à HH:mm"/>
                    </span>
                </div>
                
                <div class="detail-row">
                    <span class="detail-label">Statut</span>
                    <span class="detail-value">
                        <c:choose>
                            <c:when test="${reservation.status == 'CONFIRMEE'}">✅ Confirmée</c:when>
                            <c:when test="${reservation.status == 'EN_ATTENTE'}">⏳ En attente</c:when>
                            <c:otherwise>${reservation.status}</c:otherwise>
                        </c:choose>
                    </span>
                </div>
                
                <c:if test="${not empty reservation.payment}">
                    <div class="detail-row">
                        <span class="detail-label">Montant total</span>
                        <span class="detail-value price-highlight">
                            <fmt:formatNumber value="${reservation.payment.amount}" type="currency" currencySymbol="MAD"/>
                        </span>
                    </div>
                    
                    <div class="detail-row">
                        <span class="detail-label">Paiement</span>
                        <span class="detail-value">
                            ${reservation.payment.paymentMethod} - ${reservation.payment.status}
                        </span>
                    </div>
                </c:if>
            </div>
        </c:if>
        
        <div class="email-notice">
            <p>Un email de confirmation a été envoyé à votre adresse. Vérifiez également vos spams.</p>
        </div>
        
        <div class="actions">
            <a href="${pageContext.request.contextPath}/reservation/list" class="btn btn-primary">
                📋 Voir mes réservations
            </a>
            <a href="${pageContext.request.contextPath}/user/dashboard" class="btn btn-secondary">
                🏠 Tableau de bord
            </a>
            <a href="${pageContext.request.contextPath}/search/flights" class="btn btn-secondary">
                ✈️ Nouvelle recherche
            </a>
        </div>
    </div>
</body>
</html>
