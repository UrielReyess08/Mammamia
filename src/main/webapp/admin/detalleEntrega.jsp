<<<<<<< HEAD
<%-- 
    Document   : detalleEntrega
    Created on : 12 ene. 2024, 16:54:29
    Author     : daiko
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="model.Usuario" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Detalle Entrega | Mammamía</title>
    </head>
    <body class="d-flex flex-column min-vh-100 mt-5">

        <%@page import="model.Pedido, connection.Conexion, dao.PedidoDao, java.util.*"%>
        <%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
        
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
            Pedido det = PedidoDao.obtenerEntregaporId(idPedido);
        %>
        
        <main class="container mt-3 d-flex flex-column align-items-center justify-content-center">
            <article class="row">
                <section class="col-md-8">
                    <h1 class="mb-4">Detalles de la Entrega: <%= det.getIdPedido() %></h1>
        
                    <table class="table table-striped table-responsive">
                        <tr>
                            <th>Nombre Receptor:</th>
                            <td><%= det.getReceptor() %></td>
                        </tr>
                        <tr>
                            <th>Dirección:</th>
                            <td><%= det.getDireccion() %></td>
                        </tr>
                        <tr>
                            <th>Tipo de Vivienda:</th>
                            <td>
                                <%
                                    int tipoVivienda = det.getTipoVivienda();
                                    switch (tipoVivienda){
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
                            </td>
                        </tr>
                        <!-- Agrega otras filas según sea necesario -->
                    </table>
        
                    <form action="${pageContext.request.contextPath}/ControlEntrega" method="post" class="mt-3">
                        <input type="hidden" id="idPedido" name="idPedido" value="<%= det.getIdPedido() %>">
                        <input type="hidden" name="action" value="confirmarEntrega">
                        <button type="submit" class="btn btn-primary">Confirmar Entrega</button>
                    </form>
                </section>
                <aside class="col-md-4">
                    <!-- Puedes agregar contenido adicional o información relacionada aquí -->
                </aside>
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
<%-- 
    Document   : detalleEntrega
    Created on : 12 ene. 2024, 16:54:29
    Author     : daiko
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="model.Usuario" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Detalle Entrega | Mammamía</title>
    </head>
    <body>
        <%@page import="model.Pedido, conexion.Conexion, dao.PedidoDao, java.util.*"%>
        <%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

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
            int idPedido = Integer.parseInt(request.getParameter("idPedido"));
            
            Pedido det = PedidoDao.obtenerEntregaporId(idPedido);
        %>

        <main>
            <article class="...">
                <section>
                    <h1>Detalles de la Entrega: <%= det.getIdPedido() %></h1>
                    <p>Nombre Receptor: <%= det.getReceptor() %></p>
                    <p>Dirección: <%= det.getDireccion() %></p>
                    <p>Tipo de Vivienda:
                        <%
                            int tipoVivienda = det.getTipoVivienda();
                            switch (tipoVivienda){
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
                    <p>Referencia: <%= det.getReferencia() %></p>
                    <p>Teléfono: <%= det.getTelefono() %></p>
                    <p>Hora: <%= det.getHoraPedido() %></p>
                    <p>Estado:
                        <% 
                            int estado = det.getEstado();
                            switch (estado){
                                case 1:
                                    out.print("En Camino");
                                    break;
                                default:
                                    out.print("Estado Desconocido");
                            }
                        %>
                    </p>
                    <p>Total: <%= det.getTotal() %></p>
                </section>

                <form action="${pageContext.request.contextPath}/ControlEntrega" method="post">
                    <input type="hidden" id="idPedido" name="idPedido" value="<%= det.getIdPedido() %>">
                    <input type="hidden" name="action" value="confirmarEntrega">
                    <button type="submit">Confirmar Entrega</button>
                </form>
            </article>
        </main>
    </body>
</html>
>>>>>>> 4595d29 (Se quitó los estilos Bootstrap a los módulos de administrador)
