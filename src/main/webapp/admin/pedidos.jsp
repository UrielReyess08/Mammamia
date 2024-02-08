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
    <title>Pedidos | Sistema Mammamía</title>
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
    List<Pedido> milista = PedidoDao.listarPedidos();
    request.setAttribute("list", milista);
%>
<main class="table-responsive-md">
    <article class="container-fluid">
        <section class="table">
            <!-- Filtro de Búsqueda -->
            <form action="${pageContext.request.contextPath}/ControlPedido" method="get">
                <label for="idPedido">Ingresa el ID del pedido:</label>
                <input type="text" id="idPedido" name="idPedido">
                <button class="btn btn-primary mt-0" type="submit">Buscar</button>
                <button class="btn btn-success mt-0" type="submit">Limpiar</button>
            </form>
            
            <%-- Impresion de Errores --%>
            <c:if test="${empty list}">
                <p>No hay pedidos disponibles.</p>
            </c:if>
            
            <c:if test="${not empty errorId}">
                <p>${errorId}</p>
            </c:if>
            
            <c:if test="${not empty errorNumber}">
                <p>${errorNumber}</p>
            </c:if>
            <%-- --%>
            
            <%-- TABLA DEL FILTRO --%>
                    <c:if test="${not empty filteredPedido}">
                        <h3>TABLA DE PEDIDO: ${filteredPedido.getIdPedido()}</h3>
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
                                        <td>${filteredPedido.getIdPedido()}</td>
                                        <td>${filteredPedido.getNombre()} ${filteredPedido.getApellido()}</td>
                                        <td>${filteredPedido.getReceptor()}</td>
                                        <td>${filteredPedido.getDireccion()}</td>
                                        <td>
                                            <c:choose>
                                                <c:when test="${filteredPedido.getMetodoPago() == 0}">Visa</c:when>
                                                <c:when test="${filteredPedido.getMetodoPago() == 1}">Mastercard</c:when>
                                                <c:when test="${filteredPedido.getMetodoPago() == 2}">American Express</c:when>
                                                <c:otherwise>Método Desconocido</c:otherwise>
                                            </c:choose>
                                        </td>
                                        <td>${filteredPedido.getHoraPedido()}</td>
                                        <td>
                                            <c:choose>
                                                <c:when test="${filteredPedido.getEstado() == 0}">En Preparación</c:when>
                                                <c:when test="${filteredPedido.getEstado() == 1}">En Camino</c:when>
                                                <c:otherwise>Estado Desconocido</c:otherwise>
                                            </c:choose>
                                        </td>
                                        <td>${filteredPedido.getTotal()}</td>

                                        <td>
                                            <form action="${pageContext.request.contextPath}/ControlPedido" method="post">
                                                <input type="hidden" name="idPedido" value="${filteredPedido.getIdPedido()}">
                                                <input type="hidden" name="newEstado" value="0">
                                                <button class="btn btn-primary btn-sm" type="submit">En Preparación
                                                </button>
                                            </form> 
                                        </td>

                                        <td>
                                            <form action="${pageContext.request.contextPath}/ControlPedido" method="post">
                                                <input type="hidden" name="idPedido" value="${filteredPedido.getIdPedido()}">
                                                <input type="hidden" name="newEstado" value="1">
                                                <button class="btn btn-success btn-sm" type="submit">En Camino
                                                </button>
                                            </form>
                                        </td>

                                        <td>
                                            <form action="${pageContext.request.contextPath}/ControlPedido" method="post">
                                                <input type="hidden" name="idPedido" value="${filteredPedido.getIdPedido()}">
                                                <input type="hidden" name="newEstado" value="3">
                                                <button class="btn btn-secondary btn-sm" type="submit">Entregado
                                                </button>
                                            </form>
                                        </td>

                                        <td>
                                            <form action="${pageContext.request.contextPath}/ControlPedido" method="post">
                                                <input type="hidden" name="idPedido" value="${filteredPedido.getIdPedido()}">
                                                <input type="hidden" name="newEstado" value="4">
                                                <button class="btn btn-secondary btn-sm" type="submit">Cancelar
                                                </button>
                                            </form>
                                        </td>

                                        <td>
                                            <a class="btn btn-warning btn-sm" href="${pageContext.request.contextPath}/admin/detallePedido.jsp?idPedido=${filteredPedido.getIdPedido()}">
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
                        <h3>TABLA GENERAL</h3>
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
                                                    <c:when test="${ped.getEstado() == 1}">En Camino</c:when>
                                                    <c:otherwise>Estado Desconocido</c:otherwise>
                                                </c:choose>
                                            </td>
                                            <td>${ped.getTotal()}</td>

                                            <td>
                                                <form action="${pageContext.request.contextPath}/ControlPedido"
                                                      method="post">
                                                    <input type="hidden" name="idPedido" value="${ped.getIdPedido()}">
                                                    <input type="hidden" name="newEstado" value="0">
                                                    <button class="btn btn-primary btn-sm" type="submit">En Preparación
                                                    </button>
                                                </form>
                                            </td>

                                            <td>
                                                <form action="${pageContext.request.contextPath}/ControlPedido"
                                                      method="post">
                                                    <input type="hidden" name="idPedido" value="${ped.getIdPedido()}">
                                                    <input type="hidden" name="newEstado" value="1">
                                                    <button class="btn btn-success btn-sm" type="submit">En Camino
                                                    </button>
                                                </form>
                                            </td>

                                            <td>
                                                <form action="${pageContext.request.contextPath}/ControlPedido"
                                                      method="post">
                                                    <input type="hidden" name="idPedido" value="${ped.getIdPedido()}">
                                                    <input type="hidden" name="newEstado" value="3">
                                                    <button class="btn btn-info btn-sm text-light" type="submit">Entregado
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

                                                <a class="btn btn-warning btn-sm text-light" href="${pageContext.request.contextPath}/admin/detallePedido.jsp?idPedido=${ped.getIdPedido()}">
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

<footer class="footer mt-auto py-3 bg-light">
    <div class="container">
        <p class="text-muted">Copyright@Todos los derechos reservados | Sistema Mammamía</p>
    </div>
</footer>
</body>
</html>