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

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        List<Carrito> listaCarrito = (List<Carrito>) session.getAttribute("carrito");
        if (listaCarrito == null) {
            listaCarrito = new ArrayList<>();
            session.setAttribute("carrito", listaCarrito);
        }


        String accion = request.getParameter("accion");
        switch (accion) {
            case "AgregarCarrito":
                int idProducto = Integer.parseInt(request.getParameter("id"));
                p = productoDao.listarId(idProducto);
                item = item + 1;
                Carrito car = new Carrito();
                car.setNombre(p.getNombre());
                car.setPrecio(p.getPrecio());
                listaCarrito.add(car);
                request.setAttribute("contador", listaCarrito.size());
                request.getRequestDispatcher("controlCarrito?accion=Home").forward(request, response);
//                response.sendRedirect("pack/pizzas.jsp");
//
                break;
            case "Carrito":
                totalPagar = 0.0;
                int number1 = 50;
                listaCarrito = (List<Carrito>) session.getAttribute("carrito");
                request.setAttribute("carrito", listaCarrito);
                request.setAttribute("number10", number1);
                request.getRequestDispatcher("/pack/carrito.jsp").forward(request, response);
                break;

            default:
                request.getRequestDispatcher("/pack/second/pizzas.jsp").forward(request, response);
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

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">

    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request  servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException      if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request  servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException      if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}