<%-- 
    Document   : addressbook
    Created on : 14 ene. 2024, 18:00:52
    Author     : daiko
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Editar Dirección | Mammamía</title>
    </head>
    <body>
        <%@page import="model.Cliente, model.Direccion, conexion.Conexion, dao.ClienteDao, java.util.*"%>
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
            
        <main>
            <a href="${pageContext.request.contextPath}/customer/account/addressbook.jsp">Regresar</a>
            <h1>Editar Dirección</h1>
            <article class="...">
                <section>
                    <a href="${pageContext.request.contextPath}/customer/account/panel.jsp">Panel de mi Cuenta</a>|
                    <a href="${pageContext.request.contextPath}/controlCliente?action=editarCliente&id=<%= idCliente %>">Editar Información</a>|
                    <a href="${pageContext.request.contextPath}/customer/account/addressbook.jsp">Mis Direcciones</a>|
                    <a href="${pageContext.request.contextPath}/customer/account/wallet.jsp">Mis Tarjetas</a>
                </section>

                <section>
                    <form action="${pageContext.request.contextPath}/controlCliente?action=actualizarDireccion" method="post">
                        
                        <input type="hidden" name="idDireccionCliente" value="${dire.idDireccionCliente}">
                        
                        <input type="hidden" name="idCliente" value="${dire.idCliente}"><br>

                        <label for="nombreDireccion">¿Cómo te gustaría guardar esta dirección?</label>
                        <input type="text" name="nombreDireccion" value="${dire.nombreDireccion}" required /><br>

                        <label for="direccion">Dirección:</label>
                        <input type="text" name="direccion" value="${dire.direccion}" required /><br>

                        <label for="tipoVivienda">Tipo de Vivienda:</label>
                        <select name="tipoVivienda" class="form-select" required>
                            <option value="1" ${dire.tipoVivienda == 1 ? "selected" : ""}>Departamento</option>
                            <option value="2" ${dire.tipoVivienda == 2 ? "selected" : ""}>Casa</option>
                            <option value="3" ${dire.tipoVivienda == 3 ? "selected" : ""}>Condominio</option>
                            <option value="4" ${dire.tipoVivienda == 4 ? "selected" : ""}>Empresa</option>
                            <option value="4" ${dire.tipoVivienda == 4 ? "selected" : ""}>Hotel</option>
                        </select>

                        <label for="referencia">Referencia:</label>
                        <input type="text" name="referencia" value="${dire.referencia}" required /><br>

                        <label for="telefono">Telefóno:</label>
                        <input type="text" name="telefono" value="${dire.telefono}" required /><br>

                        <input type="submit" value="Editar">
                    </form>
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
