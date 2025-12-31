<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Gestion des Hôtels - VoyageConnect Admin</title>
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
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
            --shadow-lg: 0 10px 15px -3px rgba(0, 0, 0, 0.1);
            --radius-md: 8px;
            --radius-lg: 12px;
            --radius-xl: 16px;
            --radius-full: 9999px;
            --transition-base: 250ms ease;
            --gradient-primary: linear-gradient(135deg, #003580 0%, #0057b8 100%);
            --gradient-admin: linear-gradient(135deg, #003580 0%, #003580 100%);
        }

        * { margin: 0; padding: 0; box-sizing: border-box; }

        body {
            font-family: -apple-system, BlinkMacSystemFont, "Segoe UI", Roboto, sans-serif;
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
            background: var(--gradient-admin);
            padding: 2.5rem 0;
            margin-bottom: 2rem;
        }

        .page-header-content {
            display: flex;
            justify-content: space-between;
            align-items: center;
            flex-wrap: wrap;
            gap: 1rem;
        }

        .page-header h1 {
            color: #ffffff;
            font-size: 1.75rem;
            font-weight: 700;
            display: flex;
            align-items: center;
            gap: 0.75rem;
        }

        .page-header .subtitle {
            color: rgba(255, 255, 255, 0.8);
            font-size: 0.95rem;
            margin-top: 0.25rem;
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

        /* Alerts */
        .alert {
            padding: 1rem 1.5rem;
            border-radius: var(--radius-lg);
            margin-bottom: 1.5rem;
            display: flex;
            align-items: center;
            gap: 0.75rem;
        }

        .alert-success { background: #d4edda; color: #155724; border: 1px solid #c3e6cb; }
        .alert-danger { background: #f8d7da; color: #721c24; border: 1px solid #f5c6cb; }

        .alert button {
            margin-left: auto;
            background: none;
            border: none;
            font-size: 1.25rem;
            cursor: pointer;
            opacity: 0.7;
        }

        /* Admin Cards */
        .admin-card {
            background: var(--vc-bg-light);
            border-radius: var(--radius-xl);
            box-shadow: var(--shadow-md);
            margin-bottom: 2rem;
            overflow: hidden;
        }

        .card-header {
            background: var(--vc-border-light);
            padding: 1.25rem 1.5rem;
            border-bottom: 1px solid var(--vc-border);
            display: flex;
            align-items: center;
            justify-content: space-between;
        }

        .card-header h2 {
            font-size: 1.1rem;
            font-weight: 700;
            color: var(--vc-primary);
            display: flex;
            align-items: center;
            gap: 0.5rem;
        }

        .card-body { padding: 1.5rem; }

        /* Form Styles */
        .form-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(220px, 1fr));
            gap: 1.25rem;
        }

        .form-group {
            display: flex;
            flex-direction: column;
            gap: 0.5rem;
        }

        .form-group.full-width { grid-column: 1 / -1; }

        .form-label {
            font-weight: 600;
            font-size: 0.875rem;
            color: var(--vc-text);
            display: flex;
            align-items: center;
            gap: 0.5rem;
        }

        .form-label .required { color: var(--vc-danger); }

        .form-control {
            padding: 0.75rem 1rem;
            border: 2px solid var(--vc-border);
            border-radius: var(--radius-md);
            font-size: 0.95rem;
            transition: all var(--transition-base);
            background: var(--vc-bg-light);
        }

        .form-control:focus {
            outline: none;
            border-color: var(--vc-accent);
            box-shadow: 0 0 0 3px rgba(0, 113, 194, 0.1);
        }

        textarea.form-control {
            min-height: 100px;
            resize: vertical;
        }

        /* Amenities Grid */
        .amenities-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(150px, 1fr));
            gap: 0.75rem;
        }

        .amenity-checkbox {
            display: flex;
            align-items: center;
            gap: 0.75rem;
            padding: 0.75rem;
            background: var(--vc-border-light);
            border-radius: var(--radius-md);
            cursor: pointer;
            transition: all var(--transition-base);
            border: 2px solid transparent;
        }

        .amenity-checkbox:hover {
            background: #e5e7eb;
        }

        .amenity-checkbox input {
            width: 18px;
            height: 18px;
            accent-color: var(--vc-accent);
        }

        .amenity-checkbox input:checked + .amenity-label {
            color: var(--vc-accent);
            font-weight: 600;
        }

        .amenity-label {
            display: flex;
            align-items: center;
            gap: 0.5rem;
            font-size: 0.875rem;
        }

        /* Buttons */
        .btn {
            display: inline-flex;
            align-items: center;
            justify-content: center;
            gap: 0.5rem;
            padding: 0.75rem 1.5rem;
            font-size: 0.95rem;
            font-weight: 600;
            border: none;
            border-radius: var(--radius-md);
            cursor: pointer;
            transition: all var(--transition-base);
            text-decoration: none;
        }

        .btn-primary { background: var(--gradient-primary); color: #ffffff; }
        .btn-primary:hover { transform: translateY(-2px); box-shadow: var(--shadow-lg); }

        .btn-success { background: linear-gradient(135deg, #00aa6c 0%, #00c97b 100%); color: #ffffff; }
        .btn-warning { background: linear-gradient(135deg, #febb02 0%, #ffcc33 100%); color: #1a1a1a; }
        .btn-danger { background: linear-gradient(135deg, #dc3545 0%, #e74c5e 100%); color: #ffffff; }
        .btn-sm { padding: 0.5rem 0.875rem; font-size: 0.8rem; }

        .form-actions {
            margin-top: 1.5rem;
            display: flex;
            gap: 1rem;
            flex-wrap: wrap;
        }

        /* Table */
        .table-responsive { overflow-x: auto; }

        .admin-table {
            width: 100%;
            border-collapse: separate;
            border-spacing: 0;
        }

        .admin-table th {
            background: var(--vc-border-light);
            color: var(--vc-text-light);
            font-weight: 600;
            font-size: 0.75rem;
            text-transform: uppercase;
            letter-spacing: 0.5px;
            padding: 0.875rem;
            text-align: left;
            border-bottom: 2px solid var(--vc-border);
        }

        .admin-table td {
            padding: 0.875rem;
            border-bottom: 1px solid var(--vc-border-light);
            vertical-align: middle;
            font-size: 0.9rem;
        }

        .admin-table tbody tr:hover { background: var(--vc-border-light); }

        .hotel-name {
            font-weight: 700;
            color: var(--vc-primary);
        }

        .stars {
            color: #ffc107;
            font-size: 0.9rem;
        }

        .location-badge {
            display: inline-flex;
            align-items: center;
            gap: 0.375rem;
            padding: 0.25rem 0.625rem;
            background: linear-gradient(135deg, #e0e7ff 0%, #c7d2fe 100%);
            color: #4338ca;
            border-radius: var(--radius-md);
            font-size: 0.8rem;
            font-weight: 500;
        }

        .price-tag {
            font-weight: 700;
            color: var(--vc-success);
        }

        .rooms-badge {
            padding: 0.25rem 0.5rem;
            border-radius: var(--radius-md);
            font-size: 0.8rem;
            font-weight: 600;
        }

        .rooms-ok { background: #dcfce7; color: #15803d; }
        .rooms-low { background: #fef3c7; color: #a16207; }
        .rooms-full { background: #fee2e2; color: #dc2626; }

        .amenity-icons {
            display: flex;
            gap: 0.5rem;
        }

        .amenity-icon {
            width: 28px;
            height: 28px;
            display: flex;
            align-items: center;
            justify-content: center;
            border-radius: 50%;
            font-size: 0.75rem;
        }

        .amenity-icon.active {
            background: #dcfce7;
            color: #15803d;
        }

        .amenity-icon.inactive {
            background: #f3f4f6;
            color: #9ca3af;
        }

        .action-buttons { display: flex; gap: 0.5rem; }

        .empty-state {
            text-align: center;
            padding: 3rem;
            color: var(--vc-text-light);
        }

        .empty-state i {
            font-size: 3rem;
            margin-bottom: 1rem;
            color: var(--vc-border);
        }

        /* Stats */
        .stats-row {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(140px, 1fr));
            gap: 1rem;
            margin-bottom: 1.5rem;
        }

        .stat-mini {
            background: var(--vc-border-light);
            padding: 1rem;
            border-radius: var(--radius-md);
            text-align: center;
        }

        .stat-mini-value {
            font-size: 1.5rem;
            font-weight: 700;
            color: var(--vc-primary);
        }

        .stat-mini-label { font-size: 0.8rem; color: var(--vc-text-light); }

        @media (max-width: 768px) {
            .page-header-content { flex-direction: column; text-align: center; }
            .form-grid { grid-template-columns: 1fr; }
            .amenities-grid { grid-template-columns: 1fr 1fr; }
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
                    <h1><i class="fas fa-hotel"></i> Gestion des Hôtels</h1>
                    <p class="subtitle">Ajoutez et gérez les hôtels partenaires de la plateforme</p>
                </div>
                <a href="${pageContext.request.contextPath}/admin/dashboard" class="btn-back">
                    <i class="fas fa-arrow-left"></i> Retour au Dashboard
                </a>
            </div>
        </div>
    </div>

    <div class="container">
        <!-- Messages -->
        <c:if test="${not empty success}">
            <div class="alert alert-success">
                <i class="fas fa-check-circle"></i>
                <span>${success}</span>
                <button onclick="this.parentElement.remove()">&times;</button>
            </div>
        </c:if>
        <c:if test="${not empty error}">
            <div class="alert alert-danger">
                <i class="fas fa-exclamation-circle"></i>
                <span>${error}</span>
                <button onclick="this.parentElement.remove()">&times;</button>
            </div>
        </c:if>

        <!-- Stats -->
        <div class="stats-row">
            <div class="stat-mini">
                <div class="stat-mini-value">${hotels != null ? hotels.size() : 0}</div>
                <div class="stat-mini-label">Total Hôtels</div>
            </div>
            <div class="stat-mini">
                <div class="stat-mini-value">${destinations != null ? destinations.size() : 0}</div>
                <div class="stat-mini-label">Destinations</div>
            </div>
        </div>

        <!-- Add New Hotel -->
        <div class="admin-card">
            <div class="card-header">
                <h2><i class="fas fa-plus-circle"></i> Ajouter un nouvel hôtel</h2>
            </div>
            <div class="card-body">
                <form action="${pageContext.request.contextPath}/admin/hotels" method="post">
                    <input type="hidden" name="action" value="create">
                    
                    <div class="form-grid">
                        <div class="form-group">
                            <label class="form-label">
                                <i class="fas fa-hotel"></i> Nom de l'hôtel <span class="required">*</span>
                            </label>
                            <input type="text" name="name" class="form-control" placeholder="Ex: Hôtel Royal Palace" required>
                        </div>

                        <div class="form-group">
                            <label class="form-label">
                                <i class="fas fa-map-marker-alt"></i> Destination <span class="required">*</span>
                            </label>
                            <select name="destinationId" class="form-control" required>
                                <option value="">-- Sélectionner une destination --</option>
                                <c:forEach items="${destinations}" var="dest">
                                    <option value="${dest.id}">${dest.name} (${dest.country})</option>
                                </c:forEach>
                            </select>
                        </div>

                        <div class="form-group">
                            <label class="form-label">
                                <i class="fas fa-star"></i> Étoiles <span class="required">*</span>
                            </label>
                            <select name="stars" class="form-control" required>
                                <option value="1">⭐ 1 étoile</option>
                                <option value="2">⭐⭐ 2 étoiles</option>
                                <option value="3">⭐⭐⭐ 3 étoiles</option>
                                <option value="4" selected>⭐⭐⭐⭐ 4 étoiles</option>
                                <option value="5">⭐⭐⭐⭐⭐ 5 étoiles</option>
                            </select>
                        </div>

                        <div class="form-group">
                            <label class="form-label">
                                <i class="fas fa-money-bill"></i> Prix par nuit (MAD) <span class="required">*</span>
                            </label>
                            <input type="number" name="pricePerNight" class="form-control" placeholder="500" min="0" step="0.01" required>
                        </div>

                        <div class="form-group">
                            <label class="form-label">
                                <i class="fas fa-bed"></i> Chambres totales <span class="required">*</span>
                            </label>
                            <input type="number" name="totalRooms" class="form-control" placeholder="50" min="1" required>
                        </div>

                        <div class="form-group">
                            <label class="form-label">
                                <i class="fas fa-map"></i> Adresse
                            </label>
                            <input type="text" name="address" class="form-control" placeholder="Ex: 123 Boulevard Mohammed V">
                        </div>

                        <div class="form-group full-width">
                            <label class="form-label">
                                <i class="fas fa-align-left"></i> Description
                            </label>
                            <textarea name="description" class="form-control" placeholder="Description de l'hôtel..."></textarea>
                        </div>

                        <div class="form-group full-width">
                            <label class="form-label">
                                <i class="fas fa-image"></i> URL de l'image
                            </label>
                            <input type="url" name="imageUrl" class="form-control" placeholder="https://example.com/image.jpg">
                        </div>

                        <div class="form-group full-width">
                            <label class="form-label">
                                <i class="fas fa-concierge-bell"></i> Services inclus
                            </label>
                            <div class="amenities-grid">
                                <label class="amenity-checkbox">
                                    <input type="checkbox" name="wifi" value="true" checked>
                                    <span class="amenity-label"><i class="fas fa-wifi"></i> WiFi gratuit</span>
                                </label>
                                <label class="amenity-checkbox">
                                    <input type="checkbox" name="pool" value="true">
                                    <span class="amenity-label"><i class="fas fa-swimming-pool"></i> Piscine</span>
                                </label>
                                <label class="amenity-checkbox">
                                    <input type="checkbox" name="restaurant" value="true">
                                    <span class="amenity-label"><i class="fas fa-utensils"></i> Restaurant</span>
                                </label>
                                <label class="amenity-checkbox">
                                    <input type="checkbox" name="parking" value="true">
                                    <span class="amenity-label"><i class="fas fa-parking"></i> Parking</span>
                                </label>
                            </div>
                        </div>
                    </div>

                    <div class="form-actions">
                        <button type="submit" class="btn btn-success">
                            <i class="fas fa-plus"></i> Ajouter l'hôtel
                        </button>
                        <button type="reset" class="btn btn-warning">
                            <i class="fas fa-undo"></i> Réinitialiser
                        </button>
                    </div>
                </form>
            </div>
        </div>

        <!-- Hotels List -->
        <div class="admin-card">
            <div class="card-header">
                <h2><i class="fas fa-list"></i> Liste des hôtels</h2>
            </div>
            <div class="card-body">
                <c:choose>
                    <c:when test="${not empty hotels}">
                        <div class="table-responsive">
                            <table class="admin-table">
                                <thead>
                                    <tr>
                                        <th>Hôtel</th>
                                        <th>Destination</th>
                                        <th>Étoiles</th>
                                        <th>Prix/Nuit</th>
                                        <th>Chambres</th>
                                        <th>Services</th>
                                        <th>Actions</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <c:forEach items="${hotels}" var="hotel">
                                        <tr>
                                            <td><span class="hotel-name">${hotel.name}</span></td>
                                            <td>
                                                <span class="location-badge">
                                                    <i class="fas fa-map-marker-alt"></i> ${hotel.destination.name}
                                                </span>
                                            </td>
                                            <td>
                                                <span class="stars">
                                                    <c:forEach begin="1" end="${hotel.stars}">⭐</c:forEach>
                                                </span>
                                            </td>
                                            <td>
                                                <span class="price-tag">
                                                    <fmt:formatNumber value="${hotel.pricePerNight}" type="number" maxFractionDigits="0"/> MAD
                                                </span>
                                            </td>
                                            <td>
                                                <c:choose>
                                                    <c:when test="${hotel.availableRooms > 10}">
                                                        <span class="rooms-badge rooms-ok">${hotel.availableRooms}/${hotel.totalRooms}</span>
                                                    </c:when>
                                                    <c:when test="${hotel.availableRooms > 0}">
                                                        <span class="rooms-badge rooms-low">${hotel.availableRooms}/${hotel.totalRooms}</span>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <span class="rooms-badge rooms-full">Complet</span>
                                                    </c:otherwise>
                                                </c:choose>
                                            </td>
                                            <td>
                                                <div class="amenity-icons">
                                                    <span class="amenity-icon ${hotel.wifi ? 'active' : 'inactive'}" title="WiFi">
                                                        <i class="fas fa-wifi"></i>
                                                    </span>
                                                    <span class="amenity-icon ${hotel.pool ? 'active' : 'inactive'}" title="Piscine">
                                                        <i class="fas fa-swimming-pool"></i>
                                                    </span>
                                                    <span class="amenity-icon ${hotel.restaurant ? 'active' : 'inactive'}" title="Restaurant">
                                                        <i class="fas fa-utensils"></i>
                                                    </span>
                                                    <span class="amenity-icon ${hotel.parking ? 'active' : 'inactive'}" title="Parking">
                                                        <i class="fas fa-parking"></i>
                                                    </span>
                                                </div>
                                            </td>
                                            <td>
                                                <div class="action-buttons">
                                                    <button class="btn btn-warning btn-sm" onclick="editHotel('${hotel.id}')">
                                                        <i class="fas fa-edit"></i>
                                                    </button>
                                                    <form action="${pageContext.request.contextPath}/admin/hotels" method="post" style="display: inline;" onsubmit="return confirm('Supprimer cet hotel ?');">
                                                        <input type="hidden" name="action" value="delete">
                                                        <input type="hidden" name="id" value="${hotel.id}">
                                                        <button type="submit" class="btn btn-danger btn-sm">
                                                            <i class="fas fa-trash"></i>
                                                        </button>
                                                    </form>
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
                            <i class="fas fa-hotel"></i>
                            <p>Aucun hôtel enregistré</p>
                        </div>
                    </c:otherwise>
                </c:choose>
            </div>
        </div>
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
        function editHotel(id) {
            alert('Fonctionnalité de modification en cours de développement. ID: ' + id);
        }
    </script>
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
