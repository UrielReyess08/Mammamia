<%@page contentType="text/html" pageEncoding="UTF-8" %>
<%@page import="jakarta.servlet.http.HttpSession" %>
<%@page import="model.Usuario, controller.controlCarrito" %>
<%@page import="model.Cliente, model.Producto, model.Direccion, model.Tarjeta" %>
<%@ page import="dao.ProductoDao, dao.ClienteDao" %>
<%@ page import="java.util.List" %>
<html>
<head>
    <%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Ropa+Sans&display=swap" rel="stylesheet">
    <title>Checkout | Mammamía</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css"
          integrity="sha512-z3gLpd7yknf1YoNbCzqRKc4qyor8gaKU1qmn+CShxbuBusANI9QpRohGBreCFkKxLhei6S9CQXFEbbKuqLg0DA=="
          crossorigin="anonymous" referrerpolicy="no-referrer"/>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css"
          integrity="sha384-xOolHFLEh07PJGoPkLv1IbcEPTNtaed2xpHsD9ESMhqIYd0nLMwNLD69Npy4HI+N" crossorigin="anonymous">
    <link rel="stylesheet" href="<%=request.getContextPath()%>/estilos/checkout.css">

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
    
    if (isLoggedIn) {
        Cliente cliente = (Cliente) sesion.getAttribute("cliente");
        idCliente = cliente.getIdCliente();
        nombreCliente = cliente.getNombre();
        apellidoCliente = cliente.getApellido();
        emailCliente = cliente.getEmail();
    } else if (isGuest) {
        idCliente = (int) sesion.getAttribute("idCliente");
    }
%>

<header>
    <nav class="navbar navbar-expand-lg navbar-dark">
        <a class="navbar-brand" href="${pageContext.request.contextPath}/index.jsp">
            <span><img src="${pageContext.request.contextPath}/img/inicio/logo.png" alt="logo" width="30"
                       height="30"></span>
            Mammamia
        </a>
        <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarSupportedContent"
                aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
            <span class="navbar-toggler-icon"></span>
        </button>
        
        <div class="collapse navbar-collapse" id="navbarSupportedContent">
            <ul class="navbar-nav mr-auto">
                <li class="nav-item">
                    <a class="nav-link" href="${pageContext.request.contextPath}/menu.jsp">Menú <span class="sr-only">(current)</span></a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="${pageContext.request.contextPath}/nosotros.jsp">Nosotros <span
                            class="sr-only">(current)</span></a>
                </li>
                <!-- Menú para cliente -->
                <%
                    if (isLoggedIn) {
                %>
                <li class="nav-item">
                    <a class="nav-link" href="${pageContext.request.contextPath}/customer/logout.jsp">Cerrar Sesión
                        <span class="sr-only">(current)</span></a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="${pageContext.request.contextPath}/customer/account/panel.jsp">Mi cuenta
                        <span class="sr-only">(current)</span></a>
                </li>
                <!-- Menú para invitado-->
                <%
                } else if (isGuest) {
                %>
                <li class="nav-item">
                    <a class="nav-link" href="${pageContext.request.contextPath}/customer/logout.jsp">Iniciar Sesión
                        (Invitado) <span class="sr-only">(current)</span></a>
                </li>
                <%
                } else {
                %>
                <li class="nav-item">
                    <a class="nav-link" href="${pageContext.request.contextPath}/customer/login.jsp">Iniciar Sesión</a>
                </li>
                <%
                    }
                %>
            </ul>
        
        </div>
    </nav>
</header>

