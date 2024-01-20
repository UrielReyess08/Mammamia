<%@page contentType="text/html" pageEncoding="UTF-8" %>
<%@page import="model.Usuario, model.Categoria, dao.CategoriaDao, java.util.*" %>
<!DOCTYPE html>
<html>
<head>
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
    <title>Agregar Producto | Sistema Mammamía</title>
</head>
<body class="text-center mt-5">
<%
    // Obtener la sesión
    HttpSession sesion = request.getSession(false);
    
    // Verificación de inicio de sesión
    if (sesion == null || sesion.getAttribute("usuario") == null) {
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
    List<Categoria> categorias = CategoriaDao.listarCategorias();
%>

<main class="container mt-3">
    <a href="${pageContext.request.contextPath}/admin/inventario.jsp" class="btn btn-secondary mb-3">Regresar</a>
    <h1>Agregar Producto</h1>
    <article class="container">
        <section>
            <form action="${pageContext.request.contextPath}/ControlProducto?action=registrar" method="post">
                
                <div class="container table-responsive">
                    <table class="table">
                        <thead>
                        <tr>
                            <th>Categoría:</th>
                            <td>
                                <select name="idCategoria" class="form-select">
                                    <% for (Categoria categoria : categorias) { %>
                                    <option value="<%= categoria.getIdCategoria() %>"><%= categoria.getNombre() %>
                                    </option>
                                    <% } %>
                                </select>
                            </td>
                        </tr>
                        </thead>
                        
                        <tbody>
                        <tr>
                            <th>Nombre:</th>
                            <td><input type="text" name="nombre" class="form-control" required></td>
                        
                        <tr>
                            <th>Descripción:</th>
                            <td><textarea name="descripcion" class="form-control" required></textarea></td>
                        </tr>
                        
                        <tr>
                            <th>Precio:</th>
                            <td><input type="text" name="precio" class="form-control" required></td>
                        </tr>
                        
                        <tr>
                            <th>Stock:</th>
                            <td><input type="text" name="stock" class="form-control" required></td>
                        </tr>
                        
                        <tr>
                            <th>Estado:</th>
                            <td>
                                <select name="estado" class="form-select">
                                    <option value="1">Disponible</option>
                                    <option value="0">No Disponible</option>
                                </select>
                            </td>
                        </tr>
                        </tr>
                        </tbody>
                    </table>
                </div>
                
                <input type="submit" class="btn btn-primary" value="Registrar Producto">
            </form>
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