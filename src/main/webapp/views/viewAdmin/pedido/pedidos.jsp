<%-- 
    Document   : pedidos
    Created on : 7 ene. 2024, 20:36:44
    Author     : daiko
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="model.Cliente" %>
<%@page import="model.Usuario" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Pedidos | Mammamía</title>
    </head>
    <body>
        <%
            // Obtener la sesión
            HttpSession sesion = request.getSession(false);
            
            // Obtener la sesion y verificar si el user ha iniciado sesion
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
                    <a href="${pageContext.request.contextPath}/index.jsp">Inicio</a>
                </li>
                <li>
                    <a href="${pageContext.request.contextPath}/views/viewAdmin/pedido/pedidos.jsp">Pedidos</a>
                </li>
                <li>
                    <a href="${pageContext.request.contextPath}/views/viewCliente/login/logout.jsp">Cerrar Sesión</a>
                </li>
                <li>
                    <a href="${pageContext.request.contextPath}/views/viewCliente/cliente/panelUsuario.jsp">Hola <%= nombreSesion %></a>
                </li>
            </ul>
        </header>
        
        <main>
            <h1>Pedidos</h1>
            <article class="...">
                <section>
                    <label>Busca/Filtra el pedido que deseas</label>
                    <input type="text" placeholder="Buscar/Filtrar Pedido">
                    <button>Buscar</button>

                    <table border="1">
                        <thead>
                            <tr>
                                <th>idPedido</th>
                                <th>horaPedido</th>
                                <th>estado</th>
                                <th>total</th>
                                <th>Buttons</th>
                                <th></th>
                            </tr>
                        </thead>
                        <tbody>
                            <tr>
                                <td>1</td>
                                <td>2023-12-28 13:30:00</td>
                                <td>En Preparación</td>
                                <td>25.00</td>
                                <td>
                                    <input type="submit" value="En Preparacion" name="enPreparacion"/>
                                    <input type="submit" value="En Camino" name="enCamino"/>
                                    <input type="submit" value="Entregado" name="entregado"/>
                                </td>
                                <td>
                                    <a href="detallePedido.html">Más Detalles</a>
                                </td>
                            </tr>
                            <tr>
                                <td>2</td>
                                <td>2023-12-28 13:30:00</td>
                                <td>En Camino</td>
                                <td>25.00</td>
                                <td>
                                    <input type="submit" value="En Preparacion" name="enPreparacion"/>
                                    <input type="submit" value="En Camino" name="enCamino"/>
                                    <input type="submit" value="Entregado" name="entregado"/>
                                </td>
                                <td>
                                    <a href="detallePedido.html">Más Detalles</a>
                                </td>
                            </tr>
                            <tr>
                                <td>3</td>
                                <td>2023-12-28 13:30:00</td>
                                <td>Entregado</td>
                                <td>25.00</td>
                                <td>
                                    <input type="submit" value="En Preparacion" name="enPreparacion"/>
                                    <input type="submit" value="En Camino" name="enCamino"/>
                                    <input type="submit" value="Entregado" name="entregado"/>
                                </td>
                                <td>
                                    <a href="detallePedido.html">Más Detalles</a>
                                </td>
                            </tr>
                        </tbody>
                    </table>
                </section>
            </article>
        </main>

        <footer>
            <jsp:include page="/footer.jsp" />
        </footer>
    </body>
</html>
