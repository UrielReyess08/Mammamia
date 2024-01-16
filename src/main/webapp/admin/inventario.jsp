<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="model.Usuario, model.Producto, conexion.Conexion, dao.ProductoDao, java.util.*"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Inventario | Sistema Mammamía</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    </head>
    <body>
        <style>
             .button-group {
            display: flex;
            gap: 5px; /* Ajusta el espacio entre los botones según tus preferencias */
        }
    
        .button-group button {
            flex: 1;
        }
        </style>
    
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
        <div class="container">
            <ul class="nav">
                <li class="nav-item">
                    <span class="nav-link">Sistema Wazaaa</span>
                </li>
                <li class="nav-item">
                    <span class="nav-link">Bienvenido, <%= nombreRol %></span>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="${pageContext.request.contextPath}/customer/logout.jsp">Cerrar Sesión</a>
                </li>
            </ul>
        </div>
    </header>
    
    <%
        List<Producto> producto = ProductoDao.listarProductos();
        request.setAttribute("list", producto);
    %>
    
    <main class="container mt-3">
        <article>
            <section>
                <a href="${pageContext.request.contextPath}/admin/register/producto.jsp" class="btn btn-primary m-1" style="font-size: 1rem;">Agregar Producto</a>
                <a href="${pageContext.request.contextPath}/admin/categorias.jsp" class="btn btn-secondary" style="font-size: 1rem;">Gestionar Categorias</a>
    
                <!-- Impresion de Errores -->
                <c:if test="${empty list}">
                    <p class="mt-3">No hay productos disponibles.</p>
                </c:if>
    
                <!-- TABLA GENERAL -->
                <c:if test="${not empty list}">
                    <h3 class="mt-3">TABLA DE PRODUCTOS</h3>
                    <div class="table-responsive">
                        <table class="table table-striped" style="margin: 0px;">
                            <thead>
                                <tr>
                                    <th>ID</th>
                                    <th>CATEGORÍA</th>
                                    <th>NOMBRE</th>
                                    <th>DESCRIPCIÓN</th>
                                    <th>PRECIO</th>
                                    <th>STOCK</th>
                                    <th>ESTADO</th>
                                    <th>ACCIONES</th>
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
                                            <div class="button-group">
                                                <a href="${pageContext.request.contextPath}/ControlProducto?action=editar&id=${prod.getIdProducto()}" class="btn btn-primary" style="font-size: 1rem;">Modificar</a>
                                        
                                                <form action="${pageContext.request.contextPath}/ControlProducto" method="post" class="d-inline">
                                                    <input type="hidden" id="idProducto" name="idProducto" value="${prod.getIdProducto()}">
                                                    <input type="hidden" name="action" value="eliminar">
                                                    <button type="submit" class="btn btn-primary btn-danger" style="font-size: 1rem;">Eliminar</button>
                                                </form>
                                            </div>
                                        </td>
                                    </tr>
                                </c:forEach>
                            </tbody>
                        </table>
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
    
    <!-- Bootstrap JS y dependencias -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
    
    </body>
</html>
