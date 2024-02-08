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
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css"
          integrity="sha512-z3gLpd7yknf1YoNbCzqRKc4qyor8gaKU1qmn+CShxbuBusANI9QpRohGBreCFkKxLhei6S9CQXFEbbKuqLg0DA=="
          crossorigin="anonymous" referrerpolicy="no-referrer">
    <link rel="stylesheet" href="https://kit-pro.fontawesome.com/releases/v6.5.1/css/pro.min.css">
    <link rel="stylesheet" href="<%=request.getContextPath()%>/estilos/menu.css">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Carrito de compras</title>
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Ropa+Sans:ital@1&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="<%=request.getContextPath()%>/estilos/carrito.css">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css"
          integrity="sha384-xOolHFLEh07PJGoPkLv1IbcEPTNtaed2xpHsD9ESMhqIYd0nLMwNLD69Npy4HI+N" crossorigin="anonymous">
</head>
<body>
<%
    // Obtener la sesión
    HttpSession sesion = request.getSession(false);
    
    // Obtener la sesion para cliente
    Boolean isLoggedIn = (sesion != null && sesion.getAttribute("isLoggedIn") != null && (Boolean) sesion.getAttribute("isLoggedIn"));
    
    // Obtener la sesion para invitado
    Boolean isGuest = (sesion != null && sesion.getAttribute("isGuest") != null && (Boolean) sesion.getAttribute("isGuest"));
    
    // Obtener la última página visitada de la sesión
    String lastPage = (String) sesion.getAttribute("lastPage");
    if (lastPage == null) {
        lastPage = "menu.jsp";
    }
%>


<header>
    <nav class="navbar navbar-expand-lg">
        <div class="container">
            <div class="collapse navbar-collapse" id="navbarSupportedContent">
                <ul class="navbar-nav ms-auto">
                    <li class="nav-item">
                        <a class="nav-link active" href="${pageContext.request.contextPath}/index.jsp">
                            <img src="..." alt="logo"/> | Inicio
                        </a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link active" href="${pageContext.request.contextPath}/menu.jsp">Menú</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link active" href="${pageContext.request.contextPath}/nosotros.jsp">Nosotros</a>
                    </li>
                    <!-- Menú para cliente -->
                    <%
                        if (isLoggedIn) {
                    %>
                    <li class="nav-item">
                        <a class="nav-link active" href="${pageContext.request.contextPath}/customer/logout.jsp">Cerrar
                            Sesión</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link active" href="${pageContext.request.contextPath}/customer/account/panel.jsp">Mi
                            Cuenta</a>
                    </li>
                    <!-- Menú para invitado-->
                    <%
                    } else if (isGuest) {
                    %>
                    <li class="nav-item">
                        <a class="nav-link active" href="${pageContext.request.contextPath}/customer/logout.jsp">Iniciar
                            Sesión (Invitado)</a>
                    </li>
                    <%
                    } else {
                    %>
                    <li class="nav-item">
                        <a class="nav-link active" href="${pageContext.request.contextPath}/customer/login.jsp">Iniciar
                            Sesión</a>
                    </li>
                    <%
                        }
                    %>
                </ul>
            </div>
        </div>
    </nav>
    <ul>
        <li>
            <a href="<%=request.getContextPath()%>/<%=lastPage%>">Seguir comprando</a>
        </li>
    </ul>
</header>

<div class="container">
    <div class="row pt-5 pb-5">
        <c:if test="${totalPagar > 0}">
        <div class="col-lg-8 table-responsive">
            
                <table class="table table-bordered text-center">
                    <thead>
                    <tr>
                        <th>Producto</th>
                        <th>Precio</th>
                        <th>Cantidad</th>
                        <th>SubTotal</th>
                        <th></th>
                    </tr>
                    </thead>
                    <tbody>
                    <c:forEach var="car" items="${carrito}">
                        <tr>
                            <td class="align-middle">${car.getNombre()}</td>
                            <td class="align-middle">S/ ${car.getPrecio()}</td>
                            <td class="align-middle">
                                <input type="hidden" id="id" value="${car.getIdProducto()}">
                                <input type="number" min="1" step="1" id="Cantidad" value="${car.getCantidad()}"
                                       class="form-control">
                            </td>
                            <td class="align-middle">S/ ${car.getSubtotal()}</td>
                            <td class="align-middle">
                                <input type="hidden" id="id" value="${car.getIdProducto()}">
                                <a href="<%=request.getContextPath()%>/controlCarrito?accion=Delete&idp=${car.getIdProducto()}"
                                   id="btnDetele" class="">
                                    <i class="fa-solid fa-xmark fa-lg" style="color: #000000;"></i>
                                </a>
                            </td>
                        </tr>
                    </c:forEach>
                    </tbody>
                </table>
            
        </div>
        </c:if>
        <c:if test="${totalPagar > 0}">
            <div class="col-sm-4">
                <p>Subtotal: S/ ${totalPagar}</p>
                <p>Envío: S/ 5.90</p>
                <hr class="my-2">
                <p style="font-weight:700">Total a pagar: S/ ${totalPagar + 5.90}</p>
                <a href="#" id="btnRealizarPago" class="btn btn-warning text-center">Realizar pago</a>
            </div>
        </c:if>
    </div>
    
    <div class="icon-carrito">
        <c:if test="${totalPagar <= 0}">
            <i class="fa-duotone fa-cart-xmark fa-10x"></i>
            <p>EL carrito está vacío.</p>
        </c:if>
    </div>
</div>




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
                <h4>Enlaces</h4>
                <div class="footer-links">
                    <a href="#">Local</a><br>
                    <a href="#">Zona reparto</a><br>
                    <a href="${pageContext.request.contextPath}/nosotros.jsp">Nosotros</a><br>
                    <a href="">Atención al
                        cliente</a><br>
                    <a href="${pageContext.request.contextPath}/preguntas-frecuentes.jsp">Preguntas Frecuentes</a><br>
                    <a href="#">Mapa de sitio</a>
                </div>
            </div>
            <div class="col-lg-3 col-md-6">
                <h4>Políticas</h4>
                <div class="footer-links">
                    <a href="#">Políticas de Datos Personales</a><br>
                    <a href="${pageContext.request.contextPath}/terminos-condiciones.jsp">Términos y condiciones de Promociones</a><br>
                    <a href="#">Derechos ARCO</a>
                </div>
            </div>
            <div class="col-lg-3 col-md-6">
                <h4>Formas de pago</h4>
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
                                                       href="${pageContext.request.contextPath}/terminos-condiciones.jsp">términos
                            y condiciones</a>
                        </label>
                    </div>
                    <button type="submit" class="btn btn-primary mb-2">ENVIAR</button>
                </form>
            </div>
        </div>
    </div>
    <img src="${pageContext.request.contextPath}/img/inicio/logo.png" alt="" class="mx-auto d-block img-logo p-3">
    <div class="text-center">
        <hr>
        <span class="text-white">Todos los derechos reservados © <script>document.write(new Date().getFullYear())</script> </span>
    </div>
</footer>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/js/bootstrap.bundle.min.js"
        integrity="sha384-Fy6S3B9q64WdZWQUiU+q4/2Lc9npb8tCaSX9FK7E8HnRr0Jz8D6OP9dO5Vg3Q9ct"
        crossorigin="anonymous"></script>

</body>
</html>
