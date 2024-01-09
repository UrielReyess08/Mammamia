<%-- 
    Document   : contacto
    Created on : 7 ene. 2024, 18:04:21
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
        <title>Contáctanos | Mammamía</title>
    </head>
    <body>
        <%
            // Obtener la sesión
            HttpSession sesion = request.getSession(false);
            
            // Obtener la sesion y verificar si el cliente ha iniciado sesion
            Boolean isLoggedIn = (sesion != null && sesion.getAttribute("isLoggedIn") != null && (Boolean) sesion.getAttribute("isLoggedIn"));
            
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
    </body>
</html>
