<%-- 
    Document   : preguntas
    Created on : 7 ene. 2024, 18:04:37
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
        <title>JSP Page</title>
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
            <h1>Preguntas Frecuentes</h1>
            <article class="...">
                <section>
                    <!-- Firefox no soporta details, al parecer -->
                    <details>
                        <summary>¿Pregunta 1?</summary>
                        <p>Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been 
                            the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley 
                            of type and scrambled it to make a type specimen book.</p>
                    </details>

                    <details>
                        <summary>¿Pregunta 2?</summary>
                        <p>Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been 
                            the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley 
                            of type and scrambled it to make a type specimen book.</p>
                    </details>

                    <details>
                        <summary>¿Pregunta 3?</summary>
                        <p>Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been 
                            the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley 
                            of type and scrambled it to make a type specimen book.</p>
                    </details>
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
