<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@page import="jakarta.servlet.http.HttpSession" %>
<%@page import="model.Cliente" %>
<html>
<head>
    <%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
    <title>Resumen del Pedido || Mammamía</title>
</head>
<body>
    <%
            // Obtener la sesión
            HttpSession sesion = request.getSession(false);
            
            // Obtener la sesion para cliente
            Boolean isLoggedIn = (sesion != null && sesion.getAttribute("isLoggedIn") != null && (Boolean) sesion.getAttribute("isLoggedIn"));
            
            // Obtener la sesion para invitado
            Boolean isGuest = (sesion != null && sesion.getAttribute("isGuest") != null && (Boolean) sesion.getAttribute("isGuest"));
            
    %>

    <header>
        <ul>
            <li>
                <a href="${pageContext.request.contextPath}/index.jsp">
                    <img src="..." alt="logo"/> | Inicio
                </a>
            </li>
            <li>
                <a href="${pageContext.request.contextPath}/menu.jsp">Menú</a>
            </li>
            <li>
                <a href="${pageContext.request.contextPath}/nosotros.jsp">Nosotros</a>
            </li>
            <!-- Menú para cliente -->
            <%
                if (isLoggedIn) {
            %>
            <li>
                <a href="${pageContext.request.contextPath}/customer/logout.jsp">Cerrar Sesión</a>
            </li>
            <li>
                <a href="${pageContext.request.contextPath}/customer/account/panel.jsp">Mi Cuenta</a>
            </li>
            <!-- Menú para invitado-->
            <%
            } else if (isGuest) {
            %>
            <li>
                <a href="${pageContext.request.contextPath}/customer/logout.jsp">Iniciar Sesión (Invitado)</a>
            </li>
            <%
            } else {
            %>
            <li>
                <a href="${pageContext.request.contextPath}/customer/login.jsp">Iniciar Sesión</a>
            </li>
            <%
                }
            %>
        </ul>
    </header>

    <main>
        <h1>Resumen del pedido</h1>
        <table border="1">
            <thead>
            <tr>
                <th>Producto</th>
                <th>Precio</th>
                <th>Cantidad</th>
                <th>SubTotal</th>
            </tr>
            </thead>
            <tbody>
            <c:forEach var="car" items="${carrito}">
                <tr>
                    <td>${car.getNombre()}</td>
                    <td>${car.getPrecio()}</td>
                    <td>${car.getCantidad()}</td>
                    <td>${car.getSubtotal()}</td>
                </tr>
            </c:forEach>
            
            </tbody>
            <a href="<%=request.getContextPath()%>/index.jsp">Volver al menú</a>
        </table>
    </main>
    
</body>
</html>
