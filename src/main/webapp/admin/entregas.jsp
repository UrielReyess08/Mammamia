<<<<<<< HEAD


<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="model.Usuario, model.Pedido, conexion.Conexion, dao.PedidoDao, java.util.*"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Entregas | Sistema Mammamía</title>
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
        
        <%
            List<Pedido> entrega = PedidoDao.listarEntregas();
            request.setAttribute("list", entrega);
        %>
        
        <main class="container mt-3">
            <article>
                <section>
                    <!-- Filtro de Búsqueda -->
                    <form action="${pageContext.request.contextPath}/ControlEntrega" method="post">
                        <label for="idPedido">Ingresa código del pedido:</label>
                        <input type="text" id="idPedido" name="idPedido">
                        <input type="hidden" name="action" value="buscarEntrega">
                        <button type="submit" class="btn btn-primary m-1">Buscar</button>
                    </form>
        
                    <!-- Impresión de Errores -->
                    <c:if test="${empty list}">
                        <p class="mt-3">No hay pedidos para entregar.</p>
                    </c:if>
        
                    <!-- TABLA GENERAL -->
                    <c:if test="${not empty list}">
                        <h3 class="mt-3">TABLA DE ENTREGAS</h3>
                        <div class="table-responsive">
                            <table class="table table-striped">
                                <thead>
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
                                                <input type="hidden" name="idPedido" value="${ent.getIdPedido()}" />
                                            </td>
                                            <td>${ent.getHoraPedido()}</td>
                                            <td>
                                                <c:choose>
                                                    <c:when test="${ent.getEstado() == 0}">Listo para Entrega</c:when>
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
        
        <footer class="footer mt-auto py-3 bg-light">
            <div class="container">
                <p class="text-muted">Copyright@Todos los derechos reservados | Sistema Mammamía</p>
            </div>
        </footer>
        
        <!-- Bootstrap JS y dependencias -->
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
        
        </body>
</html>
=======


<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="model.Usuario, model.Pedido, conexion.Conexion, dao.PedidoDao, java.util.*"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Entregas | Sistema Mammamía</title>
    </head>
    <body>
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

        <header>
            <ul>
                <li>
                    Sistema
                </li>
                <li>
                    Bienvenido, <%= nombreRol %>
                </li>
                <li>
                    <a href="${pageContext.request.contextPath}/customer/logout.jsp">Cerrar Sesión</a>
                </li>
            </ul>
        </header>

        <%
            List<Pedido> entrega = PedidoDao.listarEntregas();
            request.setAttribute("list",entrega);
        %>
        <main>
            <article class="...">
                <section>
                    <!-- Filtro de Búsqueda -->
                    <form action="${pageContext.request.contextPath}/ControlEntrega" method="post">
                        <label for="idPedido">Ingresa código del pedido:</label>
                        <input type="text" id="idPedido" name="idPedido">
                        <input type="hidden" name="action" value="buscarEntrega">
                        <button type="submit">Buscar</button>
                    </form>

                    <%-- Impresion de Errores --%>
                    <c:if test="${empty list}">
                        <p>No hay pedidos para entregar.</p>
                    </c:if>

                    <%-- TABLA GENERAL --%>
                    <c:if test="${not empty list}">
                        <h3>TABLA DE ENTREGAS</h3>
                        <table border="1">
                            <thead>
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
                                            <input type="hidden" name="idPedido" value="${ent.getIdPedido()}" />
                                        </td>
                                        <td>${ent.getHoraPedido()}</td>
                                        <td>
                                            <c:choose>
                                                <c:when test="${ent.getEstado() == 0}">Listo para Entrega</c:when>
                                                <c:otherwise>Estado Desconocido</c:otherwise>
                                            </c:choose>
                                        </td>
                                    </tr>
                                </c:forEach>
                            </tbody>
                        </table>
                    </c:if>
                </section>
            </article>
        </main>

        <footer>
            <p>Copyright@Todos los derechos reservados</p>
            <p>Sistema Mammamía</p> 
        </footer>
    </body>
</html>
>>>>>>> 4595d29 (Se quitó los estilos Bootstrap a los módulos de administrador)
