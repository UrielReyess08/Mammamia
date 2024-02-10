<%@page contentType="text/html" pageEncoding="UTF-8" %>
<%@page import="model.Usuario, model.Producto, conexion.Conexion, dao.ProductoDao, java.util.*" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
    <title>Editar Producto | Sistema Mammamía</title>
</head>

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
<body class="text-center">

    <header class="p-3">
        <nav class="navbar navbar-expand-sm navbar-dark text-light">
            <div class="container-fluid">
                <span class="">SISTEMA DE INVENTARIO</span>

                <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#collapsibleNavbar">
                    <span class="navbar-toggler-icon"></span>
                </button>

                <div class="collapse navbar-collapse justify-content-end" id="collapsibleNavbar">
                    <ul class="navbar-nav">
                        <li class="">
                            <span class="pe-3">Bienvenido, <%= nombreRol %>‎</span>
                        </li>
                        <li class="">
                            <a class="ps-3 text-light" href="${pageContext.request.contextPath}/customer/logout.jsp">Cerrar Sesión</a>
                        </li>
                    </ul>
                </div>

            </div>
        </nav>
    </header>

    <main class="container my-3">
        <h1>Modificar Producto</h1>
        
       <%-- Impresion de Errores --%>
        <c:if test="${not empty errorActualizarProd}">
            <div class="text-danger">
                <p>${errorActualizarProd}</p>
            </div>
        </c:if>
        <%-- --%>
        
        <form action="${pageContext.request.contextPath}/ControlProducto?action=actualizar" method="post">
            <input type="hidden" name="idProducto" value="${producto.idProducto}">

            <div class="container mt-3">
                <table class="table">
                    <thead>
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
                    </thead>
                    <tbody>
                        <tr>
                            <th>Nombre:</th>
                            <td><input type="text" name="nombre" value="${producto.nombre}" class="form-control" required></td>
                        </tr>
                        <tr>
                            <th>Descripción:</th>
                            <td><textarea name="descripcion" class="form-control" required>${producto.descripcion}</textarea>
                            </td>
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
                    </tbody>
                </table>
            </div>

            <button type="submit" class="btn btn-success">Actualizar Producto</button>
            <a href="${pageContext.request.contextPath}/admin/inventario.jsp" class="btn btn-primary">Regresar</a>
        </form>
    </main>

    <footer class="footer mt-auto py-3">
        <div class="container">
            <p class="m-0">Copyright@Todos los derechos reservados | Sistema Mammamía</p>
        </div>
    </footer>
</body>
</html>