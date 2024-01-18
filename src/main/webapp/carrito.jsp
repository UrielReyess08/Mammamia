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
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css" integrity="sha512-z3gLpd7yknf1YoNbCzqRKc4qyor8gaKU1qmn+CShxbuBusANI9QpRohGBreCFkKxLhei6S9CQXFEbbKuqLg0DA==" crossorigin="anonymous" referrerpolicy="no-referrer">
    <link rel="stylesheet" href="https://kit-pro.fontawesome.com/releases/v6.5.1/css/pro.min.css">
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
    <c:if test="${totalPagar > 0}">
        <p>Subtotal: S/ ${totalPagar}</p>
        <p>Envío: S/ 5.90</p>
        <p>Total a pagar: S/ ${totalPagar + 5.90}</p>
        <tr>
            <th>Item</th>
            <th>Id Producto</th>
            <th>Producto</th>
            <th>Precio</th>
            <th>Cantidad</th>
            <th>SubTotal</th>
            <th>Acciones</th>
        </tr>
    </c:if>
    <c:if test="${totalPagar <= 0}">
        EL carrito está vacío.
        <i class="fa-duotone fa-cart-xmark fa-10x" style="--fa-primary-opacity: 0.5; --fa-secondary-opacity: 0.2;"></i>
    </c:if>
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
                <a href="<%=request.getContextPath()%>/controlCarrito?accion=Delete&idp=${car.getIdProducto()}"
                   id="btnDetele">Eliminar</a>
            </td>
        </tr>
    </c:forEach>
    </tbody>
</table>


<a href="#" id="btnRealizarPago">Realizar pago</a>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script src="<%=request.getContextPath()%>/js/functions.js" type="text/javascript"></script>
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
<script>
    function realizarPago() {
        var totalPagar = ${totalPagar};
        if (totalPagar == 0) {
            Swal.fire({
                icon: 'error',
                title: 'Error',
                text: 'No se puede realizar el pago',
            });
            return;
        }
        window.location.href = "<%=request.getContextPath()%>/checkout.jsp";
    }

    document.getElementById("btnRealizarPago").addEventListener("click", realizarPago);
</script>

</body>
</html>
