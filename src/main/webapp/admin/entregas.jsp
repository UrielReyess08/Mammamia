<%@page contentType="text/html" pageEncoding="UTF-8" %>
<%@page import="model.Usuario, model.Pedido, conexion.Conexion, dao.PedidoDao, java.util.*" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
    <title>Entregas | Sistema Mammamía</title>
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
            <span class="">SISTEMA DE ENTREGAS</span>

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
    List<Pedido> entrega = PedidoDao.listarEntregas();
    request.setAttribute("list", entrega);
%>
<main>
    <article class="container mt-3">
        <section>
            <h1 class="mt-2">Panel de Entregas</h1>

            <!-- Filtro de Búsqueda -->
            <form action="${pageContext.request.contextPath}/ControlEntrega" method="post" class="my-3">
                <label class="h5 form-label" for="idPedido">Ingresa código del pedido:</label>
                <input type="text" id="idPedido" name="idPedido">
                <input type="hidden" name="action" value="buscarEntrega">
                <button class="btn btn-primary" type="submit">Buscar</button>
            </form>

            <%-- Impresion de Errores --%>
            <c:if test="${empty list}">
                <p>No hay pedidos para entregar.</p>
            </c:if>

            <c:if test="${not empty errorEntrega}">
                <div class="text-danger">
                    <c:out value="${errorEntrega}" />
                </div>
            </c:if>

            <%-- TABLA GENERAL --%>
            <c:if test="${not empty list}">
                <h3>TABLA DE ENTREGAS</h3>
                <div class="table-responsive">
                    <table class="table" border="1">
                        <thead class="table-dark">
                            <tr>
                                <th></th>
                                <th>HORA DEL PEDIDO</th>
                                <th>ESTADO</th>
                            </tr>
                        </thead>

                        <tbody>
                            <c:forEach items="${list}" var="ent">
                                <tr>
                                    <td>
                                        <input type="hidden" name="idPedido" value="${ent.getIdPedido()}"/>
                                    </td>
                                    <td>${ent.getHoraPedido()}</td>
                                    <td>
                                        <c:choose>
                                            <c:when test="${ent.getEstado() == 1}">Listo para Entrega</c:when>
                                            <c:otherwise>Estado Desconocido</c:otherwise>
                                        </c:choose>
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