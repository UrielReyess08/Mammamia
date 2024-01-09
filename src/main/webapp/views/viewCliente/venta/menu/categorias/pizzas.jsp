<%-- 
    Document   : pizzas
    Created on : 6 ene. 2024, 16:17:35
    Author     : daiko
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="model.Cliente" %>
<%@page import="model.Usuario" %>
<%@page import="jakarta.servlet.http.HttpSession" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Pizzería | Mammamía</title>
        <style>
            #popup-container {
                display: flex;
                align-items: center;
                justify-content: center;
                position: fixed;
                top: 0;
                left: 0;
                width: 100%;
                height: 100%;
                background: rgba(0, 0, 0, 0.5);
                z-index: 999;
                visibility: visible;
            }

            #popup-content {
                background: #fff;
                padding: 20px;
                border-radius: 10px;
                text-align: center;
            }

            #close-popup {
                position: absolute;
                top: 10px;
                right: 10px;
                cursor: pointer;
            }
        </style>
    </head>
    <body>
        <%
            // Obtener la sesión
            HttpSession sesion = request.getSession(false);
            
            // Obtener la sesion y verificar si el cliente ha iniciado sesion
            Boolean isLoggedIn = (sesion != null && sesion.getAttribute("isLoggedIn") != null && (Boolean) sesion.getAttribute("isLoggedIn"));
            
            //Boolean isInvitado = (sesion != null && sesion.getAttribute("isInvitado") != null && (Boolean) sesion.getAttribute("isInvitado"));
            
            // Declarar variable para nombre de user de sesion
            String nombreSesion = "";
            
            if(isLoggedIn){
                Object userSession = sesion.getAttribute("usuario");
                
                if(userSession != null){
                    nombreSesion = ((Usuario) userSession).getRol();
                }else{
                    nombreSesion = ((Cliente) sesion.getAttribute("cliente")).getNombre();
                }
            }
            
        %>

        <%
            // Pop up por si no hay sesión activa
            if (!isLoggedIn) {
        %>
        <!-- Popup Container -->
        <div id="popup-container">
            <div id="popup-content">
                <p>Al registrarte podras disfrutar de todos los beneficios como cliente Mammamía.</p>
                <a href="${pageContext.request.contextPath}/views/viewCliente/login/loginCliente.jsp">Ingresa o Registrate</a><br>  
                <a href="${pageContext.request.contextPath}/Control?action=continuarComoInvitado"">Continuar como Invitado</a>
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
                    <a href="${pageContext.request.contextPath}/views/viewCliente/venta/menu/menu.jsp">Menú</a>
                </li>
                <li>
                    <a href="${pageContext.request.contextPath}/views/viewExtras/nosotros.jsp">Nosotros</a>
                </li>
                <%
                    if (isLoggedIn) {
                %>
                <li>
                    <a href="${pageContext.request.contextPath}/views/viewCliente/login/logout.jsp">Cerrar Sesión</a>
                </li>
                <li>
                    <a href="${pageContext.request.contextPath}/views/viewCliente/cliente/panelUsuario.jsp">Hola <%= nombreSesion %></a>
                </li>
                <%
                    } else {
                %>
                <li>
                    <a href="${pageContext.request.contextPath}/views/viewCliente/login/loginCliente.jsp">Iniciar Sesión</a>
                </li>
                <%
                    }
                %>
            </ul>
        </header>

        <main>
            <h1>¡Disfruta de nuestra variedad de Pizzas!</h1>
            <article class="...">
                <section>
                    <a href="menuPizzas.html">Pizzas</a>|
                    <a href="menuPastas.html">Pastas</a>|
                    <a href="menuPostres.html">Postres</a>|
                    <a href="menuBebidas.html">Bebidas</a>
                </section>

                <section>
                    <div class="card" style="width: 18rem;">
                        <img class="card-img-top" src="..." alt="img_pizza_1">
                        <div class="card-body">
                            <h5 class="card-title">Pizza 1</h5>
                            <p class="card-text">Precio</p>
                            <a href="#" class="btn btn-primary">Añadir Producto</a>|
                            <a href="../../pago/carritoCompras.html">Ver Carrito</a>
                        </div>
                    </div>

                    <div class="card" style="width: 18rem;">
                        <img class="card-img-top" src="..." alt="img_pizza_2">
                        <div class="card-body">
                            <h5 class="card-title">Pizza 2</h5>
                            <p class="card-text">Precio</p>
                            <a href="#" class="btn btn-primary">Añadir Producto</a>|
                            <a href="../../pago/carritoCompras.html">Ver Carrito</a>
                        </div>
                    </div>

                    <div class="card" style="width: 18rem;">
                        <img class="card-img-top" src="..." alt="img_pizza_3">
                        <div class="card-body">
                            <h5 class="card-title">Pizza 3</h5>
                            <p class="card-text">Precio</p>
                            <a href="#" class="btn btn-primary">Añadir Producto</a>|
                            <a href="../../pago/carritoCompras.html">Ver Carrito</a>
                        </div>
                    </div>

                    <div class="card" style="width: 18rem;">
                        <img class="card-img-top" src="..." alt="img_pizza_4">
                        <div class="card-body">
                            <h5 class="card-title">Pizza 4</h5>
                            <p class="card-text">Precio</p>
                            <a href="#" class="btn btn-primary">Añadir Producto</a>|
                            <a href="../../pago/carritoCompras.html">Ver Carrito</a>
                        </div>
                    </div>

                    <div class="card" style="width: 18rem;">
                        <img class="card-img-top" src="..." alt="img_pizza_5">
                        <div class="card-body">
                            <h5 class="card-title">Pizza 5</h5>
                            <p class="card-text">Precio</p>
                            <a href="#" class="btn btn-primary">Añadir Producto</a>|
                            <a href="../../pago/carritoCompras.html">Ver Carrito</a>
                        </div>
                    </div>

                    <div class="card" style="width: 18rem;">
                        <img class="card-img-top" src="..." alt="img_pizza_6">
                        <div class="card-body">
                            <h5 class="card-title">Pizza 6</h5>
                            <p class="card-text">Precio</p>
                            <a href="#" class="btn btn-primary">Añadir Producto</a>|
                            <a href="../../pago/carritoCompras.html">Ver Carrito</a>
                        </div>
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
                    <a href="${pageContext.request.contextPath}/views/viewExtras/terminos.jsp">Terminos y Condiciones</a>
                </li>
                <li>
                    <a href="${pageContext.request.contextPath}/views/viewExtras/contacto.jsp">Atención al Cliente</a>
                </li>
                <li>
                    <a href="${pageContext.request.contextPath}/views/viewExtras/preguntas.jsp">Preguntas Frecuentes</a>
                </li>
            </ul>
        </footer>

        <script>
            // Redireccionamiento hacia Menu.jsp
            function closePopup() {
                document.getElementById('popup-container').style.visibility = 'hidden';
                window.location.href = "${pageContext.request.contextPath}/views/viewCliente/venta/menu/menu.jsp";
            }
        </script>
    </body>
</html>
