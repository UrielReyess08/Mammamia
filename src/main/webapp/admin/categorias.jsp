<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="model.Usuario, model.Categoria, conexion.Conexion, dao.CategoriaDao, java.util.*"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Categorías | Sistema Mammamía</title>
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
    
    <main class="container mt-3 d-flex flex-column align-items-center justify-content-center">
        <a href="${pageContext.request.contextPath}/admin/inventario.jsp" class="btn btn-secondary mb-3">Regresar</a>
        <h1>Categorías</h1>
    
        <table class="table">
            <c:forEach items="${list}" var="cat">
                <tr>
                    <th>ID:</th>
                    <td>${cat.getIdCategoria()}</td>
                </tr>
                <tr>
                    <th>Nombre:</th>
                    <td><input type="text" class="form-control" id="nombre_${cat.getIdCategoria()}" name="nombre" value="${cat.getNombre()}" required></td>
                </tr>
                <tr>
                    <th>Descripción:</th>
                    <td><input type="text" class="form-control" id="descripcion_${cat.getIdCategoria()}" name="descripcion" value="${cat.getDescripcion()}"></td>
                </tr>
                <tr>
                    <th>Estado:</th>
                    <td>
                        <div class="btn-group" role="group">
                            <input type="radio" class="btn-check" id="activo_${cat.getIdCategoria()}" name="estado_${cat.getIdCategoria()}" value="1" ${cat.getEstado() == 1 ? 'checked' : ''}>
                            <label class="btn btn-outline-success" for="activo_${cat.getIdCategoria()}">Activo</label>
    
                            <input type="radio" class="btn-check" id="inactivo_${cat.getIdCategoria()}" name="estado_${cat.getIdCategoria()}" value="0" ${cat.getEstado() == 0 ? 'checked' : ''}>
                            <label class="btn btn-outline-danger" for="inactivo_${cat.getIdCategoria()}">Inactivo</label>
                        </div>
                    </td>
                </tr>
                <tr>
                    <td colspan="2">
                        <form action="${pageContext.request.contextPath}/ControlCategoria" method="post">
                            <input type="hidden" name="idCategoria" value="${cat.getIdCategoria()}">
                            <button type="submit" class="btn btn-primary mt-2">Modificar Categoria</button>
                        </form>
                    </td>
                </tr>
            </c:forEach>
        </table>
    </main>
    
    <footer class="footer mt-auto py-3 bg-light">
        <div class="container text-center">
            <p class="text-muted">Copyright@Todos los derechos reservados | Sistema Mammamía</p>
        </div>
    </footer>
    
    <!-- Bootstrap JS y dependencias -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
    
    </body>
</html>
