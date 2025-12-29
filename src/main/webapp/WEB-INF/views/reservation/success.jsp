<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Réservation Confirmée - VoyageConnect</title>
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
    <style>
        /* Success Page Styles */
        body {
            background: linear-gradient(135deg, #003580 0%, #0071c2 100%);
            min-height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
            padding: 2rem;
        }
        
        .success-container {
            background: white;
            border-radius: 24px;
            padding: 3rem;
            max-width: 700px;
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
        
        /* Success Icon */
        .success-icon-wrapper {
            position: relative;
            width: 140px;
            height: 140px;
            margin: 0 auto 2rem;
        }
        
        .success-icon {
            width: 140px;
            height: 140px;
            background: linear-gradient(135deg, #00aa6c 0%, #00d084 100%);
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 4rem;
            color: white;
            animation: scaleIn 0.5s ease-out 0.3s both;
            box-shadow: 0 10px 30px rgba(0, 170, 108, 0.4);
            position: relative;
        }
        
        .success-icon::before {
            content: '';
            position: absolute;
            width: 160px;
            height: 160px;
            border: 3px solid rgba(0, 170, 108, 0.3);
            border-radius: 50%;
            animation: pulse 2s ease-out infinite;
        }
        
        @keyframes scaleIn {
            from {
                transform: scale(0) rotate(-180deg);
            }
            to {
                transform: scale(1) rotate(0deg);
            }
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
        .success-title {
            color: #003580;
            font-size: 2.5rem;
            font-weight: 800;
            margin-bottom: 1rem;
            line-height: 1.2;
        }
        
        .success-message {
            color: #6b7280;
            font-size: 1.125rem;
            margin-bottom: 2.5rem;
            line-height: 1.7;
        }
        
        /* Reservation Details Card */
        .reservation-details {
            background: #f9fafb;
            border-radius: 16px;
            padding: 2rem;
            margin: 2rem 0;
            text-align: left;
            border: 1px solid #e5e7eb;
        }
        
        .details-header {
            display: flex;
            align-items: center;
            gap: 0.75rem;
            margin-bottom: 1.5rem;
            padding-bottom: 1rem;
            border-bottom: 2px solid #e5e7eb;
        }
        
        .details-header i {
            font-size: 1.5rem;
            color: #0071c2;
        }
        
        .details-header h3 {
            color: #003580;
            font-weight: 700;
            font-size: 1.25rem;
            margin: 0;
        }
        
        .detail-row {
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 1rem 0;
            border-bottom: 1px solid #e5e7eb;
            gap: 1rem;
        }
        
        .detail-row:last-child {
            border-bottom: none;
            padding-bottom: 0;
        }
        
        .detail-label {
            display: flex;
            align-items: center;
            gap: 0.5rem;
            color: #6b7280;
            font-weight: 600;
            font-size: 0.95rem;
        }
        
        .detail-label i {
            color: #0071c2;
            width: 20px;
            text-align: center;
        }
        
        .detail-value {
            color: #1a1a1a;
            font-weight: 700;
            font-size: 1rem;
            text-align: right;
        }
        
        .reservation-id {
            background: linear-gradient(135deg, #003580 0%, #0071c2 100%);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            background-clip: text;
            font-size: 1.5rem;
            font-weight: 800;
        }
        
        .type-badge {
            display: inline-flex;
            align-items: center;
            gap: 0.5rem;
            padding: 0.5rem 1rem;
            border-radius: 9999px;
            font-weight: 600;
            font-size: 0.9rem;
        }
        
        .type-badge.flight {
            background: linear-gradient(135deg, #dbeafe 0%, #bfdbfe 100%);
            color: #1d4ed8;
        }
        
        .type-badge.hotel {
            background: linear-gradient(135deg, #dcfce7 0%, #bbf7d0 100%);
            color: #15803d;
        }
        
        .type-badge.circuit {
            background: linear-gradient(135deg, #fef3c7 0%, #fde68a 100%);
            color: #a16207;
        }
        
        .status-badge {
            display: inline-flex;
            align-items: center;
            gap: 0.5rem;
            padding: 0.5rem 1rem;
            border-radius: 9999px;
            font-weight: 600;
            font-size: 0.9rem;
        }
        
        .status-badge.confirmed {
            background: #dcfce7;
            color: #15803d;
        }
        
        .status-badge.pending {
            background: #fef3c7;
            color: #a16207;
        }
        
        .price-highlight {
            background: linear-gradient(135deg, rgba(0, 170, 108, 0.1) 0%, rgba(0, 170, 108, 0.2) 100%);
            border: 2px solid rgba(0, 170, 108, 0.3);
            border-radius: 12px;
            padding: 1.5rem;
            margin-top: 1rem;
            text-align: center;
        }
        
        .price-label {
            color: #6b7280;
            font-size: 0.875rem;
            font-weight: 600;
            margin-bottom: 0.5rem;
        }
        
        .price-amount {
            color: #00aa6c;
            font-size: 2.5rem;
            font-weight: 800;
            line-height: 1;
        }
        
        /* Email Notice */
        .email-notice {
            background: linear-gradient(135deg, #eff6ff 0%, #dbeafe 100%);
            border: 2px solid #bfdbfe;
            border-left: 4px solid #0071c2;
            padding: 1.25rem 1.5rem;
            border-radius: 12px;
            margin-top: 2rem;
            text-align: left;
            display: flex;
            align-items: flex-start;
            gap: 1rem;
        }
        
        .email-notice i {
            color: #0071c2;
            font-size: 1.5rem;
            flex-shrink: 0;
            margin-top: 0.125rem;
        }
        
        .email-notice p {
            margin: 0;
            color: #1e40af;
            font-weight: 500;
            line-height: 1.6;
        }
        
        /* Celebration Banner */
        .celebration-banner {
            background: linear-gradient(135deg, #fef3c7 0%, #fde68a 100%);
            border: 2px solid #fde68a;
            border-radius: 12px;
            padding: 1.25rem;
            margin-bottom: 2rem;
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 0.75rem;
            animation: slideDown 0.5s ease-out 0.6s both;
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
        
        .celebration-banner i {
            color: #d97706;
            font-size: 1.5rem;
        }
        
        .celebration-banner span {
            color: #92400e;
            font-weight: 700;
            font-size: 1.125rem;
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
        
        /* Confetti Animation */
        .confetti {
            position: fixed;
            width: 10px;
            height: 10px;
            background: #febb02;
            position: absolute;
            animation: confetti-fall 3s linear;
        }
        
        @keyframes confetti-fall {
            to {
                transform: translateY(100vh) rotate(360deg);
                opacity: 0;
            }
        }
        
        /* Responsive */
        @media (max-width: 768px) {
            body {
                padding: 1rem;
            }
            
            .success-container {
                padding: 2rem 1.5rem;
            }
            
            .success-title {
                font-size: 2rem;
            }
            
            .success-icon-wrapper {
                width: 100px;
                height: 100px;
            }
            
            .success-icon {
                width: 100px;
                height: 100px;
                font-size: 3rem;
            }
            
            .success-icon::before {
                width: 120px;
                height: 120px;
            }
            
            .detail-row {
                flex-direction: column;
                align-items: flex-start;
                gap: 0.5rem;
            }
            
            .detail-value {
                text-align: left;
            }
            
            .actions {
                flex-direction: column;
            }
            
            .actions .btn {
                width: 100%;
                justify-content: center;
            }
            
            .price-amount {
                font-size: 2rem;
            }
        }
    </style>
</head>
<body>
    <div class="success-container">
        <!-- Success Icon -->
        <div class="success-icon-wrapper">
            <div class="success-icon">
                <i class="fas fa-check"></i>
            </div>
        </div>
        
        <!-- Celebration Banner -->
        <div class="celebration-banner">
            <i class="fas fa-party-horn"></i>
            <span>Félicitations ! Votre voyage commence ici</span>
            <i class="fas fa-champagne-glasses"></i>
        </div>
        
        <!-- Title and Message -->
        <h1 class="success-title">Réservation Confirmée !</h1>
        
        <p class="success-message">
            Votre réservation a été enregistrée avec succès.<br>
            Préparez-vous pour une expérience inoubliable !
        </p>
        
        <!-- Reservation Details -->
        <c:if test="${not empty reservation}">
            <div class="reservation-details">
                <div class="details-header">
                    <i class="fas fa-clipboard-check"></i>
                    <h3>Détails de votre réservation</h3>
                </div>
                
                <div class="detail-row">
                    <span class="detail-label">
                        <i class="fas fa-hashtag"></i>
                        Numéro de réservation
                    </span>
                    <span class="detail-value reservation-id">#${reservation.id}</span>
                </div>
                
                <div class="detail-row">
                    <span class="detail-label">
                        <i class="fas fa-tag"></i>
                        Type de réservation
                    </span>
                    <span class="detail-value">
                        <c:choose>
                            <c:when test="${reservation.type == 'FLIGHT'}">
                                <span class="type-badge flight">
                                    <i class="fas fa-plane"></i> Vol
                                </span>
                            </c:when>
                            <c:when test="${reservation.type == 'HOTEL'}">
                                <span class="type-badge hotel">
                                    <i class="fas fa-hotel"></i> Hôtel
                                </span>
                            </c:when>
                            <c:when test="${reservation.type == 'CIRCUIT'}">
                                <span class="type-badge circuit">
                                    <i class="fas fa-route"></i> Circuit
                                </span>
                            </c:when>
                        </c:choose>
                    </span>
                </div>
                
                <div class="detail-row">
                    <span class="detail-label">
                        <i class="fas fa-calendar-alt"></i>
                        Date de réservation
                    </span>
                    <span class="detail-value">
                        <fmt:formatDate value="${reservation.createdAt}" pattern="dd/MM/yyyy 'à' HH:mm"/>
                    </span>
                </div>
                
                <div class="detail-row">
                    <span class="detail-label">
                        <i class="fas fa-info-circle"></i>
                        Statut
                    </span>
                    <span class="detail-value">
                        <c:choose>
                            <c:when test="${reservation.status == 'CONFIRMEE'}">
                                <span class="status-badge confirmed">
                                    <i class="fas fa-check-circle"></i> Confirmée
                                </span>
                            </c:when>
                            <c:when test="${reservation.status == 'EN_ATTENTE'}">
                                <span class="status-badge pending">
                                    <i class="fas fa-clock"></i> En attente
                                </span>
                            </c:when>
                            <c:otherwise>
                                ${reservation.status}
                            </c:otherwise>
                        </c:choose>
                    </span>
                </div>
                
                <c:if test="${not empty reservation.payment}">
                    <div class="price-highlight">
                        <div class="price-label">
                            <i class="fas fa-credit-card"></i> Montant total payé
                        </div>
                        <div class="price-amount">
                            <fmt:formatNumber value="${reservation.payment.amount}" type="currency" currencySymbol="€"/>
                        </div>
                    </div>
                </c:if>
            </div>
        </c:if>
        
        <!-- Email Notice -->
        <div class="email-notice">
            <i class="fas fa-envelope-circle-check"></i>
            <div>
                <p>
                    <strong>Email de confirmation envoyé !</strong><br>
                    Un récapitulatif détaillé a été envoyé à votre adresse email. 
                    Pensez à vérifier vos courriers indésirables si vous ne le trouvez pas.
                </p>
            </div>
        </div>
        
        <!-- Action Buttons -->
        <div class="actions">
            <a href="${pageContext.request.contextPath}/reservation/list" class="btn btn-highlight">
                <i class="fas fa-list"></i> Voir mes réservations
            </a>
            <a href="${pageContext.request.contextPath}/user/dashboard" class="btn btn-outline">
                <i class="fas fa-home"></i> Tableau de bord
            </a>
            <a href="${pageContext.request.contextPath}/search/flights" class="btn btn-outline">
                <i class="fas fa-search"></i> Nouvelle recherche
            </a>
        </div>
    </div>
    
    <script>
        // Simple confetti effect
        function createConfetti() {
            const colors = ['#febb02', '#0071c2', '#00aa6c', '#dc3545'];
            for (let i = 0; i < 50; i++) {
                setTimeout(() => {
                    const confetti = document.createElement('div');
                    confetti.className = 'confetti';
                    confetti.style.left = Math.random() * 100 + '%';
                    confetti.style.background = colors[Math.floor(Math.random() * colors.length)];
                    confetti.style.animationDelay = Math.random() * 0.5 + 's';
                    document.body.appendChild(confetti);
                    
                    setTimeout(() => confetti.remove(), 3000);
                }, i * 30);
            }
        }
        
        // Launch confetti on page load
        window.addEventListener('load', () => {
            setTimeout(createConfetti, 500);
        });
    </script>
</body>
</html>
