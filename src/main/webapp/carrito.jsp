<%@page contentType="text/html" pageEncoding="UTF-8" %>
<%@ page import="model.Producto" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.List, model.Carrito, controller.controlCarrito" %>
<%@page import="model.Cliente" %>
<%@page import="model.Usuario, controller.controlCarrito" %>
<%@page import="jakarta.servlet.http.HttpSession" %>
<%@ page import="dao.ProductoDao" %>
<%@ page import="model.Producto" %>
<%@ page import="java.util.List" %>
<html>
<head>
    <%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
    <title>Carrito de compras</title>
</head>
<body>
<header>
    <ul>
        <li>
            <%--            <a href="<%=request.getContextPath()%>/controlCarrito?accion=Home&menu=">Seguir comprando</a>--%>
            <a href="${pageContext.request.contextPath}/menu.jsp">Volver a la página
                anterior</a>
        </li>
    </ul>
</header>

<table border="1">
    <thead>
    <tr>
        <th>Item</th>
        <th>Id Producto</th>
        <th>Producto</th>
        <th>Precio</th>
        <th>Cantidad</th>
        <th>SubTotal</th>
        <th>Acciones</th>
    </tr>
    </thead>
    <tbody>
    <c:forEach var="car" items="${carrito}">
        <tr>
            <td>${car.getItem()}</td>
            <td>${car.getIdProducto()}</td>
            <td>${car.getNombre()}</td>
            <td>${car.getPrecio()}</td>
            <td>
                <input type="hidden" id="id" value="${car.getIdProducto()}">
                <input type="number" min="1" step="1" id="Cantidad" value="${car.getCantidad()}">
            </td>
            <td>${car.getSubtotal()}</td>
            <td>
                <input type="hidden" id="id" value="${car.getIdProducto()}">
                <a href="<%=request.getContextPath()%>/controlCarrito?accion=Delete&idp=${car.getIdProducto()}" id="btnDetele">Eliminar</a>
            </td>
        </tr>
    </c:forEach>
    <p>Total a pagar: ${totalPagar}</p>
    </tbody>
</table>
<a href="<%=request.getContextPath()%>/checkout.jsp">Realizar pago</a>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script src="<%=request.getContextPath()%>/js/functions.js" type="text/javascript"></script>
</body>
</html>
