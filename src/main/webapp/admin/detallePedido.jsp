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
            int idPedido = Integer.parseInt(request.getParameter("idPedido"));
            
            List<DetallePedido> detalles = DetallePedidoDao.listarDetallePedido(idPedido);
            request.setAttribute("list", detalles);
        %>

        <main>
            <article>
                <section>
                    <a href="${pageContext.request.contextPath}/admin/pedidos.jsp">Regresar</a>
                    <h1>Detalle del Pedido: <%= idPedido %></h1>
                    <c:forEach items="${list}" var="det">
                        <p>Nro. Detalle: ${det.getIdDetalleVenta()}</p>
                        <p>Producto: ${det.getNombre()}</p>
                        <p>Cantidad: ${det.getCantidad()}</p>
                        <hr/>
                    </c:forEach>
                </section>
            </article>
        </main>

        <footer>
            <p>Copyright@Todos los derechos reservados</p>
            <p>Sistema Mammamía</p> 
        </footer>
    </body>
</html>
