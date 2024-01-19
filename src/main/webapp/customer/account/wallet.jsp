<%-- 
    Document   : wallet
    Created on : 14 ene. 2024, 22:23:23
    Author     : daiko
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>  
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Mis Tarjetas | Mammamía</title>
    </head>
    <body>
        <%@page import="model.Cliente, model.Tarjeta, conexion.Conexion, dao.ClienteDao, java.util.*"%>
        <%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

        <%
            // Obtener la sesión
            HttpSession sesion = request.getSession(false);
            
            // Obtener la sesion para cliente
            Boolean isLoggedIn = (sesion != null && sesion.getAttribute("isLoggedIn") != null && (Boolean) sesion.getAttribute("isLoggedIn"));
            
            // Obtener la sesion para invitado
            Boolean isGuest = (sesion != null && sesion.getAttribute("isGuest") != null && (Boolean) sesion.getAttribute("isGuest"));
            
            //Declarar variable para nombre del cliente
            int idCliente = -1;
            String nombreCliente = null;
            String apellidoCliente = null;
            String emailCliente = null;
            
            if(isLoggedIn){
                Cliente cliente = (Cliente) sesion.getAttribute("cliente");
                idCliente = cliente.getIdCliente();
                nombreCliente = cliente.getNombre();
                apellidoCliente = cliente.getApellido();
                emailCliente = cliente.getEmail();
            }
        %>

        <header>
            <ul>
                <li>
                    <a href="${pageContext.request.contextPath}/index.jsp">
                        <img src="..." alt="logo"/> | Inicio
                    </a>
                </li>
                <li>
                    <a href="${pageContext.request.contextPath}/menu.jsp">Menú</a>
                </li>
                <li>
                    <a href="${pageContext.request.contextPath}/nosotros.jsp">Nosotros</a>
                </li>
                <!-- Menú para cliente -->
                <%
                    if (isLoggedIn) {
                %>
                <li>
                    <a href="${pageContext.request.contextPath}/customer/logout.jsp">Cerrar Sesión</a>
                </li>
                <li>
                    <a href="${pageContext.request.contextPath}/customer/account/panel.jsp">Mi Cuenta</a>
                </li>
                <!-- Menú para invitado-->
                <%
                    } else if (isGuest){
                %>
                <li>
                    <a href="${pageContext.request.contextPath}/customer/logout.jsp">Iniciar Sesión (Invitado)</a>
                </li>
                <%
                    } else {
                %>
                <li>
                    <a href="${pageContext.request.contextPath}/customer/login.jsp">Iniciar Sesión</a>
                </li>
                <%
                    }
                %>
            </ul>
        </header>

        <%  
                   ClienteDao clienteDao = new ClienteDao();
                   List<Tarjeta> tarjetas = clienteDao.listarTarjetaPorId(idCliente);
                   request.setAttribute("list",tarjetas);
        %>
        <main>
            <h1>Mis Direcciones</h1>
            <article class="...">
                <section>
                    <a href="${pageContext.request.contextPath}/customer/account/panel.jsp">Panel de mi Cuenta</a>|
                    <a href="${pageContext.request.contextPath}/customer/account/">Información de la Cuenta</a>|
                    <a href="${pageContext.request.contextPath}/customer/account/addressbook.jsp">Mis Direcciones</a>|
                    <a href="${pageContext.request.contextPath}/customer/account/wallet.jsp">Mis Tarjetas</a>
                </section>

                <section>
                    <a href="${pageContext.request.contextPath}/customer/account/register/wallet.jsp">Agregar Nueva Tarjeta</a>

                    <c:if test="${empty list}">
                        <p>No hay tarjetas.</p>
                    </c:if>

                    <c:if test="${not empty list}">
                        <table border="1">
                            <thead>
                                <tr>
                                    <th>N°</th>
                                    <th>NOMBRE</th>
                                    <th>MÉTODO DE PAGO</th>
                                    <th>FECHA EXP.</th>
                                    <th>TIPO</th>
                                    <th>NÚMERO</th>
                                </tr>
                            </thead>

                            <tbody>
                                <c:forEach items="${list}" var="tar">
                                    <tr>
                                        <td>${tar.getIdTarjetaCliente()}</td>
                                        <td>${tar.getNombreTarjeta()}</td>
                                        <td>
                                            <c:choose>
                                                <c:when test="${tar.getMetodoPago() == 1}">Visa</c:when>
                                                <c:when test="${tar.getMetodoPago() == 2}">Mastercard</c:when>
                                                <c:when test="${tar.getMetodoPago() == 3}">American Express</c:when>
                                                <c:otherwise>Desconocido</c:otherwise>
                                            </c:choose>
                                        </td>
                                        <td>${tar.getFechaExpiracion()}</td>
                                        <td>
                                            <c:choose>
                                                <c:when test="${tar.getTipoTarjeta() == 1}">Crédito</c:when>
                                                <c:when test="${tar.getTipoTarjeta() == 2}">Débito</c:when>
                                                <c:otherwise>Desconocido</c:otherwise>
                                            </c:choose>
                                        </td>
                                        
                                        <td>${tar.getNumeroTarjeta()}</td>
                                        <td>
                                            <a href="${pageContext.request.contextPath}/controlCliente?action=eliminarTarjeta&id=${tar.getIdTarjetaCliente()}">Eliminar</a>
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
            <ul>
                <li>
                    <img src="..." alt="logo"/>
                    <a href="...">Facebook</a>
                </li>
                <li>
                    <img src="..." alt="logo"/>
                    <a href="...">Instagram</a>
                </li>
                <li>
                    <img src="..." alt="logo"/>
                    <a href="...">Twitter</a>
                </li>
            </ul>

            <ul>
                <li>
                    <a href="${pageContext.request.contextPath}/terminos-condiciones.jsp">Terminos y Condiciones</a>
                </li>
                <li>
                    <a href="${pageContext.request.contextPath}/contacto.jsp">Atención al Cliente</a>
                </li>
                <li>
                    <a href="${pageContext.request.contextPath}/preguntas-frecuentes.jsp">Preguntas Frecuentes</a>
                </li>
            </ul>
        </footer>
    </body>
</html>
