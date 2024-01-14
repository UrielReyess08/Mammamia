<%-- 
    Document   : menu
    Created on : 11 ene. 2024, 11:56:31
    Author     : daiko
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="model.Cliente" %>
<%@page import="jakarta.servlet.http.HttpSession" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Menú | Mammamía</title>
        <link rel="stylesheet" href="estilos/popup.css">
    </head>
    <body>
        <%
            // Obtener la sesión
            HttpSession sesion = request.getSession(false);
            
            // Obtener la sesion para cliente
            Boolean isLoggedIn = (sesion != null && sesion.getAttribute("isLoggedIn") != null && (Boolean) sesion.getAttribute("isLoggedIn"));
            
            // Obtener la sesion para invitado
            Boolean isGuest = (sesion != null && sesion.getAttribute("isGuest") != null && (Boolean) sesion.getAttribute("isGuest"));
            
        %>

        <%
            // PopUp para sesión inactiva
            if (!isLoggedIn && !isGuest) {
        %>
        <!-- Popup Container -->
        <div id="popup-container">
            <div id="popup-content">
                <p>Al registrarte podras disfrutar de todos los beneficios como cliente Mammamía.</p>
                <a href="${pageContext.request.contextPath}/customer/login.jsp">Ingresa o Registrate</a><br>  
                <a href="${pageContext.request.contextPath}/controlLogin?action=continuarComoInvitado">Continuar como Invitado</a>
                <div id="close-popup" onclick="closePopup()">X</div>
            </div>
        </div>
        <%
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
            <h1>Menú</h1>
            <article class="...">
                <section>
                    <div>
                        <h2>Promociones</h2>
                        <p>Proximamente</p>
                    </div>

                    <div>
                        <h2>Combos</h2>
                        <p>Proximamente</p>
                    </div>

                    <div>
                        <h2>Card Pizzas</h2>
                        <a href="${pageContext.request.contextPath}/menu/pizzas.jsp">ver Todos</a>
                    </div>

                    <div>
                        <h2>Card Pastas</h2>
                        <a href="${pageContext.request.contextPath}/menu/pastas.jsp">ver Todos</a>
                    </div>

                    <div>
                        <h2>Card Postres</h2>
                        <a href="${pageContext.request.contextPath}/menu/postres.jsp">ver Todos</a>
                    </div>

                    <div>
                        <h2>Card Bebidas</h2>
                        <a href="${pageContext.request.contextPath}/menu/bebidas.jsp">ver Todos</a>
                    </div>
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

        <script>
            // Redireccionamiento hacia Menu.jsp
            function closePopup() {
                document.getElementById('popup-container').style.visibility = 'hidden';
                window.location.href = "${pageContext.request.contextPath}/index.jsp";
            }
        </script>
    </body>
</html>
