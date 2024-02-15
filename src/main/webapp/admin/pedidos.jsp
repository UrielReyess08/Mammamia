<%@page contentType="text/html" pageEncoding="UTF-8" %>
<%@page import="model.Usuario, model.Pedido, conexion.Conexion, dao.PedidoDao, java.util.*" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Ropa+Sans&display=swap" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
    <link rel="stylesheet" href="<%=request.getContextPath()%>/estilos/index.css">
    <title>Pedidos | Sistema Mammamía</title>
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
            <span class="">SISTEMA DE PEDIDOS</span>

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
    List<Pedido> milista = PedidoDao.listarPedidos();
    request.setAttribute("list", milista);
%>
<main class="table-responsive-md">
    <article class="container-fluid">
        <section class="table">
            <h1 class="mt-2">Panel de Pedidos</h1>

            <!-- Filtro de Búsqueda -->
            <form action="${pageContext.request.contextPath}/ControlPedido" method="get" class="my-3">
                <label for="idPedido">Ingresa el ID del pedido:</label>
                <input type="text" id="idPedido" name="idPedido">
                <button class="btn btn-primary my-2" type="submit">Buscar</button>
                <button class="btn btn-success my-2" type="submit">Limpiar</button>
            </form>

            <%-- Impresion de Errores --%>
            <c:if test="${empty list}">
                <p>No hay pedidos disponibles.</p>
            </c:if>

            <c:if test="${not empty errorFiltroPed}">
                <div class="text-danger">
                    <p>${errorFiltroPed}</p>
                </div>
            </c:if>
            <%-- --%>

            <%-- TABLA DEL FILTRO --%>
            <c:if test="${not empty filtroPedido}">
                <h3 class="mt-4 mb-2">TABLA DE PEDIDO: ${filteredPedido.getIdPedido()}</h3>
                <div class="table-responsive-md">
                    <table class="table table-bordered container" border="1">
                        <thead class="table-dark">
                            <tr>
                                <th>ID</th>
                                <th>CLIENTE</th>
                                <th>RECEPTOR</th>
                                <th>DIRECCIÓN</th>
                                <th>METODO DE PAGO</th>
                                <th>HORA</th>
                                <th>ESTADO</th>
                                <th>TOTAL</th>
                                <th></th>
                                <th></th>
                                <th></th>
                                <th></th>
                                <th></th>
                            </tr>
                        </thead>
                        <tbody>
                            <tr>
                                <td>${filtroPedido.getIdPedido()}</td>
                                <td>${filtroPedido.getNombre()} ${filtroPedido.getApellido()}</td>
                                <td>${filtroPedido.getReceptor()}</td>
                                <td>${filtroPedido.getDireccion()}</td>
                                <td>
                                    <c:choose>
                                        <c:when test="${filtroPedido.getMetodoPago() == 0}">Visa</c:when>
                                        <c:when test="${filtroPedido.getMetodoPago() == 1}">Mastercard</c:when>
                                        <c:when test="${filtroPedido.getMetodoPago() == 2}">American Express</c:when>
                                        <c:otherwise>Método Desconocido</c:otherwise>
                                    </c:choose>
                                </td>
                                <td>${filtroPedido.getHoraPedido()}</td>
                                <td>
                                    <c:choose>
                                        <c:when test="${filtroPedido.getEstado() == 0}">En Preparación</c:when>
                                        <c:when test="${filtroPedido.getEstado() == 1}">Pendiente a envío</c:when>
                                        <c:otherwise>Estado Desconocido</c:otherwise>
                                    </c:choose>
                                </td>
                                <td>${filtroPedido.getTotal()}</td>

                                <td>
                                    <form action="${pageContext.request.contextPath}/ControlPedido" method="post">
                                        <input type="hidden" name="idPedido" value="${filtroPedido.getIdPedido()}">
                                        <input type="hidden" name="newEstado" value="0">
                                        <button class="btn btn-primary btn-sm" type="submit">En Preparación
                                        </button>
                                    </form> 
                                </td>

                                <td>
                                    <form action="${pageContext.request.contextPath}/ControlPedido" method="post">
                                        <input type="hidden" name="idPedido" value="${filtroPedido.getIdPedido()}">
                                        <input type="hidden" name="newEstado" value="1">
                                        <button class="btn btn-success btn-sm" type="submit">Pendiente a envío
                                        </button>
                                    </form>
                                </td>

                                <td>
                                    <form action="${pageContext.request.contextPath}/ControlPedido" method="post">
                                        <input type="hidden" name="idPedido" value="${filtroPedido.getIdPedido()}">
                                        <input type="hidden" name="newEstado" value="3">
                                        <button class="btn btn-warning btn-sm text-light" type="submit">Entregado
                                        </button>
                                    </form>
                                </td>

                                <td>
                                    <form action="${pageContext.request.contextPath}/ControlPedido" method="post">
                                        <input type="hidden" name="idPedido" value="${filtroPedido.getIdPedido()}">
                                        <input type="hidden" name="newEstado" value="4">
                                        <button class="btn btn-danger btn-sm" type="submit">Cancelar
                                        </button>
                                    </form>
                                </td>

                                <td>
                                    <a class="btn btn-secondary btn-sm" href="${pageContext.request.contextPath}/admin/detallePedido.jsp?idPedido=${filtroPedido.getIdPedido()}">
                                        Más Detalles
                                    </a>
                                </td>
                            </tr>
                        </tbody>
                    </table>
                </div>
            </c:if>

            <%-- TABLA GENERAL --%>
            <c:if test="${not empty list}">
                <h3 class="mt-4 mb-2">TABLA GENERAL</h3>
                <div class="table-responsive-md">
                    <table class="table table-bordered container" border="1">
                        <thead class="table-dark">
                            <tr>
                                <th>ID</th>
                                <th>CLIENTE</th>
                                <th>RECEPTOR</th>
                                <th>DIRECCIÓN</th>
                                <th>METODO DE PAGO</th>
                                <th>HORA</th>
                                <th>ESTADO</th>
                                <th>TOTAL</th>
                                <th></th>
                                <th></th>
                                <th></th>
                                <th></th>
                                <th></th>
                            </tr>
                        </thead>

                        <tbody>
                            <c:forEach items="${list}" var="ped">
                                <tr>
                                    <td>${ped.getIdPedido()}</td>
                                    <td>${ped.getNombre()} ${ped.getApellido()}</td>
                                    <td>${ped.getReceptor()}</td>
                                    <td>${ped.getDireccion()}</td>
                                    <td>
                                        <c:choose>
                                            <c:when test="${ped.getMetodoPago() == 0}">Visa</c:when>
                                            <c:when test="${ped.getMetodoPago() == 1}">Mastercard</c:when>
                                            <c:when test="${ped.getMetodoPago() == 2}">American Express</c:when>
                                            <c:otherwise>Método Desconocido</c:otherwise>
                                        </c:choose>
                                    </td>
                                    <td>${ped.getHoraPedido()}</td>
                                    <td>
                                        <c:choose>
                                            <c:when test="${ped.getEstado() == 0}">En Preparación</c:when>
                                            <c:when test="${ped.getEstado() == 1}">Pendiente a envío</c:when>
                                            <c:otherwise>Estado Desconocido</c:otherwise>
                                        </c:choose>
                                    </td>
                                    <td>${ped.getTotal()}</td>

                                    <td>
                                        <form action="${pageContext.request.contextPath}/ControlPedido"
                                              method="post">
                                            <input type="hidden" name="idPedido" value="${ped.getIdPedido()}">
                                            <input type="hidden" name="newEstado" value="0">
                                            <button class="btn btn-primary btn-sm"type="submit">En Preparación
                                            </button>
                                        </form>
                                    </td>

                                    <td>
                                        <form action="${pageContext.request.contextPath}/ControlPedido"
                                              method="post">
                                            <input type="hidden" name="idPedido" value="${ped.getIdPedido()}">
                                            <input type="hidden" name="newEstado" value="1">
                                            <button class="btn btn-success btn-sm" type="submit">Pendiente a envío
                                            </button>
                                        </form>
                                    </td>

                                    <td>
                                        <form action="${pageContext.request.contextPath}/ControlPedido"
                                              method="post">
                                            <input type="hidden" name="idPedido" value="${ped.getIdPedido()}">
                                            <input type="hidden" name="newEstado" value="3">
                                            <button class="btn btn-warning btn-sm text-light" type="submit">Entregado
                                            </button>
                                        </form>
                                    </td>

                                    <td>
                                        <form action="${pageContext.request.contextPath}/ControlPedido"
                                              method="post">
                                            <input type="hidden" name="idPedido" value="${ped.getIdPedido()}">
                                            <input type="hidden" name="newEstado" value="4">
                                            <button class="btn btn-danger btn-sm" type="submit">Cancelar
                                            </button>
                                        </form>
                                    </td>

                                    <td>
                                        <a class="btn btn-secondary btn-sm" href="${pageContext.request.contextPath}/admin/detallePedido.jsp?idPedido=${ped.getIdPedido()}">
                                            Más Detalles</a>
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