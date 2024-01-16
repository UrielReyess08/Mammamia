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
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Menú | Mammamía</title>
        <link rel="preconnect" href="https://fonts.googleapis.com">
        <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
        <link href="https://fonts.googleapis.com/css2?family=Ropa+Sans:ital@1&display=swap" rel="stylesheet">
        <link rel="stylesheet" href="<%=request.getContextPath()%>/estilos/menu.css">
        <link rel="stylesheet" href="<%=request.getContextPath()%>/estilos/popup.css">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css" integrity="sha512-z3gLpd7yknf1YoNbCzqRKc4qyor8gaKU1qmn+CShxbuBusANI9QpRohGBreCFkKxLhei6S9CQXFEbbKuqLg0DA==" crossorigin="anonymous" referrerpolicy="no-referrer" />
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css" integrity="sha384-xOolHFLEh07PJGoPkLv1IbcEPTNtaed2xpHsD9ESMhqIYd0nLMwNLD69Npy4HI+N" crossorigin="anonymous">
    
        
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
            <nav class="navbar navbar-expand-lg">
                <div class="container">
                    <div class="collapse navbar-collapse" id="navbarSupportedContent">
            <ul class="navbar-nav ms-auto">
                <li class="nav-item">
                    <a class="nav-link active" href="${pageContext.request.contextPath}/index.jsp">
                        <img src="..." alt="logo"/> | Inicio
                    </a>
                </li>
                <li class="nav-item">
                    <a class="nav-link active" href="${pageContext.request.contextPath}/menu.jsp">Menú</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link active" href="${pageContext.request.contextPath}/nosotros.jsp">Nosotros</a>
                </li>
                <!-- Menú para cliente -->
                <%
                    if (isLoggedIn) {
                %>
                <li class="nav-item">
                    <a  class="nav-link active" href="${pageContext.request.contextPath}/customer/logout.jsp">Cerrar Sesión</a>
                </li>
                <li>
                    <a class="nav-link active" href="${pageContext.request.contextPath}/customer/account/panel.jsp">Mi Cuenta</a>
                </li>
                <!-- Menú para invitado-->
                <%
                    } else if (isGuest){
                %>
                <li class="nav-item">
                    <a class="nav-link active" href="${pageContext.request.contextPath}/customer/logout.jsp">Iniciar Sesión (Invitado)</a>
                </li>
                <%
                    } else {
                %>
                <li class="nav-item">
                    <a class="nav-link active" href="${pageContext.request.contextPath}/customer/login.jsp">Iniciar Sesión</a>
                </li>
                <%
                    }
                %>
            </ul>
            </div>
        </div>
            </nav>
        </header>

        <main>
            <h1>Menú</h1>
            <article class="container">
                <section class="row">
                    <div class="col-md-6 mb-4">
                        <div class="card">
                            <div class="img-container">
                                <img src="img/Menu/menu-pizza.png" class="card-img-top" alt="Imagen 1">
                            </div>
                            <div class="card-body">
                                <h2 class="card-title">Pizzas</h2>
                                <p>(Disponible)</p>
                                <a href="${pageContext.request.contextPath}/menu/pizzas.jsp" class="btn btn-warning custom-btn">Ver más</a>
                            </div>
                        </div>
                    </div>

                    <div class="col-md-6 mb-4">
                        <div class="card">
                            <div class="img-container">
                                <img src="img/Menu/menu-pastas.png" class="card-img-top" alt="Imagen 4">
                            </div>
                            <div class="card-body">
                                <h2 class="card-title">Pastas</h2>
                                <p>(Disponible)</p>
                                <a href="${pageContext.request.contextPath}/menu/pastas.jsp" class="btn btn-warning custom-btn">Ver más</a>
                            </div>
                        </div>
                    </div>

                    <div class="col-md-6 mb-4">
                        <div class="card">
                            <div class="img-container">
                                <img src="img/Menu/menu-postre.png" class="card-img-top" alt="Imagen 5">
                            </div>
                            <div class="card-body">
                                <h2 class="card-title">Postres</h2>
                                <p>(Disponible)</p>
                                <a href="${pageContext.request.contextPath}/menu/postres.jsp" class="btn btn-warning custom-btn">Ver más</a>
                            </div>
                        </div>
                    </div>

                    <div class="col-md-6 mb-4">
                        <div class="card">
                            <div class="img-container">
                                <img src="img/Menu/menu-bebidas.png" class="card-img-top" alt="Imagen 6">
                                
                            </div>
                            <div class="card-body">
                                <h2 class="card-title">Bebidas</h2>
                                <p>(Disponible)</p>
                                <a href="${pageContext.request.contextPath}/menu/bebidas.jsp" class="btn btn-warning custom-btn">Ver más</a>
                            </div>
                        </div>
                    </div>

                    <!--Inhabilitado-->
                    <div class="col-md-6 mb-4 disable-clicks">
                        <div class="card" style="opacity:0.7">
                            <div class="img-container">
                                <img src="img/Menu/menu-promociones.png" class="card-img-top" alt="Imagen 7">
                            </div>
                            <div class="card-body">
                                <h2 class="card-title">Promociones</h2>
                                <p>Proximamente</p>
                                <button class="btn btn-dark custom-btn" disabled>Ver más</button>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-6 mb-4 disable-clicks">
                        <div class="card" style="opacity:0.7">
                            <div class="img-container">
                                <img src="img/Menu/menu-combos.png" class="card-img-top" alt="Imagen 8">
                            </div>
                            <div class="card-body">
                                <h2 class="card-title">Combos</h2>
                                <p>Proximamente</p>
                                <button class="btn btn-dark custom-btn" disabled>Ver más</button>
                            </div>
                        </div>
                    </div>

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
                            <h5>Enlaces</h5>
                            <div class="footer-links">
                                <a href="#">Local</a><br>
                                <a href="#">Zona reparto</a><br>
                                <a href="#">Nosotros</a><br>
                                <a href="${pageContext.request.contextPath}/views/viewExtras/contacto.jsp">Atención al cliente</a><br>
                                <a href="${pageContext.request.contextPath}/views/viewExtras/preguntas.jsp">Preguntas Frecuentes</a><br>
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
                            <i class="fa-brands fa-cc-visa fa-3x" style="color: #ffffff;" ></i>
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
                                        He leído y revisado los <a class="text-white" href="${pageContext.request.contextPath}/views/viewExtras/terminos.jsp">términos y condiciones</a>
                                    </label>
                                </div>
                                <button type="submit" class="btn btn-primary mb-2">ENVIAR</button>
                            </form>                        
                        </div>
                    </div>
                </div>
            </div>
            <img src="img/img-footer/logo.png" alt="" class="rounded-circle mx-auto d-block img-logo p-3">
            <div class="text-center">
                <hr>
                <span class="text-white">Todos los derechos reservados © <script>document.write(new Date().getFullYear())</script> </span>
            </div>
        </footer>

        <script>
            // Redireccionamiento hacia Menu.jsp
            function closePopup() {
                document.getElementById('popup-container').style.visibility = 'hidden';
                window.location.href = "${pageContext.request.contextPath}/index.jsp";
            }
        </script>
        <script src="https://cdn.jsdelivr.net/npm/jquery@3.5.1/dist/jquery.slim.min.js" integrity="sha384-DfXdz2htPH0lsSSs5nCTpuj/zy4C+OGpamoFVy38MVBnE+IbbVYUew+OrCXaRkfj" crossorigin="anonymous"></script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-Fy6S3B9q64WdZWQUiU+q4/2Lc9npb8tCaSX9FK7E8HnRr0Jz8D6OP9dO5Vg3Q9ct" crossorigin="anonymous"></script>
        </body>
</html>
