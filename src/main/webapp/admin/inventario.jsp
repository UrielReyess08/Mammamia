<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="model.Usuario, model.Producto, conexion.Conexion, dao.ProductoDao, java.util.*"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
    <head>
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
        <title>Inventario | Sistema Mammamía</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
    </head>
    <body class="text-center mt-5">
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

        <header class="bg-light">
            <ul class="nav container">
                <li class="nav-item">
                    <span class="nav-link">Sistema</span>
                </li>
                <li class="nav-item">
                    <span class="nav-link">Bienvenido, <%= nombreRol %></span>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="${pageContext.request.contextPath}/customer/logout.jsp">Cerrar Sesión</a>
                </li>
            </ul>
        </header>
        <%
            List<Producto> producto = ProductoDao.listarProductos();
            request.setAttribute("list",producto);
        %>
        <main>
            <article class="container">
                <section>
                    <div class="container">
                        <a class="btn btn-primary mt-1" href="${pageContext.request.contextPath}/admin/register/producto.jsp">Agregar Producto</a>
                        <a class="btn btn-warning mt-1" href="${pageContext.request.contextPath}/admin/categorias.jsp">Gestionar Categorias</a>
                    </div>

                    <%-- Impresion de Errores --%>
                    <c:if test="${empty list}">
                        <p class="mt-4">No hay productos disponibles.</p>
                    </c:if>

                    <c:if test="${not empty list}">
                        <div class="table-responsive mt-5">
                            <table class="table table-bordered table-sm" border="1">
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
                                            <td>${prod.getNombreCategoria()}</td>
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
                                                <div class="container text-center">
                                                    <a class="btn btn-primary btn-sm" href="${pageContext.request.contextPath}/ControlProducto?action=editar&id=${prod.getIdProducto()}">Modificar</a>
                                                
                                                <form action="${pageContext.request.contextPath}/ControlProducto" method="post">
                                                    <input type="hidden" id="idProducto" name="idProducto" value="${prod.getIdProducto()}">
                                                    <input type="hidden" name="action" value="eliminar">
                                                    <button class="btn btn-danger btn-sm mt-1" type="submit">Eliminar</button>
                                                </form>
                                                </div>
                                            </td>
                                        </tr>
                                    </c:forEach>
                                </tbody>
                            </table><br>
                        </div>
                    </c:if>
                </section>
            </article>
        </main>        

        <footer class="footer mt-auto py-3 bg-light">
            <div class="container">
                <p class="text-muted">Copyright@Todos los derechos reservados | Sistema Mammamía</p>
            </div>
        </footer>
    </body>
</html>
>>>>>>> 4595d29 (Se quitó los estilos Bootstrap a los módulos de administrador)
