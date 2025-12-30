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
            --transition-base: 250ms cubic-bezier(0.4, 0, 0.2, 1);
            --gradient-primary: linear-gradient(135deg, #003580 0%, #0057b8 100%);
            --gradient-admin: linear-gradient(135deg, #1a1a2e 0%, #16213e 100%);
        }
        * { margin: 0; padding: 0; box-sizing: border-box; }
        body {
            font-family: -apple-system, BlinkMacSystemFont, "Segoe UI", Roboto, "Helvetica Neue", Arial, sans-serif;
            background: var(--vc-bg);
            color: var(--vc-text);
            line-height: 1.6;
        }
        .container { max-width: 1200px; margin: 0 auto; padding: 0 1.5rem; }

        /* Navbar Admin */
        .navbar-admin {
            background: var(--gradient-admin);
            padding: 1rem 0;
            box-shadow: var(--shadow-md);
        }
        .navbar-admin .container {
            display: flex;
            align-items: center;
            justify-content: space-between;
        }
        .navbar-brand {
            display: flex;
            align-items: center;
            gap: 0.75rem;
            color: #ffffff;
            text-decoration: none;
            font-size: 1.5rem;
            font-weight: 700;
        }
        .navbar-brand i { color: var(--vc-warning); }
        .navbar-nav {
            display: flex;
            align-items: center;
            gap: 0.5rem;
            list-style: none;
        }
        .nav-link {
            display: flex;
            align-items: center;
            gap: 0.5rem;
            padding: 0.625rem 1rem;
            color: rgba(255, 255, 255, 0.8);
            text-decoration: none;
            border-radius: var(--radius-md);
            transition: all var(--transition-base);
            font-weight: 500;
        }
        .nav-link:hover, .nav-link.active {
            background: rgba(255, 255, 255, 0.1);
            color: #ffffff;
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
            .navbar-nav { display: none; }
        }
    </style>
</head>
<body>
    <!-- Navbar Admin -->
    <nav class="navbar-admin">
        <div class="container">
            <a href="${pageContext.request.contextPath}/admin/dashboard" class="navbar-brand">
                <i class="fas fa-shield-halved"></i>
                <span>VoyageConnect Admin</span>
            </a>
            <ul class="navbar-nav">
                <li><a href="${pageContext.request.contextPath}/admin/dashboard" class="nav-link"><i class="fas fa-chart-line"></i> Dashboard</a></li>
                <li><a href="${pageContext.request.contextPath}/admin/destinations" class="nav-link active"><i class="fas fa-map-marked-alt"></i> Destinations</a></li>
                <li><a href="${pageContext.request.contextPath}/admin/flights" class="nav-link"><i class="fas fa-plane"></i> Vols</a></li>
                <li><a href="${pageContext.request.contextPath}/admin/hotels" class="nav-link"><i class="fas fa-hotel"></i> Hôtels</a></li>
                <li><a href="${pageContext.request.contextPath}/admin/circuits" class="nav-link"><i class="fas fa-route"></i> Circuits</a></li>
            </ul>
        </div>
    </nav>

    <!-- Page Header -->
    <div class="page-header">
        <div class="container">
            <h1><i class="fas fa-map-marked-alt"></i> Gestion des Destinations</h1>
            <p>Ajoutez, modifiez et gérez les destinations de voyage</p>
            <div class="breadcrumb-admin">
                <a href="${pageContext.request.contextPath}/admin/dashboard"><i class="fas fa-home"></i> Dashboard</a>
                <span>/</span>
                <span>Destinations</span>
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
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