<main class="container">
    <h1 class="mb-4">Finalizar Compra</h1>
    <div class="row">
        <div class="col-md-6">
            <article class="card p-4">
                <section>
                    <%
                        ClienteDao clienteDao = new ClienteDao();
                        List<Direccion> direcciones = clienteDao.listarDireccionPorId(idCliente);
                        List<Tarjeta> tarjetas = clienteDao.listarTarjetaPorId(idCliente);
                    %>
                    
                    <form action="<%=request.getContextPath()%>/controlCarrito?accion=RealizarPedido" method="POST">
                        <div class="container">
                            <h2>Dirección:</h2>
                            
                            <div class="row">
                                <div class="col-md-6">
                                    <label for="direccionSelect">Seleccionar Dirección:</label>
                                    <select name="idDireccionCliente" id="direccionSelect" class="form-control">
                                        <option value="" disabled selected class="invisible">Seleccionar opción</option>
                                        <% for (Direccion direccion : direcciones) { %>
                                        <option value="<%= direccion.getIdDireccionCliente() %>"
                                                data-direccion="<%= direccion.getDireccion() %>"
                                                data-referencia="<%= direccion.getReferencia() %>"
                                                data-telefono="<%= direccion.getTelefono() %>"
                                                data-tipo-vivienda="<%= direccion.getTipoVivienda() %>">
                                            <%= direccion.getNombreDireccion() %>
                                        </option>
                                        <% } %>
                                    </select>
                                </div>
                                
                                <div class="col-md-6">
                                    
                                    <input type="hidden" name="idCliente" value="<%= idCliente %>"/>
                                </div>
                                
                                <div class="col-md-6">
                                    <label for="receptor">Receptor:</label>
                                    <input type="text" name="receptor" class="form-control">
                                </div>
                                
                                <div class="col-md-6">
                                    <label for="direccion">Dirección a entregar:</label>
                                    <input required type="text" name="direccion" id="direccion" class="form-control">
                                </div>
                                
                                <div class="col-md-6">
                                    <label for="tipoVivienda">Tipo de vivienda:</label>
                                    <select name="tipoVivienda" id="tipoVivienda" class="form-control" required>
                                        <option value="" disabled selected class="invisible">Seleccionar opción</option>
                                        <option disabled selected type="hidden">Seleccionar opción</option>
                                        <option value="1">Departamento</option>
                                        <option value="2">Casa</option>
                                        <option value="3">Condominio</option>
                                        <option value="4">Empresa</option>
                                        <option value="5">Hotel</option>
                                    </select>
                                </div>
                                
                                <div class="col-md-6">
                                    <label for="referencia">Referencia:</label>
                                    <input required type="text" name="referencia" id="referencia" class="form-control">
                                </div>
                                
                                <div class="col-md-6">
                                    <label for="telefono">Teléfono:</label>
                                    <input required type="tel" name="telefono" id="telefono" class="form-control">
                                </div>
                            </div>
                            
                            <h2>Información de pago:</h2>
                            
                            <div class="row">
                                <div class="col-md-6">
                                    <label for="tarjetaSelect">Seleccionar Tarjeta:</label>
                                    <select name="idTarjetaCliente" id="tarjetaSelect" class="form-control">
                                        <option value="" disabled selected class="invisible">Seleccionar opción</option>
                                        <% for (Tarjeta tarjeta : tarjetas) { %>
                                        <option value="<%= tarjeta.getIdTarjetaCliente() %>"
                                                data-metodo="<%= tarjeta.getMetodoPago() %>"
                                                data-fecha="<%= tarjeta.getFechaExpiracion() %>"
                                                data-tipo="<%= tarjeta.getTipoTarjeta() %>"
                                                data-numero="<%= tarjeta.getNumeroTarjeta() %>">
                                            <%= tarjeta.getNombreTarjeta() %>
                                        </option>
                                        <% } %>
                                    </select>
                                </div>
                                
                                <div class="col-md-6">
                                    <fieldset>
                                        <legend>Tipo de tarjeta:</legend>
                                        <div>
                                            <label>
                                                <input type="radio" name="tipoTarjeta" id="tipoTarjetaCredito" value="1"
                                                       required/>
                                                Crédito
                                            </label>
                                            <label>
                                                <input type="radio" name="tipoTarjeta" id="tipoTarjetaDebito"
                                                       value="2"/>
                                                Débito
                                            </label>
                                        </div>
                                    </fieldset>
                                </div>
                                
                                <div class="col-md-6">
                                    <label for="metodoPago">Método de pago:</label>
                                    <select name="metodoPago" id="metodoPago" class="form-control" required>
                                        <option disabled selected type="hidden">Seleccionar opción</option>
                                        <option value="1">Visa</option>
                                        <option value="2">Mastercard</option>
                                        <option value="3">American Express</option>
                                    </select>
                                </div>
                                
                                <div class="col-md-6">
                                    <label for="numeroTarjeta">Número de tarjeta:</label>
                                    <input required type="text" name="numeroTarjeta" id="numeroTarjeta"
                                           class="form-control">
                                </div>
                                
                                <div class="col-md-6">
                                    <label for="fechaExpiracion">Fecha de expiración:</label>
                                    <input type="text" name="fechaExpiracion" id="fechaExpiracion" class="form-control">
                                </div>
                            </div>
                            
                            <div class="d-flex justify-content-center">
                                <input type="submit" class="btn btn-warning mt-4" value="Finalizar Compra"/>
                            </div>
                        </div>
                    </form>
                
                </section>
            </article>
        </div>
        <div class="col-md-6">
            <section class="card p-4 mt-4">
                <h1>Detalle de pedido</h1>
                <table>
                    <thead>
                    <tr>
                        <th>Producto</th>
                        <th>Precio</th>
                        <th>Cantidad</th>
                        <th>SubTotal</th>
                    </tr>
                    </thead>
                    <tbody>
                    <c:forEach var="car" items="${carrito}">
                        <tr>
                            <td>${car.getNombre()}</td>
                            <td>${car.getPrecio()}</td>
                            <td>${car.getCantidad()}</td>
                            <td>${car.getSubtotal()}</td>
                        </tr>
                    
                    </c:forEach>
                    </tbody>
                
                </table>
            </section>
        </div>
    </div>
