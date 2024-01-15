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
    <ul>
        <li>
            <a href="<%=request.getContextPath()%>/controlCarrito?accion=Carrito">Carrito <label>${contador}</label> </a>
        </li>
    </ul>
</header>

<main>
    <h1>¡Disfruta de nuestra variedad de Pizzas!</h1>
    <article class="...">
        <section>
            <a href="<%=request.getContextPath()%>/menu/pizzas.jsp">Pizzas</a>|
            <a href="<%=request.getContextPath()%>/menu/pastas.jsp">Pastas</a>|
            <a href="<%=request.getContextPath()%>/menu/postres.jsp">Postres</a>|
            <a href="<%=request.getContextPath()%>/menu/bebidas.jsp">Bebidas</a>
        </section>

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
