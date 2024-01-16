<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
    <title>Resumen del pedido</title>
</head>
<body>
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
    <a href="<%=request.getContextPath()%>/controlCarrito?accion=FinalizarCompra">Volver al menú</a>
</table>
</body>
</html>
