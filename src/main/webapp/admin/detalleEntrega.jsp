<%@page contentType="text/html" pageEncoding="UTF-8" %>
<%@page import="model.Usuario" %>
<!DOCTYPE html>
<html>
<head>
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
    <title>Detalle Entrega | Mammamía</title>
</head>
<body class="text-center mt-5">
<%@page import="model.Pedido, conexion.Conexion, dao.PedidoDao, java.util.*" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

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
    int idPedido = Integer.parseInt(request.getParameter("idPedido"));
    
    Pedido det = PedidoDao.obtenerEntregaporId(idPedido);
%>

<main>
    <article class="container">
        <section>
            <h1>Detalles de la Entrega: <%= det.getIdPedido() %>
            </h1>
            <p>Nombre Receptor: <%= det.getReceptor() %>
            </p>
            <p>Dirección: <%= det.getDireccion() %>
            </p>
            <p>Tipo de Vivienda:
                <%
                    int tipoVivienda = det.getTipoVivienda();
                    switch (tipoVivienda) {
                        case 0:
                            out.print("Departamento");
                            break;
                        case 1:
                            out.print("Casa");
                            break;
                        case 2:
                            out.print("Condominio");
                            break;
                        case 3:
                            out.print("Empresa");
                            break;
                        case 4:
                            out.print("Hotel");
                            break;
                        default:
                            out.print("No especificado");
                    }
                %>
            </p>
            <p>Referencia: <%= det.getReferencia() %>
            </p>
            <p>Teléfono: <%= det.getTelefono() %>
            </p>
            <p>Hora: <%= det.getHoraPedido() %>
            </p>
            <p>Estado:
                <%
                    int estado = det.getEstado();
                    switch (estado) {
                        case 2:
                            out.print("En Camino");
                            break;
                        default:
                            out.print("Estado Desconocido");
                    }
                %>
            </p>
            <p>Total: <%= det.getTotal() %>
            </p>
        </section>
        
        <form action="${pageContext.request.contextPath}/ControlEntrega" method="post">
            <input type="hidden" id="idPedido" name="idPedido" value="<%= det.getIdPedido() %>">
            <input type="hidden" name="action" value="confirmarEntrega">
            <button class="btn btn-primary mt-2" type="submit">Confirmar Entrega</button>
        </form>
    </article>
</main>

<br>
<footer class="footer mt-auto py-3 bg-light">
    <div class="container">
        <p class="text-muted">Copyright@Todos los derechos reservados | Sistema Mammamía</p>
    </div>
</footer>
</body>
</html>