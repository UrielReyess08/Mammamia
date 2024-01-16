<%@page contentType="text/html" pageEncoding="UTF-8" %>
<%@page import="jakarta.servlet.http.HttpSession" %>
<%@page import="model.Usuario, controller.controlCarrito" %>
<%@page import="model.Cliente, model.Producto, model.Direccion, model.Tarjeta" %>
<%@ page import="dao.ProductoDao, dao.ClienteDao" %>
<%@ page import="java.util.List" %>
<html>
<head>
    <%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
    <title>Checkout | Mammamía</title>
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
    <h1>Finalizar Compra</h1>
    <article class="...">
        <section>
            <h1>Resumen del pedido</h1>
            <table border="1">
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

            <%
                ClienteDao clienteDao = new ClienteDao();
                List<Direccion> direcciones = clienteDao.listarDireccionPorId(idCliente);
                List<Tarjeta> tarjetas = clienteDao.listarTarjetaPorId(idCliente);
            %>

            <form action="<%=request.getContextPath()%>/controlCarrito?accion=RealizarPedido" method="POST">
                <h2>Dirección:</h2>

                <label>Seleccionar Dirección:</label>
                <select name="idDireccionCliente" id="direccionSelect">
                    <% for (Direccion direccion : direcciones) { %>
                    <option value="<%= direccion.getIdDireccionCliente() %>"
                            data-direccion="<%= direccion.getDireccion() %>"
                            data-referencia="<%= direccion.getReferencia() %>"
                            data-telefono="<%= direccion.getTelefono() %>"
                            data-tipo-vivienda="<%= direccion.getTipoVivienda() %>">
                            <%= direccion.getNombreDireccion() %>
                    </option>
                    <% } %>
                </select><br>
                
                <label>
                    <input type="hidden" name="idCliente" value="<%= idCliente %>"/>
                </label>
                
                <label>
                    Receptor:
                    <input type="text" name="receptor">
                </label>
                
                <label>
                    Dirección a entregar:
                    <input required type="text" name="direccion" id="direccion"/>
                </label>
                
                <label>
                    Tipo de vivienda:
                    <select name="tipoVivienda" id="tipoVivienda" required>
                        <option disabled selected type="hidden">Seleccionar opción</option>
                        <option value="1">Departamento</option>
                        <option value="2">Casa</option>
                        <option value="3">Condominio</option>
                        <option value="4">Empresa</option>
                        <option value="5">Hotel</option>
                    </select>
                </label>
                
                <label>
                    Referencia:
                    <input required type="text" name="referencia" id="referencia"/>
                </label>

                <label>
                    Teléfono:
                    <input required type="tel" name="telefono" id="telefono"/>
                </label>
                
                <h2>Información de pago:</h2>
                
                <label>Seleccionar Tarjeta:</label>
                <select name="idTarjetaCliente" id="tarjetaSelect">
                    <% for (Tarjeta tarjeta : tarjetas) { %>
                    <option value="<%= tarjeta.getIdTarjetaCliente() %>"
                            data-metodo="<%= tarjeta.getMetodoPago() %>"
                            data-fecha="<%= tarjeta.getFechaExpiracion() %>"
                            data-tipo="<%= tarjeta.getTipoTarjeta() %>"
                            data-numero="<%= tarjeta.getNumeroTarjeta() %>">
                    <%= tarjeta.getNombreTarjeta() %>
                    </option>
                    <% } %>
                </select><br>
                
                <fieldset>
                    <legend>Tipo de tarjeta:</legend>
                    <div>
                        <label>
                            <input type="radio" name="tipoTarjeta" id="tipoTarjetaCredito" value="1" required/>
                            Crédito
                        </label>

                        <label>
                            <input type="radio" name="tipoTarjeta" id="tipoTarjetaDebito" value="2" />
                            Débito
                        </label>
                    </div>
                </fieldset>
                
                <label>
                    Método de pago
                    <select name="metodoPago" id="metodoPago" required>
                        <option disabled selected type="hidden">Seleccionar opción</option>
                        <option value="1">Visa</option>
                        <option value="2">Mastercard</option>
                        <option value="3">American Express</option>
                    </select>
                </label>
                
                <label>
                    Número de tarjeta:
                    <input required type="text" name="numeroTarjeta" id="numeroTarjeta"/>
                </label>
                
                <label>
                    Fecha de expiración:
                    <input type="text" name="fechaExpiracion" id="fechaExpiracion"/>
                </label>
                
                <input type="submit" value="Finalizar Compra"/>
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
            <a href="../../../viewExtra/terminos.html">Terminos y Condiciones</a>
        </li>
        <li>
            <a href="../../../viewExtra/contacto.html">Atención al Cliente</a>
        </li>
        <li>
            <a href="../../../viewExtra/preguntas.html">Preguntas Frecuentes</a>
        </li>
    </ul>
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
</script>
</body>
</html>
