<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

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

<script>
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
</script>
