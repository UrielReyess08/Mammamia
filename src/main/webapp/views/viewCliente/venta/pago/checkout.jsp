<%@page contentType="text/html" pageEncoding="UTF-8" %>
<%@page import="model.Cliente" %>
<%@page import="model.Usuario, controller.controlCarrito" %>
<%@page import="jakarta.servlet.http.HttpSession" %>
<%@ page import="dao.ProductoDao" %>
<%@ page import="model.Producto" %>
<%@ page import="java.util.List" %>
<html>
<head>
    <%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
    <title>Checkout</title>
</head>
<body>
<header>
    <ul>
        <li>
            <a href="../../../index.html">
                <img src="..." alt="logo"/>
                PIZZERÍA MAMMAMÍA
            </a>
        </li>
        <li>
            <a href="../menu/menu.html">Menú</a>
        </li>
        <li>
            <a href="../../../viewExtra/nosotros.html">Nosotros</a>
        </li>
        <li>
            <a href="../../../viewCliente/loginCliente.html">Iniciar Sesión</a>
        </li>
        <li>
            <a href="../../../viewCliente/cliente/panelUsuario.html">Mi Cuenta</a>
        </li>
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
            <form action="<%=request.getContextPath()%>/controlCarrito?accion=RealizarPedido" method="POST">
                <h2>Dirección:</h2>
<%--                <label>--%>
                    Selecciona tu dirección:
<%--                    <select name="">--%>
<%--                        <option>getDirecciones</option>--%>
<%--                    </select>--%>
<%--                </label>--%>
                
                <label>
                    idCliente
                    <input type="number" name="idCliente"/>
                </label>
                
                <label>
                    Receptor:
                    <input type="text" name="receptor">
                </label>
                
                <label>
                    Dirección a entregar:
                    <input required type="text" name="direccion"/>
                </label>
                
                <label>
                    Tipo de vivienda:
                    <select name="tipoVivienda" required>
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
                    <input required type="text" name="referencia"/>
                </label>
<%--                --%>
                <label>
                    Teléfono:
                    <input required type="tel" name="telefono"/>
                </label>
                
                <h2>Información de pago:</h2>
                
<%--                <label>--%>
<%--                    Selecciona tarjeta:--%>
<%--                    <select name="">--%>
<%--                        <option>getDirecciones</option>--%>
<%--                    </select>--%>
<%--                </label>--%>
                
                <fieldset>
                    <legend>Tipo de tarjeta:</legend>
                    <div>
                        
                        <label>
                            <input type="radio" name="tipoTarjeta" value="1" required/>
                            Crédito
                        </label>
                        
                        <label>
                            <input type="radio" name="tipoTarjeta" value="2" />
                            Débito
                        </label>
                    </div>
                </fieldset>
                
                <label>
                    Método de pago
                    <select name="metodoPago" required>
                        <option disabled selected type="hidden">Seleccionar opción</option>
                        <option value="1">Visa</option>
                        <option value="2">Mastercard</option>
                        <option value="3">American Express</option>
                    </select>
                </label>
                
                <label>
                    Número de tarjeta:
                    <input required type="text" name="numeroTarjeta"/>
                </label>
                
                <label>
                    Fecha de expiración:
                    <input type="text" name="fechaExpiracion">
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
</body>
</html>
