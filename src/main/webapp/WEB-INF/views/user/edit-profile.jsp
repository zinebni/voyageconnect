<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Modifier mon profil - VoyageConnect</title>
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
    <style>
        /* ============================================
   VoyageConnect - Modern Booking Style CSS
   ============================================ */

/* ========== CSS Variables ========== */
:root {
    /* Primary Colors - Modern Blue Palette */
    --vc-primary: #003580;
    --vc-primary-dark: #002347;
    --vc-primary-light: #0057b8;
    --vc-accent: #0071c2;
    --vc-accent-hover: #005999;
    
    /* Secondary Colors */
    --vc-secondary: #6366f1;
    --vc-yellow: #febb02;
    --vc-yellow-dark: #e6a902;
    --vc-success: #00aa6c;
    --vc-danger: #dc3545;
    
    /* Neutral Colors */
    --vc-bg: #f5f7fa;
    --vc-bg-light: #ffffff;
    --vc-text: #1a1a1a;
    --vc-text-light: #6b7280;
    --vc-border: #e5e7eb;
    --vc-border-light: #f3f4f6;
    
    /* Shadows */
    --shadow-sm: 0 1px 2px rgba(0, 0, 0, 0.05);
    --shadow-md: 0 4px 6px -1px rgba(0, 0, 0, 0.1), 0 2px 4px -1px rgba(0, 0, 0, 0.06);
    --shadow-lg: 0 10px 15px -3px rgba(0, 0, 0, 0.1), 0 4px 6px -2px rgba(0, 0, 0, 0.05);
    --shadow-xl: 0 20px 25px -5px rgba(0, 0, 0, 0.1), 0 10px 10px -5px rgba(0, 0, 0, 0.04);
    --shadow-card: 0 2px 8px rgba(0, 0, 0, 0.08);
    --shadow-hover: 0 8px 24px rgba(0, 0, 0, 0.12);
    
    /* Gradients */
    --gradient-primary: linear-gradient(135deg, #003580 0%, #0057b8 100%);
    --gradient-accent: linear-gradient(135deg, #0071c2 0%, #003580 100%);
    --gradient-hero: linear-gradient(135deg, rgba(0, 53, 128, 0.95) 0%, rgba(0, 113, 194, 0.95) 100%);
    --gradient-card: linear-gradient(135deg, rgba(255, 255, 255, 0.9) 0%, rgba(255, 255, 255, 0.7) 100%);
    
    /* Spacing */
    --spacing-xs: 0.5rem;
    --spacing-sm: 1rem;
    --spacing-md: 1.5rem;
    --spacing-lg: 2rem;
    --spacing-xl: 3rem;
    
    /* Border Radius */
    --radius-sm: 4px;
    --radius-md: 8px;
    --radius-lg: 12px;
    --radius-xl: 16px;
    --radius-full: 9999px;
    
    /* Transitions */
    --transition-fast: 150ms cubic-bezier(0.4, 0, 0.2, 1);
    --transition-base: 250ms cubic-bezier(0.4, 0, 0.2, 1);
    --transition-slow: 350ms cubic-bezier(0.4, 0, 0.2, 1);
}

/* ========== Reset & Base Styles ========== */
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

/* ========== Typography ========== */
h1, h2, h3, h4, h5, h6 {
    font-weight: 700;
    line-height: 1.2;
    color: var(--vc-text);
    margin-bottom: var(--spacing-sm);
}

h1 { font-size: 2.5rem; }
h2 { font-size: 2rem; }
h3 { font-size: 1.75rem; }
h4 { font-size: 1.5rem; }
h5 { font-size: 1.25rem; }
h6 { font-size: 1rem; }

p {
    margin-bottom: var(--spacing-sm);
    color: var(--vc-text-light);
}

.lead {
    font-size: 1.25rem;
    font-weight: 300;
    color: rgba(255, 255, 255, 0.95);
    margin-bottom: var(--spacing-lg);
}

/* ========== Buttons ========== */
.btn {
    display: inline-flex;
    align-items: center;
    justify-content: center;
    gap: 0.5rem;
    padding: 0.75rem 1.5rem;
    font-size: 1rem;
    font-weight: 600;
    line-height: 1.5;
    text-align: center;
    text-decoration: none;
    border: none;
    border-radius: var(--radius-md);
    cursor: pointer;
    transition: all var(--transition-base);
    white-space: nowrap;
    position: relative;
    overflow: hidden;
}

.btn::before {
    content: '';
    position: absolute;
    top: 50%;
    left: 50%;
    width: 0;
    height: 0;
    border-radius: 50%;
    background: rgba(255, 255, 255, 0.2);
    transform: translate(-50%, -50%);
    transition: width 0.6s, height 0.6s;
}

.btn:hover::before {
    width: 300px;
    height: 300px;
}

.btn-highlight {
    background: var(--gradient-primary);
    color: #ffffff;
    box-shadow: var(--shadow-md);
}

.btn-highlight:hover {
    background: var(--gradient-accent);
    box-shadow: var(--shadow-lg);
    transform: translateY(-2px);
}

.btn-glass {
    background: rgba(255, 255, 255, 0.15);
    color: #ffffff;
    border: 2px solid rgba(255, 255, 255, 0.3);
    backdrop-filter: blur(10px);
}

.btn-glass:hover {
    background: rgba(255, 255, 255, 0.25);
    border-color: rgba(255, 255, 255, 0.5);
    transform: translateY(-2px);
}

.btn-lg {
    padding: 1rem 2rem;
    font-size: 1.125rem;
}

.btn-sm {
    padding: 0.5rem 1rem;
    font-size: 0.875rem;
}

.btn-block {
    width: 100%;
    display: flex;
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

/* ========== Hero Section ========== */
.hero-section {
    background: var(--gradient-hero);
    background-image: 
        linear-gradient(135deg, rgba(0, 53, 128, 0.95) 0%, rgba(0, 113, 194, 0.9) 100%),
        url('https://images.unsplash.com/photo-1436491865332-7a61a109cc05?w=1920&h=600&fit=crop');
    background-size: cover;
    background-position: center;
    background-attachment: fixed;
    padding: 5rem 0;
    text-align: center;
    position: relative;
    overflow: hidden;
}

.hero-section::before {
    content: '';
    position: absolute;
    top: 0;
    left: 0;
    right: 0;
    bottom: 0;
    background: radial-gradient(circle at 30% 50%, rgba(99, 102, 241, 0.2) 0%, transparent 50%);
    animation: pulse 8s ease-in-out infinite;
}

@keyframes pulse {
    0%, 100% { opacity: 0.5; }
    50% { opacity: 1; }
}

.hero-section .container {
    position: relative;
    z-index: 1;
}

.hero-section h1 {
    color: #ffffff;
    font-size: 3.5rem;
    font-weight: 800;
    margin-bottom: 1rem;
    text-shadow: 0 4px 12px rgba(0, 0, 0, 0.3);
    animation: fadeInUp 0.8s ease-out;
}

.hero-section .lead {
    font-size: 1.5rem;
    animation: fadeInUp 0.8s ease-out 0.2s backwards;
}

.hero-buttons {
    display: flex;
    gap: 1rem;
    justify-content: center;
    flex-wrap: wrap;
    margin-top: 2rem;
    animation: fadeInUp 0.8s ease-out 0.4s backwards;
}

@keyframes fadeInUp {
    from {
        opacity: 0;
        transform: translateY(30px);
    }
    to {
        opacity: 1;
        transform: translateY(0);
    }
}

/* ========== Search Form ========== */
.search-form-container {
    background: var(--vc-bg-light);
    border-radius: var(--radius-xl);
    padding: 2rem;
    box-shadow: var(--shadow-xl);
    margin-top: -3rem;
    margin-bottom: 3rem;
    position: relative;
    z-index: 10;
    border: 1px solid var(--vc-border);
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

.search-form-container h3 {
    color: var(--vc-primary);
    margin-bottom: 1.5rem;
    display: flex;
    align-items: center;
    gap: 0.5rem;
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
    color: var(--vc-text);
    margin-bottom: 0.5rem;
    font-size: 0.9rem;
}

.form-control,
.form-select {
    width: 100%;
    padding: 0.75rem 1rem;
    font-size: 1rem;
    border: 2px solid var(--vc-border);
    border-radius: var(--radius-md);
    background: var(--vc-bg-light);
    color: var(--vc-text);
    transition: all var(--transition-base);
    outline: none;
}

.form-control:focus,
.form-select:focus {
    border-color: var(--vc-accent);
    box-shadow: 0 0 0 3px rgba(0, 113, 194, 0.1);
}

.form-control::placeholder {
    color: var(--vc-text-light);
}

/* ========== Cards ========== */
.card {
    background: var(--vc-bg-light);
    border-radius: var(--radius-lg);
    overflow: hidden;
    transition: all var(--transition-base);
    border: 1px solid var(--vc-border);
}

.glass-card {
    background: rgba(255, 255, 255, 0.95);
    backdrop-filter: blur(10px);
    box-shadow: var(--shadow-card);
    border: 1px solid rgba(255, 255, 255, 0.5);
}

.glass-card:hover {
    box-shadow: var(--shadow-hover);
    transform: translateY(-4px);
    border-color: var(--vc-accent);
}

.card-highlight {
    background: var(--gradient-primary);
    color: #ffffff;
    box-shadow: var(--shadow-lg);
}

.card-body {
    padding: var(--spacing-md);
}

/* ========== Destination Cards ========== */
.destination-card {
    position: relative;
    overflow: hidden;
    height: 100%;
    display: flex;
    flex-direction: column;
}

.destination-card img {
    width: 100%;
    height: 200px;
    object-fit: cover;
    transition: transform var(--transition-slow);
}

.destination-card:hover img {
    transform: scale(1.1);
}

.destination-card .card-body {
    flex: 1;
    display: flex;
    flex-direction: column;
}

.destination-card h5 {
    color: var(--vc-primary);
    margin-bottom: 0.5rem;
    font-size: 1.25rem;
    display: flex;
    align-items: center;
    gap: 0.5rem;
}

.destination-card p {
    flex: 1;
    font-size: 0.9rem;
    margin-bottom: 1rem;
}

.result-price {
    font-size: 1.5rem;
    font-weight: 700;
    color: var(--vc-success);
    margin-bottom: 1rem;
}

/* ========== Features Grid ========== */
.features-grid {
    display: grid;
    grid-template-columns: repeat(auto-fit, minmax(280px, 1fr));
    gap: 2rem;
    margin-bottom: 3rem;
}

.feature-icon {
    font-size: 3rem;
    margin-bottom: 1rem;
    display: inline-block;
    animation: bounce 2s infinite;
}

@keyframes bounce {
    0%, 100% { transform: translateY(0); }
    50% { transform: translateY(-10px); }
}

.features-grid .card {
    text-align: center;
    padding: 2rem;
    transition: all var(--transition-base);
}

.features-grid .card:hover {
    transform: translateY(-8px) scale(1.02);
}

/* ========== Destinations Grid ========== */
.destinations-grid {
    display: grid;
    grid-template-columns: repeat(auto-fit, minmax(280px, 1fr));
    gap: 2rem;
    margin-bottom: 3rem;
}

/* ========== Section Header ========== */
.section-header {
    text-align: center;
    margin-bottom: 3rem;
    padding-top: 3rem;
}

.section-header h2 {
    color: var(--vc-primary);
    font-size: 2.5rem;
    margin-bottom: 0.5rem;
    display: flex;
    align-items: center;
    justify-content: center;
    gap: 0.75rem;
}

.section-header p {
    font-size: 1.125rem;
    color: var(--vc-text-light);
}

/* ========== Utilities ========== */
.text-center { text-align: center; }
.text-left { text-align: left; }
.text-right { text-align: right; }

.mb-1 { margin-bottom: 0.5rem; }
.mb-2 { margin-bottom: 1rem; }
.mb-3 { margin-bottom: 1.5rem; }
.mb-4 { margin-bottom: 2rem; }

.mt-1 { margin-top: 0.5rem; }
.mt-2 { margin-top: 1rem; }
.mt-3 { margin-top: 1.5rem; }
.mt-4 { margin-top: 2rem; }

/* ========== Responsive Design ========== */
@media (max-width: 768px) {
    .hero-section h1 {
        font-size: 2rem;
    }
    
    .hero-section .lead {
        font-size: 1.125rem;
    }
    
    .navbar-nav {
        gap: 0.5rem;
    }
    
    .nav-link {
        padding: 0.5rem;
        font-size: 0.9rem;
    }
    
    .form-row {
        grid-template-columns: 1fr;
    }
    
    .features-grid,
    .destinations-grid {
        grid-template-columns: 1fr;
        gap: 1.5rem;
    }
    
    .hero-buttons {
        flex-direction: column;
        width: 100%;
    }
    
    .hero-buttons .btn {
        width: 100%;
    }
    
    .section-header h2 {
        font-size: 1.75rem;
    }
    
    .container {
        padding: 0 1rem;
    }
}

@media (max-width: 480px) {
    .hero-section h1 {
        font-size: 1.75rem;
    }
    
    .search-form-container {
        padding: 1.5rem;
        margin-top: -2rem;
    }
    
    h2 { font-size: 1.5rem; }
    h3 { font-size: 1.25rem; }
    h4 { font-size: 1.125rem; }
}

/* ========== Animations ========== */
@keyframes fadeIn {
    from { opacity: 0; }
    to { opacity: 1; }
}

@keyframes slideInLeft {
    from {
        opacity: 0;
        transform: translateX(-30px);
    }
    to {
        opacity: 1;
        transform: translateX(0);
    }
}

@keyframes slideInRight {
    from {
        opacity: 0;
        transform: translateX(30px);
    }
    to {
        opacity: 1;
        transform: translateX(0);
    }
}

/* Apply animations on scroll */
.features-grid .card {
    animation: fadeInUp 0.6s ease-out backwards;
}

.features-grid .card:nth-child(1) { animation-delay: 0.1s; }
.features-grid .card:nth-child(2) { animation-delay: 0.2s; }
.features-grid .card:nth-child(3) { animation-delay: 0.3s; }

.destinations-grid .card {
    animation: fadeInUp 0.6s ease-out backwards;
}

.destinations-grid .card:nth-child(1) { animation-delay: 0.1s; }
.destinations-grid .card:nth-child(2) { animation-delay: 0.2s; }
.destinations-grid .card:nth-child(3) { animation-delay: 0.3s; }
.destinations-grid .card:nth-child(4) { animation-delay: 0.4s; }

/* ========== Scrollbar Styling ========== */
::-webkit-scrollbar {
    width: 10px;
}

::-webkit-scrollbar-track {
    background: var(--vc-border-light);
}

::-webkit-scrollbar-thumb {
    background: var(--vc-accent);
    border-radius: var(--radius-full);
}

::-webkit-scrollbar-thumb:hover {
    background: var(--vc-accent-hover);
}

/* ========== Page Header ========== */
.page-header {
    background: var(--gradient-primary);
    padding: 3rem 0;
    text-align: center;
    margin-bottom: 3rem;
    box-shadow: var(--shadow-lg);
}

.page-header h1 {
    color: #ffffff;
    font-size: 2.5rem;
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

/* ========== Search Options ========== */
.search-options {
    display: grid;
    grid-template-columns: repeat(auto-fit, minmax(300px, 1fr));
    gap: 2rem;
    margin-bottom: 3rem;
}

.option-card {
    text-align: center;
    padding: 2.5rem 2rem;
    transition: all var(--transition-base);
    position: relative;
    overflow: hidden;
}

.option-card::before {
    content: '';
    position: absolute;
    top: 0;
    left: 0;
    width: 100%;
    height: 4px;
    background: var(--gradient-primary);
    transform: scaleX(0);
    transition: transform var(--transition-base);
}

.option-card:hover::before {
    transform: scaleX(1);
}

.option-icon {
    font-size: 4rem;
    color: var(--vc-accent);
    margin-bottom: 1.5rem;
    display: inline-block;
    transition: all var(--transition-base);
}

.option-card:hover .option-icon {
    transform: scale(1.1) translateY(-5px);
}

.option-card h3 {
    color: var(--vc-primary);
    font-size: 1.75rem;
    margin-bottom: 1rem;
}

.option-card p {
    color: var(--vc-text-light);
    margin-bottom: 1.5rem;
    font-size: 1rem;
}

/* ========== Search Section Divider ========== */
.search-section-divider {
    border: none;
    height: 2px;
    background: linear-gradient(
        to right,
        transparent,
        var(--vc-accent),
        transparent
    );
    margin: 4rem 0;
    opacity: 0.3;
}

/* ========== Destination Cards (Search Page) ========== */
.destination-country {
    display: flex;
    align-items: center;
    gap: 0.5rem;
    color: var(--vc-text-light);
    font-size: 0.9rem;
    margin-bottom: 0.5rem;
}

.destination-description {
    color: var(--vc-text-light);
    font-size: 0.95rem;
    line-height: 1.6;
    margin-bottom: 1rem;
    flex: 1;
}

/* ========== Empty State ========== */
.empty-state {
    text-align: center;
    padding: 4rem 2rem;
    margin: 3rem 0;
}

.empty-state-icon {
    font-size: 5rem;
    color: var(--vc-border);
    margin-bottom: 1.5rem;
    opacity: 0.5;
}

.empty-state h3 {
    color: var(--vc-text);
    font-size: 1.75rem;
    margin-bottom: 1rem;
}

.empty-state p {
    color: var(--vc-text-light);
    font-size: 1.125rem;
    margin-bottom: 2rem;
    max-width: 600px;
    margin-left: auto;
    margin-right: auto;
}

/* ========== Features Banner ========== */
.features-banner {
    margin: 4rem 0;
    padding: 3rem;
    background: var(--gradient-accent);
    border: none;
}

.features-banner-content {
    display: flex;
    align-items: center;
    justify-content: space-between;
    gap: 2rem;
    flex-wrap: wrap;
}

.features-banner-icon {
    font-size: 3.5rem;
    color: var(--vc-yellow);
    animation: pulse 3s ease-in-out infinite;
}

.features-banner-text {
    flex: 1;
    min-width: 250px;
}

.features-banner-text h3 {
    color: #ffffff;
    font-size: 1.75rem;
    margin-bottom: 0.5rem;
}

.features-banner-text p {
    color: rgba(255, 255, 255, 0.9);
    font-size: 1.125rem;
    margin: 0;
}

/* ========== Hotel Cards ========== */
.hotels-grid {
    display: grid;
    grid-template-columns: repeat(auto-fill, minmax(500px, 1fr));
    gap: 2rem;
    margin-bottom: 3rem;
}

.hotel-card {
    display: flex;
    flex-direction: column;
    overflow: hidden;
    height: 100%;
    transition: all var(--transition-base);
}

.hotel-card:hover {
    transform: translateY(-4px);
    box-shadow: var(--shadow-hover);
}

.hotel-image-container {
    position: relative;
    width: 100%;
    height: 200px;
    background: linear-gradient(135deg, var(--vc-primary-light) 0%, var(--vc-accent) 100%);
    display: flex;
    align-items: center;
    justify-content: center;
    overflow: hidden;
}

.hotel-image-placeholder {
    font-size: 4rem;
    color: rgba(255, 255, 255, 0.3);
}

.hotel-stars {
    position: absolute;
    top: 1rem;
    right: 1rem;
    background: rgba(255, 255, 255, 0.95);
    padding: 0.5rem 1rem;
    border-radius: var(--radius-full);
    display: flex;
    gap: 0.25rem;
    box-shadow: var(--shadow-md);
}

.hotel-stars i {
    color: var(--vc-yellow);
    font-size: 0.875rem;
}

.hotel-body {
    padding: 1.5rem;
    display: flex;
    flex-direction: column;
    flex: 1;
}

.hotel-header {
    display: flex;
    justify-content: space-between;
    align-items: flex-start;
    margin-bottom: 1rem;
    gap: 1rem;
}

.hotel-title {
    color: var(--vc-primary);
    font-size: 1.5rem;
    font-weight: 700;
    margin: 0;
    flex: 1;
    line-height: 1.3;
}

.hotel-rating {
    display: flex;
    gap: 0.25rem;
    flex-shrink: 0;
}

.hotel-rating i {
    color: var(--vc-yellow);
    font-size: 1rem;
}

.hotel-location {
    color: var(--vc-text);
    font-weight: 600;
    font-size: 1rem;
    margin-bottom: 0.5rem;
    display: flex;
    align-items: center;
    gap: 0.5rem;
}

.hotel-location i {
    color: var(--vc-accent);
}

.hotel-address {
    color: var(--vc-text-light);
    font-size: 0.9rem;
    margin-bottom: 1rem;
    display: flex;
    align-items: center;
    gap: 0.5rem;
}

.hotel-address i {
    color: var(--vc-text-light);
}

/* ========== Amenities ========== */
.amenities {
    display: flex;
    flex-wrap: wrap;
    gap: 0.5rem;
    margin-bottom: 1.5rem;
}

.amenity-badge {
    display: inline-flex;
    align-items: center;
    gap: 0.5rem;
    padding: 0.5rem 1rem;
    background: var(--vc-border-light);
    color: var(--vc-text);
    border-radius: var(--radius-full);
    font-size: 0.875rem;
    font-weight: 500;
    transition: all var(--transition-base);
}

.amenity-badge:hover {
    background: var(--vc-accent);
    color: #ffffff;
    transform: translateY(-2px);
}

.amenity-badge i {
    font-size: 1rem;
}

/* ========== Hotel Footer ========== */
.hotel-footer {
    margin-top: auto;
    padding-top: 1.5rem;
    border-top: 2px solid var(--vc-border-light);
}

.hotel-availability {
    display: flex;
    align-items: center;
    gap: 0.5rem;
    margin-bottom: 1rem;
    color: var(--vc-text-light);
    font-size: 0.9rem;
}

.hotel-availability i {
    color: var(--vc-success);
}

.availability-text {
    color: var(--vc-text);
}

.availability-text strong {
    color: var(--vc-success);
    font-weight: 700;
}

.availability-total {
    color: var(--vc-text-light);
}

.hotel-booking {
    display: flex;
    justify-content: space-between;
    align-items: center;
    gap: 1.5rem;
}

.hotel-price-section {
    display: flex;
    flex-direction: column;
    align-items: flex-start;
}

.price-label {
    font-size: 0.75rem;
    color: var(--vc-text-light);
    text-transform: uppercase;
    letter-spacing: 0.5px;
    margin-bottom: 0.25rem;
}

.hotel-price {
    font-size: 2rem;
    font-weight: 800;
    color: var(--vc-success);
    line-height: 1;
}

.price-period {
    font-size: 0.875rem;
    color: var(--vc-text-light);
    margin-top: 0.25rem;
}

.hotel-booking .btn {
    min-width: 140px;
    white-space: nowrap;
}

/* ========== Results Header ========== */
.results-header {
    display: flex;
    justify-content: space-between;
    align-items: center;
    margin-bottom: 2rem;
    flex-wrap: wrap;
    gap: 1rem;
}

.results-header h2 {
    color: var(--vc-primary);
    font-size: 1.75rem;
    margin: 0;
    display: flex;
    align-items: center;
    gap: 0.5rem;
}

.results-count {
    color: var(--vc-text-light);
    font-weight: 400;
    font-size: 1.25rem;
}

.results-info {
    display: flex;
    align-items: center;
    gap: 0.5rem;
    padding: 0.5rem 1rem;
    background: var(--vc-border-light);
    border-radius: var(--radius-md);
    color: var(--vc-text-light);
    font-size: 0.9rem;
}

.results-info i {
    color: var(--vc-accent);
}

/* ========== Tips Section ========== */
.tips-section {
    margin: 3rem 0;
    padding: 2rem;
    border: none;
}

.tips-content {
    display: flex;
    align-items: center;
    gap: 1.5rem;
}

.tips-icon {
    font-size: 3rem;
    color: var(--vc-yellow);
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

/* ========== Destinations Page Styles ========== */
.destinations-intro {
    background: var(--vc-border-light);
    padding: 1.5rem 2rem;
    border-radius: var(--radius-lg);
    margin-bottom: 3rem;
    border-left: 4px solid var(--vc-accent);
}

.destinations-intro p {
    margin: 0;
    color: var(--vc-text);
    font-size: 1rem;
    line-height: 1.8;
    display: flex;
    align-items: flex-start;
    gap: 0.75rem;
}

.destinations-intro i {
    color: var(--vc-accent);
    margin-top: 0.25rem;
    flex-shrink: 0;
}

/* ========== Destinations List Grid ========== */
.destinations-list-grid {
    display: grid;
    grid-template-columns: repeat(auto-fill, minmax(380px, 1fr));
    gap: 2rem;
    margin-bottom: 3rem;
}

.destination-list-card {
    display: flex;
    flex-direction: column;
    overflow: hidden;
    transition: all var(--transition-base);
    height: 100%;
}

.destination-list-card:hover {
    transform: translateY(-6px);
    box-shadow: var(--shadow-hover);
}

/* ========== Destination Image ========== */
.destination-image-wrapper {
    position: relative;
    width: 100%;
    height: 250px;
    overflow: hidden;
    background: var(--vc-border);
}

.destination-image {
    width: 100%;
    height: 100%;
    object-fit: cover;
    transition: transform var(--transition-slow);
}

.destination-list-card:hover .destination-image {
    transform: scale(1.08);
}

.destination-image-fallback {
    width: 100%;
    height: 100%;
    background: linear-gradient(135deg, var(--vc-primary) 0%, var(--vc-accent) 100%);
    display: flex;
    flex-direction: column;
    align-items: center;
    justify-content: center;
    color: #ffffff;
    gap: 1rem;
}

.destination-image-fallback i {
    font-size: 4rem;
    opacity: 0.8;
}

.destination-image-fallback span {
    font-size: 1.5rem;
    font-weight: 700;
    text-align: center;
    padding: 0 1rem;
}

.destination-overlay {
    position: absolute;
    top: 0;
    left: 0;
    right: 0;
    bottom: 0;
    background: linear-gradient(to bottom, rgba(0, 0, 0, 0.3) 0%, transparent 50%);
    display: flex;
    padding: 1rem;
}

.destination-badge {
    display: inline-flex;
    align-items: center;
    gap: 0.5rem;
    padding: 0.5rem 1rem;
    background: rgba(254, 187, 2, 0.95);
    color: var(--vc-text);
    border-radius: var(--radius-full);
    font-weight: 600;
    font-size: 0.875rem;
    box-shadow: var(--shadow-md);
}

.destination-badge i {
    color: var(--vc-danger);
}

/* ========== Destination Body ========== */
.destination-body {
    padding: 1.5rem;
    display: flex;
    flex-direction: column;
    flex: 1;
}

.destination-header {
    margin-bottom: 1rem;
}

.destination-title {
    color: var(--vc-primary);
    font-size: 1.5rem;
    font-weight: 700;
    margin-bottom: 0.5rem;
    display: flex;
    align-items: center;
    gap: 0.5rem;
    line-height: 1.3;
}

.destination-title i {
    color: var(--vc-accent);
    font-size: 1.25rem;
}

.destination-country {
    display: flex;
    align-items: center;
    gap: 0.5rem;
    color: var(--vc-text-light);
    font-size: 0.95rem;
    font-weight: 500;
}

.destination-country i {
    color: var(--vc-accent);
}

.destination-description {
    color: var(--vc-text-light);
    font-size: 0.95rem;
    line-height: 1.7;
    margin-bottom: 1.5rem;
    flex: 1;
}

/* ========== Destination Stats ========== */
.destination-stats {
    display: flex;
    justify-content: space-around;
    gap: 1rem;
    padding: 1rem;
    background: var(--vc-border-light);
    border-radius: var(--radius-md);
    margin-bottom: 1.5rem;
}

.stat-item {
    display: flex;
    flex-direction: column;
    align-items: center;
    gap: 0.5rem;
    text-align: center;
}

.stat-item i {
    font-size: 1.5rem;
    color: var(--vc-accent);
}

.stat-item span {
    font-size: 0.75rem;
    color: var(--vc-text-light);
    font-weight: 500;
}

/* ========== Destination Actions ========== */
.destination-actions {
    display: grid;
    grid-template-columns: repeat(3, 1fr);
    gap: 0.75rem;
    margin-top: auto;
}

.btn-action {
    padding: 0.75rem 0.5rem;
    font-size: 0.875rem;
    display: flex;
    flex-direction: column;
    align-items: center;
    gap: 0.25rem;
    white-space: nowrap;
}

.btn-action i {
    font-size: 1.25rem;
}

.btn-outline-primary {
    background: transparent;
    color: var(--vc-accent);
    border: 2px solid var(--vc-accent);
    transition: all var(--transition-base);
}

.btn-outline-primary:hover {
    background: var(--vc-accent);
    color: #ffffff;
    transform: translateY(-2px);
    box-shadow: var(--shadow-md);
}

/* ========== CTA Banner ========== */
.cta-banner {
    margin: 4rem 0;
    padding: 3rem;
    border: none;
}

.cta-content {
    display: flex;
    align-items: center;
    justify-content: space-between;
    gap: 2rem;
    flex-wrap: wrap;
}

.cta-icon {
    font-size: 4rem;
    color: var(--vc-yellow);
    animation: spin-slow 20s linear infinite;
    flex-shrink: 0;
}

@keyframes spin-slow {
    from { transform: rotate(0deg); }
    to { transform: rotate(360deg); }
}

.cta-text {
    flex: 1;
    min-width: 250px;
}

.cta-text h3 {
    color: #ffffff;
    font-size: 1.75rem;
    margin-bottom: 0.5rem;
}

.cta-text p {
    color: rgba(255, 255, 255, 0.95);
    font-size: 1.125rem;
    margin: 0;
}

/* ========== Flights Page Styles ========== */
.flights-list {
    display: flex;
    flex-direction: column;
    gap: 1.5rem;
    margin-bottom: 3rem;
}

.flight-card {
    padding: 1.5rem;
    transition: all var(--transition-base);
}

.flight-card:hover {
    transform: translateY(-4px);
    box-shadow: var(--shadow-hover);
}

/* ========== Flight Header ========== */
.flight-header {
    display: flex;
    justify-content: space-between;
    align-items: flex-start;
    margin-bottom: 1.5rem;
    padding-bottom: 1rem;
    border-bottom: 2px solid var(--vc-border-light);
    gap: 1rem;
}

.flight-info-header {
    flex: 1;
}

.flight-number {
    color: var(--vc-primary);
    font-size: 1.5rem;
    font-weight: 700;
    margin-bottom: 0.5rem;
    display: flex;
    align-items: center;
    gap: 0.5rem;
}

.flight-number i {
    color: var(--vc-accent);
}

.flight-airline {
    color: var(--vc-text-light);
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
    border-radius: var(--radius-full);
    font-weight: 600;
    font-size: 0.875rem;
    text-transform: uppercase;
    letter-spacing: 0.5px;
    white-space: nowrap;
}

.class-ECONOMY {
    background: linear-gradient(135deg, #e3f2fd 0%, #bbdefb 100%);
    color: #1565c0;
}

.class-BUSINESS {
    background: linear-gradient(135deg, #f3e5f5 0%, #e1bee7 100%);
    color: #6a1b9a;
}

.class-FIRST {
    background: linear-gradient(135deg, #fff3e0 0%, #ffe0b2 100%);
    color: #e65100;
}

/* ========== Flight Route ========== */
.flight-route {
    display: grid;
    grid-template-columns: 1fr auto 1fr;
    gap: 2rem;
    margin-bottom: 1.5rem;
    padding: 1.5rem;
    background: var(--vc-border-light);
    border-radius: var(--radius-lg);
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
    color: var(--vc-accent);
}

.route-city {
    font-size: 1.25rem;
    font-weight: 700;
    color: var(--vc-primary);
}

.route-time {
    display: flex;
    align-items: center;
    gap: 0.5rem;
    color: var(--vc-text-light);
    font-size: 0.95rem;
    padding-left: 2.25rem;
}

.route-time i {
    color: var(--vc-text-light);
}

/* ========== Route Line ========== */
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
    color: var(--vc-accent);
    background: #ffffff;
    width: 60px;
    height: 60px;
    border-radius: 50%;
    display: flex;
    align-items: center;
    justify-content: center;
    box-shadow: var(--shadow-md);
    z-index: 2;
    animation: plane-fly 3s ease-in-out infinite;
}

@keyframes plane-fly {
    0%, 100% { transform: translateX(0); }
    50% { transform: translateX(10px); }
}

.route-dashes {
    position: absolute;
    top: 50%;
    left: 0;
    right: 0;
    height: 2px;
    background: repeating-linear-gradient(
        to right,
        var(--vc-accent) 0,
        var(--vc-accent) 10px,
        transparent 10px,
        transparent 20px
    );
    z-index: 1;
}

/* ========== Flight Footer ========== */
.flight-footer {
    display: flex;
    justify-content: space-between;
    align-items: center;
    gap: 2rem;
    padding-top: 1rem;
    border-top: 2px solid var(--vc-border-light);
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
    color: var(--vc-text-light);
    font-size: 0.95rem;
}

.detail-item i {
    color: var(--vc-success);
    font-size: 1.1rem;
}

.detail-item strong {
    color: var(--vc-success);
    font-weight: 700;
}

/* ========== Flight Booking Section ========== */
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

.flight-price {
    font-size: 2.25rem;
    font-weight: 800;
    color: var(--vc-success);
    line-height: 1;
    margin: 0.25rem 0;
}

.btn-book {
    min-width: 150px;
    padding: 1rem 1.5rem;
    font-size: 1rem;
}

/* ========== Alert Styles ========== */
.alert {
    padding: 1rem 1.5rem;
    border-radius: var(--radius-md);
    margin-bottom: 2rem;
    display: flex;
    align-items: center;
    gap: 0.75rem;
    animation: slideDown 0.3s ease-out;
}

@keyframes slideDown {
    from {
        opacity: 0;
        transform: translateY(-10px);
    }
    to {
        opacity: 1;
        transform: translateY(0);
    }
}

.alert-error {
    background: #fee;
    border: 2px solid #fcc;
    color: #c33;
}

.alert-error i {
    color: #c33;
    font-size: 1.25rem;
}

.alert-success {
    background: #efe;
    border: 2px solid #cfc;
    color: #3c3;
}

.alert-info {
    background: #eef;
    border: 2px solid #ccf;
    color: #33c;
}

/* ========== Circuits Page Styles ========== */
.circuits-grid {
    display: grid;
    grid-template-columns: repeat(auto-fill, minmax(500px, 1fr));
    gap: 2rem;
    margin-bottom: 3rem;
}

.circuit-card {
    display: flex;
    flex-direction: column;
    overflow: hidden;
    height: 100%;
    transition: all var(--transition-base);
}

.circuit-card:hover {
    transform: translateY(-4px);
    box-shadow: var(--shadow-hover);
}

/* ========== Circuit Image ========== */
.circuit-image-container {
    position: relative;
    width: 100%;
    height: 200px;
    background: linear-gradient(135deg, #6366f1 0%, #8b5cf6 100%);
    display: flex;
    align-items: center;
    justify-content: center;
    overflow: hidden;
}

.circuit-image-placeholder {
    font-size: 4rem;
    color: rgba(255, 255, 255, 0.3);
}

.circuit-duration-badge {
    position: absolute;
    top: 1rem;
    right: 1rem;
    background: rgba(254, 187, 2, 0.95);
    color: var(--vc-text);
    padding: 0.75rem 1.25rem;
    border-radius: var(--radius-full);
    font-weight: 700;
    font-size: 0.95rem;
    display: flex;
    align-items: center;
    gap: 0.5rem;
    box-shadow: var(--shadow-md);
}

.circuit-duration-badge i {
    font-size: 1.1rem;
}

/* ========== Circuit Body ========== */
.circuit-body {
    padding: 1.5rem;
    display: flex;
    flex-direction: column;
    flex: 1;
}

.circuit-title {
    color: var(--vc-primary);
    font-size: 1.5rem;
    font-weight: 700;
    margin-bottom: 0.75rem;
    display: flex;
    align-items: center;
    gap: 0.5rem;
    line-height: 1.3;
}

.circuit-title i {
    color: var(--vc-accent);
}

.circuit-location {
    color: var(--vc-text);
    font-weight: 600;
    font-size: 1rem;
    margin-bottom: 0.75rem;
    display: flex;
    align-items: center;
    gap: 0.5rem;
}

.circuit-location i {
    color: var(--vc-accent);
}

.circuit-description {
    color: var(--vc-text-light);
    font-size: 0.95rem;
    line-height: 1.7;
    margin-bottom: 1.5rem;
}

/* ========== Circuit Info Grid ========== */
.circuit-info-grid {
    display: grid;
    grid-template-columns: repeat(2, 1fr);
    gap: 1rem;
    margin-bottom: 1.5rem;
}

.info-card {
    display: flex;
    align-items: center;
    gap: 0.75rem;
    padding: 1rem;
    background: var(--vc-border-light);
    border-radius: var(--radius-md);
    transition: all var(--transition-base);
}

.info-card:hover {
    background: var(--vc-accent);
    color: #ffffff;
    transform: translateY(-2px);
}

.info-card:hover .info-icon {
    background: rgba(255, 255, 255, 0.2);
    color: #ffffff;
}

.info-card:hover .info-label,
.info-card:hover .info-value {
    color: #ffffff;
}

.info-card-wide {
    grid-column: 1 / -1;
}

.info-icon {
    width: 45px;
    height: 45px;
    background: #ffffff;
    border-radius: var(--radius-md);
    display: flex;
    align-items: center;
    justify-content: center;
    color: var(--vc-accent);
    font-size: 1.25rem;
    flex-shrink: 0;
    transition: all var(--transition-base);
}

.info-content {
    display: flex;
    flex-direction: column;
    gap: 0.25rem;
    flex: 1;
}

.info-label {
    font-size: 0.75rem;
    color: var(--vc-text-light);
    text-transform: uppercase;
    letter-spacing: 0.5px;
    font-weight: 600;
}

.info-value {
    font-size: 0.95rem;
    color: var(--vc-text);
    font-weight: 700;
}

.info-value i {
    font-size: 0.75rem;
    margin: 0 0.25rem;
}

/* ========== Circuit Footer ========== */
.circuit-footer {
    margin-top: auto;
    padding-top: 1.5rem;
    border-top: 2px solid var(--vc-border-light);
}

.circuit-availability {
    display: flex;
    align-items: center;
    gap: 0.5rem;
    margin-bottom: 1rem;
    font-size: 0.95rem;
    font-weight: 600;
}

.circuit-availability i {
    font-size: 1.1rem;
}

.circuit-booking {
    display: flex;
    justify-content: space-between;
    align-items: center;
    gap: 1.5rem;
}

.circuit-price-section {
    display: flex;
    flex-direction: column;
    align-items: flex-start;
}

.circuit-price {
    font-size: 2rem;
    font-weight: 800;
    color: var(--vc-success);
    line-height: 1;
    margin: 0.25rem 0;
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

/* ========== Responsive Adjustments for Circuits Page ========== */
@media (max-width: 992px) {
    .circuits-grid {
        grid-template-columns: 1fr;
    }
    
    .circuit-booking {
        flex-direction: column;
        align-items: stretch;
    }
    
    .circuit-price-section {
        align-items: center;
        text-align: center;
    }
}

@media (max-width: 768px) {
    .circuit-image-container {
        height: 180px;
    }
    
    .circuit-image-placeholder {
        font-size: 3rem;
    }
    
    .circuit-info-grid {
        grid-template-columns: 1fr;
    }
    
    .info-card-wide {
        grid-column: 1;
    }
}

@media (max-width: 480px) {
    .circuit-body {
        padding: 1rem;
    }
    
    .circuit-title {
        font-size: 1.25rem;
    }
    
    .circuit-price {
        font-size: 1.75rem;
    }
    
    .circuit-image-container {
        height: 150px;
    }
    
    .circuit-duration-badge {
        padding: 0.5rem 1rem;
        font-size: 0.85rem;
    }
    
    .info-card {
        padding: 0.75rem;
    }
    
    .info-icon {
        width: 40px;
        height: 40px;
        font-size: 1.1rem;
    }
}

/* ========== Responsive Adjustments for Flights Page ========== */
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
    
    .route-dashes {
        top: 50%;
        left: 0;
        right: 0;
        height: 2px;
        width: 100%;
        background: repeating-linear-gradient(
            to right,
            var(--vc-accent) 0,
            var(--vc-accent) 10px,
            transparent 10px,
            transparent 20px
        );
    }
    
    .flight-footer {
        flex-direction: column;
        align-items: stretch;
    }
    
    .flight-booking {
        flex-direction: column;
        align-items: stretch;
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
    .flight-header {
        flex-direction: column;
        align-items: flex-start;
    }
    
    .flight-class-badge {
        align-self: flex-start;
    }
    
    .flight-route {
        padding: 1rem;
        gap: 1rem;
    }
    
    .route-city {
        font-size: 1.1rem;
    }
    
    .route-icon {
        width: 50px;
        height: 50px;
        font-size: 1.5rem;
    }
    
    .flight-number {
        font-size: 1.25rem;
    }
}

@media (max-width: 480px) {
    .flight-card {
        padding: 1rem;
    }
    
    .flight-route {
        padding: 0.75rem;
    }
    
    .route-location i {
        font-size: 1.25rem;
    }
    
    .route-city {
        font-size: 1rem;
    }
    
    .route-time {
        font-size: 0.85rem;
        padding-left: 2rem;
    }
    
    .flight-price {
        font-size: 1.75rem;
    }
    
    .btn-book {
        padding: 0.875rem 1.25rem;
    }
}

/* ========== Responsive Adjustments for Destinations Page ========== */
@media (max-width: 992px) {
    .destinations-list-grid {
        grid-template-columns: repeat(auto-fill, minmax(320px, 1fr));
    }
}

@media (max-width: 768px) {
    .destinations-list-grid {
        grid-template-columns: 1fr;
        gap: 1.5rem;
    }
    
    .destination-image-wrapper {
        height: 220px;
    }
    
    .destination-stats {
        flex-wrap: wrap;
    }
    
    .stat-item {
        flex: 1 1 30%;
    }
    
    .cta-content {
        flex-direction: column;
        text-align: center;
    }
    
    .cta-icon {
        font-size: 3rem;
    }
    
    .destinations-intro {
        padding: 1rem 1.5rem;
    }
    
    .destinations-intro p {
        flex-direction: column;
        align-items: flex-start;
        font-size: 0.95rem;
    }
}

@media (max-width: 480px) {
    .destination-body {
        padding: 1rem;
    }
    
    .destination-title {
        font-size: 1.25rem;
    }
    
    .destination-actions {
        grid-template-columns: 1fr;
        gap: 0.5rem;
    }
    
    .btn-action {
        flex-direction: row;
        justify-content: center;
    }
    
    .destination-image-wrapper {
        height: 200px;
    }
    
    .destination-stats {
        padding: 0.75rem;
        gap: 0.5rem;
    }
    
    .stat-item i {
        font-size: 1.25rem;
    }
    
    .stat-item span {
        font-size: 0.7rem;
    }
    
    .cta-banner {
        padding: 2rem 1.5rem;
    }
}

/* ========== Responsive Adjustments for Hotels Page ========== */
@media (max-width: 992px) {
    .hotels-grid {
        grid-template-columns: 1fr;
    }
    
    .hotel-booking {
        flex-direction: column;
        align-items: stretch;
    }
    
    .hotel-price-section {
        align-items: center;
        text-align: center;
    }
    
    .hotel-booking .btn {
        width: 100%;
    }
}

@media (max-width: 768px) {
    .hotel-header {
        flex-direction: column;
    }
    
    .hotel-rating {
        align-self: flex-start;
    }
    
    .hotel-image-container {
        height: 180px;
    }
    
    .hotel-image-placeholder {
        font-size: 3rem;
    }
    
    .results-header {
        flex-direction: column;
        align-items: flex-start;
    }
    
    .tips-content {
        flex-direction: column;
        text-align: center;
    }
    
    .tips-icon {
        font-size: 2.5rem;
    }
}

@media (max-width: 480px) {
    .hotel-body {
        padding: 1rem;
    }
    
    .hotel-title {
        font-size: 1.25rem;
    }
    
    .hotel-price {
        font-size: 1.75rem;
    }
    
    .amenities {
        gap: 0.5rem;
    }
    
    .amenity-badge {
        padding: 0.4rem 0.8rem;
        font-size: 0.8rem;
    }
    
    .hotel-image-container {
        height: 150px;
    }
}

/* ========== Responsive Adjustments for Search Page ========== */
@media (max-width: 768px) {
    .page-header h1 {
        font-size: 1.75rem;
        flex-direction: column;
        gap: 0.5rem;
    }
    
    .page-header .lead-text {
        font-size: 1rem;
    }
    
    .search-options {
        grid-template-columns: 1fr;
        gap: 1.5rem;
    }
    
    .option-card {
        padding: 2rem 1.5rem;
    }
    
    .option-icon {
        font-size: 3rem;
    }
    
    .features-banner-content {
        flex-direction: column;
        text-align: center;
    }
    
    .features-banner-icon {
        font-size: 2.5rem;
    }
    
    .features-banner {
        padding: 2rem 1.5rem;
    }
    
    .empty-state {
        padding: 3rem 1rem;
    }
    
    .empty-state-icon {
        font-size: 3.5rem;
    }
}

@media (max-width: 480px) {
    .page-header {
        padding: 2rem 0;
    }
    
    .page-header h1 {
        font-size: 1.5rem;
    }
    
    .option-card h3 {
        font-size: 1.5rem;
    }
    
    .features-banner-text h3 {
        font-size: 1.5rem;
    }
    
    .features-banner-text p {
        font-size: 1rem;
    }
}

/* ========== Print Styles ========== */
@media print {
    .navbar,
    .hero-section,
    .page-header,
    .btn {
        display: none;
    }
    
    .card {
        break-inside: avoid;
    }
}
        /* Edit Profile Page Styles */
        .edit-profile-header {
            background: linear-gradient(135deg, #003580 0%, #0071c2 100%);
            color: white;
            padding: 3rem 0;
            margin-bottom: 2rem;
        }
        
        .edit-profile-header h1 {
            color: white;
            font-size: 2.5rem;
            font-weight: 800;
            margin-bottom: 0.5rem;
            display: flex;
            align-items: center;
            gap: 0.75rem;
        }
        
        .breadcrumb-custom {
            display: flex;
            align-items: center;
            gap: 0.5rem;
            color: rgba(255, 255, 255, 0.9);
            font-size: 0.95rem;
        }
        
        .breadcrumb-custom a {
            color: rgba(255, 255, 255, 0.9);
            text-decoration: none;
            transition: color 0.2s;
        }
        
        .breadcrumb-custom a:hover {
            color: white;
        }
        
        .breadcrumb-custom i {
            font-size: 0.75rem;
        }
        
        /* Form Card */
        .edit-form-card {
            background: white;
            border-radius: 16px;
            padding: 2rem;
            box-shadow: 0 2px 8px rgba(0, 0, 0, 0.08);
            border: 1px solid #e5e7eb;
        }
        
        .form-section {
            margin-bottom: 2rem;
        }
        
        .form-section:last-child {
            margin-bottom: 0;
        }
        
        .section-title {
            color: #003580;
            font-weight: 700;
            font-size: 1.25rem;
            margin-bottom: 1.5rem;
            display: flex;
            align-items: center;
            gap: 0.5rem;
            padding-bottom: 0.75rem;
            border-bottom: 2px solid #f3f4f6;
        }
        
        .form-grid {
            display: grid;
            grid-template-columns: repeat(2, 1fr);
            gap: 1.5rem;
        }
        
        .form-grid-full {
            grid-column: 1 / -1;
        }
        
        .form-group {
            display: flex;
            flex-direction: column;
        }
        
        .form-label {
            display: flex;
            align-items: center;
            gap: 0.5rem;
            font-weight: 600;
            color: #1a1a1a;
            margin-bottom: 0.5rem;
            font-size: 0.95rem;
        }
        
        .form-label i {
            color: #0071c2;
            width: 18px;
            text-align: center;
        }
        
        .form-label .required {
            color: #dc3545;
        }
        
        .form-control {
            width: 100%;
            padding: 0.875rem 1rem;
            font-size: 1rem;
            border: 2px solid #e5e7eb;
            border-radius: 8px;
            background: #ffffff;
            color: #1a1a1a;
            transition: all 0.25s cubic-bezier(0.4, 0, 0.2, 1);
            outline: none;
        }
        
        .form-control:focus {
            border-color: #0071c2;
            box-shadow: 0 0 0 3px rgba(0, 113, 194, 0.1);
        }
        
        .form-control:disabled {
            background: #f3f4f6;
            color: #9ca3af;
            cursor: not-allowed;
        }
        
        .form-control.error {
            border-color: #dc3545;
        }
        
        .form-control.error:focus {
            box-shadow: 0 0 0 3px rgba(220, 53, 69, 0.1);
        }
        
        .form-help {
            font-size: 0.85rem;
            color: #6b7280;
            margin-top: 0.375rem;
        }
        
        .form-help i {
            margin-right: 0.25rem;
        }
        
        .form-error {
            font-size: 0.85rem;
            color: #dc3545;
            margin-top: 0.375rem;
            display: flex;
            align-items: center;
            gap: 0.375rem;
        }
        
        /* Alert Messages */
        .alert {
            padding: 1rem 1.5rem;
            border-radius: 12px;
            margin-bottom: 1.5rem;
            display: flex;
            align-items: center;
            gap: 0.75rem;
            animation: slideDown 0.3s ease-out;
        }
        
        @keyframes slideDown {
            from {
                opacity: 0;
                transform: translateY(-10px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }
        
        .alert-success {
            background: #dcfce7;
            border: 2px solid #bbf7d0;
            color: #15803d;
        }
        
        .alert-error {
            background: #fee2e2;
            border: 2px solid #fecaca;
            color: #dc2626;
        }
        
        .alert i {
            font-size: 1.25rem;
        }
        
        .btn-close-alert {
            background: transparent;
            border: none;
            cursor: pointer;
            padding: 0.25rem;
            margin-left: auto;
            opacity: 0.7;
            transition: opacity 0.2s;
        }
        
        .btn-close-alert:hover {
            opacity: 1;
        }
        
        /* Action Buttons */
        .form-actions {
            display: flex;
            gap: 1rem;
            margin-top: 2rem;
            padding-top: 1.5rem;
            border-top: 2px solid #f3f4f6;
        }
        
        .btn-cancel {
            background: transparent;
            color: #6b7280;
            border: 2px solid #e5e7eb;
            transition: all 0.25s ease;
        }
        
        .btn-cancel:hover {
            background: #f3f4f6;
            color: #1a1a1a;
            border-color: #d1d5db;
        }
        
        /* Info Box */
        .info-box {
            background: #eff6ff;
            border: 2px solid #bfdbfe;
            border-radius: 12px;
            padding: 1rem 1.25rem;
            margin-bottom: 1.5rem;
            display: flex;
            gap: 0.75rem;
        }
        
        .info-box i {
            color: #1d4ed8;
            font-size: 1.25rem;
            flex-shrink: 0;
            margin-top: 0.125rem;
        }
        
        .info-box-content {
            flex: 1;
        }
        
        .info-box-content strong {
            color: #1e40af;
            display: block;
            margin-bottom: 0.25rem;
        }
        
        .info-box-content p {
            color: #1e40af;
            margin: 0;
            font-size: 0.9rem;
        }
        
        /* Responsive */
        @media (max-width: 768px) {
            .edit-profile-header h1 {
                font-size: 1.75rem;
                flex-direction: column;
                gap: 0.5rem;
            }
            
            .form-grid {
                grid-template-columns: 1fr;
                gap: 1rem;
            }
            
            .form-actions {
                flex-direction: column;
            }
            
            .form-actions .btn {
                width: 100%;
            }
            
            .edit-form-card {
                padding: 1.5rem;
            }
        }
    </style>
</head>
<body class="page-wrapper">
    <jsp:include page="/WEB-INF/views/common/navbar.jsp" />
    
    <!-- Page Header -->
    <div class="edit-profile-header">
        <div class="container">
            <div class="breadcrumb-custom">
                <a href="${pageContext.request.contextPath}/user/dashboard">
                    <i class="fas fa-home"></i> Tableau de bord
                </a>
                <i class="fas fa-chevron-right"></i>
                <a href="${pageContext.request.contextPath}/user/profile">
                    <i class="fas fa-user"></i> Profil
                </a>
                <i class="fas fa-chevron-right"></i>
                <span>Modifier</span>
            </div>
            <h1>
                <i class="fas fa-user-edit"></i> Modifier mon profil
            </h1>
        </div>
    </div>
    
    <div class="container">
        <!-- Success Message -->
        <c:if test="${not empty success}">
            <div class="alert alert-success">
                <i class="fas fa-check-circle"></i>
                <span>${success}</span>
                <button type="button" class="btn-close-alert" onclick="this.parentElement.remove()">
                    <i class="fas fa-times"></i>
                </button>
            </div>
        </c:if>
        
        <!-- Error Message -->
        <c:if test="${not empty error}">
            <div class="alert alert-error">
                <i class="fas fa-exclamation-circle"></i>
                <span>${error}</span>
                <button type="button" class="btn-close-alert" onclick="this.parentElement.remove()">
                    <i class="fas fa-times"></i>
                </button>
            </div>
        </c:if>
        
        <div class="row">
            <div class="col-md-8 mx-auto">
                <!-- Edit Form Card -->
                <div class="edit-form-card">
                    <form action="${pageContext.request.contextPath}/user/update-profile" method="POST" id="editProfileForm">
                        <!-- Personal Information Section -->
                        <div class="form-section">
                            <h3 class="section-title">
                                <i class="fas fa-user"></i> Informations personnelles
                            </h3>
                            
                            <div class="form-grid">
                                <!-- First Name -->
                                <div class="form-group">
                                    <label for="firstName" class="form-label">
                                        <i class="fas fa-user"></i>
                                        Prénom
                                        <span class="required">*</span>
                                    </label>
                                    <input type="text" 
                                           class="form-control" 
                                           id="firstName" 
                                           name="firstName" 
                                           value="${user.firstName}"
                                           required
                                           minlength="2"
                                           maxlength="50"
                                           placeholder="Votre prénom">
                                    <small class="form-help">
                                        <i class="fas fa-info-circle"></i>
                                        2 à 50 caractères
                                    </small>
                                </div>
                                
                                <!-- Last Name -->
                                <div class="form-group">
                                    <label for="lastName" class="form-label">
                                        <i class="fas fa-user"></i>
                                        Nom
                                        <span class="required">*</span>
                                    </label>
                                    <input type="text" 
                                           class="form-control" 
                                           id="lastName" 
                                           name="lastName" 
                                           value="${user.lastName}"
                                           required
                                           minlength="2"
                                           maxlength="50"
                                           placeholder="Votre nom">
                                    <small class="form-help">
                                        <i class="fas fa-info-circle"></i>
                                        2 à 50 caractères
                                    </small>
                                </div>
                            </div>
                        </div>
                        
                        <!-- Contact Information Section -->
                        <div class="form-section">
                            <h3 class="section-title">
                                <i class="fas fa-address-book"></i> Coordonnées
                            </h3>
                            
                            <div class="info-box">
                                <i class="fas fa-lock"></i>
                                <div class="info-box-content">
                                    <strong>Email protégé</strong>
                                    <p>Votre adresse email ne peut pas être modifiée ici. Contactez le support si nécessaire.</p>
                                </div>
                            </div>
                            
                            <div class="form-grid">
                                <!-- Email (Read-only) -->
                                <div class="form-group form-grid-full">
                                    <label for="email" class="form-label">
                                        <i class="fas fa-envelope"></i>
                                        Email
                                    </label>
                                    <input type="email" 
                                           class="form-control" 
                                           id="email" 
                                           value="${user.email}"
                                           disabled>
                                    <small class="form-help">
                                        <i class="fas fa-lock"></i>
                                        Adresse email non modifiable
                                    </small>
                                </div>
                                
                                <!-- Phone -->
                                <div class="form-group">
                                    <label for="phone" class="form-label">
                                        <i class="fas fa-phone"></i>
                                        Téléphone
                                    </label>
                                    <input type="tel" 
                                           class="form-control" 
                                           id="phone" 
                                           name="phone" 
                                           value="${user.phone}"
                                           maxlength="20"
                                           placeholder="Ex: +33 6 12 34 56 78">
                                    <small class="form-help">
                                        <i class="fas fa-info-circle"></i>
                                        Optionnel
                                    </small>
                                </div>
                                
                                <!-- Address -->
                                <div class="form-group form-grid-full">
                                    <label for="address" class="form-label">
                                        <i class="fas fa-map-marker-alt"></i>
                                        Adresse
                                    </label>
                                    <input type="text" 
                                           class="form-control" 
                                           id="address" 
                                           name="address" 
                                           value="${user.address}"
                                           maxlength="255"
                                           placeholder="Votre adresse complète">
                                    <small class="form-help">
                                        <i class="fas fa-info-circle"></i>
                                        Optionnel - Utile pour vos réservations
                                    </small>
                                </div>
                            </div>
                        </div>
                        
                        <!-- Security Note -->
                        <div class="info-box" style="background: #fef3c7; border-color: #fde68a;">
                            <i class="fas fa-shield-alt" style="color: #a16207;"></i>
                            <div class="info-box-content">
                                <strong style="color: #92400e;">Changer votre mot de passe ?</strong>
                                <p style="color: #92400e;">
                                    Pour modifier votre mot de passe, rendez-vous sur la 
                                    <a href="${pageContext.request.contextPath}/user/change-password" 
                                       style="color: #92400e; text-decoration: underline; font-weight: 600;">
                                        page de changement de mot de passe
                                    </a>.
                                </p>
                            </div>
                        </div>
                        
                        <!-- Form Actions -->
                        <div class="form-actions">
                            <button type="submit" class="btn btn-highlight">
                                <i class="fas fa-save"></i> Enregistrer les modifications
                            </button>
                            <a href="${pageContext.request.contextPath}/user/profile" class="btn btn-cancel">
                                <i class="fas fa-times"></i> Annuler
                            </a>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>
    
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        // Form Validation
        document.getElementById('editProfileForm').addEventListener('submit', function(e) {
            const firstName = document.getElementById('firstName').value.trim();
            const lastName = document.getElementById('lastName').value.trim();
            
            if (firstName.length < 2 || firstName.length > 50) {
                e.preventDefault();
                alert('Le prénom doit contenir entre 2 et 50 caractères');
                document.getElementById('firstName').focus();
                return false;
            }
            
            if (lastName.length < 2 || lastName.length > 50) {
                e.preventDefault();
                alert('Le nom doit contenir entre 2 et 50 caractères');
                document.getElementById('lastName').focus();
                return false;
            }
            
            return true;
        });
        
        // Auto-hide alerts after 5 seconds
        setTimeout(function() {
            const alerts = document.querySelectorAll('.alert');
            alerts.forEach(function(alert) {
                alert.style.transition = 'opacity 0.5s ease';
                alert.style.opacity = '0';
                setTimeout(function() {
                    alert.remove();
                }, 500);
            });
        }, 5000);
    </script>
</body>
</html>
