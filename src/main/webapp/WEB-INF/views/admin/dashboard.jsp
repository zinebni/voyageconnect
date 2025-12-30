<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Dashboard Admin - VoyageConnect</title>
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
    <style>
/* ========== CSS Variables (Navbar Only) ========== */
:root {
    --vc-primary: #003580;
    --vc-accent: #0071c2;
    --vc-bg-light: #ffffff;
    --vc-text: #1a1a1a;
    --vc-text-light: #6b7280;
    --vc-border: #e5e7eb;
    --vc-border-light: #f3f4f6;
    --vc-danger: #dc3545;
    --shadow-md: 0 4px 6px -1px rgba(0, 0, 0, 0.1);
    --shadow-xl: 0 20px 25px -5px rgba(0, 0, 0, 0.1);
    --radius-md: 8px;
    --radius-lg: 12px;
    --radius-full: 9999px;
    --transition-base: 250ms cubic-bezier(0.4, 0, 0.2, 1);
    --transition-slow: 350ms cubic-bezier(0.4, 0, 0.2, 1);
    --gradient-primary: linear-gradient(135deg, #003580 0%, #0057b8 100%);
}

/* ========== Base ========== */
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
            -moz-osx-font-smoothing: grayscale;
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

        /* ============================================= */
        /* Admin Dashboard Styles */
        .admin-dashboard-header {
            background: linear-gradient(135deg, #dc3545 0%, #c82333 100%);
            color: white;
            padding: 3rem 0;
            margin-bottom: 2rem;
        }
        
        .admin-dashboard-header h1 {
            color: white;
            font-size: 2.5rem;
            font-weight: 800;
            margin-bottom: 0.5rem;
            display: flex;
            align-items: center;
            gap: 0.75rem;
        }
        
        .admin-dashboard-header p {
            font-size: 1.125rem;
            opacity: 0.9;
            margin: 0;
        }
        
        .admin-badge {
            display: inline-flex;
            align-items: center;
            gap: 0.5rem;
            padding: 0.5rem 1rem;
            background: rgba(255, 255, 255, 0.2);
            border-radius: 9999px;
            font-weight: 600;
            font-size: 0.875rem;
            margin-top: 1rem;
        }
        
        /* Stats Grid */
        .stats-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(220px, 1fr));
            gap: 2.5rem;
            margin-bottom: 2rem;
        }
        
        .stat-card {
            background: white;
            border-radius: 16px;
            padding: 2rem;
            box-shadow: 0 2px 8px rgba(0, 0, 0, 0.08);
            border: 1px solid #e5e7eb;
            transition: all 0.25s ease;
            text-align: center;
        }
        
        .stat-card:hover {
            transform: translateY(-4px);
            box-shadow: 0 8px 24px rgba(0, 0, 0, 0.12);
        }
        
        .stat-icon {
            font-size: 3rem;
            margin-bottom: 1rem;
        }
        
        .stat-icon.blue { color: #0071c2; }
        .stat-icon.green { color: #00aa6c; }
        .stat-icon.yellow { color: #febb02; }
        .stat-icon.red { color: #dc3545; }
        .stat-icon.purple { color: #9b59b6; }
        .stat-icon.orange { color: #f39c12; }
        
        .stat-value {
            font-size: 2.5rem;
            font-weight: 800;
            color: #003580;
            line-height: 1;
            margin-bottom: 0.5rem;
        }
        
        .stat-label {
            color: #6b7280;
            font-size: 0.875rem;
            font-weight: 600;
            text-transform: uppercase;
            letter-spacing: 0.5px;
        }
        
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
        
        /* Charts */
        .chart-container {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(350px, 1fr));
            gap: 2rem;
        }
        
        .chart-box {
            background: #f9fafb;
            border-radius: 12px;
            padding: 1.5rem;
            border: 1px solid #e5e7eb;
        }
        
        .chart-title {
            color: #003580;
            font-weight: 700;
            font-size: 1.125rem;
            margin-bottom: 1.5rem;
            display: flex;
            align-items: center;
            gap: 0.5rem;
        }
        
        .chart-title i {
            color: #0071c2;
        }
        
        .bar-item {
            display: flex;
            align-items: center;
            margin-bottom: 1.25rem;
            gap: 1rem;
        }
        
        .bar-label {
            min-width: 120px;
            font-weight: 600;
            color: #1a1a1a;
            font-size: 0.9rem;
        }
        
        .bar-wrapper {
            flex: 1;
            background: #e5e7eb;
            border-radius: 9999px;
            height: 32px;
            position: relative;
            overflow: hidden;
        }
        
        .bar-fill {
            height: 100%;
            background: linear-gradient(135deg, #003580 0%, #0071c2 100%);
            border-radius: 9999px;
            display: flex;
            align-items: center;
            justify-content: flex-end;
            padding-right: 0.75rem;
            transition: width 1s ease-out;
            box-shadow: inset 0 1px 2px rgba(0, 0, 0, 0.1);
        }
        
        .bar-value {
            color: white;
            font-weight: 700;
            font-size: 0.875rem;
        }
        
        /* Table */
        .admin-table {
            width: 100%;
            border-collapse: separate;
            border-spacing: 0;
        }
        
        .admin-table th {
            background: #f9fafb;
            color: #6b7280;
            font-weight: 600;
            font-size: 0.875rem;
            text-transform: uppercase;
            letter-spacing: 0.5px;
            padding: 1rem;
            text-align: left;
            border-bottom: 2px solid #e5e7eb;
        }
        
        .admin-table td {
            padding: 1rem;
            border-bottom: 1px solid #f3f4f6;
            color: #1a1a1a;
        }
        
        .admin-table tbody tr {
            transition: all 0.2s ease;
        }
        
        .admin-table tbody tr:hover {
            background: #f9fafb;
        }
        
        .reservation-id {
            font-weight: 700;
            color: #003580;
        }
        
        .type-badge {
            display: inline-flex;
            align-items: center;
            gap: 0.5rem;
            padding: 0.375rem 0.75rem;
            border-radius: 9999px;
            font-size: 0.875rem;
            font-weight: 600;
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
            gap: 0.375rem;
            padding: 0.375rem 0.75rem;
            border-radius: 9999px;
            font-size: 0.875rem;
            font-weight: 600;
        }
        
        .status-badge.confirmee {
            background: #dcfce7;
            color: #15803d;
        }
        
        .status-badge.enattente {
            background: #fef3c7;
            color: #a16207;
        }
        
        .status-badge.annulee {
            background: #fee2e2;
            color: #dc2626;
        }
        
        /* Action Buttons for Reservation Management */
        .btn-action {
            display: inline-flex;
            align-items: center;
            gap: 0.35rem;
            padding: 0.5rem 0.875rem;
            border: none;
            border-radius: 6px;
            font-size: 0.8rem;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.2s ease;
            text-decoration: none;
        }
        
        .btn-action i {
            font-size: 0.75rem;
        }
        
        .btn-confirm {
            background: linear-gradient(135deg, #00aa6c 0%, #008f5a 100%);
            color: white;
            box-shadow: 0 2px 4px rgba(0, 170, 108, 0.3);
        }
        
        .btn-confirm:hover {
            background: linear-gradient(135deg, #00c77d 0%, #00aa6c 100%);
            transform: translateY(-1px);
            box-shadow: 0 4px 8px rgba(0, 170, 108, 0.4);
        }
        
        .btn-cancel {
            background: linear-gradient(135deg, #dc3545 0%, #c82333 100%);
            color: white;
            box-shadow: 0 2px 4px rgba(220, 53, 69, 0.3);
        }
        
        .btn-cancel:hover {
            background: linear-gradient(135deg, #e84a59 0%, #dc3545 100%);
            transform: translateY(-1px);
            box-shadow: 0 4px 8px rgba(220, 53, 69, 0.4);
        }
        
        /* View Details Button */
        .btn-view-details {
            display: inline-flex;
            align-items: center;
            gap: 0.35rem;
            padding: 0.5rem 0.875rem;
            border: none;
            border-radius: 6px;
            font-size: 0.8rem;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.2s ease;
            text-decoration: none;
            background: linear-gradient(135deg, #0071c2 0%, #003580 100%);
            color: white;
            box-shadow: 0 2px 4px rgba(0, 113, 194, 0.3);
        }
        
        .btn-view-details:hover {
            background: linear-gradient(135deg, #0088e8 0%, #0071c2 100%);
            transform: translateY(-1px);
            box-shadow: 0 4px 8px rgba(0, 113, 194, 0.4);
            color: white;
        }
        
        .btn-view-details i {
            font-size: 0.85rem;
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
        
        /* Empty State */
        .empty-state {
            text-align: center;
            padding: 3rem;
            color: #9ca3af;
        }
        
        .empty-state i {
            font-size: 4rem;
            margin-bottom: 1rem;
            color: #e5e7eb;
        }
        
        /* Responsive */
        @media (max-width: 768px) {
            .admin-dashboard-header h1 {
                font-size: 1.75rem;
                flex-direction: column;
                gap: 0.5rem;
            }
            
            .stats-grid {
                grid-template-columns: 1fr;
            }
            
            .chart-container {
                grid-template-columns: 1fr;
            }
            
            .quick-actions-grid {
                grid-template-columns: 1fr;
            }
            
            .admin-table {
                font-size: 0.875rem;
            }
            
            .admin-table th,
            .admin-table td {
                padding: 0.75rem 0.5rem;
            }
        }
    </style>
</head>
<body class="page-wrapper">
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
    
    <!-- Admin Header -->
    <div class="admin-dashboard-header">
        <div class="container">
            <h1>
                <i class="fas fa-shield-halved"></i> Tableau de bord Administrateur
            </h1>
            <p>Vue d'ensemble et gestion de la plateforme VoyageConnect</p>
            <div class="admin-badge">
                <i class="fas fa-crown"></i>
                <span>Accès Administrateur</span>
            </div>
        </div>
    </div>

    <div class="container">
        <!-- Main Statistics -->
        <div class="stats-grid">
            <div class="stat-card">
                <div class="stat-icon blue">
                    <i class="fas fa-users"></i>
                </div>
                <div class="stat-value">${totalUsers}</div>
                <div class="stat-label">Utilisateurs</div>
            </div>
            
            <div class="stat-card">
                <div class="stat-icon green">
                    <i class="fas fa-plane"></i>
                </div>
                <div class="stat-value">${totalFlights}</div>
                <div class="stat-label">Vols</div>
            </div>
            
            <div class="stat-card">
                <div class="stat-icon yellow">
                    <i class="fas fa-hotel"></i>
                </div>
                <div class="stat-value">${totalHotels}</div>
                <div class="stat-label">Hôtels</div>
            </div>
            
            <div class="stat-card">
                <div class="stat-icon red">
                    <i class="fas fa-route"></i>
                </div>
                <div class="stat-value">${totalCircuits}</div>
                <div class="stat-label">Circuits</div>
            </div>
            
            <div class="stat-card">
                <div class="stat-icon purple">
                    <i class="fas fa-map-marked-alt"></i>
                </div>
                <div class="stat-value">${totalDestinations}</div>
                <div class="stat-label">Destinations</div>
            </div>
        </div>
        
        <!-- Reservations Statistics -->
        <div class="section-card">
            <div class="section-header">
                <h2 class="section-title">
                    <i class="fas fa-chart-line"></i> Statistiques des Réservations
                </h2>
            </div>
            
            <div class="stats-grid">
                <div class="stat-card">
                    <div class="stat-icon blue">
                        <i class="fas fa-clipboard-list"></i>
                    </div>
                    <div class="stat-value">${totalReservations}</div>
                    <div class="stat-label">Total</div>
                </div>
                
                <div class="stat-card">
                    <div class="stat-icon green">
                        <i class="fas fa-check-circle"></i>
                    </div>
                    <div class="stat-value">${confirmedReservations}</div>
                    <div class="stat-label">Confirmées</div>
                </div>
                
                <div class="stat-card">
                    <div class="stat-icon yellow">
                        <i class="fas fa-clock"></i>
                    </div>
                    <div class="stat-value">${pendingReservations}</div>
                    <div class="stat-label">En attente</div>
                </div>
                
                <div class="stat-card">
                    <div class="stat-icon red">
                        <i class="fas fa-times-circle"></i>
                    </div>
                    <div class="stat-value">${cancelledReservations}</div>
                    <div class="stat-label">Annulées</div>
                </div>
            </div>
        </div>
        
        <!-- Revenue Statistics -->
        <div class="section-card">
            <div class="section-header">
                <h2 class="section-title">
                    <i class="fas fa-money-bill-trend-up"></i> Revenus
                </h2>
            </div>
            
            <div class="stats-grid">
                <div class="stat-card">
                    <div class="stat-icon green">
                        <i class="fas fa-sack-dollar"></i>
                    </div>
                    <div class="stat-value">
                        <fmt:formatNumber value="${totalRevenue}" type="currency" currencySymbol="" maxFractionDigits="0"/> MAD
                    </div>
                    <div class="stat-label">Revenus totaux</div>
                </div>
                
                <div class="stat-card">
                    <div class="stat-icon blue">
                        <i class="fas fa-calendar-check"></i>
                    </div>
                    <div class="stat-value">
                        <fmt:formatNumber value="${monthlyRevenue}" type="currency" currencySymbol="" maxFractionDigits="0"/> MAD
                    </div>
                    <div class="stat-label">Ce mois</div>
                </div>
            </div>
        </div>
        
        <!-- Charts Section -->
        <div class="section-card">
            <div class="section-header">
                <h2 class="section-title">
                    <i class="fas fa-chart-bar"></i> Statistiques Détaillées
                </h2>
            </div>
            
            <div class="chart-container">
                <!-- Reservations by Type -->
                <div class="chart-box">
                    <h4 class="chart-title">
                        <i class="fas fa-chart-pie"></i>
                        Réservations par type
                    </h4>
                    <c:choose>
                        <c:when test="${not empty reservationsByType}">
                            <c:forEach items="${reservationsByType}" var="entry">
                                <c:set var="percentage" value="${(entry.value / totalReservations) * 100}" />
                                <div class="bar-item">
                                    <span class="bar-label">${entry.key}</span>
                                    <div class="bar-wrapper">
                                        <div class="bar-fill" data-width="${percentage}">
                                            <span class="bar-value">${entry.value}</span>
                                        </div>
                                    </div>
                                </div>
                            </c:forEach>
                        </c:when>
                        <c:otherwise>
                            <div class="empty-state">
                                <i class="fas fa-chart-simple"></i>
                                <p>Aucune donnée disponible</p>
                            </div>
                        </c:otherwise>
                    </c:choose>
                </div>
                
                <!-- Popular Destinations -->
                <div class="chart-box">
                    <h4 class="chart-title">
                        <i class="fas fa-map-location-dot"></i>
                        Destinations populaires
                    </h4>
                    <c:choose>
                        <c:when test="${not empty popularDestinations}">
                            <c:forEach items="${popularDestinations}" var="entry" varStatus="status">
                                <c:if test="${status.index < 5}">
                                    <c:set var="maxValue" value="${popularDestinations[0].value}" />
                                    <c:set var="destPercentage" value="${(entry.value / maxValue) * 100}" />
                                    <div class="bar-item">
                                        <span class="bar-label">${entry.key}</span>
                                        <div class="bar-wrapper">
                                            <div class="bar-fill" data-width="${destPercentage}">
                                                <span class="bar-value">${entry.value}</span>
                                            </div>
                                        </div>
                                    </div>
                                </c:if>
                            </c:forEach>
                        </c:when>
                        <c:otherwise>
                            <div class="empty-state">
                                <i class="fas fa-map"></i>
                                <p>Aucune destination</p>
                            </div>
                        </c:otherwise>
                    </c:choose>
                </div>
            </div>
        </div>
        
        <!-- Messages de succès/erreur -->
        <c:if test="${not empty sessionScope.success}">
            <div class="alert alert-success" style="background: #d4edda; color: #155724; padding: 1rem 1.5rem; border-radius: 12px; margin-bottom: 1.5rem; display: flex; align-items: center; gap: 0.75rem; border: 1px solid #c3e6cb;">
                <i class="fas fa-check-circle" style="font-size: 1.25rem;"></i>
                <span>${sessionScope.success}</span>
                <button onclick="this.parentElement.remove()" style="margin-left: auto; background: none; border: none; color: #155724; cursor: pointer; font-size: 1.25rem;">&times;</button>
            </div>
            <c:remove var="success" scope="session"/>
        </c:if>
        <c:if test="${not empty sessionScope.error}">
            <div class="alert alert-danger" style="background: #f8d7da; color: #721c24; padding: 1rem 1.5rem; border-radius: 12px; margin-bottom: 1.5rem; display: flex; align-items: center; gap: 0.75rem; border: 1px solid #f5c6cb;">
                <i class="fas fa-exclamation-circle" style="font-size: 1.25rem;"></i>
                <span>${sessionScope.error}</span>
                <button onclick="this.parentElement.remove()" style="margin-left: auto; background: none; border: none; color: #721c24; cursor: pointer; font-size: 1.25rem;">&times;</button>
            </div>
            <c:remove var="error" scope="session"/>
        </c:if>
        
        <!-- ========== GESTION DES RÉSERVATIONS ========== -->
        <div class="section-card">
            <div class="section-header">
                <h2 class="section-title">
                    <i class="fas fa-tasks"></i> Gestion des Réservations
                </h2>
                <span style="background: #febb02; color: #1a1a1a; padding: 0.5rem 1rem; border-radius: 20px; font-weight: 600; font-size: 0.875rem;">
                    <i class="fas fa-clock"></i> ${pendingReservations} en attente
                </span>
            </div>
            
            <c:choose>
                <c:when test="${not empty recentReservations}">
                    <div style="overflow-x: auto;">
                        <table class="admin-table">
                            <thead>
                                <tr>
                                    <th><i class="fas fa-hashtag"></i> N° Résa</th>
                                    <th><i class="fas fa-tag"></i> Type</th>
                                    <th><i class="fas fa-user"></i> Client</th>
                                    <th><i class="fas fa-envelope"></i> Email</th>
                                    <th><i class="fas fa-info"></i> Détails</th>
                                    <th><i class="fas fa-money-bill"></i> Montant</th>
                                    <th><i class="fas fa-flag"></i> Statut</th>
                                    <th><i class="fas fa-eye"></i> Voir</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach items="${recentReservations}" var="res">
                                    <tr>
                                        <td><span class="reservation-id">${res.reservationNumber}</span></td>
                                        <td>
                                            <c:choose>
                                                <c:when test="${res.type == 'FLIGHT'}">
                                                    <span class="type-badge flight">
                                                        <i class="fas fa-plane"></i> Vol
                                                    </span>
                                                </c:when>
                                                <c:when test="${res.type == 'HOTEL'}">
                                                    <span class="type-badge hotel">
                                                        <i class="fas fa-hotel"></i> Hôtel
                                                    </span>
                                                </c:when>
                                                <c:when test="${res.type == 'CIRCUIT'}">
                                                    <span class="type-badge circuit">
                                                        <i class="fas fa-route"></i> Circuit
                                                    </span>
                                                </c:when>
                                                <c:when test="${res.type == 'PACKAGE'}">
                                                    <span class="type-badge" style="background: #e8d5f9; color: #9b59b6;">
                                                        <i class="fas fa-box"></i> Package
                                                    </span>
                                                </c:when>
                                            </c:choose>
                                        </td>
                                        <td><strong>${res.user.firstName} ${res.user.lastName}</strong></td>
                                        <td style="font-size: 0.85rem; color: #666;">${res.user.email}</td>
                                        <td style="font-size: 0.85rem; max-width: 200px;">
                                            <c:choose>
                                                <c:when test="${res.type == 'FLIGHT' and not empty res.flight}">
                                                    ${res.flight.flightNumber} - ${res.flight.departureCity} → ${res.flight.destination.name}
                                                </c:when>
                                                <c:when test="${res.type == 'HOTEL' and not empty res.hotel}">
                                                    ${res.hotel.name} (${res.hotel.stars}★)
                                                </c:when>
                                                <c:when test="${res.type == 'CIRCUIT' and not empty res.circuit}">
                                                    ${res.circuit.name} - ${res.circuit.durationDays}j
                                                </c:when>
                                                <c:when test="${res.type == 'PACKAGE'}">
                                                    <c:if test="${not empty res.flight}">Vol: ${res.flight.flightNumber}</c:if>
                                                    <c:if test="${not empty res.hotel}"> + ${res.hotel.name}</c:if>
                                                </c:when>
                                            </c:choose>
                                        </td>
                                        <td>
                                            <strong style="color: #00aa6c;">
                                                <fmt:formatNumber value="${res.totalAmount}" type="currency" currencySymbol="" maxFractionDigits="0"/> MAD
                                            </strong>
                                        </td>
                                        <td>
                                            <c:choose>
                                                <c:when test="${res.status == 'CONFIRMEE'}">
                                                    <span class="status-badge confirmee">
                                                        <i class="fas fa-check-circle"></i> Confirmée
                                                    </span>
                                                </c:when>
                                                <c:when test="${res.status == 'EN_ATTENTE'}">
                                                    <span class="status-badge enattente">
                                                        <i class="fas fa-clock"></i> En attente
                                                    </span>
                                                </c:when>
                                                <c:when test="${res.status == 'ANNULEE'}">
                                                    <span class="status-badge annulee">
                                                        <i class="fas fa-times-circle"></i> Annulée
                                                    </span>
                                                </c:when>
                                            </c:choose>
                                        </td>
                                        <td>
                                            <a href="${pageContext.request.contextPath}/admin/reservation/view?id=${res.id}" 
                                               class="btn-view-details" 
                                               title="Voir les détails et gérer la réservation">
                                                <i class="fas fa-eye"></i> Voir détails
                                            </a>
                                        </td>
                                    </tr>
                                </c:forEach>
                            </tbody>
                        </table>
                    </div>
                </c:when>
                <c:otherwise>
                    <div class="empty-state">
                        <i class="fas fa-inbox"></i>
                        <p>Aucune réservation à gérer</p>
                    </div>
                </c:otherwise>
            </c:choose>
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
