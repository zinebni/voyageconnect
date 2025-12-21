<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.voyageconnect.model.User" %>
<%@ page import="com.voyageconnect.model.UserRole" %>
<%
    // ⚠️ PAGE DE TEST UNIQUEMENT - À SUPPRIMER EN PRODUCTION ⚠️
    
    // Créer un utilisateur fictif pour les tests
    User testUser = new User();
    testUser.setId(1L);
    testUser.setEmail("test@voyage.com");
    testUser.setFirstname("Test");
    testUser.setLastname("User");
    testUser.setRole(UserRole.USER);
    
    // Stocker dans la session
    session.setAttribute("user", testUser);
    session.setAttribute("userId", 1L);
    session.setAttribute("userRole", UserRole.USER);
    
    // Rediriger vers la page demandée ou la recherche de vols
    String redirect = request.getParameter("redirect");
    if (redirect == null || redirect.isEmpty()) {
        redirect = request.getContextPath() + "/search/flights";
    }
    
    response.sendRedirect(redirect);
%>
<!DOCTYPE html>
<html>
<head>
    <title>Session de test créée</title>
</head>
<body>
    <p>Session de test créée. Redirection...</p>
</body>
</html>
