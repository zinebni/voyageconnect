<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.time.format.DateTimeFormatter" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Détails de la Réservation - VoyageConnect</title>
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
            --transition-base: 250ms cubic-bezier(0.4, 0, 0.2, 1);
            --gradient-primary: linear-gradient(135deg, #003580 0%, #0057b8 100%);
        }
        
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }
        
        body {
            font-family: -apple-system, BlinkMacSystemFont, "Segoe UI", Roboto, sans-serif;
            background: var(--vc-bg);
            color: var(--vc-text);
            line-height: 1.6;
            -webkit-font-smoothing: antialiased;
        }
        
        .page-wrapper {
            min-height: 100vh;
            display: flex;
            flex-direction: column;
        }
        
        .container {
            width: 100%;
            max-width: 1200px;
            margin: 0 auto;
            padding: 0 1.5rem;
        }

        /* Navbar */
        /* ========== Modern Navbar ========== */
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

/* ========== Brand ========== */
.navbar-brand {
    display: flex;
    align-items: center;
    gap: 0.5rem;
    font-size: 1.5rem;
    font-weight: 700;
    color: var(--vc-primary);
    text-decoration: none;
    transition: color var(--transition-base);
    flex-shrink: 0;
}

.navbar-brand i {
    font-size: 1.75rem;
}

.navbar-brand:hover {
    color: var(--vc-accent);
}

/* ========== Main Navigation ========== */
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
    white-space: nowrap;
}

.navbar-main .nav-link:hover {
    color: var(--vc-accent);
    background: var(--vc-border-light);
}

.navbar-main .nav-link i {
    font-size: 1.1rem;
}

/* ========== User Section ========== */
.navbar-user {
    display: flex;
    align-items: center;
    gap: 0.75rem;
    flex-shrink: 0;
}

