<%-- 
    Document   : add-inventario
    Created on : 13 ene. 2024, 00:35:11
    Author     : daiko
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="model.Usuario, model.Categoria, dao.CategoriaDao, java.util.*" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Agregar Producto | Sistema Mammamía</title>
    </head>
    <body class="d-flex flex-column min-vh-100 mt-5">

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
        
        <main class="container mt-3">
            <a href="${pageContext.request.contextPath}/admin/inventario.jsp" class="btn btn-secondary mb-3">Regresar</a>
            <h1 class="text-center">Modificar Producto</h1>
        
            <article class="card">
                <section class="card-body">
                    <form action="${pageContext.request.contextPath}/ControlProducto?action=actualizar" method="post">
        
                        <input type="hidden" name="idProducto" value="${producto.idProducto}">
        
                        <div class="mb-3">
                            <label class="form-label">Categoría:</label>
                            <select name="idCategoria" class="form-select" required>
                                <option value="1" ${producto.idCategoria == 1 ? "selected" : ""}>Bebidas</option>
                                <option value="2" ${producto.idCategoria == 2 ? "selected" : ""}>Pizzas</option>
                                <option value="3" ${producto.idCategoria == 3 ? "selected" : ""}>Pastas</option>
                                <option value="4" ${producto.idCategoria == 4 ? "selected" : ""}>Postres</option>
                            </select>
                        </div>
        
                        <div class="mb-3">
                            <label class="form-label">Nombre:</label>
                            <input type="text" name="nombre" value="${producto.nombre}" class="form-control" required>
                        </div>
        
                        <div class="mb-3">
                            <label class="form-label">Descripción:</label>
                            <textarea name="descripcion" class="form-control" required>${producto.descripcion}</textarea>
                        </div>
        
                        <div class="mb-3">
                            <label class="form-label">Precio:</label>
                            <input type="text" name="precio" value="${producto.precio}" class="form-control" required>
                        </div>
        
                        <div class="mb-3">
                            <label class="form-label">Stock:</label>
                            <input type="text" name="stock" value="${producto.stock}" class="form-control" required>
                        </div>
        
                        <div class="mb-3">
                            <label class="form-label">Estado:</label>
                            <select name="estado" class="form-select" required>
                                <option value="0" ${producto.estado == 0 ? "selected" : ""}>Inactivo</option>
                                <option value="1" ${producto.estado == 1 ? "selected" : ""}>Activo</option>
                            </select>
                        </div>
        
                        <div class="mb-3 text-center">
                            <button type="submit" class="btn btn-primary">Actualizar Producto</button>
                        </div>
        
                    </form>
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
