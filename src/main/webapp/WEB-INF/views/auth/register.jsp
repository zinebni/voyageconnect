<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="fr">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Inscription – VoyageConnect</title>

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
<link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css" rel="stylesheet">
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">

<style>
/* ===== GLOBAL BACKGROUND (same as login) ===== */
body {
    min-height: 100vh;
    display: flex;
    justify-content: center;
    align-items: center;
    background:
        radial-gradient(circle at top right, rgba(255,255,255,.15), transparent 40%),
        linear-gradient(135deg, var(--vc-primary), var(--vc-accent));
    padding: 40px 20px;
    overflow: hidden;
}

/* ===== CARD ===== */
.auth-container {
    width: 100%;
    max-width: 720px;
    z-index: 2;
}

.auth-card {
    background: rgba(255,255,255,.96);
    backdrop-filter: blur(10px);
    border-radius: var(--vc-radius-xl);
    padding: 3rem;
    box-shadow: var(--vc-shadow-2xl);
    animation: fadeUp .6s ease;
}

/* ===== LOGO ===== */
.auth-logo {
    text-align: center;
    margin-bottom: 1.5rem;
}

.auth-logo i {
    font-size: 3.2rem;
    color: var(--vc-yellow);
}

/* ===== HEADER ===== */
.auth-header {
    text-align: center;
    margin-bottom: 2.5rem;
}

.auth-header h2 {
    font-weight: 800;
    color: var(--vc-primary);
}

.auth-header p {
    color: var(--vc-text-muted);
}

/* ===== INPUTS ===== */
.form-label {
    font-weight: 600;
}

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

/* ===== BUTTONS ===== */
.btn-highlight {
    height: 48px;
    font-weight: 700;
    letter-spacing: .3px;
    box-shadow: 0 10px 25px rgba(0,0,0,.15);
}

.btn-highlight:hover {
    transform: translateY(-1px);
}

.btn-secondary {
    height: 48px;
}

/* ===== FOOTER ===== */
.auth-footer {
    text-align: center;
    margin-top: 2rem;
    padding-top: 1.5rem;
    border-top: 1px solid var(--vc-border-light);
}

.auth-footer a {
    color: var(--vc-accent);
    font-weight: 600;
    text-decoration: none;
}

.auth-footer a:hover {
    color: var(--vc-yellow);
}

/* ===== ANIMATION ===== */
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
</style>
</head>

<body>

<div class="auth-container">
    <div class="auth-card">

        <div class="auth-logo">
            <i class="fa-solid fa-user-plus"></i>
        </div>

        <div class="auth-header">
            <h2><i class="fa-solid fa-id-card me-2"></i>Inscription</h2>
            <p>Créez votre compte VoyageConnect</p>
        </div>

        <c:if test="${not empty error}">
            <div class="alert alert-danger">
                <i class="fa-solid fa-circle-exclamation me-2"></i>${error}
            </div>
        </c:if>

        <form action="${pageContext.request.contextPath}/auth/register" method="post">

            <div class="row">
                <div class="col-md-6 mb-4">
                    <label class="form-label">Prénom</label>
                    <div class="input-icon-wrapper">
                        <input type="text" name="firstName" class="form-control" required>
                        <i class="fa-solid fa-user"></i>
                    </div>
                </div>

                <div class="col-md-6 mb-4">
                    <label class="form-label">Nom</label>
                    <div class="input-icon-wrapper">
                        <input type="text" name="lastName" class="form-control" required>
                        <i class="fa-solid fa-user"></i>
                    </div>
                </div>
            </div>

            <div class="mb-4">
                <label class="form-label">Adresse email</label>
                <div class="input-icon-wrapper">
                    <input type="email" name="email" class="form-control" required>
                    <i class="fa-solid fa-envelope"></i>
                </div>
            </div>

            <div class="mb-4">
                <label class="form-label">Téléphone</label>
                <div class="input-icon-wrapper">
                    <input type="tel" name="phone" class="form-control">
                    <i class="fa-solid fa-phone"></i>
                </div>
            </div>

            <div class="mb-4">
                <label class="form-label">Adresse</label>
                <div class="input-icon-wrapper">
                    <textarea name="address" class="form-control" rows="2"></textarea>
                    <i class="fa-solid fa-location-dot"></i>
                </div>
            </div>

            <div class="row">
                <div class="col-md-6 mb-4">
                    <label class="form-label">Mot de passe</label>
                    <div class="input-icon-wrapper">
                        <input type="password" id="password" name="password" class="form-control" required minlength="6">
                        <i class="fa-solid fa-lock"></i>
                    </div>
                    <small class="text-muted">Minimum 6 caractères</small>
                </div>

                <div class="col-md-6 mb-4">
                    <label class="form-label">Confirmation</label>
                    <div class="input-icon-wrapper">
                        <input type="password" id="confirmPassword" name="confirmPassword" class="form-control" required>
                        <i class="fa-solid fa-lock"></i>
                    </div>
                </div>
            </div>

            <button class="btn btn-highlight w-100 mb-3">
                <i class="fa-solid fa-user-check me-2"></i>Créer mon compte
            </button>

            <a href="${pageContext.request.contextPath}/" class="btn btn-secondary w-100">
                <i class="fa-solid fa-house me-2"></i>Accueil
            </a>
        </form>

        <div class="auth-footer">
            <p>
                Déjà inscrit ?
                <a href="${pageContext.request.contextPath}/auth/login">
                    <i class="fa-solid fa-right-to-bracket me-1"></i>Se connecter
                </a>
            </p>
        </div>

    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
<script>
document.getElementById('confirmPassword').addEventListener('input', function () {
    const pwd = document.getElementById('password').value;
    this.setCustomValidity(this.value !== pwd ? 'Les mots de passe ne correspondent pas' : '');
});
</script>

</body>
</html>
