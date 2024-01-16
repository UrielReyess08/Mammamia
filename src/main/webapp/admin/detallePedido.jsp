<%-- 
    Document   : detallePedido
    Created on : 11 ene. 2024, 21:33:29
    Author     : daiko
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="model.Usuario, model.DetallePedido, conexion.Conexion, dao.DetallePedidoDao, java.util.*"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Detalle del Pedido | Mammamía</title>
    </head>
    <body class="mt-5" style="display: flex; flex-direction: column; min-height: 100vh;">

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
            int idPedido = Integer.parseInt(request.getParameter("idPedido"));
            List<DetallePedido> detalles = DetallePedidoDao.listarDetallePedido(idPedido);
            request.setAttribute("list", detalles);
        %>
        
        <main class="container mt-3" style="flex: 1;display: flex; align-items: center; justify-content: center;">
            <article>
                <section>
                    <a href="${pageContext.request.contextPath}/admin/pedidos.jsp" class="btn btn-secondary mb-3">Regresar</a>
                    <h1 class="text-center">Detalle del Pedido: <%= idPedido %></h1>
                    
                    <div class="table-responsive">
                        <table class="table table-striped">
                            <thead>
                                <tr>
                                    <th>Nro. Detalle</th>
                                    <th>Producto</th>
                                    <th>Cantidad</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach items="${list}" var="det">
                                    <tr>
                                        <td>${det.getIdDetalleVenta()}</td>
                                        <td>${det.getNombre()}</td>
                                        <td>${det.getCantidad()}</td>
                                    </tr>
                                </c:forEach>
                            </tbody>
                        </table>
                    </div>
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
