<%@page contentType="text/html" pageEncoding="UTF-8" %>
<%@page import="model.Usuario, model.DetallePedido, conexion.Conexion, dao.DetallePedidoDao, java.util.*" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
    <title>Detalle del Pedido | Mammamía</title>
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
        int idPedido = Integer.parseInt(request.getParameter("idPedido"));

        List<DetallePedido> detalles = DetallePedidoDao.listarDetallePedido(idPedido);
        request.setAttribute("list", detalles);
    %>

    <main class="my-3">
        <article class="container">
            <div class="table-responsive-md">
                <section class="table">
                    <h1 class="mt-4">Detalle del Pedido: <%= idPedido %></h1>
                    <div class="mt-3">
                        <c:forEach items="${list}" var="det">
                            <div class="card">
                                <div class="card-body">
                                    <p class="card-text">Nro. Detalle: ${det.getDetallePedido()}</p>
                                    <p class="card-text">Producto: ${det.getNombre()}</p>
                                    <p class="card-text">Cantidad: ${det.getCantidad()}</p>
                                </div>
                            </div>
                        </c:forEach>

                        <a class="btn btn-primary mt-3" href="${pageContext.request.contextPath}/admin/pedidos.jsp">Regresar</a>
                    </div>
                </section>
            </div>
        </article>
    </main>

    <footer class="footer mt-auto py-3">
        <div class="container">
            <p class="m-0">Copyright@Todos los derechos reservados | Sistema Mammamía</p>
        </div>
    </footer>
</body>
</html>