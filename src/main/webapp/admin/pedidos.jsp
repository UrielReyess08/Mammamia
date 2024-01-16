<%-- 
    Document   : pedido
    Created on : 11 ene. 2024, 11:54:54
    Author     : daiko
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="model.Usuario, model.Pedido, conexion.Conexion, dao.PedidoDao, java.util.*"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Pedidos | Sistema Mammamía</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
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
                        <span class="nav-link">Sistema Mammamía</span>
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
        
        <%
            List<Pedido> milista = PedidoDao.listarPedidos();
            request.setAttribute("list",milista);
        %>
        
        <main class="container mt-3">
            <article>
                <section>
                    <!-- Filtro de Búsqueda -->
                    <form action="${pageContext.request.contextPath}/ControlPedido" method="get" class="mb-3">
                        <div class="input-group">
                            <label for="idPedido" class="visually-hidden">Ingresa el ID del pedido:</label>
                            <input type="text" id="idPedido" name="idPedido" class="form-control" placeholder="Ingresa el ID del pedido">
                            <button type="submit" class="btn btn-primary">Buscar</button>
                            <button type="reset" class="btn btn-secondary">Limpiar</button>
                        </div>
                    </form>
        
                    <!-- Impresión de Errores -->
                    <c:if test="${empty list}">
                        <p>No hay pedidos disponibles.</p>
                    </c:if>
        
                    <c:if test="${not empty errorId}">
                        <p class="alert alert-danger">${errorId}</p>
                    </c:if>
        
                    <c:if test="${not empty errorNumber}">
                        <p class="alert alert-danger">${errorNumber}</p>
                    </c:if>
        
                    <!-- Tabla del Filtro -->
                    <c:if test="${not empty filteredPedido}">
                        <h3 class="mt-3">TABLA DE PEDIDO: ${filteredPedido.getIdPedido()}</h3>
                        <div class="table-responsive">
                            <table class="table table-bordered table-hover">
                                <thead class="table-light">
                                    <tr>
                                        <th>ID</th>
                                        <th>CLIENTE</th>
                                        <th>RECEPTOR</th>
                                        <th>DIRECCIÓN</th>
                                        <th>MÉTODO DE PAGO</th>
                                        <th>HORA</th>
                                        <th>ESTADO</th>
                                        <th>TOTAL</th>
                                        <th>ACCIONES</th>
                                        <th>MÁS DETALLES</th>
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
                                                <c:when test="${filteredPedido.getEstado() == 2}">Entregado</c:when>
                                                <c:otherwise>Estado Desconocido</c:otherwise>
                                            </c:choose>
                                        </td>
                                        <td>${filteredPedido.getTotal()}</td>
                                        <td>
                                            <c:choose>
                                                <c:when test="${filteredPedido.getEstado() == 0}">
                                                    <span style="display:inline-block; width:150px;" class="btn btn-warning btn-sm me-1" style="font-size: 1rem;">En Preparación</span>
                                                </c:when>
                                                <c:when test="${filteredPedido.getEstado() == 1}">
                                                    <span style="display:inline-block; width:150px;" class="btn btn-info btn-sm me-1 mt-1" style="font-size: 1rem;">En Camino</span>
                                                </c:when>
                                                <c:when test="${filteredPedido.getEstado() == 2}">
                                                    <span style="display:inline-block; width:150px;" class="btn btn-success btn-sm me-1 mt-1" style="font-size: 1rem;">Entregado</span>
                                                </c:when>
                                                <c:otherwise>
                                                    <span style="display:inline-block; width:150px;" class="btn btn-secondary btn-sm me-1 mt-1" style="font-size: 1rem;">Estado Desconocido</span>
                                                </c:otherwise>
                                            </c:choose>
                                        </td>
                                           <td>
                                            <a href="${pageContext.request.contextPath}/admin/detallePedido.jsp?idPedido=${filteredPedido.getIdPedido()}" class="btn btn-primary btn-sm">Más Detalles</a>
                                           </td>
                                        </td>
                                    </tr>
                                </tbody>
                            </table>
                        </div>
                    </c:if>
        
                    <!-- Tabla General -->
                    <c:if test="${not empty list}">
                        <h3 class="mt-3">TABLA GENERAL</h3>
                        <div class="table-responsive">
                            <table class="table table-bordered table-hover">
                                <thead class="table-light">
                                    <tr>
                                        <th>ID</th>
                                        <th>CLIENTE</th>
                                        <th>RECEPTOR</th>
                                        <th>DIRECCIÓN</th>
                                        <th>MÉTODO DE PAGO</th>
                                        <th>HORA</th>
                                        <th>ESTADO</th>
                                        <th>TOTAL</th>
                                        <th>ACCIONES</th>
                                        <th>MÁS DETALLES</th>
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
                                                    <c:when test="${ped.getEstado() == 2}">Entregado</c:when>
                                                    <c:otherwise>Estado Desconocido</c:otherwise>
                                                </c:choose>
                                            </td>
                                            <td>${ped.getTotal()}</td>
                                            <td>
                                                <c:choose>
                                                    <c:when test="${ped.getEstado() == 0}">
                                                        <span style="display:inline-block; width:150px;" class="btn btn-warning btn-sm me-1 mt-1" style="font-size: 1rem;">En Preparación</span>
                                                    </c:when>
                                                    <c:when test="${ped.getEstado() == 1}">
                                                        <span style="display:inline-block; width:150px;" class="btn btn-info btn-sm me-1 mt-1" style="font-size: 1rem;">En Camino</span>
                                                    </c:when>
                                                    <c:when test="${ped.getEstado() == 2}">
                                                        <span style="display:inline-block; width:150px;" class="btn btn-success btn-sm me-1 mt-1" style="font-size: 1rem;">Entregado</span>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <span style="display:inline-block; width:150px;" class="btn btn-secondary btn-sm me-1 mt-1" style="font-size: 1rem;">Estado Desconocido</span>
                                                    </c:otherwise>
                                                </c:choose>
                                            </td>                                    
                                            <td>
                                                <a href="${pageContext.request.contextPath}/admin/detallePedido.jsp?idPedido=${ped.getIdPedido()}" class="btn btn-primary btn-sm">Más Detalles</a>
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
        
        <footer class="bg-light py-3">
            <div class="container">
                <p class="text-muted">Copyright@Todos los derechos reservados | Sistema Mammamía</p>
            </div>
        </footer>
        
        <!-- Bootstrap JS y dependencias -->
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
        
        </body>
</html>
