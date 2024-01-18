package controller;

import dao.PedidoDao;
import dao.ProductoDao;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.Carrito;
import model.Pedido;
import model.Producto;

import java.io.IOException;
import java.io.PrintWriter;
import java.text.DecimalFormat;
import java.util.ArrayList;
import java.util.List;

@WebServlet(name = "controlCarrito", value = "/controlCarrito")
public class controlCarrito extends HttpServlet {

    ProductoDao productoDao = new ProductoDao();
    Producto p = new Producto();
//    List<Producto> Productos = new ArrayList<>();

//    List<Carrito> listaCarrito = new ArrayList<>();

    int item;
    double totalPagar = 0.0;
    int cantidad = 1;
    double subtotal;

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

//        Mantener los productos del carrito guardados en el navegador
        HttpSession sessionCart = request.getSession();
        List<Carrito> listaCarrito = (List<Carrito>) sessionCart.getAttribute("carrito");
        if (listaCarrito == null) {
            listaCarrito = new ArrayList<>();
            sessionCart.setAttribute("carrito", listaCarrito);
        }

        DecimalFormat df = new DecimalFormat("#.##");
        String accion = request.getParameter("accion");

        String menu = null;
        int categoria = 0;

        switch (accion) {
            case "AgregarCarrito":
                int pos = 0;
                cantidad = 1;
                int idProducto = Integer.parseInt(request.getParameter("id"));
                p = productoDao.listarId(idProducto);

                if (listaCarrito.size() > 0) {
                    for (int i = 0; i < listaCarrito.size(); i++) {
                        if (idProducto == listaCarrito.get(i).getIdProducto()) {
                            pos = i;
                        }
                    }
                    if (idProducto == listaCarrito.get(pos).getIdProducto()) {
                        categoria = p.getIdCategoria();
                        cantidad = listaCarrito.get(pos).getCantidad() + cantidad;
                        double subtotal = listaCarrito.get(pos).getPrecio() * cantidad;
                        listaCarrito.get(pos).setCantidad(cantidad);
                        String subtotalString = df.format(subtotal);
                        listaCarrito.get(pos).setSubtotal(Double.parseDouble(subtotalString));
                        double totalPagar = 0.0;
                        for (int i = 0; i < listaCarrito.size(); i++) {
                            totalPagar = totalPagar + listaCarrito.get(i).getSubtotal();
                        }
                        request.setAttribute("totalPagar", totalPagar);
//                        listaCarrito.get(pos).setSubtotal(subtotal);

                    } else {
                        item = item + 1;
                        categoria = p.getIdCategoria();
                        Carrito car = new Carrito();
                        car.setItem(item);
                        car.setIdProducto(p.getIdProducto());
                        car.setNombre(p.getNombre());
                        car.setPrecio(p.getPrecio());
                        car.setCantidad(cantidad);
                        double subtotal = cantidad * p.getPrecio();
                        String subtotalString = df.format(subtotal);
                        car.setSubtotal(Double.parseDouble(subtotalString));

//                        car.setSubtotal(cantidad * p.getPrecio());
                        listaCarrito.add(car);
                    }

                } else {
                    item = item + 1;
                    categoria = p.getIdCategoria();
                    Carrito car = new Carrito();
                    car.setItem(item);
                    car.setIdProducto(p.getIdProducto());
                    car.setNombre(p.getNombre());
                    car.setPrecio(p.getPrecio());
                    car.setCantidad(cantidad);
                    double subtotal = cantidad * p.getPrecio();

                    String subtotalString = df.format(subtotal);
                    car.setSubtotal(Double.parseDouble(subtotalString));

//                    car.setSubtotal(cantidad * p.getPrecio());
                    listaCarrito.add(car);

                }

                request.setAttribute("contador", listaCarrito.size());
                switch (categoria) {
                    case 1:
                        menu = "pizzas.jsp";
                        break;
                    case 2:
                        menu = "bebidas.jsp";
                        break;
                    case 3:
                        menu = "pastas.jsp";
                        break;
                    case 4:
                        menu = "postres.jsp";
                        break;
                }
                String retorno = "menu/";
                request.getRequestDispatcher(retorno + menu).forward(request, response);
                break;

            case "Delete":
//                totalPagar = 0.0;
                int idproducto = Integer.parseInt(request.getParameter("idp"));
                for (int i = 0; i < listaCarrito.size(); i++) {
                    if (listaCarrito.get(i).getIdProducto() == idproducto) {
                        listaCarrito.remove(i);
                    }

                }
//                request.setAttribute("totalPagar", totalPagar);
                request.getRequestDispatcher("controlCarrito?accion=Carrito").forward(request, response);

                break;

            case "ActualizarCantidad":
                idProducto = Integer.parseInt(request.getParameter("id"));
                int cant = Integer.parseInt(request.getParameter("cantidad"));
                for (int j = 0; j < listaCarrito.size(); j++) {
                    if (listaCarrito.get(j).getIdProducto() == idProducto) {
                        listaCarrito.get(j).setCantidad(cant);
                        double subtotal = listaCarrito.get(j).getPrecio() * cant;
                        String subtotalString = df.format(subtotal);
                        listaCarrito.get(j).setSubtotal(Double.parseDouble(subtotalString));
//                        listaCarrito.get(j).setSubtotal(listaCarrito.get(j).getPrecio() * cant);
                    }
                }
                break;

            case "Carrito":
                totalPagar = 0.0;
                listaCarrito = (List<Carrito>) sessionCart.getAttribute("carrito");
                request.setAttribute("carrito", listaCarrito);
                if (listaCarrito.isEmpty()) {
//                    request.getRequestDispatcher("views/viewCliente/venta/pago/carrito.jsp").forward(request, response);
                    totalPagar = 0.0;
                    request.setAttribute("totalPagar", totalPagar);
                } else {
                    for (int i = 0; i < listaCarrito.size(); i++) {
                        totalPagar = totalPagar + listaCarrito.get(i).getSubtotal();
                    }
                    request.setAttribute("totalPagar", totalPagar);
                }

                request.getRequestDispatcher("carrito.jsp").forward(request, response);
                break;

            case "RealizarPedido":
                String receptor, direccion, referencia, telefono, fechaExpiracion, numeroTarjeta;
                int estado, tipoVivienda, metodoPago, tipoTarjeta, idCliente;
                listaCarrito = (List<Carrito>) sessionCart.getAttribute("carrito");
                PedidoDao dao = new PedidoDao();
                tipoVivienda = Integer.parseInt(request.getParameter("tipoVivienda"));
                metodoPago = Integer.parseInt(request.getParameter("metodoPago"));
                tipoTarjeta = Integer.parseInt(request.getParameter("tipoTarjeta"));
                idCliente = Integer.parseInt(request.getParameter("idCliente"));
                receptor = request.getParameter("receptor");
                direccion = request.getParameter("direccion");
                referencia = request.getParameter("referencia");
                telefono = request.getParameter("telefono");
                fechaExpiracion = request.getParameter("fechaExpiracion");
                numeroTarjeta = request.getParameter("numeroTarjeta");

                Pedido pedido = new Pedido(tipoVivienda, metodoPago, tipoTarjeta, 1, idCliente, listaCarrito, receptor, direccion, referencia, telefono, fechaExpiracion, numeroTarjeta, totalPagar);
                int res = dao.generarPedido(pedido);
                request.getRequestDispatcher("controlCarrito?accion=ResumenPedido").forward(request, response);
                break;

            case "ResumenPedido":
                listaCarrito = (List<Carrito>) sessionCart.getAttribute("carrito");
                request.getRequestDispatcher("order.jsp").forward(request, response);
                listaCarrito.clear();
                break;

            case "FinalizarCompra":
                request.getRequestDispatcher("menu.jsp").forward(request, response);
                break;

            default:
//                String page = request.getParameter("menu");
                String url = "menu.jsp";
                request.getRequestDispatcher(url).forward(request, response);
        }

        response.setContentType("text/html;charset=UTF-8");
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}