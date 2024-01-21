<%-- 
    Document   : wallet
    Created on : 14 ene. 2024, 22:23:23
    Author     : daiko
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="model.Cliente"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Agregar Tarjeta | Mammamía</title>
    </head>
    <body>
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
            <a href="${pageContext.request.contextPath}/customer/account/wallet.jsp">Regresar</a>
            <h1>Agregar Tarjeta</h1>
            <article class="...">
                <section>
                    <a href="${pageContext.request.contextPath}/customer/account/panel.jsp">Panel de mi Cuenta</a>|
                    <a href="${pageContext.request.contextPath}/controlCliente?action=editarCliente&id=<%= idCliente %>">Editar Información</a>|
                    <a href="${pageContext.request.contextPath}/customer/account/addressbook.jsp">Mis Direcciones</a>|
                    <a href="${pageContext.request.contextPath}/customer/account/wallet.jsp">Mis Tarjetas</a>
                </section>

                <section>
                    <form action="${pageContext.request.contextPath}/controlCliente?action=registrarTarjeta" method="post">

                        <input type="hidden" name="idCliente" value="<%= idCliente %>"><br>

                        <label>¿Cómo te gustaría guardar esta tarjeta?</label>
                        <input type="text" name="nombreTarjeta" required /><br>

                        <label>Metodo de Pago:</label>
                        <select name="metodoPago" required>
                            <option disabled selected type="hidden">Seleccionar opción</option>
                            <option value="1">Visa</option>
                            <option value="2">Mastercard</option>
                            <option value="3">American Express</option>
                        </select><br>

                        <label>Fecha de Expiración:</label>
                        <input type="text" name="fechaExpiracion" required /><br>


                        <label>Tipo:</label>
                        <div>
                            <label>
                                <input type="radio" name="tipoTarjeta" value="1" required/>
                                Crédito
                            </label>

                            <label>
                                <input type="radio" name="tipoTarjeta" value="2" />
                                Débito
                            </label>
                        </div>

                        <label>Número:</label>
                        <input type="text" name="numeroTarjeta" required /><br>

                        <input type="submit" value="Agregar">
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
