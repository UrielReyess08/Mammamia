<%@page contentType="text/html" pageEncoding="UTF-8" %>
<%@page import="model.Cliente" %>
<%@page import="model.Usuario, controller.controlCarrito" %>
<%@page import="jakarta.servlet.http.HttpSession" %>
<%@ page import="dao.ProductoDao" %>
<%@ page import="model.Producto" %>
<%@ page import="java.util.List" %>
<!DOCTYPE html>
<html>
<head>
    <%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Pizzeria | Mammamía</title>
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Ropa+Sans:ital@1&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="../estilos/menu-all.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css"
    integrity="sha512-z3gLpd7yknf1YoNbCzqRKc4qyor8gaKU1qmn+CShxbuBusANI9QpRohGBreCFkKxLhei6S9CQXFEbbKuqLg0DA=="
    crossorigin="anonymous" referrerpolicy="no-referrer"/>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css"
    integrity="sha384-xOolHFLEh07PJGoPkLv1IbcEPTNtaed2xpHsD9ESMhqIYd0nLMwNLD69Npy4HI+N" crossorigin="anonymous">
        </head>
<body>
<%
    List<Producto> miLista = ProductoDao.listarPizzas();
    request.setAttribute("Productos", miLista);
%>


<header>
    <div class="text-center">
        <h1>Mammamia</h1>
    </div>
    <nav class="navbar navbar-expand-lg">
        <div class="container">
            <div class="collapse navbar-collapse" id="navbarSupportedContent">
                <ul class="navbar-nav ms-auto">
                    <li class="nav-item">
                        <a class="nav-link active" aria-current="page"
                           href="${pageContext.request.contextPath}/menu.jsp">Menú</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link active" href="${pageContext.request.contextPath}/nosotros.jsp">Nosotros</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link active" href="viewCliente/loginCliente.html" tabindex="-1"
                           aria-current="page">Iniciar Sesion</a>
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
            <a href="<%=request.getContextPath()%>/controlCarrito?accion=Carrito">Carrito <label>${contador}</label>
            </a>
        </li>
    </ul>
</header>

<main>
    <article class="...">
        <section>
            <a href="<%=request.getContextPath()%>/menu/pizzas.jsp">Pizzas</a>|
            <a href="<%=request.getContextPath()%>/menu/pastas.jsp">Pastas</a>|
            <a href="<%=request.getContextPath()%>/menu/postres.jsp">Postres</a>|
            <a href="<%=request.getContextPath()%>/menu/bebidas.jsp">Bebidas</a>
        </section>
        <div class="container mt-4">
            <h1>¡Disfruta de nuestra variedad de Pizzas!</h1>
            <div>
                <%
                    int contador = 1;
                %>
                <div class="row"></div>
                <c:forEach var="prod" items="${Productos}">
                    <div class="col-lg-4 col-md-6 col-sm-12 mx-auto my-4">
                        <div class="card w-100" style="width: 18rem;">
                            <img class="card-img-top" src="..." alt="img_pizza_1">
                            <div class="card-body">
                                <h5 class="card-title${prod.getNombre()}">${prod.getNombre()}</h5>
                                <p class="card-text">${prod.getDescripcion()}</p>
                                <p class="card-text">Precio: S/ ${prod.getPrecio()}</p>
                                <a href="<%=request.getContextPath()%>/controlCarrito?accion=AgregarCarrito&id=${prod.getIdProducto()}" class="btn btn-primary">Añadir a carrito</a>|
                            </div>
                        </div>
                    </div>
                    <%
                        contador++;
                    %>
                </c:forEach>

        <section>
            <c:forEach var="prod" items="${Productos}">
                <div class="card" style="width: 18rem;">
                    <img class="card-img-top" src="..." alt="img_pizza_1">
                    <div class="card-body">
                        <h5 class="card-title${prod.getNombre()}">${prod.getNombre()}</h5>
                        <p class="card-text">${prod.getDescripcion()}</p>
                        <p class="card-text">Precio: S/ ${prod.getPrecio()}</p>
                        <a href="<%=request.getContextPath()%>/controlCarrito?accion=AgregarCarrito&id=${prod.getIdProducto()}" class="btn btn-primary">Añadir a carrito</a>|
                    </div>
                </div>
            </c:forEach>

        </section>
    </article>
</main>

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
