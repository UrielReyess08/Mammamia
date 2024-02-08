<%-- 
    Document   : addressbook
    Created on : 14 ene. 2024, 18:00:52
    Author     : daiko
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta name="viewport" content="w<idth=device-width, initial-scale=1, shrink-to-fit=no">
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Mis Direcciones | Mammamía</title>
        <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
        <link href="https://fonts.googleapis.com/css2?family=Ropa+Sans&display=swap" rel="stylesheet">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css"
          integrity="sha512-z3gLpd7yknf1YoNbCzqRKc4qyor8gaKU1qmn+CShxbuBusANI9QpRohGBreCFkKxLhei6S9CQXFEbbKuqLg0DA=="
          crossorigin="anonymous" referrerpolicy="no-referrer"/>
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css"
          integrity="sha384-xOolHFLEh07PJGoPkLv1IbcEPTNtaed2xpHsD9ESMhqIYd0nLMwNLD69Npy4HI+N" crossorigin="anonymous">
        
        <link rel="stylesheet" href="<%=request.getContextPath()%>/estilos/index.css">
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
        <%  
                   ClienteDao clienteDao = new ClienteDao();
                   List<Direccion> direcciones = clienteDao.listarDireccionPorId(idCliente);
                   request.setAttribute("list",direcciones);
        %>
        <main class="text-center">
            <h1>Mis Direcciones</h1>
            <article class="...">
                <section>
                    <div class="container">
                        <ul class="nav nav-tabs nav-justified">
                            <li class="nav-item">
                                <a href="${pageContext.request.contextPath}/customer/account/panel.jsp">Panel de mi Cuenta</a>
                            </li>
                            <li class="nav-item">
                                <a href="${pageContext.request.contextPath}/controlCliente?action=editarCliente&id=<%= idCliente %>">Editar Información</a>
                            </li>
                            <li class="nav-item">
                                <a href="${pageContext.request.contextPath}/controlCliente?action=editarCliente&id=<%= idCliente %>">Editar Información</a>
                            </li>
                            <li class="nav-item">
                                <a href="${pageContext.request.contextPath}/customer/account/wallet.jsp">Mis Tarjetas</a>
                            </li>
                        </ul>
                    </div>
                </section>
                            
                   <br>
                <section>
                    <a class="btn btn-primary" href="${pageContext.request.contextPath}/customer/account/register/addressbook.jsp">Agregar Nueva Dirección</a>
                    
                    <c:if test="${empty list}">
                                
                        <p class="mt-2">No hay direcciones.</p>
                    </c:if>
                       
                    <c:if test="${not empty list}">
                        <div class="table-responsive">
                            <table border="1" class="container mt-3">
                            <thead class="bg-warning">
                                <tr>
                                    <th>N°</th>
                                    <th>NOMBRE</th>
                                    <th>DIRECCIÓN</th>
                                    <th>TIPO DE VIVIENDA</th>
                                    <th>REFERENCIA</th>
                                    <th>TELEFONO</th>
                                </tr>
                            </thead>

                            <tbody>
                                <c:forEach items="${list}" var="dire">
                                    <tr>
                                        <td>${dire.getIdDireccionCliente()}</td>
                                        <td>${dire.getNombreDireccion()}</td>
                                        <td>${dire.getDireccion()}</td>
                                        <td>
                                            <c:choose>
                                                <c:when test="${dire.getTipoVivienda() == 1}">Departamento</c:when>
                                                <c:when test="${dire.getTipoVivienda() == 2}">Casa</c:when>
                                                <c:when test="${dire.getTipoVivienda() == 3}">Condominio</c:when>
                                                <c:when test="${dire.getTipoVivienda() == 4}">Empresa</c:when>
                                                <c:when test="${dire.getTipoVivienda() == 5}">Hotel</c:when>
                                                <c:otherwise>Desconocido</c:otherwise>
                                            </c:choose>
                                        </td>
                                        <td>${dire.getReferencia()}</td>
                                        <td>${dire.getTelefono()}</td>
                                        <td>
                                            <a class="btn btn-success btn-sm" href="${pageContext.request.contextPath}/controlCliente?action=editarDireccion&id=${dire.getIdDireccionCliente()}">Modificar</a>
                                            <a class="btn btn-danger btn-sm" href="${pageContext.request.contextPath}/controlCliente?action=eliminarDireccion&id=${dire.getIdDireccionCliente()}">Eliminar</a>
                                        </td>
                                    </tr>
                                </c:forEach>
                            </tbody>
                        </table>
                        </div>
                    </c:if> 

                </section>
            </article>
        </main>    
          <br>
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
                    <a href="${pageContext.request.contextPath}/views/viewExtras/contacto.jsp">Atención al
                        cliente</a><br>
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
                <h5>Formas de pago</h5>
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
    </body>
</html>
