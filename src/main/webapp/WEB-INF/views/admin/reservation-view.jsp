<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.time.format.DateTimeFormatter" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Détails Réservation (Admin) - VoyageConnect</title>
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">
    <style>
        :root {
            --vc-primary: #003580;
            --vc-accent: #0071c2;
            --vc-bg: #f5f7fa;
            --vc-bg-light: #ffffff;
            --vc-text: #1a1a1a;
            --vc-text-light: #6b7280;
            --vc-border: #e5e7eb;
            --vc-border-light: #f3f4f6;
            --vc-success: #00aa6c;
            --vc-warning: #febb02;
            --vc-danger: #dc3545;
            --shadow-md: 0 4px 6px -1px rgba(0, 0, 0, 0.1);
            --shadow-xl: 0 20px 25px -5px rgba(0, 0, 0, 0.1);
            --radius-md: 8px;
            --radius-lg: 12px;
            --radius-xl: 16px;
            --radius-full: 9999px;
            --transition-base: 250ms cubic-bezier(0.4, 0, 0.2, 1);
            --gradient-primary: linear-gradient(135deg, #003580 0%, #0057b8 100%);
            --gradient-admin: linear-gradient(135deg, #003580 0%, #003580 100%);
        }
        
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }
        
        body {
            font-family: -apple-system, BlinkMacSystemFont, "Segoe UI", Roboto, "Helvetica Neue", Arial, sans-serif;
            background: var(--vc-bg);
            color: var(--vc-text);
            line-height: 1.6;
            font-size: 16px;
            overflow-x: hidden;
            -webkit-font-smoothing: antialiased;
        }
        
        .page-wrapper {
            min-height: 100vh;
            display: flex;
            flex-direction: column;
        }
        
        .container {
            max-width: 1200px;
            margin: 0 auto;
            padding: 0 1.5rem;
        }
                /*actions rapides*/
         /* Section Cards */
        .section-card {
            background: white;
            border-radius: 16px;
            padding: 2rem;
            box-shadow: 0 2px 8px rgba(0, 0, 0, 0.08);
            margin-bottom: 2rem;
            border: 1px solid #e5e7eb;
        }
        
        .section-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 1.5rem;
            padding-bottom: 1rem;
            border-bottom: 2px solid #f3f4f6;
        }
        
        .section-title {
            color: #003580;
            font-weight: 700;
            font-size: 1.5rem;
            margin: 0;
            display: flex;
            align-items: center;
            gap: 0.75rem;
        }
        
        .section-title i {
            color: #0071c2;
            font-size: 1.75rem;
        }
                
        /* Quick Actions */
        .quick-actions-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
            gap: 1rem;
        }
        
        .action-btn {
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 0.5rem;
            padding: 1rem 1.5rem;
            background: linear-gradient(135deg, #003580 0%, #0057b8 100%);
            color: white;
            text-decoration: none;
            border-radius: 8px;
            font-weight: 600;
            transition: all 0.25s ease;
            box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
        }
        
        .action-btn:hover {
            background: linear-gradient(135deg, #0071c2 0%, #003580 100%);
            transform: translateY(-2px);
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.15);
            color: white;
        }
        
        .action-btn i {
            font-size: 1.25rem;
        }
        /* Navbar */
        .navbar-modern {
            background: var(--vc-bg-light);
            box-shadow: var(--shadow-md);
            position: sticky;
            top: 0;
            z-index: 1000;
            border-bottom: 1px solid var(--vc-border);
        }

        .navbar-wrapper {
            display: flex;
            align-items: center;
            justify-content: space-between;
            padding: 1rem 0;
            gap: 2rem;
        }

        .navbar-brand {
            display: flex;
            align-items: center;
            gap: 0.5rem;
            font-size: 1.5rem;
            font-weight: 700;
            color: var(--vc-primary);
            text-decoration: none;
            transition: color var(--transition-base);
        }

        .navbar-brand:hover {
            color: var(--vc-accent);
        }

        .navbar-main {
            display: flex;
            align-items: center;
            gap: 0.5rem;
            flex: 1;
            justify-content: center;
        }

        .navbar-main .nav-link {
            display: flex;
            align-items: center;
            gap: 0.5rem;
            padding: 0.625rem 1rem;
            color: var(--vc-text);
            text-decoration: none;
            font-weight: 500;
            border-radius: var(--radius-md);
            transition: all var(--transition-base);
        }

        .navbar-main .nav-link:hover {
            color: var(--vc-accent);
            background: var(--vc-border-light);
        }

        .navbar-user {
            display: flex;
            align-items: center;
            gap: 0.75rem;
        }

        .user-dropdown {
            position: relative;
        }

        .user-toggle {
            display: flex;
            align-items: center;
            gap: 0.5rem;
            padding: 0.625rem 1rem;
            background: transparent;
            border: 2px solid var(--vc-border);
            border-radius: var(--radius-full);
            color: var(--vc-text);
            font-weight: 500;
            cursor: pointer;
            transition: all var(--transition-base);
        }

        .user-toggle:hover {
            border-color: var(--vc-accent);
            background: var(--vc-border-light);
        }

        .user-toggle i.fas.fa-user-circle {
            font-size: 1.5rem;
            color: var(--vc-accent);
        }

        .user-menu {
            position: absolute;
            top: calc(100% + 0.5rem);
            right: 0;
            min-width: 280px;
            background: var(--vc-bg-light);
            border-radius: var(--radius-lg);
            box-shadow: var(--shadow-xl);
            border: 1px solid var(--vc-border);
            opacity: 0;
            visibility: hidden;
            transform: translateY(-10px);
            transition: all var(--transition-base);
        }

        .user-menu.show {
            opacity: 1;
            visibility: visible;
            transform: translateY(0);
        }

        .user-menu-header {
            display: flex;
            align-items: center;
            gap: 0.75rem;
            padding: 1rem;
            background: var(--vc-border-light);
            border-radius: var(--radius-lg) var(--radius-lg) 0 0;
        }

        .user-menu-header i {
            font-size: 2.5rem;
            color: var(--vc-accent);
        }

        .user-menu-item {
            display: flex;
            align-items: center;
            gap: 0.75rem;
            padding: 0.75rem 1rem;
            color: var(--vc-text);
            text-decoration: none;
            transition: all var(--transition-base);
        }

        .user-menu-item:hover {
            background: var(--vc-border-light);
            color: var(--vc-accent);
        }

        .user-menu-item.logout {
            color: var(--vc-danger);
        }

        .user-menu-divider {
            height: 1px;
            background: var(--vc-border);
            margin: 0.5rem 0;
        }

        /* Page Header - Admin Style */
        .page-header {
            background: var(--gradient-admin);
            padding: 2.5rem 0;
            text-align: center;
            margin-bottom: 2rem;
            box-shadow: var(--shadow-md);
        }
        
        .page-header h1 {
            color: #ffffff;
            font-size: 2rem;
            font-weight: 800;
            margin-bottom: 0.5rem;
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 0.75rem;
        }
        
        .page-header .subtitle {
            color: rgba(255, 255, 255, 0.85);
            font-size: 1rem;
        }

        .admin-badge {
            display: inline-flex;
            align-items: center;
            gap: 0.5rem;
            background: rgba(254, 187, 2, 0.2);
            color: #febb02;
            padding: 0.5rem 1rem;
            border-radius: var(--radius-full);
            font-weight: 600;
            font-size: 0.875rem;
            margin-top: 1rem;
        }

        /* Back Button */
        .back-button-container {
            margin-bottom: 1.5rem;
        }

        .btn-back {
            display: inline-flex;
            align-items: center;
            gap: 0.5rem;
            padding: 0.75rem 1.25rem;
            background: var(--vc-bg-light);
            border: 2px solid var(--vc-border);
            color: var(--vc-text);
            text-decoration: none;
            border-radius: var(--radius-md);
            font-weight: 600;
            transition: all var(--transition-base);
        }

        .btn-back:hover {
            border-color: var(--vc-accent);
            color: var(--vc-accent);
            transform: translateX(-4px);
        }

        /* Alerts */
        .alert {
            padding: 1rem 1.5rem;
            border-radius: var(--radius-lg);
            margin-bottom: 1.5rem;
            display: flex;
            align-items: center;
            gap: 0.75rem;
        }

        .alert-success {
            background: #d4edda;
            color: #155724;
            border: 1px solid #c3e6cb;
        }

        .alert-danger {
            background: #f8d7da;
            color: #721c24;
            border: 1px solid #f5c6cb;
        }

        .alert-warning {
            background: #fff3cd;
            color: #856404;
            border: 1px solid #ffeeba;
        }

        .alert-info {
            background: #d1ecf1;
            color: #0c5460;
            border: 1px solid #bee5eb;
        }

        .alert button {
            margin-left: auto;
            background: none;
            border: none;
            cursor: pointer;
            font-size: 1.25rem;
            opacity: 0.7;
        }

        /* Reservation Card */
        .reservation-card {
            background: var(--vc-bg-light);
            border-radius: var(--radius-xl);
            box-shadow: var(--shadow-md);
            overflow: hidden;
            margin-bottom: 2rem;
        }

        .card-header {
            background: var(--gradient-admin);
            padding: 2rem;
            color: #ffffff;
        }

        .reservation-number {
            display: flex;
            align-items: center;
            gap: 0.75rem;
            font-size: 1.5rem;
            font-weight: 700;
            margin-bottom: 1rem;
        }

        .reservation-meta {
            display: flex;
            flex-wrap: wrap;
            gap: 1.5rem;
        }

        .meta-item {
            display: flex;
            align-items: center;
            gap: 0.5rem;
            font-size: 0.9rem;
            color: rgba(255, 255, 255, 0.9);
        }

        /* Customer Info Box */
        .customer-info-box {
            background: rgba(255, 255, 255, 0.1);
            border-radius: var(--radius-md);
            padding: 1rem 1.5rem;
            margin-top: 1.5rem;
        }

        .customer-info-box h3 {
            font-size: 0.85rem;
            text-transform: uppercase;
            letter-spacing: 0.5px;
            margin-bottom: 0.75rem;
            opacity: 0.8;
        }

        .customer-details {
            display: flex;
            flex-wrap: wrap;
            gap: 1.5rem;
        }

        .customer-detail {
            display: flex;
            align-items: center;
            gap: 0.5rem;
        }

        /* Status Badge */
        .status-badge {
            display: inline-flex;
            align-items: center;
            gap: 0.5rem;
            padding: 0.5rem 1rem;
            border-radius: var(--radius-full);
            font-weight: 600;
            font-size: 0.875rem;
        }

        .status-EN_ATTENTE {
            background: rgba(254, 187, 2, 0.2);
            color: #febb02;
        }

        .status-CONFIRMEE {
            background: rgba(0, 170, 108, 0.2);
            color: #00aa6c;
        }

        .status-ANNULEE {
            background: rgba(220, 53, 69, 0.2);
            color: #dc3545;
        }

        /* Card Body */
        .card-body {
            padding: 2rem;
        }

        .section-title {
            display: flex;
            align-items: center;
            gap: 0.75rem;
            font-size: 1.25rem;
            font-weight: 700;
            color: var(--vc-primary);
            margin-bottom: 1.5rem;
            padding-bottom: 0.75rem;
            border-bottom: 2px solid var(--vc-border-light);
        }

        /* Details Grid */
        .details-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
            gap: 1.5rem;
            margin-bottom: 2rem;
        }

        .detail-item {
            display: flex;
            flex-direction: column;
            gap: 0.25rem;
        }

        .detail-label {
            display: flex;
            align-items: center;
            gap: 0.5rem;
            font-size: 0.85rem;
            color: var(--vc-text-light);
            font-weight: 500;
        }

        .detail-value {
            font-size: 1rem;
            font-weight: 600;
            color: var(--vc-text);
        }

        .detail-value.large {
            font-size: 1.5rem;
            color: var(--vc-success);
        }

        /* Product Card */
        .product-card {
            background: var(--vc-border-light);
            border-radius: var(--radius-lg);
            padding: 1.5rem;
            margin-bottom: 2rem;
        }

        .product-header {
            display: flex;
            align-items: center;
            gap: 1rem;
            margin-bottom: 1.5rem;
        }

        .product-icon {
            width: 60px;
            height: 60px;
            background: var(--gradient-primary);
            border-radius: var(--radius-md);
            display: flex;
            align-items: center;
            justify-content: center;
            color: #ffffff;
            font-size: 1.5rem;
        }

        .product-info h3 {
            font-size: 1.25rem;
            font-weight: 700;
            color: var(--vc-text);
        }

        .product-info p {
            color: var(--vc-text-light);
            font-size: 0.9rem;
        }

        .product-details {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(180px, 1fr));
            gap: 1rem;
        }

        /* Admin Action Buttons */
        .admin-actions {
            background: var(--vc-border-light);
            border-radius: var(--radius-lg);
            padding: 2rem;
            margin-top: 2rem;
        }

        .admin-actions h3 {
            display: flex;
            align-items: center;
            gap: 0.5rem;
            font-size: 1.1rem;
            font-weight: 700;
            margin-bottom: 1.5rem;
            color: var(--vc-primary);
        }

        .action-buttons {
            display: flex;
            flex-wrap: wrap;
            gap: 1rem;
            align-items: center;
        }

        .btn {
            display: inline-flex;
            align-items: center;
            justify-content: center;
            gap: 0.5rem;
            padding: 0.875rem 1.5rem;
            font-size: 0.95rem;
            font-weight: 600;
            text-decoration: none;
            border: none;
            border-radius: var(--radius-md);
            cursor: pointer;
            transition: all var(--transition-base);
        }

        .btn-confirm {
            background: linear-gradient(135deg, #00aa6c 0%, #00c97b 100%);
            color: #ffffff;
            box-shadow: 0 4px 12px rgba(0, 170, 108, 0.3);
        }

        .btn-confirm:hover {
            transform: translateY(-2px);
            box-shadow: 0 6px 20px rgba(0, 170, 108, 0.4);
        }

        .btn-cancel {
            background: linear-gradient(135deg, #dc3545 0%, #e74c5e 100%);
            color: #ffffff;
            box-shadow: 0 4px 12px rgba(220, 53, 69, 0.3);
        }

        .btn-cancel:hover {
            transform: translateY(-2px);
            box-shadow: 0 6px 20px rgba(220, 53, 69, 0.4);
        }

        .btn-outline {
            background: transparent;
            border: 2px solid var(--vc-border);
            color: var(--vc-text);
        }

        .btn-outline:hover {
            border-color: var(--vc-accent);
            color: var(--vc-accent);
        }

        .btn-print {
            background: var(--gradient-primary);
            color: #ffffff;
        }

        .btn-print:hover {
            transform: translateY(-2px);
            box-shadow: 0 6px 20px rgba(0, 53, 128, 0.3);
        }

        .status-message {
            display: flex;
            align-items: center;
            gap: 0.5rem;
            padding: 0.75rem 1.25rem;
            border-radius: var(--radius-md);
            font-weight: 600;
        }

        .status-confirmed {
            background: rgba(0, 170, 108, 0.1);
            color: var(--vc-success);
        }

        .status-cancelled {
            background: rgba(220, 53, 69, 0.1);
            color: var(--vc-danger);
        }

        /* Responsive */
        @media (max-width: 768px) {
            .page-header h1 {
                font-size: 1.5rem;
            }

            .card-header {
                padding: 1.5rem;
            }

            .reservation-number {
                font-size: 1.25rem;
            }

            .reservation-meta {
                flex-direction: column;
                gap: 0.75rem;
            }

            .card-body {
                padding: 1.5rem;
            }

            .details-grid {
                grid-template-columns: 1fr;
            }

            .action-buttons {
                flex-direction: column;
                gap: 1rem;
            }

            .btn {
                width: 100%;
            }
        }

        @media print {
            .navbar-modern,
            .back-button-container,
            .admin-actions,
            .alert {
                display: none !important;
            }

            .page-header {
                background: #1a1a2e !important;
                -webkit-print-color-adjust: exact;
                print-color-adjust: exact;
            }

            .reservation-card {
                box-shadow: none;
                border: 1px solid #ddd;
            }
        }
    </style>
</head>
<body class="page-wrapper">
    <!-- Navbar -->
    <nav class="navbar-modern">
        <div class="container">
            <div class="navbar-wrapper">
                <a href="${pageContext.request.contextPath}/" class="navbar-brand">
                    <i class="fas fa-plane-departure"></i>
                    <span>VoyageConnect</span>
                </a>
                
                <div class="navbar-main">
                    <a href="${pageContext.request.contextPath}/admin/dashboard" class="nav-link">
                        <i class="fas fa-chart-line"></i>
                        <span>Dashboard</span>
                    </a>
                    <a href="${pageContext.request.contextPath}/admin/destinations" class="nav-link">
                        <i class="fas fa-map-marked-alt"></i>
                        <span>Destinations</span>
                    </a>
                    <a href="${pageContext.request.contextPath}/admin/flights" class="nav-link">
                        <i class="fas fa-plane"></i>
                        <span>Vols</span>
                    </a>
                    <a href="${pageContext.request.contextPath}/admin/hotels" class="nav-link">
                        <i class="fas fa-hotel"></i>
                        <span>Hôtels</span>
                    </a>
                </div>
                
                <div class="navbar-user">
                    <c:if test="${not empty sessionScope.user}">
                        <div class="user-dropdown">
                            <button class="user-toggle" id="userMenuToggle">
                                <i class="fas fa-user-circle"></i>
                                <span>${sessionScope.user.firstName}</span>
                                <i class="fas fa-chevron-down"></i>
                            </button>
                            <div class="user-menu" id="userMenu">
                                <div class="user-menu-header">
                                    <i class="fas fa-user-circle"></i>
                                    <div>
                                        <strong>${sessionScope.user.firstName} ${sessionScope.user.lastName}</strong>
                                        <small>${sessionScope.user.email}</small>
                                    </div>
                                </div>
                                <div class="user-menu-divider"></div>
                                <a href="${pageContext.request.contextPath}/admin/dashboard" class="user-menu-item">
                                    <i class="fas fa-crown"></i>
                                    <span>Administration</span>
                                </a>
                                <div class="user-menu-divider"></div>
                                <a href="${pageContext.request.contextPath}/auth/logout" class="user-menu-item logout">
                                    <i class="fas fa-sign-out-alt"></i>
                                    <span>Déconnexion</span>
                                </a>
                            </div>
                        </div>
                    </c:if>
                </div>
            </div>
        </div>
    </nav>
    
    <!-- Page Header -->
    <div class="page-header">
        <div class="container">
            <h1>
                <i class="fas fa-file-invoice"></i> Détails de la Réservation
            </h1>
            <p class="subtitle">Gestion administrative - Confirmer ou Annuler</p>
            <div class="admin-badge">
                <i class="fas fa-crown"></i>
                <span>Mode Administrateur</span>
            </div>
        </div>
    </div>
    
    <div class="container">
        <!-- Back Button -->
        <div class="back-button-container">
            <a href="${pageContext.request.contextPath}/admin/dashboard" class="btn-back">
                <i class="fas fa-arrow-left"></i>
                Retour au Dashboard
            </a>
        </div>

        <!-- Success/Error Messages -->
        <c:if test="${not empty sessionScope.success}">
            <div class="alert alert-success">
                <i class="fas fa-check-circle"></i>
                <span>${sessionScope.success}</span>
                <button onclick="this.parentElement.remove()">&times;</button>
            </div>
            <c:remove var="success" scope="session"/>
        </c:if>
        
        <c:if test="${not empty sessionScope.error}">
            <div class="alert alert-danger">
                <i class="fas fa-exclamation-circle"></i>
                <span>${sessionScope.error}</span>
                <button onclick="this.parentElement.remove()">&times;</button>
            </div>
            <c:remove var="error" scope="session"/>
        </c:if>

        <c:if test="${not empty reservation}">
            <!-- Reservation Card -->
            <div class="reservation-card">
                <!-- Card Header -->
                <div class="card-header">
                    <div class="reservation-number">
                        <i class="fas fa-ticket-alt"></i>
                        ${reservation.reservationNumber}
                    </div>
                    <div class="reservation-meta">
                        <div class="meta-item">
                            <i class="fas fa-calendar-alt"></i>
                            <span>Créée le ${reservation.createdAtFormatted != null ? reservation.createdAtFormatted : 'N/A'}</span>
                        </div>
                        <div class="meta-item">
                            <i class="fas fa-info-circle"></i>
                            <span>Statut: 
                                <span class="status-badge status-${reservation.status}">
                                    <c:choose>
                                        <c:when test="${reservation.status == 'EN_ATTENTE'}">
                                            <i class="fas fa-clock"></i> En Attente
                                        </c:when>
                                        <c:when test="${reservation.status == 'CONFIRMEE'}">
                                            <i class="fas fa-check-circle"></i> Confirmée
                                        </c:when>
                                        <c:when test="${reservation.status == 'ANNULEE'}">
                                            <i class="fas fa-times-circle"></i> Annulée
                                        </c:when>
                                        <c:otherwise>${reservation.status}</c:otherwise>
                                    </c:choose>
                                </span>
                            </span>
                        </div>
                    </div>

                    <!-- Customer Info -->
                    <div class="customer-info-box">
                        <h3><i class="fas fa-user"></i> Informations Client</h3>
                        <div class="customer-details">
                            <div class="customer-detail">
                                <i class="fas fa-user"></i>
                                <strong>${reservation.user.firstName} ${reservation.user.lastName}</strong>
                            </div>
                            <div class="customer-detail">
                                <i class="fas fa-envelope"></i>
                                ${reservation.user.email}
                            </div>
                            <c:if test="${not empty reservation.user.phone}">
                                <div class="customer-detail">
                                    <i class="fas fa-phone"></i>
                                    ${reservation.user.phone}
                                </div>
                            </c:if>
                        </div>
                    </div>
                </div>

                <!-- Card Body -->
                <div class="card-body">
                    <!-- General Information -->
                    <h2 class="section-title">
                        <i class="fas fa-info-circle"></i> Informations générales
                    </h2>
                    
                    <div class="details-grid">
                        <div class="detail-item">
                            <span class="detail-label">
                                <i class="fas fa-tag"></i> Type de réservation
                            </span>
                            <span class="detail-value">
                                <c:choose>
                                    <c:when test="${reservation.type == 'FLIGHT'}">
                                        <i class="fas fa-plane" style="color: var(--vc-accent);"></i> Vol
                                    </c:when>
                                    <c:when test="${reservation.type == 'HOTEL'}">
                                        <i class="fas fa-hotel" style="color: var(--vc-accent);"></i> Hôtel
                                    </c:when>
                                    <c:when test="${reservation.type == 'CIRCUIT'}">
                                        <i class="fas fa-route" style="color: var(--vc-accent);"></i> Circuit
                                    </c:when>
                                    <c:when test="${reservation.type == 'PACKAGE'}">
                                        <i class="fas fa-box" style="color: var(--vc-accent);"></i> Package
                                    </c:when>
                                    <c:otherwise>${reservation.type}</c:otherwise>
                                </c:choose>
                            </span>
                        </div>

                        <div class="detail-item">
                            <span class="detail-label">
                                <i class="fas fa-users"></i> Nombre de personnes
                            </span>
                            <span class="detail-value">${reservation.numberOfPeople}</span>
                        </div>

                        <div class="detail-item">
                            <span class="detail-label">
                                <i class="fas fa-money-bill-wave"></i> Montant total
                            </span>
                            <span class="detail-value large">
                                <fmt:formatNumber value="${reservation.totalAmount}" type="currency" currencySymbol="" maxFractionDigits="0"/> MAD
                            </span>
                        </div>
                    </div>

                    <!-- Flight Details -->
                    <c:if test="${reservation.type == 'FLIGHT' && reservation.flight != null}">
                        <h2 class="section-title">
                            <i class="fas fa-plane-departure"></i> Détails du vol
                        </h2>
                        
                        <div class="product-card">
                            <div class="product-header">
                                <div class="product-icon">
                                    <i class="fas fa-plane"></i>
                                </div>
                                <div class="product-info">
                                    <h3>Vol ${reservation.flight.flightNumber}</h3>
                                    <p>${reservation.flight.airline}</p>
                                </div>
                            </div>
                            
                            <div class="product-details">
                                <div class="detail-item">
                                    <span class="detail-label">
                                        <i class="fas fa-plane-departure"></i> Départ
                                    </span>
                                    <span class="detail-value">${reservation.flight.departureCity}</span>
                                    <span style="font-size: 0.85rem; color: var(--vc-text-light);">
                                        ${reservation.flight.departureDateFormatted != null ? reservation.flight.departureDateFormatted : 'N/A'}
                                    </span>
                                </div>

                                <div class="detail-item">
                                    <span class="detail-label">
                                        <i class="fas fa-plane-arrival"></i> Arrivée
                                    </span>
                                    <span class="detail-value">${reservation.flight.destination != null ? reservation.flight.destination.name : 'N/A'}</span>
                                    <span style="font-size: 0.85rem; color: var(--vc-text-light);">
                                        ${reservation.flight.arrivalDateFormatted != null ? reservation.flight.arrivalDateFormatted : 'N/A'}
                                    </span>
                                </div>

                                <div class="detail-item">
                                    <span class="detail-label">
                                        <i class="fas fa-chair"></i> Classe
                                    </span>
                                    <span class="detail-value">
                                        <c:choose>
                                            <c:when test="${reservation.flight.flightClass.name() == 'ECONOMY'}">Économique</c:when>
                                            <c:when test="${reservation.flight.flightClass.name() == 'BUSINESS'}">Business</c:when>
                                            <c:when test="${reservation.flight.flightClass.name() == 'FIRST'}">Première</c:when>
                                            <c:otherwise>${reservation.flight.flightClass}</c:otherwise>
                                        </c:choose>
                                    </span>
                                </div>

                                <div class="detail-item">
                                    <span class="detail-label">
                                        <i class="fas fa-money-bill"></i> Prix unitaire
                                    </span>
                                    <span class="detail-value">
                                        <fmt:formatNumber value="${reservation.flight.price}" type="currency" currencySymbol="" maxFractionDigits="0"/> MAD
                                    </span>
                                </div>
                            </div>
                        </div>
                    </c:if>

                    <!-- Hotel Details -->
                    <c:if test="${reservation.type == 'HOTEL' && reservation.hotel != null}">
                        <h2 class="section-title">
                            <i class="fas fa-hotel"></i> Détails de l'hôtel
                        </h2>
                        
                        <div class="product-card">
                            <div class="product-header">
                                <div class="product-icon">
                                    <i class="fas fa-hotel"></i>
                                </div>
                                <div class="product-info">
                                    <h3>${reservation.hotel.name}</h3>
                                    <p>
                                        <c:forEach begin="1" end="${reservation.hotel.stars}">
                                            <i class="fas fa-star" style="color: #febb02;"></i>
                                        </c:forEach>
                                    </p>
                                </div>
                            </div>
                            
                            <div class="product-details">
                                <div class="detail-item">
                                    <span class="detail-label">
                                        <i class="fas fa-map-marker-alt"></i> Destination
                                    </span>
                                    <span class="detail-value">${reservation.hotel.destination != null ? reservation.hotel.destination.name : 'N/A'}</span>
                                </div>

                                <div class="detail-item">
                                    <span class="detail-label">
                                        <i class="fas fa-calendar-check"></i> Check-in
                                    </span>
                                    <span class="detail-value">
                                        <c:choose>
                                            <c:when test="${reservation.checkInDateFormatted != null}">
                                                ${reservation.checkInDateFormatted}
                                            </c:when>
                                            <c:otherwise>N/A</c:otherwise>
                                        </c:choose>
                                    </span>
                                </div>

                                <div class="detail-item">
                                    <span class="detail-label">
                                        <i class="fas fa-calendar-times"></i> Check-out
                                    </span>
                                    <span class="detail-value">
                                        <c:choose>
                                            <c:when test="${reservation.checkOutDateFormatted != null}">
                                                ${reservation.checkOutDateFormatted}
                                            </c:when>
                                            <c:otherwise>N/A</c:otherwise>
                                        </c:choose>
                                    </span>
                                </div>

                                <div class="detail-item">
                                    <span class="detail-label">
                                        <i class="fas fa-money-bill"></i> Prix par nuit
                                    </span>
                                    <span class="detail-value">
                                        <fmt:formatNumber value="${reservation.hotel.pricePerNight}" type="currency" currencySymbol="" maxFractionDigits="0"/> MAD
                                    </span>
                                </div>
                            </div>
                        </div>
                    </c:if>

                    <!-- Circuit Details -->
                    <c:if test="${reservation.type == 'CIRCUIT' && reservation.circuit != null}">
                        <h2 class="section-title">
                            <i class="fas fa-route"></i> Détails du circuit
                        </h2>
                        
                        <div class="product-card">
                            <div class="product-header">
                                <div class="product-icon">
                                    <i class="fas fa-route"></i>
                                </div>
                                <div class="product-info">
                                    <h3>${reservation.circuit.name}</h3>
                                    <p>${reservation.circuit.description}</p>
                                </div>
                            </div>
                            
                            <div class="product-details">
                                <div class="detail-item">
                                    <span class="detail-label">
                                        <i class="fas fa-map-marker-alt"></i> Destination
                                    </span>
                                    <span class="detail-value">${reservation.circuit.destination != null ? reservation.circuit.destination.name : 'N/A'}</span>
                                </div>

                                <div class="detail-item">
                                    <span class="detail-label">
                                        <i class="fas fa-calendar-alt"></i> Durée
                                    </span>
                                    <span class="detail-value">${reservation.circuit.durationDays} jours</span>
                                </div>

                                <div class="detail-item">
                                    <span class="detail-label">
                                        <i class="fas fa-money-bill"></i> Prix par personne
                                    </span>
                                    <span class="detail-value">
                                        <fmt:formatNumber value="${reservation.circuit.price}" type="currency" currencySymbol="" maxFractionDigits="0"/> MAD
                                    </span>
                                </div>
                            </div>
                        </div>
                    </c:if>

                    <!-- Payment Information -->
                    <c:if test="${reservation.payment != null}">
                        <h2 class="section-title">
                            <i class="fas fa-credit-card"></i> Informations de paiement
                        </h2>
                        
                        <div class="details-grid">
                            <div class="detail-item">
                                <span class="detail-label">
                                    <i class="fas fa-credit-card"></i> Méthode de paiement
                                </span>
                                <span class="detail-value">
                                    <c:choose>
                                        <c:when test="${reservation.payment.paymentMethod == 'CREDIT_CARD'}">Carte de crédit</c:when>
                                        <c:when test="${reservation.payment.paymentMethod == 'PAYPAL'}">PayPal</c:when>
                                        <c:when test="${reservation.payment.paymentMethod == 'BANK_TRANSFER'}">Virement bancaire</c:when>
                                        <c:otherwise>${reservation.payment.paymentMethod}</c:otherwise>
                                    </c:choose>
                                </span>
                            </div>

                            <div class="detail-item">
                                <span class="detail-label">
                                    <i class="fas fa-check-circle"></i> Statut du paiement
                                </span>
                                <span class="detail-value">
                                    <c:choose>
                                        <c:when test="${reservation.payment.status == 'PENDING'}">En attente</c:when>
                                        <c:when test="${reservation.payment.status == 'COMPLETED'}">Complété</c:when>
                                        <c:when test="${reservation.payment.status == 'FAILED'}">Échoué</c:when>
                                        <c:when test="${reservation.payment.status == 'REFUNDED'}">Remboursé</c:when>
                                        <c:otherwise>${reservation.payment.status}</c:otherwise>
                                    </c:choose>
                                </span>
                            </div>
                        </div>
                    </c:if>

                    <!-- Admin Actions Section -->
                    <div class="admin-actions">
                        <h3>
                            <i class="fas fa-tools"></i> Actions Administrateur
                        </h3>
                        
                        <div class="action-buttons">
                            <c:choose>
                                <c:when test="${reservation.status == 'EN_ATTENTE'}">
                                    <!-- Confirm Button -->
                                    <form action="${pageContext.request.contextPath}/admin/reservation/view" method="post" 
                                          style="display: inline;" 
                                          onsubmit="return confirm('Confirmer cette reservation ? Un email de confirmation sera envoye au client.');">
                                        <input type="hidden" name="action" value="confirm">
                                        <input type="hidden" name="reservationId" value="${reservation.id}">
                                        <button type="submit" class="btn btn-confirm">
                                            <i class="fas fa-check-circle"></i> Confirmer la Réservation
                                        </button>
                                    </form>
                                    
                                    <!-- Cancel Button -->
                                    <form action="${pageContext.request.contextPath}/admin/reservation/view" method="post" 
                                          style="display: inline;" 
                                          onsubmit="return confirm('Annuler cette reservation ? Un email sera envoye au client.');">
                                        <input type="hidden" name="action" value="cancel">
                                        <input type="hidden" name="reservationId" value="${reservation.id}">
                                        <button type="submit" class="btn btn-cancel">
                                            <i class="fas fa-times-circle"></i> Annuler la Réservation
                                        </button>
                                    </form>
                                </c:when>
                                
                                <c:when test="${reservation.status == 'CONFIRMEE'}">
                                    <div class="status-message status-confirmed">
                                        <i class="fas fa-check-circle"></i>
                                        <span>Cette réservation est confirmée</span>
                                    </div>
                                    
                                    <!-- Cancel Button (can still cancel a confirmed reservation) -->
                                    <form action="${pageContext.request.contextPath}/admin/reservation/view" method="post" 
                                          style="display: inline;" 
                                          onsubmit="return confirm('Annuler cette reservation confirmee ? Un email sera envoye au client.');">
                                        <input type="hidden" name="action" value="cancel">
                                        <input type="hidden" name="reservationId" value="${reservation.id}">
                                        <button type="submit" class="btn btn-cancel">
                                            <i class="fas fa-times-circle"></i> Annuler la Réservation
                                        </button>
                                    </form>
                                </c:when>
                                
                                <c:when test="${reservation.status == 'ANNULEE'}">
                                    <div class="status-message status-cancelled">
                                        <i class="fas fa-ban"></i>
                                        <span>Cette réservation a été annulée</span>
                                    </div>
                                </c:when>
                            </c:choose>
                            
                            <!-- Common Buttons -->
                            
                            <button onclick="window.print();" class="btn btn-print">
                                <i class="fas fa-print"></i> Imprimer
                            </button>
                        </div>
                    </div>
                </div>
            </div>
        </c:if>

        <c:if test="${empty reservation}">
            <div class="alert alert-warning">
                <i class="fas fa-exclamation-triangle"></i>
                <span>Aucune réservation trouvée.</span>
            </div>
        </c:if>

        <!-- Quick Actions -->
        <div class="section-card">
            <div class="section-header">
                <h2 class="section-title">
                    <i class="fas fa-bolt"></i> Actions Rapides
                </h2>
            </div>
            
            <div class="quick-actions-grid">
                <a href="${pageContext.request.contextPath}/admin/destinations" class="action-btn">
                    <i class="fas fa-map-marked-alt"></i>
                    <span>Gérer Destinations</span>
                </a>
                <a href="${pageContext.request.contextPath}/admin/flights" class="action-btn">
                    <i class="fas fa-plane"></i>
                    <span>Gérer Vols</span>
                </a>
                <a href="${pageContext.request.contextPath}/admin/hotels" class="action-btn">
                    <i class="fas fa-hotel"></i>
                    <span>Gérer Hôtels</span>
                </a>
                <a href="${pageContext.request.contextPath}/admin/circuits" class="action-btn">
                    <i class="fas fa-route"></i>
                    <span>Gérer Circuits</span>
                </a>
            </div>
        </div>
    </div>

    <script>
        // User Dropdown Toggle
        document.addEventListener('DOMContentLoaded', function() {
            const userToggle = document.getElementById('userMenuToggle');
            const userMenu = document.getElementById('userMenu');
            
            if (userToggle && userMenu) {
                userToggle.addEventListener('click', function(e) {
                    e.stopPropagation();
                    userMenu.classList.toggle('show');
                });
                
                document.addEventListener('click', function(e) {
                    if (!userToggle.contains(e.target) && !userMenu.contains(e.target)) {
                        userMenu.classList.remove('show');
                    }
                });
            }
        });
    </script>
</body>
</html>
