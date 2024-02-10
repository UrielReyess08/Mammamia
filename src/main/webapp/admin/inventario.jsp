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
    <title>Inventario | Sistema Mammamía</title>
</head>
<body class="text-center">
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

<%
    List<Producto> producto = ProductoDao.listarProductos();
    request.setAttribute("list", producto);
%>

<main class="container my-3">
    <article class="container">
        <section>
            <h1 class="mt-2">Panel de Inventario</h1>

            <!-- Filtro de Búsqueda -->
            <form action="${pageContext.request.contextPath}/ControlProducto" method="get" class="my-3">
                <input type="hidden" name="action" value="buscar">
                <label for="idProducto">Ingresa el ID del producto:</label>
                <input type="text" id="idProducto" name="idProducto">
                <button class="btn btn-primary my-2" type="submit">Buscar</button>
                <button class="btn btn-success my-2" type="submit">Limpiar</button>
            </form>

            <%-- Impresion de Errores --%>
            <c:if test="${empty list}">
                <p class="mt-4">No hay productos disponibles.</p>
            </c:if>

            <c:if test="${not empty errorFiltro}">
                <div class="text-danger">
                    <c:out value="${errorFiltro}" /> 
                </div> 
            </c:if>

            <%-- --%>

            <%-- TABLA DEL FILTRO --%>
            <c:if test="${not empty filtroProducto}">
                <h3 class="mt-4 mb-2">TABLA DE PRODUCTO: ${filtroProducto.getIdProducto()}</h3>
                <div class="table-responsive-md">
                    <table class="table table-bordered container" border="1">
                        <thead class="table-dark">
                            <tr>
                                <th>ID</th>
                                <th>CATEGORÍA</th>
                                <th>NOMBRE</th>
                                <th>DESCRIPCIÓN</th>
                                <th>PRECIO</th>
                                <th>STOCK</th>
                                <th>ESTADO</th>
                                <th></th>
                                <th></th>
                            </tr>
                        </thead>
                        <tbody>
                            <tr>
                                <td>${filtroProducto.getIdProducto()}</td>
                                <td>${filtroProducto.getNombreCategoria()}</td>
                                <td>${filtroProducto.getNombre()}</td>
                                <td>${filtroProducto.getDescripcion()}</td>
                                <td>${filtroProducto.getPrecio()}</td>
                                <td>${filtroProducto.getStock()}</td>
                                <td>
                                    <c:choose>
                                        <c:when test="${filtroProducto.getEstado() == 0}">Inactivo</c:when>
                                        <c:when test="${filtroProducto.getEstado() == 1}">Activo</c:when>
                                        <c:otherwise>Estado Desconocido</c:otherwise>
                                    </c:choose>
                                </td>
                                <td>
                                    <a class="btn btn-success btn-sm"
                                       href="${pageContext.request.contextPath}/ControlProducto?action=editar&id=${filtroProducto.getIdProducto()}">Modificar</a>
                                </td>
                                <td>
                                    <form action="${pageContext.request.contextPath}/ControlProducto" method="post">
                                        <input type="hidden" id="idProducto" name="idProducto"
                                               value="${filtroProducto.getIdProducto()}">
                                        <input type="hidden" name="action" value="eliminar">
                                        <button class="btn btn-danger btn-sm" type="submit">Eliminar</button>
                                    </form>
                                </td>
                            </tr>
                        </tbody>
                    </table>
                </div>
            </c:if>


            <%-- TABLA GENERAL --%>
            <c:if test="${not empty list}">
                <h3 class="mt-4 mb-2">TABLA GENERAL</h3> 

                <div class="d-flex justify-content-between w-100 my-2">
                    <div>
                        <a class="btn btn-primary mt-2" href="${pageContext.request.contextPath}/admin/register/producto.jsp">Agregar
                            Producto</a>
                    </div>
                    <div>
                        <a class="btn btn-warning text-light mt-2" href="${pageContext.request.contextPath}/admin/categorias.jsp">Gestionar
                            Categorias</a>
                    </div>
                </div>

                <div class="table-responsive-md">
                    <table class="table table-bordered container" border="1">
                        <thead class="table-dark">
                            <tr>
                                <th>ID</th>
                                <th>CATEGORÍA</th>
                                <th>NOMBRE</th>
                                <th>DESCRIPCIÓN</th>
                                <th>PRECIO</th>
                                <th>STOCK</th>
                                <th>ESTADO</th>
                                <th></th>
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
                                        <a class="btn btn-success btn-sm"
                                           href="${pageContext.request.contextPath}/ControlProducto?action=editar&id=${prod.getIdProducto()}">Modificar</a>
                                    </td>
                                    <td>
                                        <form action="${pageContext.request.contextPath}/ControlProducto" method="post">
                                            <input type="hidden" id="idProducto" name="idProducto"
                                                   value="${prod.getIdProducto()}">
                                            <input type="hidden" name="action" value="eliminar">
                                            <button class="btn btn-danger btn-sm" type="submit">Eliminar</button>
                                        </form>
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

<footer class="footer mt-auto py-3">
    <div class="container">
        <p class="m-0">Copyright@Todos los derechos reservados | Sistema Mammamía</p>
    </div>
</footer>
</body>
</html>