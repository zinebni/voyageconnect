<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.time.format.DateTimeFormatter" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Recherche de Vols - VoyageConnect</title>
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">
    <style>
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
        
        /* Base */
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
           width: 100%;
           max-width: 1200px;
           margin: 0 auto;
           padding: 0 var(--spacing-md);
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
            background: linear-gradient(135deg, #003580 0%, #0057b8 100%);
            padding: 3rem 0;
            text-align: center;
            margin-bottom: 3rem;
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
        }
        
        .page-header h1 {
            color: #ffffff;
            font-size: 2.5rem;
            font-weight: 800;
            margin-bottom: 0.5rem;
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 0.75rem;
        }
        
        .page-header .lead-text {
            color: rgba(255, 255, 255, 0.9);
            font-size: 1.25rem;
            margin: 0;
        }
        
        /* Search Form */
        .search-form-container {
            background: #ffffff;
            border-radius: 16px;
            padding: 2rem;
            box-shadow: 0 2px 8px rgba(0, 0, 0, 0.08);
            margin-bottom: 3rem;
            border: 1px solid #e5e7eb;
        }
        
        .search-form-container h3 {
            color: #003580;
            margin-bottom: 1.5rem;
            display: flex;
            align-items: center;
            gap: 0.5rem;
            font-size: 1.5rem;
        }
        
        .form-row {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
            gap: 1rem;
            align-items: end;
        }
        
        .form-label {
            display: flex;
            align-items: center;
            gap: 0.5rem;
            font-weight: 600;
            color: #1a1a1a;
            margin-bottom: 0.5rem;
            font-size: 0.9rem;
        }
        
        .form-control, .form-select {
            width: 100%;
            padding: 0.75rem 1rem;
            font-size: 1rem;
            border: 2px solid #e5e7eb;
            border-radius: 8px;
            background: #ffffff;
            color: #1a1a1a;
            transition: all 0.25s ease;
            outline: none;
        }
        
        .form-control:focus, .form-select:focus {
            border-color: #0071c2;
            box-shadow: 0 0 0 3px rgba(0, 113, 194, 0.1);
        }
        
        /* Button */
        .btn {
            display: inline-flex;
            align-items: center;
            justify-content: center;
            gap: 0.5rem;
            padding: 0.75rem 1.5rem;
            font-size: 1rem;
            font-weight: 600;
            text-decoration: none;
            border: none;
            border-radius: 8px;
            cursor: pointer;
            transition: all 0.25s ease;
        }
        
        .btn-highlight {
            background: linear-gradient(135deg, #003580 0%, #0057b8 100%);
            color: #ffffff;
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
        }
        
        .btn-highlight:hover {
            background: linear-gradient(135deg, #0071c2 0%, #003580 100%);
            box-shadow: 0 10px 15px rgba(0, 0, 0, 0.2);
            transform: translateY(-2px);
            color: #ffffff;
        }
        
        /* Alert */
        .alert {
            padding: 1rem 1.5rem;
            border-radius: 12px;
            margin-bottom: 2rem;
            display: flex;
            align-items: center;
            gap: 0.75rem;
        }
        
        .alert-error {
            background: #fee2e2;
            border: 2px solid #fecaca;
            color: #dc2626;
        }
        
        .alert-error i {
            font-size: 1.25rem;
        }
        
        /* Results Header */
        .results-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 2rem;
            flex-wrap: wrap;
            gap: 1rem;
        }
        
        .results-header h2 {
            color: #003580;
            font-size: 1.75rem;
            margin: 0;
            display: flex;
            align-items: center;
            gap: 0.5rem;
        }
        
        .results-count {
            color: #6b7280;
            font-weight: 400;
            font-size: 1.25rem;
        }
        
        .results-info {
            display: flex;
            align-items: center;
            gap: 0.5rem;
            padding: 0.5rem 1rem;
            background: #f3f4f6;
            border-radius: 8px;
            color: #6b7280;
            font-size: 0.9rem;
        }
        
        .results-info i {
            color: #0071c2;
        }
        
        /* Flights List */
        .flights-list {
            display: flex;
            flex-direction: column;
            gap: 1.5rem;
            margin-bottom: 3rem;
        }
        
        .flight-card {
            background: #ffffff;
            border-radius: 16px;
            padding: 1.5rem;
            box-shadow: 0 2px 8px rgba(0, 0, 0, 0.08);
            border: 1px solid #e5e7eb;
            transition: all 0.25s ease;
        }
        
        .flight-card:hover {
            transform: translateY(-4px);
            box-shadow: 0 8px 24px rgba(0, 0, 0, 0.12);
        }
        
        /* Flight Header */
        .flight-header {
            display: flex;
            justify-content: space-between;
            align-items: flex-start;
            margin-bottom: 1.5rem;
            padding-bottom: 1rem;
            border-bottom: 2px solid #f3f4f6;
            gap: 1rem;
        }
        
        .flight-number {
            color: #003580;
            font-size: 1.5rem;
            font-weight: 700;
            margin-bottom: 0.5rem;
            display: flex;
            align-items: center;
            gap: 0.5rem;
        }
        
        .flight-number i {
            color: #0071c2;
        }
        
        .flight-airline {
            color: #6b7280;
            font-size: 0.95rem;
            margin: 0;
            display: flex;
            align-items: center;
            gap: 0.5rem;
        }
        
        .flight-class-badge {
            display: inline-flex;
            align-items: center;
            gap: 0.5rem;
            padding: 0.75rem 1.25rem;
            border-radius: 9999px;
            font-weight: 600;
            font-size: 0.875rem;
            text-transform: uppercase;
            letter-spacing: 0.5px;
            white-space: nowrap;
        }
        
        .class-ECONOMY {
            background: linear-gradient(135deg, #dbeafe 0%, #bfdbfe 100%);
            color: #1d4ed8;
        }
        
        .class-BUSINESS {
            background: linear-gradient(135deg, #dcfce7 0%, #bbf7d0 100%);
            color: #15803d;
        }
        
        .class-FIRST {
            background: linear-gradient(135deg, #fef3c7 0%, #fde68a 100%);
            color: #a16207;
        }
        
        /* Flight Route */
        .flight-route {
            display: grid;
            grid-template-columns: 1fr auto 1fr;
            gap: 2rem;
            margin-bottom: 1.5rem;
            padding: 1.5rem;
            background: #f9fafb;
            border-radius: 12px;
        }
        
        .route-point {
            display: flex;
            flex-direction: column;
            gap: 0.75rem;
        }
        
        .route-location {
            display: flex;
            align-items: center;
            gap: 0.75rem;
        }
        
        .route-location i {
            font-size: 1.5rem;
            color: #0071c2;
        }
        
        .route-city {
            font-size: 1.25rem;
            font-weight: 700;
            color: #003580;
        }
        
        .route-time {
            display: flex;
            align-items: center;
            gap: 0.5rem;
            color: #6b7280;
            font-size: 0.95rem;
            padding-left: 2.25rem;
        }
        
        .route-time i {
            color: #6b7280;
        }
        
        /* Route Line */
        .route-line {
            display: flex;
            flex-direction: column;
            align-items: center;
            justify-content: center;
            position: relative;
            min-width: 100px;
        }
        
        .route-icon {
            font-size: 2rem;
            color: #0071c2;
            background: #ffffff;
            width: 60px;
            height: 60px;
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
            z-index: 2;
        }
        
        .route-dashes {
            position: absolute;
            top: 50%;
            left: 0;
            right: 0;
            height: 2px;
            background: repeating-linear-gradient(
                to right,
                #0071c2 0,
                #0071c2 10px,
                transparent 10px,
                transparent 20px
            );
            z-index: 1;
        }
        
        /* Flight Footer */
        .flight-footer {
            display: flex;
            justify-content: space-between;
            align-items: center;
            gap: 2rem;
            padding-top: 1rem;
            border-top: 2px solid #f3f4f6;
        }
        
        .flight-details {
            display: flex;
            flex-direction: column;
            gap: 0.5rem;
        }
        
        .detail-item {
            display: flex;
            align-items: center;
            gap: 0.5rem;
            color: #6b7280;
            font-size: 0.95rem;
        }
        
        .detail-item i {
            color: #00aa6c;
            font-size: 1.1rem;
        }
        
        .detail-item strong {
            color: #00aa6c;
            font-weight: 700;
        }
        
        /* Flight Booking */
        .flight-booking {
            display: flex;
            align-items: center;
            gap: 1.5rem;
        }
        
        .flight-price-section {
            display: flex;
            flex-direction: column;
            align-items: flex-end;
            text-align: right;
        }
        
        .price-label {
            font-size: 0.75rem;
            color: #6b7280;
            text-transform: uppercase;
            letter-spacing: 0.5px;
            margin-bottom: 0.25rem;
        }
        
        .flight-price {
            font-size: 2.25rem;
            font-weight: 800;
            color: #00aa6c;
            line-height: 1;
            margin: 0.25rem 0;
        }
        
        .price-period {
            font-size: 0.875rem;
            color: #6b7280;
            margin-top: 0.25rem;
        }
        
        .btn-book {
            min-width: 150px;
            padding: 1rem 1.5rem;
        }
        
        /* Empty State */
        .empty-state {
            text-align: center;
            padding: 4rem 2rem;
            margin: 3rem 0;
        }
        
        .empty-state-icon {
            font-size: 5rem;
            color: #e5e7eb;
            margin-bottom: 1.5rem;
            opacity: 0.5;
        }
        
        .empty-state h3 {
            color: #1a1a1a;
            font-size: 1.75rem;
            margin-bottom: 1rem;
        }
        
        .empty-state p {
            color: #6b7280;
            font-size: 1.125rem;
            margin-bottom: 2rem;
        }
        
        /* Tips Section */
        .tips-section {
            margin: 3rem 0;
            padding: 2rem;
            background: linear-gradient(135deg, #003580 0%, #0071c2 100%);
            border-radius: 16px;
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
        }
        
        .tips-content {
            display: flex;
            align-items: center;
            gap: 1.5rem;
        }
        
        .tips-icon {
            font-size: 3rem;
            color: #febb02;
            flex-shrink: 0;
        }
        
        .tips-text h3 {
            color: #ffffff;
            font-size: 1.5rem;
            margin-bottom: 0.5rem;
        }
        
        .tips-text p {
            color: rgba(255, 255, 255, 0.95);
            font-size: 1.125rem;
            margin: 0;
        }
        
        /* Responsive */
        @media (max-width: 992px) {
            .flight-route {
                grid-template-columns: 1fr;
                gap: 1.5rem;
            }
            
            .route-line {
                flex-direction: row;
                height: 60px;
                min-width: auto;
            }
            
            .flight-footer {
                flex-direction: column;
                align-items: stretch;
            }
            
            .flight-booking {
                flex-direction: column;
            }
            
            .flight-price-section {
                align-items: center;
                text-align: center;
            }
            
            .btn-book {
                width: 100%;
            }
        }
        
        @media (max-width: 768px) {
            .page-header h1 {
                font-size: 1.75rem;
            }
            
            .flight-header {
                flex-direction: column;
                align-items: flex-start;
            }
            
            .form-row {
                grid-template-columns: 1fr;
            }
            
            .flight-route {
                padding: 1rem;
            }
            
            .route-city {
                font-size: 1.1rem;
            }
            
            .route-icon {
                width: 50px;
                height: 50px;
                font-size: 1.5rem;
            }
            
            .results-header {
                flex-direction: column;
                align-items: flex-start;
            }
            
            .tips-content {
                flex-direction: column;
                text-align: center;
            }
        }
        
        @media (max-width: 480px) {
            .flight-card {
                padding: 1rem;
            }
            
            .flight-route {
                padding: 0.75rem;
            }
            
            .flight-price {
                font-size: 1.75rem;
            }
            
            .search-form-container {
                padding: 1.5rem;
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
                <i class="fas fa-plane-departure"></i> Recherche de Vols
            </h1>
            <p class="lead-text">Trouvez les meilleurs vols vers votre destination</p>
        </div>
    </div>
    
    <div class="container">
        <!-- Search Form -->
        <div class="search-form-container">
            <h3>
                <i class="fas fa-filter"></i> Recherchez votre vol idéal
            </h3>
            <form method="GET" action="${pageContext.request.contextPath}/search/flights">
                <div class="form-row">
                    <div>
                        <label for="destinationId" class="form-label">
                            <i class="fas fa-map-marker-alt"></i> Destination
                        </label>
                        <select name="destinationId" id="destinationId" class="form-select">
                            <option value="">Toutes les destinations</option>
                            <c:forEach var="destination" items="${destinations}">
                                <option value="${destination.id}" ${selectedDestinationId == destination.id ? 'selected' : ''}>
                                    ${destination.name}, ${destination.country}
                                </option>
                            </c:forEach>
                        </select>
                    </div>
                    
                    <div>
                        <label for="departureCity" class="form-label">
                            <i class="fas fa-plane-departure"></i> Ville de départ
                        </label>
                        <input type="text" name="departureCity" id="departureCity" class="form-control" 
                               value="${departureCity}" placeholder="Ex: Paris">
                    </div>
                    
                    <div>
                        <label for="departureDate" class="form-label">
                            <i class="fas fa-calendar-alt"></i> Date de départ
                        </label>
                        <input type="date" name="departureDate" id="departureDate" class="form-control" 
                               value="${departureDate}">
                    </div>
                    
                    <div>
                        <label for="passengers" class="form-label">
                            <i class="fas fa-users"></i> Passagers
                        </label>
                        <input type="number" name="passengers" id="passengers" class="form-control" 
                               value="${passengers}" min="1" max="10" placeholder="1">
                    </div>
                    
                    <div>
                        <button type="submit" class="btn btn-highlight" style="width: 100%;">
                            <i class="fas fa-search"></i> Rechercher
                        </button>
                    </div>
                </div>
            </form>
        </div>
        
        <!-- Error Message -->
        <c:if test="${not empty error}">
            <div class="alert alert-error">
                <i class="fas fa-exclamation-triangle"></i>
                <span>${error}</span>
            </div>
        </c:if>
        
        <!-- Results Header -->
        <div class="results-header">
            <h2>
                <i class="fas fa-plane"></i> Vols disponibles
                <span class="results-count">(${flights.size()})</span>
            </h2>
            <c:if test="${not empty flights}">
                <div class="results-info">
                    <i class="fas fa-info-circle"></i> 
                    ${flights.size()} vol(s) trouvé(s)
                </div>
            </c:if>
        </div>
        
        <!-- Results -->
        <c:choose>
            <c:when test="${empty flights}">
                <div class="empty-state">
                    <div class="empty-state-icon">
                        <i class="fas fa-plane-slash"></i>
                    </div>
                    <h3>Aucun vol trouvé</h3>
                    <p>Essayez de modifier vos critères de recherche ou explorez d'autres dates</p>
                    <a href="${pageContext.request.contextPath}/search/flights" class="btn btn-highlight">
                        <i class="fas fa-redo"></i> Réinitialiser la recherche
                    </a>
                </div>
            </c:when>
            <c:otherwise>
                <div class="flights-list">
                    <c:forEach var="flight" items="${flights}">
                        <div class="flight-card card glass-card">
                            <!-- Flight Header -->
                            <div class="flight-header">
                                <div class="flight-info-header">
                                    <h4 class="flight-number">
                                        <i class="fas fa-plane"></i> ${flight.flightNumber}
                                    </h4>
                                    <p class="flight-airline">
                                        <i class="fas fa-building"></i> ${flight.airline}
                                    </p>
                                </div>
                                <span class="flight-class-badge class-${flight.flightClass}">
                                    <c:choose>
                                        <c:when test="${flight.flightClass.name() == 'ECONOMY'}">
                                            <i class="fas fa-chair"></i> Économique
                                        </c:when>
                                        <c:when test="${flight.flightClass.name() == 'BUSINESS'}">
                                            <i class="fas fa-briefcase"></i> Business
                                        </c:when>
                                        <c:when test="${flight.flightClass.name() == 'FIRST'}">
                                            <i class="fas fa-crown"></i> Première
                                        </c:when>
                                        <c:otherwise>
                                            ${flight.flightClass}
                                        </c:otherwise>
                                    </c:choose>
                                </span>
                            </div>
                            
                            <!-- Flight Route -->
                            <div class="flight-route">
                                <div class="route-point">
                                    <div class="route-location">
                                        <i class="fas fa-plane-departure"></i>
                                        <span class="route-city">${flight.departureCity != null ? flight.departureCity : 'N/A'}</span>
                                    </div>
                                    <div class="route-time">
                                        <i class="fas fa-clock"></i>
                                        <p>${flight.departureDateFormatted != null ? flight.departureDateFormatted : 'N/A'}</p>
                                    </div>
                                </div>
                                
                                <div class="route-line">
                                    <div class="route-icon">
                                        <i class="fas fa-plane"></i>
                                    </div>
                                    <div class="route-dashes"></div>
                                </div>
                                
                                <div class="route-point">
                                    <div class="route-location">
                                        <i class="fas fa-plane-arrival"></i>
                                        <span class="route-city">${flight.destination != null ? flight.destination.name : 'Destination inconnue'}</span>
                                    </div>
                                    <div class="route-time">
                                        <i class="fas fa-clock"></i>
                                        <p>${flight.arrivalDateFormatted != null ? flight.arrivalDateFormatted : 'N/A'}</p>
                                    </div>
                                </div>
                            </div>
                            
                            <!-- Flight Footer -->
                            <div class="flight-footer">
                                <div class="flight-details">
                                    <div class="detail-item">
                                        <i class="fas fa-chair"></i>
                                        <span><strong>${flight.availableSeats != null ? flight.availableSeats : 0}</strong> place(s) disponible(s)</span>
                                    </div>
                                </div>
                                
                                <div class="flight-booking">
                                    <div class="flight-price-section">
                                        <span class="price-label">À partir de</span>
                                        <div class="flight-price">
                                            <c:choose>
                                                <c:when test="${flight.price != null}">
                                                    <fmt:formatNumber value="${flight.price}" type="currency" currencySymbol="€" />
                                                </c:when>
                                                <c:otherwise>
                                                    N/A
                                                </c:otherwise>
                                            </c:choose>
                                        </div>
                                        <span class="price-period">par personne</span>
                                    </div>
                                    <a href="${pageContext.request.contextPath}/reservation/new?type=flight&id=${flight.id}" 
                                       class="btn btn-highlight btn-book">
                                        <i class="fas fa-ticket-alt"></i> Réserver
                                    </a>
                                </div>
                            </div>
                        </div>
                    </c:forEach>
                </div>
            </c:otherwise>
        </c:choose>
        
        <!-- Tips Section -->
        <c:if test="${not empty flights}">
            <div class="tips-section card card-highlight">
                <div class="tips-content">
                    <div class="tips-icon">
                        <i class="fas fa-info-circle"></i>
                    </div>
                    <div class="tips-text">
                        <h3>Bon à savoir</h3>
                        <p>Les prix affichés sont par personne. Réservez dès maintenant pour garantir votre place aux meilleurs tarifs !</p>
                    </div>
                </div>
            </div>
        </c:if>

    </div>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
   
</body>
</html>
