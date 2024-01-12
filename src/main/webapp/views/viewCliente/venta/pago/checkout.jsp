<%--
  Created by IntelliJ IDEA.
  User: RefinedCandle49
  Date: 11/01/2024
  Time: 18:52
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
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
            <form action="..." method="POST">
                <h2>Dirección:</h2>
                <label>Selecciona tu dirección:</label>
                <select name="...">
                    <option>getDirecciones</option>
                </select><br>
                
                <label>idDireccionCliente</label>
                <input type="text" name="idDireccionCliente" value="" /><br>
                
                <label>idCliente</label>
                <input type="text" name="idCliente" value="" /><br>
                
                <label>direccion</label>
                <input type="text" name="idDireccion" value="" /><br>
                
                <label>tipoVivienda</label>
                <input type="text" name="tipoVivienda" value="" /><br>
                
                <label>referencia</label>
                <input type="text" name="referencia" value="" /><br>
                
                <label>telefono</label>
                <input type="text" name="telefono" value="" /><br>
                
                <h2>Datos Personales:</h2>
                <label>Nombre</label>
                <input type="text" name="nombre" value="" /><br>
                
                <label>Apellido</label>
                <input type="text" name="apellido" value="" /><br>
                
                <label>Email</label>
                <input type="text" name="email" value="" /><br>
                
                <h2>Tarjeta de Pago:</h2>
                <label>Selecciona tu tarjeta:</label>
                <select name="...">
                    <option>getPago</option>
                </select><br>
                
                <label>idTarjetaCliente</label>
                <input type="text" name="idTarjetaCliente" value="" /><br>
                
                <label>idCliente</label>
                <input type="text" name="idCliente" value="" /><br>
                
                <label>metodoPago</label>
                <input type="text" name="metodoPago" value="" /><br>
                
                <label>fechaExpiracion</label>
                <input type="text" name="fechaExpiracion" value="" /><br>
                
                <label>tipoTarjeta</label>
                <input type="text" name="tipoTarjeta" value="" /><br>
                
                <label>numeroTarjeta</label>
                <input type="text" name="numeroTarjeta" value="" /><br>
                
                <input type="submit" value="Finalizar Compra" />
            </form>
        </section>
        
        <section>
            <h2>Detalle del Pedido</h2>
            <table border="1">
                <thead>
                <tr>
                    <th>Producto</th>
                    <th>Cantidad</th>
                    <th>Total</th>
                </tr>
                </thead>
                <tbody>
                <tr>
                    <td>Pizza</td>
                    <td>1</td>
                    <td>35.00</td>
                </tr>
                </tbody>
            </table>
            
            <!-- Esto es solo mientras diseñamos --><a href="resumenPedido.html">Resumen del Pedido</a>
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