</main>


<footer class="mt-4">
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
                    <a href="#">Nosotros</a><br>
                    <a href="${pageContext.request.contextPath}/views/viewExtras/contacto.jsp">Atención al
                        cliente</a><br>
                    <a href="${pageContext.request.contextPath}/views/viewExtras/preguntas.jsp">Preguntas Frecuentes</a><br>
                    <a href="#">Mapa de sitio</a>
                </div>
            </div>
            <div class="col-lg-3 col-md-6">
                <h4>Políticas</h4>
                <div class="footer-links">
                    <a href="#">Políticas de Datos Personales</a><br>
                    <a href="#">Términos y condiciones de Promociones</a><br>
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
                                                       href="${pageContext.request.contextPath}/views/viewExtras/terminos.jsp">términos
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
<script>
    document.getElementById('direccionSelect').addEventListener('change', function () {
        var selectedOption = this.options[this.selectedIndex];
        document.getElementById('direccion').value = selectedOption.getAttribute('data-direccion');
        document.getElementById('referencia').value = selectedOption.getAttribute('data-referencia');
        document.getElementById('telefono').value = selectedOption.getAttribute('data-telefono');
        document.getElementById('tipoVivienda').value = selectedOption.getAttribute('data-tipo-vivienda');
    });

    document.getElementById('tarjetaSelect').addEventListener('change', function () {
        var selectedOption = this.options[this.selectedIndex];
        document.getElementById('metodoPago').value = selectedOption.getAttribute('data-metodo');
        document.getElementById('fechaExpiracion').value = selectedOption.getAttribute('data-fecha');

        var tipoTarjeta = selectedOption.getAttribute('data-tipo');
        switch (tipoTarjeta) {
            case '1':
                document.getElementById('tipoTarjetaCredito').checked = true;
                break;
            case '2':
                document.getElementById('tipoTarjetaDebito').checked = true;
                break;
        }
        document.getElementById('numeroTarjeta').value = selectedOption.getAttribute('data-numero');
    });

    document.getElementById('numeroTarjeta').addEventListener('input', function() {
        var numeroTarjeta = this.value.replace(/\s/g, '');
        if (numeroTarjeta.length !== 16) {
            this.setCustomValidity('El número de tarjeta debe tener 16 dígitos');
        } else {
            this.setCustomValidity('');
        }
    });

    document.getElementById('fechaExpiracion').addEventListener('input', function() {
        var fechaExpiracion = this.value;
        var regex = /^(0[1-9]|1[0-2])\/\d{2}$/; // Formato MM/YY
        if (!regex.test(fechaExpiracion)) {
            this.setCustomValidity('El formato de la fecha de expiración debe ser MM/YY');
        } else {
            this.setCustomValidity('');
        }
    });
</script>
<script src="https://cdn.jsdelivr.net/npm/jquery@3.5.1/dist/jquery.slim.min.js"
        integrity="sha384-DfXdz2htPH0lsSSs5nCTpuj/zy4C+OGpamoFVy38MVBnE+IbbVYUew+OrCXaRkfj"
        crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/js/bootstrap.bundle.min.js"
        integrity="sha384-Fy6S3B9q64WdZWQUiU+q4/2Lc9npb8tCaSX9FK7E8HnRr0Jz8D6OP9dO5Vg3Q9ct"
        crossorigin="anonymous"></script>
</body>
</html>