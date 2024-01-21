<%--
  Created by IntelliJ IDEA.
  User: RefinedCandle49
  Date: 20/01/2024
  Time: 16:25
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@page import="model.Cliente, conexion.Conexion, dao.ClienteDao, java.util.*"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Editar Información | Mammamía</title>
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
            
      if(isLoggedIn){
        Cliente cliente = (Cliente) sesion.getAttribute("cliente");
        idCliente = cliente.getIdCliente();
        nombreCliente = cliente.getNombre();
        apellidoCliente = cliente.getApellido();
        emailCliente = cliente.getEmail();
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
        <section>
          <a href="${pageContext.request.contextPath}/customer/account/panel.jsp">Panel de mi Cuenta</a>|
          <a href="${pageContext.request.contextPath}/controlCliente?action=editarCliente&id=<%= idCliente %>">Editar Información</a>|
          <a href="${pageContext.request.contextPath}/customer/account/addressbook.jsp">Mis Direcciones</a>|
          <a href="${pageContext.request.contextPath}/customer/account/wallet.jsp">Mis Tarjetas</a>
        </section>

        <section>
          <a href="${pageContext.request.contextPath}/customer/account/panel.jsp">Regresar</a>
          <h1>Editar Información</h1>
                    
          <form action="${pageContext.request.contextPath}/controlCliente?action=actualizarCliente" method="post">
                    
            <input type="text" name="idCliente" value="<%= idCliente %>"><br>
                        
            <label>Nombres:</label>
            <input type="text" name="nombre" value="${cli.nombre}"><br>
                        
            <label>Apellidos:</label>
            <input type="text" name="apellido" value="${cli.apellido}"><br>
                        
            <label>Correo Electrónico:</label>
            <input type="text" name="email" value="${cli.email}"><br>
                        
            <label>Contraseña:</label>
            <input type="text" name="password" value="${cli.password}"><br>
                        
            <input type="submit" value="Editar">
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
          <a href="${pageContext.request.contextPath}/terminos-condiciones.jsp">Terminos y Condiciones</a>
        </li>
        <li>
          <a href="${pageContext.request.contextPath}/contacto.jsp">Atención al Cliente</a>
        </li>
        <li>
          <a href="${pageContext.request.contextPath}/preguntas-frecuentes.jsp">Preguntas Frecuentes</a>
        </li>
      </ul>
    </footer>
  </body>
</html>
