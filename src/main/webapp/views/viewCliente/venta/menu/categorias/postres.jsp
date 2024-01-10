<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="model.Cliente" %>
<%@page import="model.Usuario" %>
<%@page import="jakarta.servlet.http.HttpSession" %>
<%@ page import="dao.ProductoDao" %>
<%@ page import="model.Producto" %>
<%@ page import="java.util.List" %>
<!DOCTYPE html>
<html>
    <head>
        <%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Postres | Mammamía</title>
        
    </head>
    <body>
    <%
        List<Producto> miLista = ProductoDao.listarPostres();
        request.setAttribute("Productos", miLista);
    %>
    <header>
        <ul>
            <li>
                <a href="<%=request.getContextPath()%>/controlCarrito?accion=Carrito">Carrito <label>${contador}</label>
                </a>
            </li>
        </ul>
    </header>
    
    <main>
        <h1>¡Disfruta de nuestra variedad de Pastas!</h1>
        <article class="...">
            <section>
                <a href="<%=request.getContextPath()%>/views/viewCliente/venta/menu/categorias/pizzas.jsp">Pizzas</a>|
                <a href="<%=request.getContextPath()%>/views/viewCliente/venta/menu/categorias/pastas.jsp">Pastas</a>|
                <a href="<%=request.getContextPath()%>/views/viewCliente/venta/menu/categorias/postres.jsp">Postres</a>|
                <a href="<%=request.getContextPath()%>/views/viewCliente/venta/menu/categorias/bebidas.jsp">Bebidas</a>
            </section>
            
            <section>
                <c:forEach var="prod" items="${Productos}">
                    <div class="card" style="width: 18rem;">
                        <img class="card-img-top" src="..." alt="img_pizza_1">
                        <div class="card-body">
                            <h5 class="card-title${prod.getNombre()}">${prod.getNombre()}</h5>
                            <p class="card-text">${prod.getDescripcion()}</p>
                            <p class="card-text">Precio: S/ ${prod.getPrecio()}</p>
                            <a href="<%=request.getContextPath()%>/controlCarrito?accion=AgregarCarrito&id=${prod.getIdProducto()}"
                               class="btn btn-primary">Añadir a carrito</a>|
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

        <script>
            // Redireccionamiento hacia Menu.jsp
            function closePopup() {
                document.getElementById('popup-container').style.visibility = 'hidden';
                window.location.href = "${pageContext.request.contextPath}/views/viewCliente/venta/menu/menu.jsp";
            }
        </script>
    </body>
</html>
