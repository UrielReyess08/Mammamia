<%@page contentType="text/html" pageEncoding="UTF-8" %>
<%@page import="model.Cliente" %>
<%@page import="model.Usuario, controller.controlCarrito" %>
<%@page import="jakarta.servlet.http.HttpSession" %>
<%@ page import="dao.ProductoDao" %>
<%@ page import="model.producto" %>
<%@ page import="java.util.List" %>
<!DOCTYPE html>
<html>
<head>
    <%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Pizzería | Mammamía</title>
</head>
<body>
<%
    List<producto> miLista = ProductoDao.listar();
    request.setAttribute("productos", miLista);
%>


<header>
    <ul>
        <li>
            <a href="index.jsp">Carrito <label>${contador}</label> </a>
        </li>
    </ul>
</header>

<main>
    <h1>¡Disfruta de nuestra variedad de Pizzas!</h1>
    <article class="...">
        <section>
            <a href="menuPizzas.html">Pizzas</a>|
            <a href="menuPastas.html">Pastas</a>|
            <a href="menuPostres.html">Postres</a>|
            <a href="menuBebidas.html">Bebidas</a>
        </section>

        <section>
            <c:forEach var="prod" items="${productos}">
                <div class="card" style="width: 18rem;">
                    <img class="card-img-top" src="..." alt="img_pizza_1">
                    <div class="card-body">
                        <h5 class="card-title${prod.getNombre()}">${prod.getNombre()}</h5>
                        <p class="card-text">${prod.getDescripcion()}</p>
                        <p class="card-text">Precio: S/ ${prod.getPrecio()}</p>
                        <a href="output.jsp?id=${prod.getIdProducto()}" class="btn btn-primary">Añadir a carrito</a>|
<%--                        <a href="../../pago/carritoCompras.html">Ver Carrito</a>--%>
                    </div>
                </div>
                <form action="carrito.jsp" method="post">
                    <input type="hidden" name="productoId" value="${prod.getIdProducto()}">
                    <input type="hidden" name="productoNombre" value="${prod.getNombre()}">
                    <input type="hidden" name="productoPrecio" value="${prod.getPrecio()}">
                    <input type="submit" value="Añadir a carrito">
                </form>
            </c:forEach>

        </section>
        <form action="output.jsp" method="post">
            
            <label>
                Nota 1:
                <input type="text" name="nota1">
            </label>
            
            <label>
                Nota 2:
                <input type="text" name="nota2">
            </label>
            
            <label>
                Nota 3:
                <input type="text" name="nota3">
            </label>
            
            <input type="submit" value="Procesar">
        </form>
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
