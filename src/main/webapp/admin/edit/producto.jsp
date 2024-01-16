<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="model.Usuario, model.Producto, conexion.Conexion, dao.ProductoDao, java.util.*"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Editar Producto | Sistema Mammamía</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
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
    
    <header class="bg-light">
        <div class="container">
            <ul class="nav">
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
        </div>
    </header>
    
    <main class="container mt-3">
        <a href="${pageContext.request.contextPath}/admin/inventario.jsp" class="btn btn-secondary mb-3">Regresar</a>
        <h1>Modificar Producto</h1>
    
        <form action="${pageContext.request.contextPath}/ControlProducto?action=actualizar" method="post">
            <input type="hidden" name="idProducto" value="${producto.idProducto}">
    
            <table class="table">
                <tr>
                    <th>Categoría:</th>
                    <td>
                        <select name="idCategoria" class="form-select" required>
                            <option value="1" ${producto.idCategoria == 1 ? "selected" : ""}>Bebidas</option>
                            <option value="2" ${producto.idCategoria == 2 ? "selected" : ""}>Pizzas</option>
                            <option value="3" ${producto.idCategoria == 3 ? "selected" : ""}>Pastas</option>
                            <option value="4" ${producto.idCategoria == 4 ? "selected" : ""}>Postres</option>
                        </select>
                    </td>
                </tr>
                <tr>
                    <th>Nombre:</th>
                    <td><input type="text" name="nombre" value="${producto.nombre}" class="form-control" required></td>
                </tr>
                <tr>
                    <th>Descripción:</th>
                    <td><textarea name="descripcion" class="form-control" required>${producto.descripcion}</textarea></td>
                </tr>
                <tr>
                    <th>Precio:</th>
                    <td><input type="text" name="precio" value="${producto.precio}" class="form-control" required></td>
                </tr>
                <tr>
                    <th>Stock:</th>
                    <td><input type="text" name="stock" value="${producto.stock}" class="form-control" required></td>
                </tr>
                <tr>
                    <th>Estado:</th>
                    <td>
                        <select name="estado" class="form-select" required>
                            <option value="0" ${producto.estado == 0 ? "selected" : ""}>Inactivo</option>
                            <option value="1" ${producto.estado == 1 ? "selected" : ""}>Activo</option>
                        </select>
                    </td>
                </tr>
            </table>
    
            <button type="submit" class="btn btn-primary">Actualizar Producto</button>
        </form>
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
