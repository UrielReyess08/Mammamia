<%@ page import="model.carritoCompra" %>
<%@ page import="dao.ProductoDao" %>
<%@ page import="model.producto" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.ArrayList" %><%--
  Created by IntelliJ IDEA.
  User: valde
  Date: 13/06/2023
  Time: 23:04
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <%
        ProductoDao productoDao = new ProductoDao();
        producto p = new producto();
        List<producto> productos = new ArrayList<>();
        
        List<carritoCompra> listaCarrito = new ArrayList<>();
        int item = 0;
        double totalPagar = 0.0;
        int cantidad = 1;
    %>
    <title>Recepción de datos</title>
</head>
<body>
  <%
      int idProducto = Integer.parseInt(request.getParameter("id"));
      p = productoDao.listarId(idProducto);
      item = item + 1;
      carritoCompra car = new carritoCompra();
      car.setItem(item);
      car.setIdProducto(p.getIdProducto());
      car.setNombre(p.getNombre());
      car.setDescripcion(p.getDescripcion());
      car.setPrecio(p.getPrecio());
      car.setCantidad(cantidad);
      car.setSubtotal(cantidad * p.getPrecio());
      listaCarrito.add(car);
      request.setAttribute("contador", listaCarrito.size());
      request.getRequestDispatcher("pizzas.jsp").forward(request, response);
//      String accion = request.getParameter("accion");
//      switch (accion) {
//          case "AgregarCarrito":
//              response.sendRedirect("pizzas.jsp");
//              request.getRequestDispatcher("pizzas.jsp").forward(request, response);
//              break;
//      }
  %>

<%--  <main>
    <h1>Promediooooo</h1>
    <p>Nota 1: <%=nota1%></p>
    <p>Nota 2: <%=nota2%></p>
    <p>Nota 3: <%=nota3%></p>
    <p>Resultado: <%=resultado%></p>
  </main>--%>
    <main>

    
    </main>
<%
//    response.sendRedirect("pizzas.jsp");
    out.println("Hola");
%>
</body>
</html>
