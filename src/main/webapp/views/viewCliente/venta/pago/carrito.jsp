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
            <%--            <a href="<%=request.getContextPath()%>/controlCarrito?accion=Home&menu=">Seguir comprando</a>--%>
            <a href="#" onclick="history.back()">Volver a la página anterior</a>
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
    <form action="<%=request.getContextPath()%>/controlCarrito?accion=ActualizarCantidad" method="get">
        <input type="hidden" name="idProducto" value="${car.getIdProducto()}">
        <input type="hidden" name="cantidad" value="${car.getCantidad()}">
    </form>
    <c:forEach var="car" items="${carrito}">
        <tr>
            <td>${car.getItem()}</td>
            <td>${car.getIdProducto()}</td>
            <td>${car.getNombre()}</td>
            <td>${car.getPrecio()}</td>
            <td>
                <input type="hidden" id="id" value="${car.getIdProducto()}">
                <input type="number" id="Cantidad" value="${car.getCantidad()}">
            </td>
            <td>${car.getSubtotal()}</td>
            <td>
                <a href="#">Eliminar</a>
            </td>
        </tr>
    </c:forEach>
        <input type="submit" value="Enviar">
    
    </tbody>
</table>
<a href="Pago.html">Pagar</a>
<%--<script src="<%=request.getContextPath()%>/funtions.js" type="text/javascript"></script>--%>
</body>
</html>
