<%@page contentType="text/html" pageEncoding="UTF-8" %>
<%@page import="model.Cliente" %>
<%@page import="model.Usuario" %>
<%@page import="jakarta.servlet.http.HttpSession" %>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Bebidas | Mammamía</title>

</head>
<body>

<header>
    <ul>
        <li>
            <a href="${pageContext.request.contextPath}/index.jsp">
                <img src="..." alt="logo"/> | Inicio
            </a>
        </li>
        <li>
            <a href="${pageContext.request.contextPath}/views/viewCliente/venta/menu/menu.jsp">Menú</a>
        </li>
    </ul>
</header>

<main>
    <h1>¡Disfruta de nuestra variedad de Bebidas!</h1>
    <article class="...">
        <section>
            <a href="<%=request.getContextPath()%>/views/viewCliente/venta/menu/categorias/pizzas.jsp">Pizzas</a>|
            <a href="<%=request.getContextPath()%>/views/viewCliente/venta/menu/categorias/pastas.jsp">Pastas</a>|
            <a href="<%=request.getContextPath()%>/views/viewCliente/venta/menu/categorias/postres.jsp">Postres</a>|
            <a href="<%=request.getContextPath()%>/views/viewCliente/venta/menu/categorias/bebidas.jsp">Bebidas</a>
        </section>
        
        <section>
            <div class="card" style="width: 18rem;">
                <img class="card-img-top" src="..." alt="img_bebida_1">
                <div class="card-body">
                    <h5 class="card-title">Bebida 1</h5>
                    <p class="card-text">Precio</p>
                    <a href="#" class="btn btn-primary">Añadir Producto</a>|
                    <a href="../../pago/carritoCompras.html">Ver Carrito</a>
                </div>
            </div>

        </section>
    </article>
</main>

<footer>
    <ul>
        <li>
            <img src="..." alt="logo"/>
            <a href="...">Facebook</a>
        </li>
        <li>
            <img src="..." alt="logo"/>
            <a href="...">Instagram</a>
        </li>
        <li>
            <img src="..." alt="logo"/>
            <a href="...">Twitter</a>
        </li>
    </ul>
    
    <ul>
        <li>
            <a href="${pageContext.request.contextPath}/views/viewExtras/terminos.jsp">Terminos y Condiciones</a>
        </li>
        <li>
            <a href="${pageContext.request.contextPath}/views/viewExtras/contacto.jsp">Atención al Cliente</a>
        </li>
        <li>
            <a href="${pageContext.request.contextPath}/views/viewExtras/preguntas.jsp">Preguntas Frecuentes</a>
        </li>
    </ul>
</footer>
</body>
</html>
