<%-- 
    Document   : edit-inventario
    Created on : 13 ene. 2024, 00:34:59
    Author     : daiko
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="model.Usuario" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Editar Producto | Sistema Mammamía</title>
    </head>
    <body>
        <%@page import="model.Producto, connection.Conexion, dao.ProductoDao, java.util.*"%>
        <%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

        <%
            // Obtener la sesión
            HttpSession sesion = request.getSession(false);
            
            // Verificación de inicio de sesión
            if (sesion == null || sesion.getAttribute("usuario") == null){
                System.out.println("Sesión inválida o usuario no presente");
                response.sendRedirect(request.getContextPath() + "/customer/login.jsp");
                return;
            }
            
            //Variable para el nombre del rol
            String nombreRol = (String) ((Usuario) sesion.getAttribute("usuario")).getRol();
        %>

        <header>
            <ul>
                <li>
                    Sistema
                </li>
                <li>
                    Bienvenido, <%= nombreRol %>
                </li>
                <li>
                    <a href="${pageContext.request.contextPath}/customer/logout.jsp">Cerrar Sesión</a>
                </li>
            </ul>
        </header>

        <main>
            <article class="...">
                <section>
                    <c:forEach items="${list}" var="prod">
                        <c:if test="${prod.getIdProducto() == param.idProducto}">
                            <form action="${pageContext.request.contextPath}/ControlProducto" method="post">
                                <input type="text" name="idProducto" value="${prod.getIdProducto()}"><br>

                                <label for="idCategoria_${prod.getIdProducto()}">Categoría:</label>
                                <input type="text" id="idCategoria_${prod.getIdProducto()}" name="idCategoria" value="${prod.getIdCategoria()}" required/><br>

                                <label for="nombre_${prod.getIdProducto()}">Nombre:</label>
                                <input type="text" id="nombre_${prod.getIdProducto()}" name="nombre" value="${prod.getNombre()}" required/><br>

                                <label for="descripcion_${prod.getIdProducto()}">Descripción:</label>
                                <input type="text" id="descripcion_${prod.getIdProducto()}" name="descripcion" value="${prod.getDescripcion()}" required/><br>

                                <label for="precio_${prod.getIdProducto()}">Precio:</label>
                                <input type="text" id="precio_${prod.getIdProducto()}" name="precio" value="${prod.getPrecio()}" required/><br>


                                <label for="stock_${prod.getIdProducto()}">Stock:</label>
                                <input type="text" id="stock_${prod.getIdProducto()}" name="stock" value="${prod.getStock()}" required/><br>

                                <label for="estado_${prod.getIdProducto()}">Estado:</label>
                                <input type="text" id="estado_${prod.getIdProducto()}" name="estado" value="${prod.getEstado()}" required/><br>

                                <input type="submit" value="Modificar Producto">
                            </form>
                        </c:if>
                    </c:forEach>
                </section>
            </article>
        </main>

        <footer>
            <p>Copyright@Todos los derechos reservados</p>
            <p>Sistema Mammamía</p> 
        </footer>
    </body>
</html>
