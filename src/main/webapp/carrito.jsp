<%@ page import="model.Producto" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.List, model.Carrito, controller.controlCarrito" %>
<%@page import="model.Cliente" %>
<%@page import="model.Usuario, controller.controlCarrito" %>
<%@page import="jakarta.servlet.http.HttpSession" %>
<%@ page import="dao.ProductoDao" %>
<%@ page import="model.Producto" %>
<%@ page import="java.util.List" %><%--
  Created by IntelliJ IDEA.
  User: RefinedCandle49
  Date: 9/01/2024
  Time: 12:48
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
    <title>Carrito de compras</title>
</head>
<body>
<header>
    <ul>
        <li>
            <a href="controlCarrito?accion=Home">Seguir comprando</a>
        </li>
    </ul>
</header>

<c:forEach var="car" items="${carrito}">
<%--    <p>${car.getItem()}</p>--%>
    <p>${car.getNombre()}</p>
</c:forEach>
    <p>${number10}</p>
</body>
</html>