/* ========== Login Button ========== */
.btn-login {
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

.btn-login:hover {
    color: var(--vc-accent);
    background: var(--vc-border-light);
}

/* ========== Register Button ========== */
.btn {
    display: inline-flex;
    align-items: center;
    justify-content: center;
    gap: 0.5rem;
    padding: 0.625rem 1rem;
    font-size: 0.875rem;
    font-weight: 600;
    text-decoration: none;
    border: none;
    border-radius: var(--radius-md);
    cursor: pointer;
    transition: all var(--transition-base);
}

.btn-highlight {
    background: var(--gradient-primary);
    color: #ffffff;
    box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
}

.btn-highlight:hover {
    box-shadow: 0 4px 8px rgba(0, 0, 0, 0.15);
    transform: translateY(-1px);
    color: #ffffff;
}

.btn-sm {
    padding: 0.5rem 1rem;
    font-size: 0.875rem;
}

/* ========== User Dropdown ========== */
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

.user-toggle:hover,
.user-toggle.active {
    border-color: var(--vc-accent);
    background: var(--vc-border-light);
}

.user-toggle i.fas.fa-user-circle {
    font-size: 1.5rem;
    color: var(--vc-accent);
}

.user-name {
    max-width: 120px;
    overflow: hidden;
    text-overflow: ellipsis;
    white-space: nowrap;
}

.dropdown-arrow {
    font-size: 0.75rem;
    transition: transform var(--transition-base);
}

.user-toggle.active .dropdown-arrow {
    transform: rotate(180deg);
}

/* ========== User Menu Dropdown ========== */
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

.user-menu-header div {
    display: flex;
    flex-direction: column;
    gap: 0.25rem;
    overflow: hidden;
}

.user-menu-header strong {
    color: var(--vc-text);
    font-size: 1rem;
    white-space: nowrap;
    overflow: hidden;
    text-overflow: ellipsis;
}

.user-menu-header small {
    color: var(--vc-text-light);
    font-size: 0.8rem;
    white-space: nowrap;
    overflow: hidden;
    text-overflow: ellipsis;
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

.user-menu-item i {
    width: 20px;
    text-align: center;
    color: var(--vc-text-light);
}

.user-menu-item:hover i {
    color: var(--vc-accent);
}

.user-menu-item.logout {
    color: var(--vc-danger);
}

.user-menu-item.logout:hover {
    background: rgba(220, 53, 69, 0.1);
}

.user-menu-item.logout i {
    color: var(--vc-danger);
}

.user-menu-divider {
    height: 1px;
    background: var(--vc-border);
    margin: 0.5rem 0;
}

/* ========== Mobile Toggle ========== */
.mobile-toggle {
    display: none;
    align-items: center;
    justify-content: center;
    width: 40px;
    height: 40px;
    background: transparent;
    border: 2px solid var(--vc-border);
    border-radius: var(--radius-md);
    color: var(--vc-text);
    cursor: pointer;
    transition: all var(--transition-base);
}

.mobile-toggle:hover,
.mobile-toggle.active {
    border-color: var(--vc-accent);
    background: var(--vc-border-light);
    color: var(--vc-accent);
}

.mobile-toggle i {
    font-size: 1.25rem;
}

/* ========== Mobile Menu ========== */
.mobile-menu {
    display: none;
    flex-direction: column;
    background: var(--vc-bg-light);
    border-top: 1px solid var(--vc-border);
    max-height: 0;
    overflow: hidden;
    transition: max-height var(--transition-slow);
}

.mobile-menu.show {
    max-height: 100vh;
    overflow-y: auto;
}

.mobile-menu-item {
    display: flex;
    align-items: center;
    gap: 0.75rem;
    padding: 1rem 1.5rem;
    color: var(--vc-text);
    text-decoration: none;
    border-bottom: 1px solid var(--vc-border-light);
    transition: all var(--transition-base);
}

.mobile-menu-item:hover {
    background: var(--vc-border-light);
    color: var(--vc-accent);
}

.mobile-menu-item i {
    width: 24px;
    text-align: center;
    color: var(--vc-text-light);
}

.mobile-menu-item:hover i {
    color: var(--vc-accent);
}

.mobile-menu-item.logout {
    color: var(--vc-danger);
}

.mobile-menu-item.logout i {
    color: var(--vc-danger);
}

.mobile-menu-item.highlight {
    background: var(--gradient-primary);
    color: #ffffff;
    font-weight: 600;
}

.mobile-menu-item.highlight i {
    color: #ffffff;
}

.mobile-user-info {
    display: flex;
    align-items: center;
    gap: 0.75rem;
    padding: 1rem 1.5rem;
    background: var(--vc-border-light);
    font-weight: 600;
    color: var(--vc-primary);
}

.mobile-user-info i {
    font-size: 1.5rem;
    color: var(--vc-accent);
}

.mobile-menu-divider {
    height: 8px;
    background: var(--vc-border-light);
    margin: 0.5rem 0;
}

/* Prevent body scroll when mobile menu is open */
body.mobile-menu-open {
    overflow: hidden;
    overflow: hidden;
    position: fixed;
    width: 100%;
}

/* ========== Responsive ========== */
@media (max-width: 992px) {
    .navbar-main {
        display: none;
    }
    
    .navbar-user {
        gap: 0.5rem;
    }
    
    .mobile-toggle {
        display: flex;
    }
    
    .mobile-menu {
        display: flex;
    }
    
    .btn-login span,
    .btn span {
        display: none;
    }
    
    .user-name {
        display: none;
    }
}

@media (max-width: 768px) {
    .navbar-wrapper {
        padding: 0.75rem 0;
    }
    
    .navbar-brand {
        font-size: 1.25rem;
    }
    
    .navbar-brand i {
        font-size: 1.5rem;
    }
    
    .brand-text {
        display: none;
    }
}

@media (max-width: 480px) {
    .user-toggle {
        padding: 0.5rem 0.75rem;
    }
    
    .btn-login {
        padding: 0.5rem 0.75rem;
    }
    
    .btn.btn-highlight.btn-sm {
        padding: 0.5rem 0.75rem;
        font-size: 0.875rem;
    }
}

        /* Page Header */
        .page-header {
            background: var(--gradient-primary);
            padding: 2.5rem 0;
            text-align: center;
            margin-bottom: 3rem;
            box-shadow: var(--shadow-md);
        }
        
        .page-header h1 {
            color: #ffffff;
            font-size: 2.25rem;
            font-weight: 800;
            margin-bottom: 0.5rem;
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 0.75rem;
        }
        
        .page-header .subtitle {
            color: rgba(255, 255, 255, 0.9);
            font-size: 1.125rem;
            margin: 0;
        }

        /* Back Button */
        .back-button-container {
            margin-bottom: 2rem;
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

        /* Reservation Card */
        .reservation-card {
            background: var(--vc-bg-light);
            border-radius: var(--radius-xl);
            box-shadow: var(--shadow-md);
            overflow: hidden;
            margin-bottom: 2rem;
        }

        .card-header {
            background: var(--gradient-primary);
            padding: 2rem;
            color: #ffffff;
        }

        .reservation-number {
            display: flex;
            align-items: center;
            gap: 0.75rem;
            font-size: 1.75rem;
            font-weight: 700;
            margin-bottom: 0.5rem;
        }

        .reservation-meta {
            display: flex;
            align-items: center;
            gap: 2rem;
            flex-wrap: wrap;
            margin-top: 1rem;
            color: rgba(255, 255, 255, 0.9);
        }

        .meta-item {
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
            text-transform: uppercase;
            letter-spacing: 0.5px;
        }

        .status-EN_ATTENTE {
            background: rgba(254, 187, 2, 0.2);
            color: #a16207;
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
            font-size: 1.5rem;
            font-weight: 700;
            color: var(--vc-primary);
            margin-bottom: 1.5rem;
            padding-bottom: 0.75rem;
            border-bottom: 3px solid var(--vc-border);
        }

        /* Details Grid */
        .details-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
            gap: 1.5rem;
            margin-bottom: 2rem;
        }

        .detail-item {
            display: flex;
            flex-direction: column;
            gap: 0.5rem;
        }

        .detail-label {
            display: flex;
            align-items: center;
            gap: 0.5rem;
            font-size: 0.875rem;
            font-weight: 600;
            color: var(--vc-text-light);
            text-transform: uppercase;
            letter-spacing: 0.5px;
        }

        .detail-value {
            font-size: 1.125rem;
            font-weight: 600;
            color: var(--vc-text);
        }

        .detail-value.large {
            font-size: 1.75rem;
            color: var(--vc-success);
        }

        /* Product Card */
        .product-card {
            background: var(--vc-border-light);
            border-radius: var(--radius-lg);
            padding: 1.5rem;
            margin-bottom: 1.5rem;
        }

        .product-header {
            display: flex;
            align-items: center;
            gap: 1rem;
            margin-bottom: 1rem;
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
            font-size: 1.75rem;
        }

        .product-info h3 {
            font-size: 1.25rem;
            font-weight: 700;
            color: var(--vc-primary);
            margin-bottom: 0.25rem;
        }

        .product-info p {
            color: var(--vc-text-light);
            margin: 0;
        }

        .product-details {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
            gap: 1rem;
            padding-top: 1rem;
            border-top: 2px solid var(--vc-border);
        }

        /* Action Buttons */
        .action-buttons {
            display: flex;
            gap: 1rem;
            margin-top: 2rem;
            padding-top: 2rem;
            border-top: 3px solid var(--vc-border);
        }

        .btn {
            display: inline-flex;
            align-items: center;
            justify-content: center;
            gap: 0.5rem;
            padding: 0.875rem 1.5rem;
            font-size: 1rem;
            font-weight: 600;
            text-decoration: none;
            border: none;
            border-radius: var(--radius-md);
            cursor: pointer;
            transition: all var(--transition-base);
        }

        .btn-primary {
            background: var(--gradient-primary);
            color: #ffffff;
            box-shadow: var(--shadow-md);
        }

        .btn-primary:hover {
            box-shadow: var(--shadow-xl);
            transform: translateY(-2px);
            color: #ffffff;
        }

        .btn-danger {
            background: var(--vc-danger);
            color: #ffffff;
            box-shadow: var(--shadow-md);
        }

        .btn-danger:hover {
            background: #c82333;
            box-shadow: var(--shadow-xl);
            transform: translateY(-2px);
            color: #ffffff;
        }

        .btn-outline {
            background: transparent;
            border: 2px solid var(--vc-border);
            color: var(--vc-text);
        }

        .btn-outline:hover {
            border-color: var(--vc-accent);
            color: var(--vc-accent);
            background: var(--vc-border-light);
        }

        /* Alert */
        .alert {
            padding: 1rem 1.5rem;
            border-radius: var(--radius-lg);
            margin-bottom: 1.5rem;
            display: flex;
            align-items: center;
            gap: 0.75rem;
        }

        .alert-info {
            background: rgba(0, 113, 194, 0.1);
            color: var(--vc-accent);
            border: 2px solid rgba(0, 113, 194, 0.2);
        }

        .alert-warning {
            background: rgba(254, 187, 2, 0.1);
            color: #a16207;
            border: 2px solid rgba(254, 187, 2, 0.2);
        }

        /* Responsive */
        @media (max-width: 768px) {
            .page-header h1 {
                font-size: 1.75rem;
            }

            .details-grid {
                grid-template-columns: 1fr;
            }

            .action-buttons {
                flex-direction: column;
            }

            .btn {
                width: 100%;
            }

            .reservation-meta {
                flex-direction: column;
                gap: 0.75rem;
                align-items: flex-start;
            }

            .product-details {
                grid-template-columns: 1fr;
            }
        }
    </style>
</head>
<body class="page-wrapper">
    <jsp:include page="/WEB-INF/views/common/navbar.jsp" />
    
    <!-- Page Header -->
    <div class="page-header">
        <div class="container">
            <h1>
                <i class="fas fa-file-invoice"></i> Détails de la Réservation
            </h1>
            <p class="subtitle">Consultez les informations détaillées de votre réservation</p>
        </div>
    </div>
    
    <div class="container">
        <!-- Back Button -->
        <div class="back-button-container">
            <a href="${pageContext.request.contextPath}/reservation/list" class="btn-back">
                <i class="fas fa-arrow-left"></i> Retour à mes réservations
            </a>
        </div>

        <c:if test="${not empty error}">
            <div class="alert alert-warning">
                <i class="fas fa-exclamation-triangle"></i>
                <span>${error}</span>
            </div>
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
                            <span class="status-badge status-${reservation.status}">
                                <i class="fas fa-circle"></i>
                                <c:choose>
                                    <c:when test="${reservation.status == 'EN_ATTENTE'}">En Attente</c:when>
                                    <c:when test="${reservation.status == 'CONFIRMEE'}">Confirmée</c:when>
                                    <c:when test="${reservation.status == 'ANNULEE'}">Annulée</c:when>
                                    <c:otherwise>${reservation.status}</c:otherwise>
                                </c:choose>
                            </span>
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
                                    <c:when test="${reservation.type == 'FLIGHT'}">Vol</c:when>
                                    <c:when test="${reservation.type == 'HOTEL'}">Hôtel</c:when>
                                    <c:when test="${reservation.type == 'CIRCUIT'}">Circuit</c:when>
                                    <c:when test="${reservation.type == 'PACKAGE'}">Package</c:when>
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
                                <i class="fas fa-euro-sign"></i> Montant total
                            </span>
                            <span class="detail-value large">
                                <fmt:formatNumber value="${reservation.totalAmount}" type="currency" currencySymbol="€" />
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
                                    <span class="detail-value" style="font-size: 0.875rem; color: var(--vc-text-light);">
                                        ${reservation.flight.departureDateFormatted != null ? reservation.flight.departureDateFormatted : 'N/A'}
                                    </span>
                                </div>

                                <div class="detail-item">
                                    <span class="detail-label">
                                        <i class="fas fa-plane-arrival"></i> Arrivée
                                    </span>
                                    <span class="detail-value">${reservation.flight.destination != null ? reservation.flight.destination.name : 'N/A'}</span>
                                    <span class="detail-value" style="font-size: 0.875rem; color: var(--vc-text-light);">
                                        ${reservation.flight.arrivalDateFormatted != null ? reservation.flight.arrivalDateFormatted : 'N/A'}
                                    </span>
                                </div>

                                <div class="detail-item">
                                    <span class="detail-label">
                                        <i class="fas fa-chair"></i> Classe
                                    </span>
                                    <span class="detail-value">
                                        <c:choose>
                                            <c:when test="${reservation.flight.flightClass == 'ECONOMY'}">Économique</c:when>
                                            <c:when test="${reservation.flight.flightClass == 'BUSINESS'}">Business</c:when>
                                            <c:when test="${reservation.flight.flightClass == 'FIRST'}">Première</c:when>
                                            <c:otherwise>${reservation.flight.flightClass}</c:otherwise>
                                        </c:choose>
                                    </span>
                                </div>

                                <div class="detail-item">
                                    <span class="detail-label">
                                        <i class="fas fa-euro-sign"></i> Prix unitaire
                                    </span>
                                    <span class="detail-value">
                                        <fmt:formatNumber value="${reservation.flight.price}" type="currency" currencySymbol="€" />
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
                                            <c:when test="${reservation.checkInDate != null}">
                                                <fmt:formatDate value="${reservation.checkInDate}" pattern="dd/MM/yyyy" />
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
                                            <c:when test="${reservation.checkOutDate != null}">
                                                <fmt:formatDate value="${reservation.checkOutDate}" pattern="dd/MM/yyyy" />
                                            </c:when>
                                            <c:otherwise>N/A</c:otherwise>
                                        </c:choose>
                                    </span>
                                </div>

                                <div class="detail-item">
                                    <span class="detail-label">
                                        <i class="fas fa-euro-sign"></i> Prix par nuit
                                    </span>
                                    <span class="detail-value">
                                        <fmt:formatNumber value="${reservation.hotel.pricePerNight}" type="currency" currencySymbol="€" />
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
                                    <span class="detail-value">${reservation.circuit.duration} jours</span>
                                </div>

                                <div class="detail-item">
                                    <span class="detail-label">
                                        <i class="fas fa-users"></i> Places disponibles
                                    </span>
                                    <span class="detail-value">${reservation.circuit.availablePlaces}</span>
                                </div>

                                <div class="detail-item">
                                    <span class="detail-label">
                                        <i class="fas fa-euro-sign"></i> Prix par personne
                                    </span>
                                    <span class="detail-value">
                                        <fmt:formatNumber value="${reservation.circuit.price}" type="currency" currencySymbol="€" />
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

                    <!-- Action Buttons -->
                    <div class="action-buttons">
                        <a href="${pageContext.request.contextPath}/reservation/list" class="btn btn-outline">
                            <i class="fas fa-list"></i> Retour à la liste
                        </a>
                        
                        <c:if test="${reservation.status == 'EN_ATTENTE' || reservation.status == 'CONFIRMEE'}">
                            <a href="${pageContext.request.contextPath}/reservation/cancel?id=${reservation.id}" 
                               class="btn btn-danger"
                               onclick="return confirm('Êtes-vous sûr de vouloir annuler cette réservation ?');">
                                <i class="fas fa-times-circle"></i> Annuler la réservation
                            </a>
                        </c:if>

                        <a href="#" onclick="window.print(); return false;" class="btn btn-primary">
                            <i class="fas fa-print"></i> Imprimer
                        </a>
                    </div>

                    <!-- Info Alert -->
                    <c:if test="${reservation.status == 'EN_ATTENTE'}">
                        <div class="alert alert-info" style="margin-top: 2rem;">
                            <i class="fas fa-info-circle"></i>
                            <span>Votre réservation est en attente de confirmation de paiement. Une fois le paiement validé, vous recevrez un email de confirmation.</span>
                        </div>
                    </c:if>
                </div>
            </div>
        </c:if>

        <c:if test="${empty reservation}">
            <div class="alert alert-warning">
                <i class="fas fa-exclamation-triangle"></i>
                <span>Aucune réservation trouvée.</span>
            </div>
        </c:if>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
