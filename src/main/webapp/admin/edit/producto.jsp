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
            <a href="${pageContext.request.contextPath}/admin/inventario.jsp">Regresar</a>
            <h1>Modificar Producto</h1>
            <article class="...">
                <section>
                    <form action="${pageContext.request.contextPath}/ControlProducto?action=actualizar" method="post">
                        
                        <input type="hidden" name="idProducto" value="${producto.idProducto}">
                        
                        <label>Categoria:</label>
                        <select name="idCategoria" required>
                            <option value="1" ${producto.idCategoria == 1 ? "selected" : ""}>Bebidas</option>
                            <option value="2" ${producto.idCategoria == 2 ? "selected" : ""}>Pizzas</option>
                            <option value="3" ${producto.idCategoria == 3 ? "selected" : ""}>Pastas</option>
                            <option value="4" ${producto.idCategoria == 4 ? "selected" : ""}>Postres</option>
                        </select><br>
                        
                        <label>Nombre:</label>
                        <input type="text" name="nombre" value="${producto.nombre}" required><br>
                        
                        <label>Descripción:</label>
                        <textarea name="descripcion" required>${producto.descripcion}</textarea> <br>
                       
                        <label>Precio:</label>
                        <input type="text" name="precio" value="${producto.precio}" required><br>
                        
                        <label>Stock:</label>
                        <input type="text" name="stock" value="${producto.stock}" required><br>
                        
                        <label>Estado:</label>
                        <select name="estado" required>
                            <option value="0" ${producto.estado == 0 ? "selected" : ""}>Inactivo</option>
                            <option value="1" ${producto.estado == 1 ? "selected" : ""}>Activo</option>
                        </select><br>
                        
                        <input type="submit" value="Actualizar Producto">
                    </form>
                </section>
            </article>
        </main>

        <footer>
            <p>Copyright@Todos los derechos reservados</p>
            <p>Sistema Mammamía</p> 
        </footer>
    </body>
</html>
