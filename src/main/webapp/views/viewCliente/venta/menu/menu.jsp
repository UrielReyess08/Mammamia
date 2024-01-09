<%-- 
    Document   : menu
    Created on : 6 ene. 2024, 16:15:58
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
        <title>Menú | Mammamía</title>
    </head>
    <body>
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
                        <a href="${pageContext.request.contextPath}//views/viewCliente/venta/menu/categorias/pizzas.jsp">Ver Todos</a>
                    </div>

                    <div>
                        <h2>Card Pastas</h2>
                        <a href="${pageContext.request.contextPath}/views/viewCliente/venta/menu/categorias/pastas.jsp">ver Todos</a>
                    </div>

                    <div>
                        <h2>Card Postres</h2>
                        <a href="${pageContext.request.contextPath}/views/viewCliente/venta/menu/categorias/postres.jsp">ver Todos</a>
                    </div>

                    <div>
                        <h2>Card Bebidas</h2>
                        <a href="${pageContext.request.contextPath}/views/viewCliente/venta/menu/categorias/bebidas.jsp">ver Todos</a>
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
    </body>
</html>
