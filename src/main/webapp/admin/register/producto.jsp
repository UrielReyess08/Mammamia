<%-- 
    Document   : add-inventario
    Created on : 13 ene. 2024, 00:35:11
    Author     : daiko
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.List" %>
<%@page import="model.Usuario, model.Categoria, dao.CategoriaDao" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Agregar Producto | Sistema Mammamía</title>
    </head>
    <body>
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
            List<Categoria> categorias = CategoriaDao.listarCategorias();
        %>

        <main>
            <a href="${pageContext.request.contextPath}/admin/inventario.jsp">Regresar</a>
            <h1>Agregar Producto</h1>
            <article class="...">
                <section>
                    <form action="${pageContext.request.contextPath}/ControlProducto?action=registrar" method="post">

                        <label>Categoria:</label>
                        <select name="idCategoria">
                            <% for (Categoria categoria : categorias) { %>
                            <option value="<%= categoria.getIdCategoria() %>"><%= categoria.getNombre() %></option>
                            <% } %>
                        </select><br>

                        <label>Nombre:</label>
                        <input type="text" name="nombre" required><br>

                        <label>Descripción:</label>
                        <textarea name="descripcion" required></textarea><br>

                        <label>Precio:</label>
                        <input type="text" name="precio" required><br>

                        <label>Stock:</label>
                        <input type="text" name="stock" required><br>

                        <label>Estado:</label>
                        <select name="estado">
                            <option value="1">Disponible</option>
                            <option value="0">No Disponible</option>
                        </select><br>

                        <input type="submit" value="Registrar Producto">
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
