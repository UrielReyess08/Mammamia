<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="model.Usuario, model.DetallePedido, conexion.Conexion, dao.DetallePedidoDao, java.util.*"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
    <head>
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Detalle del Pedido | Mammamía</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
    </head>
    <body class="text-center mt-5">
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
            int idPedido = Integer.parseInt(request.getParameter("idPedido"));
            
            List<DetallePedido> detalles = DetallePedidoDao.listarDetallePedido(idPedido);
            request.setAttribute("list", detalles);
        %>

        <main>
            <article class="container">
                <div class="table-responsive-md">
                    <section class="table">
                        <a class="btn btn-secondary mt-3" href="${pageContext.request.contextPath}/admin/pedidos.jsp">Regresar</a>
                        <h1 class="mt-4">Detalle del Pedido: <%= idPedido %></h1>
                        <div class="mt-3">
                            <c:forEach items="${list}" var="det">
                                <div class="card">
                                    <div class="card-body">
                                        <p class="card-text">Nro. Detalle: ${det.getIdDetalleVenta()}</p>
                                        <p class="card-text">Producto: ${det.getNombre()}</p>
                                        <p class="card-text">Cantidad: ${det.getCantidad()}</p>
                                    </div>
                                </div>
                            </c:forEach>
                        </div>
                    </section>
                </div>
            </article>
        </main>

        <br><footer class="footer mt-auto py-3 bg-light">
            <div class="container">
                <p class="text-muted">Copyright@Todos los derechos reservados | Sistema Mammamía</p>
            </div>
        </footer>
    </body>
</html>