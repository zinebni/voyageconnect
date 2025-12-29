<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <title>Debug Session</title>
    <style>
        body { font-family: monospace; padding: 20px; }
        h2 { color: #003580; }
        .info { background: #f0f0f0; padding: 10px; margin: 10px 0; }
        .error { background: #fee; padding: 10px; margin: 10px 0; }
    </style>
</head>
<body>
    <h1>🔍 Debug Session</h1>
    
    <h2>Session Info:</h2>
    <div class="info">
        <strong>Session ID:</strong> ${pageContext.session.id}<br>
        <strong>Is New:</strong> ${pageContext.session.isNew()}<br>
        <strong>Creation Time:</strong> ${pageContext.session.creationTime}
    </div>
    
    <h2>User Object:</h2>
    <div class="info">
        <strong>User:</strong> ${sessionScope.user}<br>
        <c:if test="${not empty sessionScope.user}">
            <strong>ID:</strong> ${sessionScope.user.id}<br>
            <strong>Email:</strong> ${sessionScope.user.email}<br>
            <strong>First Name:</strong> ${sessionScope.user.firstName}<br>
            <strong>Last Name:</strong> ${sessionScope.user.lastName}<br>
        </c:if>
        <c:if test="${empty sessionScope.user}">
            <span class="error">❌ User object is NULL or empty!</span>
        </c:if>
    </div>
    
    <h2>UserId Attribute:</h2>
    <div class="info">
        <strong>userId:</strong> ${sessionScope.userId}
        <c:if test="${empty sessionScope.userId}">
            <span class="error">❌ userId is NULL!</span>
        </c:if>
    </div>
    
    <h2>All Session Attributes:</h2>
    <div class="info">
        <%
            java.util.Enumeration<String> attributeNames = session.getAttributeNames();
            if (!attributeNames.hasMoreElements()) {
                out.println("<span class='error'>❌ No attributes in session!</span>");
            }
            while (attributeNames.hasMoreElements()) {
                String attrName = attributeNames.nextElement();
                Object attrValue = session.getAttribute(attrName);
                out.println("<strong>" + attrName + ":</strong> " + attrValue + "<br>");
            }
        %>
    </div>
    
    <h2>Actions:</h2>
    <div>
        <a href="${pageContext.request.contextPath}/user/profile">Aller au profil</a><br>
        <a href="${pageContext.request.contextPath}/user/dashboard">Aller au dashboard</a><br>
        <a href="${pageContext.request.contextPath}/auth/login">Se connecter</a>
    </div>
</body>
</html>
<!-- ```

Ensuite accédez à : `http://localhost:8081/VoyageConnect/debug-session.jsp`

### **4. Problèmes possibles**

Voici les causes les plus probables :

**A) Le fichier profile.jsp n'existe pas ou n'est pas au bon endroit**
```
❌ MAUVAIS : webapp/user/profile.jsp
❌ MAUVAIS : WEB-INF/user/profile.jsp
✅ BON     : webapp/WEB-INF/views/user/profile.jsp -->