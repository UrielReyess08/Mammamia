package controller;

import dao.ProductoDao;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.Carrito;
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

                if (listaCarrito.size() > 0){
                    for (int i = 0; i < listaCarrito.size(); i++) {
                        if (idProducto == listaCarrito.get(i).getIdProducto()){
                            pos = i;
                        }
                    }
                    if (idProducto == listaCarrito.get(pos).getIdProducto()){
                        categoria = p.getIdCategoria();
                        cantidad = listaCarrito.get(pos).getCantidad()+cantidad;
                        double subtotal = listaCarrito.get(pos).getPrecio()*cantidad;
                        listaCarrito.get(pos).setCantidad(cantidad);
                        String subtotalString = df.format(subtotal);
                        listaCarrito.get(pos).setSubtotal(Double.parseDouble(subtotalString));
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
                String retorno = "views/viewCliente/venta/menu/categorias/";
                request.getRequestDispatcher(retorno + menu).forward(request, response);
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
                int number1 = 50;
                listaCarrito = (List<Carrito>) sessionCart.getAttribute("carrito");
                request.setAttribute("carrito", listaCarrito);
                request.setAttribute("number10", number1);
                request.getRequestDispatcher("views/viewCliente/venta/pago/carrito.jsp").forward(request, response);
                break;

            default:
//                String page = request.getParameter("menu");
                String url = "views/viewCliente/venta/menu";
                request.getRequestDispatcher(url).forward(request, response);
        }

        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet direcServlet</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet direcServlet at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
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