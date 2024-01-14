<%-- 
    Document   : inventario
    Created on : 11 ene. 2024, 22:08:19
    Author     : daiko
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="model.Usuario" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Inventario | Sistema Mammamía</title>
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
        <%
            List<Producto> producto = ProductoDao.listarProductos();
            request.setAttribute("list",producto);
        %>
        <main>
            <article class="...">
                <section>
                    <a href="${pageContext.request.contextPath}/admin/register/producto.jsp">Agregar Producto</a>|
                    <a href="${pageContext.request.contextPath}/admin/categorias.jsp">Gestionar Categorias</a>

                    <%-- Impresion de Errores --%>
                    <c:if test="${empty list}">
                        <p>No hay productos disponibles.</p>
                    </c:if>

                    <c:if test="${not empty list}">
                        <table border="1">
                            <thead>
                                <tr>
                                    <th>ID</th>
                                    <th>CATEGORÍA</th>
                                    <th>NOMBRE</th>
                                    <th>DESCRIPCIÓN</th>
                                    <th>PRECIO</th>
                                    <th>STOCK</th>
                                    <th>ESTADO</th>
                                    <th></th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach items="${list}" var="prod">
                                    <tr>
                                        <td>${prod.getIdProducto()}</td>
                                        <td>${prod.getNombreCat()}</td>
                                        <td>${prod.getNombre()}</td>
                                        <td>${prod.getDescripcion()}</td>
                                        <td>${prod.getPrecio()}</td>
                                        <td>${prod.getStock()}</td>
                                        <td>
                                            <c:choose>
                                                <c:when test="${prod.getEstado() == 0}">Inactivo</c:when>
                                                <c:when test="${prod.getEstado() == 1}">Activo</c:when>
                                                <c:otherwise>Estado Desconocido</c:otherwise>
                                            </c:choose>
                                        </td>
                                        <td>
                                            <a href="${pageContext.request.contextPath}/ControlProducto?action=editar&id=${prod.getIdProducto()}">Modificar Producto</a>|
                                            
                                            <form action="${pageContext.request.contextPath}/ControlProducto" method="post">
                                                <input type="hidden" id="idProducto" name="idProducto" value="${prod.getIdProducto()}">
                                                <input type="hidden" name="action" value="eliminar">
                                                <button type="submit">Eliminar Producto</button>
                                            </form>
                                        </td>
                                    </tr>
                                </c:forEach>
                            </tbody>
                        </table>
                    </c:if>
                </section>
            </article>
        </main>        

        <footer>
            <p>Copyright@Todos los derechos reservados</p>
            <p>Sistema Mammamía</p> 
        </footer>
    </body>
</html>
