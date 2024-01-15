<%-- 
    Document   : index
    Created on : 11 ene. 2024, 11:40:09
    Author     : daiko
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="model.Cliente" %>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Inicio | Mammamía</title>
        <link rel="preconnect" href="https://fonts.googleapis.com">
        <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
        <link href="https://fonts.googleapis.com/css2?family=Ropa+Sans:ital@1&display=swap" rel="stylesheet">
        <link rel="stylesheet" href="estilos/index.css">
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
                </li class="nav-item">
                <!-- Menú para cliente -->
                <%
                    if (isLoggedIn) {
                %>
                <li class="nav-item">
                    <a  class="nav-link active" href="${pageContext.request.contextPath}/customer/logout.jsp">Cerrar Sesión</a>
                </li>
                <li class="nav-item">
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

        <div class="img-container">
            <a href=""><img src="/img/promocion.jpg" class="rounded mx-auto d-block img-fluid"></a>
        </div>
        
        <!-- Card -->
        <div class="container mt-5 text-warning">
            <h1>Promociones de pizza Online</h1>
            <div class="row justify-content-center">
          
              <!-- Primera Fila de Tarjetas -->
              
              <div class="col-md-4 mb-4">
                <div class="card">
                    <img src="img/inicio/pizza-barbacoa.png" class="card-img-top" alt="Imagen 1" height="250px">
                    <div class="card-body">
                        <!-- Contenido de la Tarjeta 1 -->
                        <h5 class="card-title">Pizza Barbacoa</h5>
                        <p class="card-text">Pizza al estilo de california pizza margherita tomate, pizza s, comida, queso</p>
                        <button class="btn btn-dark">Comprar</button>
                    </div>
                </div>
            </div>
            
          
              <div class="col-md-4 mb-4">
                <div class="card">
                  <img src="img/inicio/pizza-siciliana.png" class="card-img-top" alt="Imagen 2" height="250px">
                  <div class="card-body">
                    <!-- Contenido de la Tarjeta 2 -->
                    <h5 class="card-title">Pizza Siciliana</h5>
                    <p class="card-text">Pizza al estilo de california pizza margherita tomate, pizza s, comida, queso.</p>
                    <button class="btn btn-dark">Comprar</button>
                </div>
                </div>
              </div>
          
              <div class="col-md-4 mb-4">
                <div class="card">
                  <img src="img/inicio/pizza-margherita.png" class="card-img-top" alt="Imagen 3" height="250px">
                  <div class="card-body">
                    <!-- Contenido de la Tarjeta 3 -->
                    <h5 class="card-title">Pizza margherita</h5>
                    <p class="card-text">sushi pizza pizza repartida, pizza, comida, queso</p>
                    <button class="btn btn-dark">Comprar</button>
                </div>
                </div>
              </div>
              <!-- Fin Primera Fila -->
          
              <!-- Segunda Fila de Tarjetas -->
              <div class="col-md-4 mb-4">
                <div class="card">
                  <img src="img/inicio/pizza-tocino.png" class="card-img-top" alt="Imagen 4" height="250px">
                  <div class="card-body">
                    <!-- Contenido de la Tarjeta 4 -->
                    <h5 class="card-title">Pizza Tocino</h5>
                    <p class="card-text">tocino cocina italiana restaurante, pizza, comida, receta, queso</p>
                    <button class="btn btn-dark">Comprar</button>
                </div>
                </div>
              </div>
          
              <div class="col-md-4 mb-4">
                <div class="card">
                  <img src="img/inicio/pizza-peperoni.png" class="card-img-top" alt="Imagen 5" height="250px">
                  <div class="card-body">
                    <!-- Contenido de la Tarjeta 5 -->
                    <h5 class="card-title">Pizza Pepperoni</h5>
                    <p class="card-text">Sabor incomparable de pepperoni americano y queso mozzarella</p>
                    <button class="btn btn-dark">Comprar</button>
                </div>
                </div>
              </div>
          
              <div class="col-md-4 mb-4">
                <div class="card">
                  <img src="img/inicio/pizza-estilocalifornia.png" class="card-img-top" alt="Imagen 6" height="250px">
                  <div class="card-body">
                    <!-- Contenido de la Tarjeta 6 -->
                    <h5 class="card-title">Pizza estilo california</h5>
                    <p class="card-text">pizza al estilo de california, margherita sushi, pizza, comida, queso</p>
                    <button class="btn btn-dark">Comprar</button>
                </div>
                </div>
              </div>
            </div>
          </div>

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
        <script src="https://cdn.jsdelivr.net/npm/jquery@3.5.1/dist/jquery.slim.min.js" integrity="sha384-DfXdz2htPH0lsSSs5nCTpuj/zy4C+OGpamoFVy38MVBnE+IbbVYUew+OrCXaRkfj" crossorigin="anonymous"></script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-Fy6S3B9q64WdZWQUiU+q4/2Lc9npb8tCaSX9FK7E8HnRr0Jz8D6OP9dO5Vg3Q9ct" crossorigin="anonymous"></script>
        </body>
</html>