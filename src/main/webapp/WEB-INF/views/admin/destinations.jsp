<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Gestion des Destinations - VoyageConnect Admin</title>
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        :root {
            --vc-primary: #003580;
            --vc-accent: #0071c2;
            --vc-bg: #f5f7fa;
            --vc-bg-light: #ffffff;
            --vc-text: #1a1a1a;
            --vc-text-light: #6b7280;
            --vc-border: #e5e7eb;
            --vc-success: #00aa6c;
            --vc-warning: #febb02;
            --vc-danger: #dc3545;
            --shadow-md: 0 4px 6px -1px rgba(0, 0, 0, 0.1);
            --shadow-lg: 0 10px 15px -3px rgba(0, 0, 0, 0.1);
            --radius-md: 8px;
            --radius-lg: 12px;
            --radius-xl: 16px;
            --radius-full: 9999px;
            --transition-base: 250ms cubic-bezier(0.4, 0, 0.2, 1);
            --gradient-primary: linear-gradient(135deg, #003580 0%, #0057b8 100%);
            --gradient-admin: linear-gradient(135deg, #003580 0%, #003580 100%);
        }
        * { margin: 0; padding: 0; box-sizing: border-box; }
        body {
            font-family: -apple-system, BlinkMacSystemFont, "Segoe UI", Roboto, "Helvetica Neue", Arial, sans-serif;
            background: var(--vc-bg);
            color: var(--vc-text);
            line-height: 1.6;
        }
        .container { max-width: 1200px; margin: 0 auto; padding: 0 1.5rem; }

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

        /* ========= Button Back to Dashboard ========== */
         .page-header-content {
            display: flex;
            justify-content: space-between;
            align-items: center;
            flex-wrap: wrap;
            gap: 1rem;
        }
                .btn-back {
            display: inline-flex;
            align-items: center;
            gap: 0.5rem;
            padding: 0.625rem 1.25rem;
            background: rgba(255, 255, 255, 0.1);
            border: 1px solid rgba(255, 255, 255, 0.2);
            color: #ffffff;
            text-decoration: none;
            border-radius: var(--radius-md);
            font-weight: 500;
            transition: all var(--transition-base);
        }

        .btn-back:hover {
            background: rgba(255, 255, 255, 0.2);
            color: #ffffff;
        }

       /* ========== Navigation Bar ========== */
nav {
    background: var(--vc-bg-light);
    box-shadow: var(--shadow-md);
    position: sticky;
    top: 0;
    z-index: 1000;
    backdrop-filter: blur(10px);
    border-bottom: 1px solid var(--vc-border);
}

.navbar {
    display: flex;
    align-items: center;
    justify-content: space-between;
    padding: 1rem var(--spacing-md);
    max-width: 1200px;
    margin: 0 auto;
}

.navbar-brand {
    font-size: 1.5rem;
    font-weight: 700;
    color: var(--vc-primary);
    text-decoration: none;
    display: flex;
    align-items: center;
    gap: 0.5rem;
    transition: color var(--transition-base);
}

.navbar-brand:hover {
    color: var(--vc-accent);
}

.navbar-nav {
    display: flex;
    list-style: none;
    gap: 1.5rem;
    align-items: center;
}

.nav-link {
    color: var(--vc-text);
    text-decoration: none;
    font-weight: 500;
    padding: 0.5rem 1rem;
    border-radius: var(--radius-md);
    transition: all var(--transition-base);
    display: flex;
    align-items: center;
    gap: 0.5rem;
}

.nav-link:hover {
    color: var(--vc-accent);
    background: var(--vc-border-light);
}
/* ========== Modern Navbar Styles ========== */
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

/* ========== Navbar Brand ========== */
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

.brand-text {
    display: inline;
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
    position: fixed;
    width: 100%;
}

/* ========== Responsive Navbar ========== */
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

/* ========== Navigation Bar ========== */
nav {
    background: var(--vc-bg-light);
    box-shadow: var(--shadow-md);
    position: sticky;
    top: 0;
    z-index: 1000;
    backdrop-filter: blur(10px);
    border-bottom: 1px solid var(--vc-border);
}

.navbar {
    display: flex;
    align-items: center;
    justify-content: space-between;
    padding: 1rem var(--spacing-md);
    max-width: 1200px;
    margin: 0 auto;
}

.navbar-brand {
    font-size: 1.5rem;
    font-weight: 700;
    color: var(--vc-primary);
    text-decoration: none;
    display: flex;
    align-items: center;
    gap: 0.5rem;
    transition: color var(--transition-base);
}

.navbar-brand:hover {
    color: var(--vc-accent);
}

.navbar-nav {
    display: flex;
    list-style: none;
    gap: 1.5rem;
    align-items: center;
}

.nav-link {
    color: var(--vc-text);
    text-decoration: none;
    font-weight: 500;
    padding: 0.5rem 1rem;
    border-radius: var(--radius-md);
    transition: all var(--transition-base);
    display: flex;
    align-items: center;
    gap: 0.5rem;
}

.nav-link:hover {
    color: var(--vc-accent);
    background: var(--vc-border-light);
}

        /* Page Header */
        .page-header {
            background: var(--gradient-primary);
            padding: 3rem 0;
            margin-bottom: 2rem;
        }
        .page-header h1 {
            color: #ffffff;
            font-size: 2.25rem;
            font-weight: 800;
            display: flex;
            align-items: center;
            gap: 0.75rem;
            margin-bottom: 0.5rem;
        }
        .page-header p {
            color: rgba(255, 255, 255, 0.9);
            font-size: 1.1rem;
            margin: 0;
        }
        .breadcrumb-admin {
            display: flex;
            align-items: center;
            gap: 0.5rem;
            margin-top: 1rem;
            font-size: 0.9rem;
        }
        .breadcrumb-admin a { color: rgba(255, 255, 255, 0.7); text-decoration: none; }
        .breadcrumb-admin a:hover { color: #ffffff; }
        .breadcrumb-admin span { color: rgba(255, 255, 255, 0.5); }

        /* Cards */
        .admin-card {
            background: var(--vc-bg-light);
            border-radius: var(--radius-xl);
            box-shadow: var(--shadow-md);
            margin-bottom: 2rem;
            overflow: hidden;
        }
        .card-header-custom {
            background: var(--vc-bg);
            padding: 1.25rem 1.5rem;
            border-bottom: 1px solid var(--vc-border);
            display: flex;
            align-items: center;
            justify-content: space-between;
        }
        .card-title {
            display: flex;
            align-items: center;
            gap: 0.75rem;
            font-size: 1.1rem;
            font-weight: 700;
            color: var(--vc-primary);
            margin: 0;
        }
        .card-title i { color: var(--vc-accent); }
        .card-body-custom { padding: 1.5rem; }

        /* Form */
        .form-label { font-weight: 600; color: var(--vc-text); margin-bottom: 0.5rem; }
        .form-control {
            border: 2px solid var(--vc-border);
            border-radius: var(--radius-md);
            padding: 0.75rem 1rem;
            transition: all var(--transition-base);
        }
        .form-control:focus {
            border-color: var(--vc-accent);
            box-shadow: 0 0 0 3px rgba(0, 113, 194, 0.1);
        }
        .form-text { color: var(--vc-text-light); font-size: 0.85rem; }

        /* Buttons */
        .btn-primary-custom {
            background: var(--gradient-primary);
            color: #ffffff;
            border: none;
            padding: 0.75rem 1.5rem;
            border-radius: var(--radius-md);
            font-weight: 600;
            display: inline-flex;
            align-items: center;
            gap: 0.5rem;
            cursor: pointer;
            transition: all var(--transition-base);
        }
        .btn-primary-custom:hover {
            transform: translateY(-2px);
            box-shadow: var(--shadow-lg);
            color: #ffffff;
        }

        /* Table */
        .table-custom { width: 100%; border-collapse: separate; border-spacing: 0; }
        .table-custom th {
            background: var(--vc-bg);
            color: var(--vc-text-light);
            font-weight: 600;
            font-size: 0.85rem;
            text-transform: uppercase;
            letter-spacing: 0.5px;
            padding: 1rem;
            text-align: left;
            border-bottom: 2px solid var(--vc-border);
        }
        .table-custom td {
            padding: 1rem;
            border-bottom: 1px solid var(--vc-border);
            vertical-align: middle;
        }
        .table-custom tbody tr { transition: all var(--transition-base); }
        .table-custom tbody tr:hover { background: var(--vc-bg); }

        .item-name { font-weight: 700; color: var(--vc-primary); }
        .item-badge {
            display: inline-flex;
            align-items: center;
            gap: 0.5rem;
            background: var(--vc-bg);
            padding: 0.25rem 0.75rem;
            border-radius: var(--radius-md);
            font-size: 0.9rem;
        }
        .item-image {
            width: 60px;
            height: 40px;
            object-fit: cover;
            border-radius: var(--radius-md);
        }
        .item-status {
            display: inline-flex;
            align-items: center;
            gap: 0.35rem;
            padding: 0.35rem 0.75rem;
            border-radius: 9999px;
            font-size: 0.8rem;
            font-weight: 600;
        }
        .status-active { background: rgba(0, 170, 108, 0.1); color: var(--vc-success); }
        .status-inactive { background: rgba(220, 53, 69, 0.1); color: var(--vc-danger); }

        .action-buttons { display: flex; gap: 0.5rem; }
        .btn-action {
            width: 36px;
            height: 36px;
            display: inline-flex;
            align-items: center;
            justify-content: center;
            border: none;
            border-radius: var(--radius-md);
            cursor: pointer;
            transition: all var(--transition-base);
        }
        .btn-edit { background: rgba(0, 113, 194, 0.1); color: var(--vc-accent); }
        .btn-edit:hover { background: var(--vc-accent); color: #ffffff; }
        .btn-delete { background: rgba(220, 53, 69, 0.1); color: var(--vc-danger); }
        .btn-delete:hover { background: var(--vc-danger); color: #ffffff; }

        /* Alerts */
        .alert-custom {
            padding: 1rem 1.5rem;
            border-radius: var(--radius-lg);
            margin-bottom: 1.5rem;
            display: flex;
            align-items: center;
            gap: 0.75rem;
        }
        .alert-success-custom { background: rgba(0, 170, 108, 0.1); color: var(--vc-success); border: 1px solid rgba(0, 170, 108, 0.2); }
        .alert-danger-custom { background: rgba(220, 53, 69, 0.1); color: var(--vc-danger); border: 1px solid rgba(220, 53, 69, 0.2); }

        /* Empty State */
        .empty-state { text-align: center; padding: 3rem; color: var(--vc-text-light); }
        .empty-state i { font-size: 4rem; color: var(--vc-border); margin-bottom: 1rem; }

        @media (max-width: 768px) {
            .page-header h1 { font-size: 1.75rem; }
            
        }
    </style>
</head>
<body>
    <!-- navbar -->
    <nav class="navbar-modern">
    <div class="container">
        <div class="navbar-wrapper">
            <!-- Logo / Brand -->
            <a href="${pageContext.request.contextPath}/" class="navbar-brand">
                <i class="fas fa-plane-departure"></i>
                <span class="brand-text">VoyageConnect</span>
            </a>
            
            <!-- Main Navigation -->
            <div class="navbar-main">
                <a href="${pageContext.request.contextPath}/search/flights" class="nav-link">
                    <i class="fas fa-plane"></i>
                    <span>Vols</span>
                </a>
                <a href="${pageContext.request.contextPath}/search/hotels" class="nav-link">
                    <i class="fas fa-hotel"></i>
                    <span>Hôtels</span>
                </a>
                <a href="${pageContext.request.contextPath}/search/circuits" class="nav-link">
                    <i class="fas fa-route"></i>
                    <span>Circuits</span>
                </a>
                <a href="${pageContext.request.contextPath}/search/destinations" class="nav-link">
                    <i class="fas fa-globe-americas"></i>
                    <span>Destinations</span>
                </a>
            </div>
            
            <!-- User Section -->
            <div class="navbar-user">
                <c:choose>
                    <c:when test="${not empty sessionScope.user}">
                        <!-- User Dropdown -->
                        <div class="user-dropdown">
                            <button class="user-toggle" id="userMenuToggle">
                                <i class="fas fa-user-circle"></i>
                                <span class="user-name">${sessionScope.user.firstName}</span>
                                <i class="fas fa-chevron-down dropdown-arrow"></i>
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
                                <c:if test="${sessionScope.user.role == 'ADMIN'}">
                                    <a href="${pageContext.request.contextPath}/admin/dashboard" class="user-menu-item">
                                        <i class="fas fa-crown"></i>
                                        <span>Administration</span>
                                    </a>
                                    <div class="user-menu-divider"></div>
                                </c:if>
                                <a href="${pageContext.request.contextPath}/user/dashboard" class="user-menu-item">
                                    <i class="fas fa-chart-line"></i>
                                    <span>Tableau de bord</span>
                                </a>
                                <a href="${pageContext.request.contextPath}/user/profile" class="user-menu-item">
                                    <i class="fas fa-user"></i>
                                    <span>Mon profil</span>
                                </a>
                                <a href="${pageContext.request.contextPath}/reservation/list" class="user-menu-item">
                                    <i class="fas fa-ticket-alt"></i>
                                    <span>Mes réservations</span>
                                </a>
                                <div class="user-menu-divider"></div>
                                <a href="${pageContext.request.contextPath}/auth/logout" class="user-menu-item logout">
                                    <i class="fas fa-sign-out-alt"></i>
                                    <span>Déconnexion</span>
                                </a>
                            </div>
                        </div>
                    </c:when>
                    <c:otherwise>
                        <!-- Guest Actions -->
                        <a href="${pageContext.request.contextPath}/auth/login" class="btn-login">
                            <i class="fas fa-sign-in-alt"></i>
                            <span>Connexion</span>
                        </a>
                        <a href="${pageContext.request.contextPath}/auth/register" class="btn btn-highlight btn-sm">
                            <i class="fas fa-user-plus"></i>
                            <span>S'inscrire</span>
                        </a>
                    </c:otherwise>
                </c:choose>
            </div>
            
            <!-- Mobile Menu Toggle -->
            <button class="mobile-toggle" id="mobileMenuToggle">
                <i class="fas fa-bars"></i>
            </button>
        </div>
    </div>
    
    <!-- Mobile Menu -->
    <div class="mobile-menu" id="mobileMenu">
        <a href="${pageContext.request.contextPath}/" class="mobile-menu-item">
            <i class="fas fa-home"></i>
            <span>Accueil</span>
        </a>
        <a href="${pageContext.request.contextPath}/search/flights" class="mobile-menu-item">
            <i class="fas fa-plane"></i>
            <span>Vols</span>
        </a>
        <a href="${pageContext.request.contextPath}/search/hotels" class="mobile-menu-item">
            <i class="fas fa-hotel"></i>
            <span>Hôtels</span>
        </a>
        <a href="${pageContext.request.contextPath}/search/circuits" class="mobile-menu-item">
            <i class="fas fa-route"></i>
            <span>Circuits</span>
        </a>
        <a href="${pageContext.request.contextPath}/destinations" class="mobile-menu-item">
            <i class="fas fa-globe-americas"></i>
            <span>Destinations</span>
        </a>
        
        <c:choose>
            <c:when test="${not empty sessionScope.user}">
                <div class="mobile-menu-divider"></div>
                <div class="mobile-user-info">
                    <i class="fas fa-user-circle"></i>
                    <span>${sessionScope.user.firstName} ${sessionScope.user.lastName}</span>
                </div>
                <c:if test="${sessionScope.user.role == 'ADMIN'}">
                    <a href="${pageContext.request.contextPath}/admin/dashboard" class="mobile-menu-item">
                        <i class="fas fa-crown"></i>
                        <span>Administration</span>
                    </a>
                </c:if>
                <a href="${pageContext.request.contextPath}/user/dashboard" class="mobile-menu-item">
                    <i class="fas fa-chart-line"></i>
                    <span>Tableau de bord</span>
                </a>
                <a href="${pageContext.request.contextPath}/user/profile" class="mobile-menu-item">
                    <i class="fas fa-user"></i>
                    <span>Mon profil</span>
                </a>
                <a href="${pageContext.request.contextPath}/reservation/list" class="mobile-menu-item">
                    <i class="fas fa-ticket-alt"></i>
                    <span>Mes réservations</span>
                </a>
                <a href="${pageContext.request.contextPath}/auth/logout" class="mobile-menu-item logout">
                    <i class="fas fa-sign-out-alt"></i>
                    <span>Déconnexion</span>
                </a>
            </c:when>
            <c:otherwise>
                <div class="mobile-menu-divider"></div>
                <a href="${pageContext.request.contextPath}/auth/login" class="mobile-menu-item">
                    <i class="fas fa-sign-in-alt"></i>
                    <span>Connexion</span>
                </a>
                <a href="${pageContext.request.contextPath}/auth/register" class="mobile-menu-item highlight">
                    <i class="fas fa-user-plus"></i>
                    <span>S'inscrire</span>
                </a>
            </c:otherwise>
        </c:choose>
    </div>
    </nav>

    <!-- Navbar Admin -->
    

    <!-- Page Header -->
    <div class="page-header">
        <div class="container">
            <div class="page-header-content">
                <div>
                    <h1><i class="fas fa-map-marked-alt"></i> Gestion des Destinations</h1>
                    <p>Ajoutez, modifiez et gérez les destinations de voyage</p>
                </div>
                <a href="${pageContext.request.contextPath}/admin/dashboard" class="btn-back">
                        <i class="fas fa-arrow-left"></i> Retour au Dashboard
                </a>
            </div>
        </div>
    </div>

    <div class="container">
        <!-- Alerts -->
        <c:if test="${not empty success}">
            <div class="alert-custom alert-success-custom">
                <i class="fas fa-check-circle"></i>
                <span>${success}</span>
            </div>
        </c:if>
        <c:if test="${not empty error}">
            <div class="alert-custom alert-danger-custom">
                <i class="fas fa-exclamation-circle"></i>
                <span>${error}</span>
            </div>
        </c:if>

        <!-- Add Form -->
        <div class="admin-card">
            <div class="card-header-custom">
                <h2 class="card-title"><i class="fas fa-plus-circle"></i> Ajouter une nouvelle destination</h2>
            </div>
            <div class="card-body-custom">
                <form action="${pageContext.request.contextPath}/admin/create-destination" method="post">
                    <div class="row g-3">
                        <div class="col-md-6">
                            <label for="name" class="form-label">Nom de la destination *</label>
                            <input type="text" class="form-control" id="name" name="name" placeholder="Ex: Paris, Marrakech..." required>
                        </div>
                        <div class="col-md-6">
                            <label for="country" class="form-label">Pays *</label>
                            <input type="text" class="form-control" id="country" name="country" placeholder="Ex: France, Maroc..." required>
                        </div>
                        <div class="col-12">
                            <label for="description" class="form-label">Description *</label>
                            <textarea class="form-control" id="description" name="description" rows="3" placeholder="Décrivez cette destination..." required></textarea>
                        </div>
                        <div class="col-12">
                            <label for="imageUrl" class="form-label">URL de l'image</label>
                            <input type="url" class="form-control" id="imageUrl" name="imageUrl" placeholder="https://exemple.com/image.jpg">
                        </div>
                        <div class="col-12">
                            <button type="submit" class="btn-primary-custom">
                                <i class="fas fa-plus"></i> Ajouter la destination
                            </button>
                        </div>
                    </div>
                </form>
            </div>
        </div>

        <!-- List -->
        <div class="admin-card">
            <div class="card-header-custom">
                <h2 class="card-title"><i class="fas fa-list"></i> Liste des destinations</h2>
                <span class="badge bg-primary">${destinations.size()} destination(s)</span>
            </div>
            <div class="card-body-custom" style="padding: 0;">
                <c:choose>
                    <c:when test="${not empty destinations}">
                        <div class="table-responsive">
                            <table class="table-custom">
                                <thead>
                                    <tr>
                                        <th>ID</th>
                                        <th>Image</th>
                                        <th>Nom</th>
                                        <th>Pays</th>
                                        <th>Description</th>
                                        <th>Statut</th>
                                        <th>Actions</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <c:forEach items="${destinations}" var="dest">
                                        <tr>
                                            <td><strong>#${dest.id}</strong></td>
                                            <td>
                                                <c:choose>
                                                    <c:when test="${not empty dest.imageUrl}">
                                                        <img src="${dest.imageUrl}" alt="${dest.name}" class="item-image">
                                                    </c:when>
                                                    <c:otherwise>
                                                        <div class="item-image" style="background: var(--vc-border); display: flex; align-items: center; justify-content: center;">
                                                            <i class="fas fa-image" style="color: var(--vc-text-light);"></i>
                                                        </div>
                                                    </c:otherwise>
                                                </c:choose>
                                            </td>
                                            <td><span class="item-name">${dest.name}</span></td>
                                            <td><span class="item-badge"><i class="fas fa-globe"></i> ${dest.country}</span></td>
                                            <td style="max-width: 250px;">
                                                <span style="display: -webkit-box; -webkit-line-clamp: 2; -webkit-box-orient: vertical; overflow: hidden;">${dest.description}</span>
                                            </td>
                                            <td>
                                                <c:choose>
                                                    <c:when test="${dest.active}">
                                                        <span class="item-status status-active"><i class="fas fa-check-circle"></i> Actif</span>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <span class="item-status status-inactive"><i class="fas fa-times-circle"></i> Inactif</span>
                                                    </c:otherwise>
                                                </c:choose>
                                            </td>
                                            <td>
                                                <div class="action-buttons">
                                                    <button class="btn-action btn-edit" title="Modifier"><i class="fas fa-edit"></i></button>
                                                    <button class="btn-action btn-delete" title="Supprimer"><i class="fas fa-trash"></i></button>
                                                </div>
                                            </td>
                                        </tr>
                                    </c:forEach>
                                </tbody>
                            </table>
                        </div>
                    </c:when>
                    <c:otherwise>
                        <div class="empty-state">
                            <i class="fas fa-map-marked-alt"></i>
                            <h4>Aucune destination</h4>
                            <p>Commencez par ajouter votre première destination.</p>
                        </div>
                    </c:otherwise>
                </c:choose>
            </div>
        </div>
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
        //nav bar toggle
        // User Dropdown Toggle
document.addEventListener('DOMContentLoaded', function() {
    const userToggle = document.getElementById('userMenuToggle');
    const userMenu = document.getElementById('userMenu');
    const mobileToggle = document.getElementById('mobileMenuToggle');
    const mobileMenu = document.getElementById('mobileMenu');
    
    // Desktop user menu
    if (userToggle && userMenu) {
        userToggle.addEventListener('click', function(e) {
            e.stopPropagation();
            userMenu.classList.toggle('show');
            userToggle.classList.toggle('active');
        });
        
        // Close when clicking outside
        document.addEventListener('click', function(e) {
            if (!userToggle.contains(e.target) && !userMenu.contains(e.target)) {
                userMenu.classList.remove('show');
                userToggle.classList.remove('active');
            }
        });
    }
    
    // Mobile menu
    if (mobileToggle && mobileMenu) {
        mobileToggle.addEventListener('click', function() {
            mobileMenu.classList.toggle('show');
            mobileToggle.classList.toggle('active');
            document.body.classList.toggle('mobile-menu-open');
        });
    }
});
        // Animate bars on page load
        document.addEventListener('DOMContentLoaded', function() {
            setTimeout(function() {
                document.querySelectorAll('.bar-fill[data-width]').forEach(function(bar) {
                    var width = parseFloat(bar.getAttribute('data-width'));
                    width = Math.min(width, 100);
                    bar.style.width = width + '%';
                });
            }, 300);
        });
    </script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>

</body>
</html>
