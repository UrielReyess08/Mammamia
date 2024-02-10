<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="model.Usuario, model.Categoria, conexion.Conexion, dao.CategoriaDao, java.util.*"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Categorías | Sistema Mammamía</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</head>
<body class="text-center">
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
        List<Categoria> categoria = CategoriaDao.listarCategorias();
        request.setAttribute("list",categoria);
    %>

    <main class="container my-3">
        <h1>Categorías</h1>
        <article class="container">
            <section>
                <%-- Impresion de Errores --%>
                <c:if test="${empty list}">
                    <p>No hay categorías disponibles.</p>
                </c:if>

                <c:if test="${not empty errorCategoria}">
                    <div class="text-danger">
                        <p>${errorCategoria}</p>
                    </div>
                </c:if>
                <%-- --%>

                <c:if test="${not empty list}">
                    <div class="table-responsive-md">
                        <table class="table table-bordered">
                            <thead class="table-dark">
                                <tr>
                                    <th>ID</th>
                                    <th>NOMBRE y DESCRIPCIÓN</th>
                                    <th>ESTADO</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach items="${list}" var="cat">
                                    <tr>
                                        <td>${cat.getIdCategoria()}</td>
                                        <td>
                                            <form action="${pageContext.request.contextPath}/ControlCategoria" method="post">
                                                <input type="hidden" name="idCategoria" value="${cat.getIdCategoria()}">
                                                <div class="row">
                                                    <div class="col">
                                                        <label for="nombre_${cat.getIdCategoria()}" class="form-label">Nombre:</label>
                                                        <input type="text" id="nombre_${cat.getIdCategoria()}" name="nombre" value="${cat.getNombre()}" class="form-control" required>
                                                    </div>
                                                    <div class="col">
                                                        <label for="descripcion_${cat.getIdCategoria()}" class="form-label">Descripción:</label>
                                                        <input type="text" id="descripcion_${cat.getIdCategoria()}" name="descripcion" value="${cat.getDescripcion()}" class="form-control">
                                                    </div>
                                                    <div class="col">
                                                        <input type="submit" value="Modificar Categoria" class="btn btn-success mt-4">
                                                    </div>
                                                </div>
                                            </form>
                                        </td>
                                        <td>
                                            <c:choose>
                                                <c:when test="${cat.getEstado() == 1}">Activo</c:when>
                                                <c:otherwise>Estado Desconocido</c:otherwise>
                                            </c:choose>
                                        </td>
                                    </tr>
                                </c:forEach>
                            </tbody>
                        </table>
                    </div>
                </c:if>
                <a class="btn btn-primary" href="${pageContext.request.contextPath}/admin/inventario.jsp">Regresar</a>
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