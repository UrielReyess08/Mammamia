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
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Carrito de Compras | Mammamia</title>
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Ropa+Sans:ital@1&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="<%=request.getContextPath()%>/estilos/m.css">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css" integrity="sha384-xOolHFLEh07PJGoPkLv1IbcEPTNtaed2xpHsD9ESMhqIYd0nLMwNLD69Npy4HI+N" crossorigin="anonymous">
    </head>
<body>
<header>
    
    <nav class="navbar navbar-expand-lg">
        <div class="container">
            <div class="collapse navbar-collapse" id="navbarSupportedContent">
                <ul class="navbar-nav ms-auto">
                    <li class="nav-item">
                        <a class="nav-link active" aria-current="page" href="/menu.html">Menú</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link active" href="/nosotros.html">Nosotros</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link active" href="viewCliente/loginCliente.html" tabindex="-1" aria-current="page">Iniciar Sesion</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link active" href="viewCliente/cliente/panelUsuario.html">Mi cuenta</a>
                    </li>
                </ul>
            </div>
        </div>
    </nav>
    <ul>
        <li>
            <%--            <a href="<%=request.getContextPath()%>/controlCarrito?accion=Home&menu=">Seguir comprando</a>--%>
            <a href="${pageContext.request.contextPath}/menu.jsp">Volver a la página
                anterior</a>
        </li>
    </ul>
</header>
<div class="container">
    <div class="row">
        <div class="col-lg-6">
        
            <h1 class="mb-4">Carrito de Compras</h1>
        
            <table border="1" class="table table-bordered cart-table text-center">
    <thead>
    <c:if test="${totalPagar > 0}">
        <p>Total a pagar: ${totalPagar}</p>
        <tr>
            <th>Item</th>
            <th>Id Producto</th>
            <th>Producto</th>
            <th>Precio</th>
            <th class="cantidad">Cantidad</th>
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
</div>

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
<div class="col-lg-6">
    <h2 class="mt-4 mb-3">Productos Sugeridos</h2>
    <div class="row">
     
        <div class="col-lg-4 col-md-6 col-sm-12 mx-auto my-4">
            <div class="card w-100" style="width: 18rem;">
                <img class="card-img-top"
                src="<%=request.getContextPath()%>/img/Lasagna/<%=contador%>.png"
                alt="img_pizza_1">
                <div class="card-body">
                    <h5 class="card-title${prod.getNombre()}">${prod.getNombre()}</h5>
                    <p class="card-text">${prod.getDescripcion()}</p>
                    <p class="card-text">Precio: S/ ${prod.getPrecio()}</p>
                    <a href="<%=request.getContextPath()%>/controlCarrito?accion=AgregarCarrito&id=${prod.getIdProducto()}"
                       class="btn btn-warning">Añadir a carrito</a>|
                </div>
            </div>
        </div>

     
        

</div>
</div>
</div>


<footer>
    <div class="container-fluid mt-3">
        <div class="social-icons">
            <i class="fa-brands fa-facebook-f fa-2x" style="color: #ffffff; margin-right: 10px;"></i>
            <i class="fa-brands fa-instagram fa-2x" style="margin-right: 10px;"></i>
            <i class="fa-brands fa-tiktok fa-2x"></i>
        </div>
    </div>
    
    
    <div class="container mt-5">
        <div class="row g-4">
            <div class="col-lg-3 col-md-6">
                <h5>Enlaces</h5>
                <div class="footer-links">
                    <a href="#">Local</a><br>
                    <a href="#">Zona reparto</a><br>
                    <a href="#">Nosotros</a><br>
                    <a href="${pageContext.request.contextPath}/views/viewExtras/contacto.jsp">Atención al
                        cliente</a><br>
                    <a href="${pageContext.request.contextPath}/views/viewExtras/preguntas.jsp">Preguntas Frecuentes</a><br>
                    <a href="#">Mapa de sitio</a>
                </div>
            </div>
            <div class="col-lg-3 col-md-6">
                <h5>Políticas</h5>
                <div class="footer-links">
                    <a href="#">Políticas de Datos Personales</a><br>
                    <a href="#">Términos y condiciones de Promociones</a><br>
                    <a href="#">Derechos ARCO</a>
                </div>
            </div>
            <div class="col-lg-3 col-md-6">
                <h5>FORMAS DE PAGO</h5>
                <i class="fa-brands fa-cc-visa fa-3x" style="color: #ffffff;"></i>
                <i class="fa-brands fa-cc-mastercard fa-3x" style="color: #ffffff;"></i>
                <i class="fa-brands fa-cc-amex fa-3x" style="color: #ffffff;"></i>
            </div>
            <div class="col-lg-3 col-md-6">
                <form class="small-form">
                    <div class="mb-2">
                        <input type="text" class="form-control" placeholder="Ingrese su correo" name="email">
                    </div>
                    <div class="mb-2 form-check">
                        <input class="form-check-input" type="checkbox" name="remember">
                        <label class="form-check-label">
                            He leído y revisado los <a class="text-white"
                                                       href="${pageContext.request.contextPath}/views/viewExtras/terminos.jsp">términos
                            y condiciones</a>
                        </label>
                    </div>
                    <button type="submit" class="btn btn-primary mb-2">ENVIAR</button>
                </form>
            </div>
        </div>
    </div>
    <img src="../img/img-footer/logo.png" alt="" class="rounded-circle mx-auto d-block img-logo p-3">
    <div class="text-center">
        <hr>
        <span class="text-white">Todos los derechos reservados © <script>document.write(new Date().getFullYear())</script> </span>
    </div>
</footer>
<script src="https://cdn.jsdelivr.net/npm/jquery@3.5.1/dist/jquery.slim.min.js" integrity="sha384-DfXdz2htPH0lsSSs5nCTpuj/zy4C+OGpamoFVy38MVBnE+IbbVYUew+OrCXaRkfj" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-Fy6S3B9q64WdZWQUiU+q4/2Lc9npb8tCaSX9FK7E8HnRr0Jz8D6OP9dO5Vg3Q9ct" crossorigin="anonymous"></script>
</body>
</html>