<%-- 
    Document   : contacto
    Created on : 11 ene. 2024, 11:44:55
    Author     : daiko
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="model.Cliente" %>
<%@page import="jakarta.servlet.http.HttpSession" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Contáctanos | Mammamía</title>
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
            <article class="...">
                <h1>Contáctate con nosotros</h1>
                <p>Al llenar el formulario autoriza el tratamiento de sus datos personales</p>
                <section>
                    <form method="POST">
                        <label>Nombre</label><br>
                        <input type="text" name="nombre" value="" /><br>

                        <label>Email</label><br>
                        <input type="text" name="email" value="" /><br>

                        <label>Teléfono</label><br>
                        <input type="text" name="telefono" value="" /><br>

                        <label>Motivo</label><br>
                        <select name="motivo">
                            <option>-- Seleccione --</option>
                            <option>Sugerencia</option>
                            <option>Reclamo</option>
                            <option>Consulta</option>
                        </select><br>

                        <label>Comentarios</label><br>
                        <textarea name="comentario" rows="5" cols="10"></textarea><br>

                        <input type="submit" value="Enviar" />
                    </form>
                </section>
            </article>
        </main>

        <footer>
            <div class="container-fluid mt-3">
                <div class="social-icons">
                    <i class="fa-brands fa-facebook-f fa-2x" style="color: #ffffff; margin-right: 10px;"></i>
                    <i class="fa-brands fa-instagram fa-2x" style="margin-right: 10px;"></i>
                    <i class="fa-brands fa-tiktok fa-2x"></i>
                </div>
            </div>
            
            
            <div class="container mt-5">
                <div class="row g-4">
                    <div class="col-lg-3 col-md-6">
                        <h4>Enlaces</h4>
                        <div class="footer-links">
                            <a href="#">Local</a><br>
                            <a href="#">Zona reparto</a><br>
                            <a href="${pageContext.request.contextPath}/nosotros.jsp">Nosotros</a><br>
                            <a href="">Atención al
                                cliente</a><br>
                            <a href="${pageContext.request.contextPath}/preguntas-frecuentes.jsp">Preguntas Frecuentes</a><br>
                            <a href="#">Mapa de sitio</a>
                        </div>
                    </div>
                    <div class="col-lg-3 col-md-6">
                        <h4>Políticas</h4>
                        <div class="footer-links">
                            <a href="#">Políticas de Datos Personales</a><br>
                            <a href="${pageContext.request.contextPath}/terminos-condiciones.jsp">Términos y condiciones de Promociones</a><br>
                            <a href="#">Derechos ARCO</a>
                        </div>
                    </div>
                    <div class="col-lg-3 col-md-6">
                        <h4>Formas de pago</h4>
                        <i class="fa-brands fa-cc-visa fa-3x" style="color: #ffffff;"></i>
                        <i class="fa-brands fa-cc-mastercard fa-3x" style="color: #ffffff;"></i>
                        <i class="fa-brands fa-cc-amex fa-3x" style="color: #ffffff;"></i>
                    </div>
                    <div class="col-lg-3 col-md-6">
                        <form class="small-form">
                            <div class="mb-2">
                                <input type="text" class="form-control" placeholder="Ingrese su correo" name="email">
                            </div>
                            <div class="mb-2 form-check">
                                <input class="form-check-input" type="checkbox" name="remember">
                                <label class="form-check-label">
                                    He leído y revisado los <a class="text-white"
                                                               href="${pageContext.request.contextPath}/terminos-condiciones.jsp">términos
                                    y condiciones</a>
                                </label>
                            </div>
                            <button type="submit" class="btn btn-primary mb-2">ENVIAR</button>
                        </form>
                    </div>
                </div>
            </div>
            <img src="${pageContext.request.contextPath}/img/inicio/logo.png" alt="" class="mx-auto d-block img-logo p-3">
            <div class="text-center">
                <hr>
                <span class="text-white">Todos los derechos reservados © <script>document.write(new Date().getFullYear())</script> </span>
            </div>
        </footer>
    </body>
</html>
