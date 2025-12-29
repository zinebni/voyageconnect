<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="fr">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Connexion – VoyageConnect</title>

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
<link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css" rel="stylesheet">
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">

<style> 
    /* ================= ROOT ================= */
:root {
    --vc-primary: #003580;
    --vc-accent: #0071c2;
    --vc-yellow: #febb02;
    --vc-text: #1a1a1a;
    --vc-text-muted: #6b7280;
    --vc-border: #e5e7eb;
    --vc-border-light: #f3f4f6;

    --vc-radius-md: 10px;
    --vc-radius-lg: 16px;
    --vc-radius-xl: 22px;

    --vc-shadow-xl: 0 20px 40px rgba(0,0,0,.18);
    --vc-shadow-2xl: 0 30px 60px rgba(0,0,0,.25);
}

/* ================= BODY ================= */
body {
    min-height: 100vh;
    display: flex;
    justify-content: center;
    align-items: center;
    background:white;
    padding: 40px 20px;
    font-family: system-ui, -apple-system, BlinkMacSystemFont, "Segoe UI", Roboto, Arial, sans-serif;
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
    flex-shrink: 0;
}

.navbar-brand i {
    font-size: 1.75rem;
    color: var(--vc-yellow);
}

.navbar-brand:hover {
    color: var(--vc-accent);
}

/* ================= CONTAINER ================= */
.auth-container {
    width: 100%;
    max-width: 720px;
    z-index: 2;
}

/* ================= CARD ================= */
.auth-card {
    background: rgba(255, 255, 255, 0.877);
    backdrop-filter: blur(12px);
    border-radius: var(--vc-radius-xl);
    padding: 3rem 3.5rem;
    box-shadow:
        var(--vc-shadow-xl),
        inset 0 1px 0 rgba(255, 255, 255, 0.498);
    animation: fadeUp .6s ease;
}

/* ================= LOGO ================= */
.auth-logo {
    text-align: center;
    margin-bottom: 1.5rem;
}

.auth-logo i {
    font-size: 1.75rem;
    font-weight: 700;
    
}

/* ================= HEADER ================= */
.auth-header {
    text-align: center;
    margin-bottom: 2.2rem;
    margin-top: 4.2rem;
}

.auth-header h2 {

    font-size: 1.5rem;
    font-weight: 700;
    color: var(--vc-primary);
}

.auth-header p {
    color: var(--vc-text-muted);
}

/* ================= FORM ================= */
.form-label {
    font-weight: 600;
    margin-bottom: .4rem;
}

.form-control {
    height: 48px;
    border-radius: var(--vc-radius-md);
    border: 1px solid var(--vc-border);
    font-weight: 500;
}

.form-control:focus {
    border-color: var(--vc-accent);
    box-shadow: 0 0 0 .15rem rgba(0,113,194,.15);
}

textarea.form-control {
    height: auto;
    resize: none;
}

/* ================= INPUT ICON ================= */
.input-icon-wrapper {
    position: relative;
}

.input-icon-wrapper i {
    position: absolute;
    left: 1rem;
    top: 50%;
    transform: translateY(-50%);
    color: var(--vc-text-muted);
    transition: .3s;
}

.input-icon-wrapper textarea + i {
    top: 1.1rem;
    transform: none;
}

.input-icon-wrapper input,
.input-icon-wrapper textarea {
    padding-left: 2.75rem;
}

.input-icon-wrapper input:focus ~ i,
.input-icon-wrapper textarea:focus ~ i {
    color: var(--vc-accent);
}

/* ================= SPACING ================= */
.mb-4 {
    margin-bottom: 1.75rem !important;
}

/* ================= BUTTONS ================= */
.btn-highlight {
    height: 52px;
    font-weight: 700;
    font-size: 1rem;
    border-radius: 12px;
    background: linear-gradient(135deg, #003580, #0071c2);
    box-shadow: 0 4px 6px -1px rgba(0, 0, 0, 0.1), 0 2px 4px -1px rgba(0, 0, 0, 0.06);
    border: none;
    color : #ffffff;
}

.btn-highlight:hover {
    transform: translateY(-2px);
    background: linear-gradient(135deg, #0071c2 0%, #003580 100%);
    box-shadow: 0 10px 15px -3px rgba(0, 0, 0, 0.1), 0 4px 6px -2px rgba(0, 0, 0, 0.05);
}

.btn-secondary {
    height: 48px;
    border-radius: 12px;
}

/* ================= FOOTER ================= */
.auth-footer {
    text-align: center;
    margin-top: 2rem;
    padding-top: 1.5rem;
    border-top: 1px solid var(--vc-border-light);
}

.auth-footer a {
    color: var(--vc-primary);
    font-weight: 600;
    text-decoration: none;
}

.auth-footer a:hover {
    color: var(--vc-accent);
}

/* ================= ALERT ================= */
.alert {
    border-radius: var(--vc-radius-md);
    font-weight: 500;
}

/* ================= ANIMATION ================= */
@keyframes fadeUp {
    from {
        opacity: 0;
        transform: translateY(25px);
    }
    to {
        opacity: 1;
        transform: translateY(0);
    }
}

/* ================= RESPONSIVE ================= */
@media (max-width: 768px) {
    body {
        align-items: flex-start;
        padding-top: 60px;
    }

    .auth-card {
        padding: 2rem 1.75rem;
    }
}
</style>
</head>

<body>

<div class="auth-container">
    <div class="auth-card">

        <a href="${pageContext.request.contextPath}/" class="navbar-brand">
                <i class="fas fa-plane-departure"></i>
                <span class="brand-text">VoyageConnect</span>
        </a>

        <div class="auth-header">
            <h2><i class="fa-solid fa-lock me-2"></i>Connexion</h2>
            <p>Accédez à votre espace VoyageConnect</p>
        </div>

        <c:if test="${not empty error}">
            <div class="alert alert-danger">
                <i class="fa-solid fa-circle-exclamation me-2"></i>${error}
            </div>
        </c:if>

        <c:if test="${not empty success}">
            <div class="alert alert-success">
                <i class="fa-solid fa-circle-check me-2"></i>${success}
            </div>
        </c:if>

        <form action="${pageContext.request.contextPath}/auth/login" method="post">

            <div class="mb-4">
                <label class="form-label">Adresse email</label>
                <div class="input-icon-wrapper">
                    <input type="email" name="email" class="form-control" placeholder="votre@email.com" required>
                    <i class="fa-solid fa-envelope"></i>
                </div>
            </div>

            <div class="mb-4">
                <label class="form-label">Mot de passe</label>
                <div class="input-icon-wrapper">
                    <input type="password" name="password" class="form-control" placeholder="••••••••" required>
                    <i class="fa-solid fa-key"></i>
                </div>
            </div>

            <button class="btn btn-highlight w-100 mb-3">
                <i class="fa-solid fa-right-to-bracket me-2"></i>Se connecter
            </button>

        </form>

        <div class="auth-footer">
            <p>
                Pas encore de compte ?
                <a href="${pageContext.request.contextPath}/auth/register">
                    <i class="fa-solid fa-user-plus me-1"></i>Créer un compte
                </a>
            </p>
        </div>

    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
