<%-- 
    Document   : nosotros
    Created on : 11 ene. 2024, 11:45:02
    Author     : daiko
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="model.Cliente" %>
<%@page import="jakarta.servlet.http.HttpSession" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Nosotros | Mammamía</title>
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

        <div class="container">
            <div class="row">
                <div class="col-md-6">
                    <h1>Nosotros</h1>
                    <p>En el corazón de nuestra pizzería late una historia apasionante que ha evolucionado a lo largo de los años. Desde nuestros modestos inicios, hemos cultivado una dedicación inquebrantable por ofrecer la mejor experiencia culinaria a cada uno de nuestros clientes.<br><br>
    
                        Nos consideramos verdaderos artistas, utilizando la cocina como nuestro lienzo y los ingredientes frescos como nuestra paleta de colores. Cada pizza que creamos es una obra maestra en sí misma, una fusión de sabores que despierta los sentidos y deja una impresión duradera.<br><br>
                        
                        En nuestro equipo, encontrarás caras apasionadas y talentosas que comparten un amor común por la buena comida. Cada miembro desempeña un papel crucial en la creación de las delicias que llegan a tu mesa, y todos compartimos la misma misión: ofrecerte una experiencia gastronómica excepcional</p>
                </div>
                <div class="col-md-6">
                
                        <div class="img-container">
                            <img src="/img/nosotros.jpg" class="card-img-top" alt="Imagen 3">
                        </div>
                </div>
            </div>
    
        </div>
    
        <footer class="mt-5">
            <div class="container-fluid mt-3">
                <div class="social-icons">
                    <a href="#"><img src="/img/img-footer/facebook.png" alt="Facebook" class="bi bi-facebook img-icon mt-4"></a>
                    <a href="#"><img src="/img/img-footer/instagram.png" alt="Instagram" class="bi bi-instagram img-icon mt-4"></a>
                    <a href="#"><img src="/img/img-footer/tik-tok.png" alt="TikTok" class="bi bi-tiktok img-icon mt-4"></a>
                </div>
                        
                <div class="container mt-5">
                    <div class="row g-4">
                        <div class="col-lg-3 col-md-6">
                            <h5>Enlaces</h5>
                            <div class="footer-links">
                                <a href="#">Local</a><br>
                                <a href="#">Zona reparto</a><br>
                                <a href="#">Nosotros</a><br>
                                <a href="#">Atención al cliente</a><br>
                                <a href="#">Preguntas Frecuentes</a><br>
                                <a href="#">Mapa de sitio</a>
                            </div>
                        </div>
                        <div class="col-lg-3 col-md-6">
                            <h5>Políticas</h5>
                            <div class="footer-links">
                                <a href="#">Políticas de Datos Personales</a><br>
                                <a href="#">Términos y condiciones de Promociones</a><br>
                                <a href="#">Derechos ARCO</a>
                            </div>
                        </div>
                        <div class="col-lg-3 col-md-6">
                            <h5>FORMAS DE PAGO</h5>
                            <img class="img-fluid" src="/img/img-footer/pagos.png" alt="">
                        </div>
                        <div class="col-lg-3 col-md-6">
                            <form class="small-form">
                                <div class="mb-2">
                                    <input type="text" class="form-control" placeholder="Ingrese su correo" name="email">
                                </div>
                                <div class="mb-2 form-check">
                                    <input class="form-check-input" type="checkbox" name="remember">
                                    <label class="form-check-label">
                                        He leído y revisado los <a class="text-white" href="#">términos y condiciones</a>
                                    </label>
                                </div>
                                <button type="submit" class="btn btn-primary mb-2">ENVIAR</button>
                            </form>                        
                        </div>
                    </div>
                </div>
            </div>
            <img src="/img/img-footer/logo.png" alt="" class="rounded-circle mx-auto d-block img-logo p-3">
            <div class="text-center">
                <hr>
                <span class="text-white">Todos los derechos reservados © <script>document.write(new Date().getFullYear())</script> </span>
            </div>
        </footer>
        
        <script src="https://cdn.jsdelivr.net/npm/jquery@3.5.1/dist/jquery.slim.min.js" integrity="sha384-DfXdz2htPH0lsSSs5nCTpuj/zy4C+OGpamoFVy38MVBnE+IbbVYUew+OrCXaRkfj" crossorigin="anonymous"></script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-Fy6S3B9q64WdZWQUiU+q4/2Lc9npb8tCaSX9FK7E8HnRr0Jz8D6OP9dO5Vg3Q9ct" crossorigin="anonymous"></script>
    </body>
    </html>
    
