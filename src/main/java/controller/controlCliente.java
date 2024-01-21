package controller;

import java.io.*;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import java.io.IOException;
import model.Cliente;
import model.Direccion;
import model.Tarjeta;
import dao.ClienteDao;

/*import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;*/

@WebServlet(name = "controlCliente", value = "/controlCliente")
public class controlCliente extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request  servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException      if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

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
        String action = request.getParameter("action");

        if ("editarCliente".equals(action)) {
            int idCliente = Integer.parseInt(request.getParameter("id"));
            Cliente cli = ClienteDao.obtenerClientePorId(idCliente);

            request.setAttribute("cli", cli);
            request.getRequestDispatcher("/customer/account/edit.jsp").forward(request, response);

        } else if ("editarDireccion".equals(action)) {
            int idDireccionCliente = Integer.parseInt(request.getParameter("id"));
            Direccion dire = ClienteDao.obtenerDireccionPorId(idDireccionCliente);

            request.setAttribute("dire", dire);

            request.getRequestDispatcher("/customer/account/edit/addressbook.jsp").forward(request, response);
        } else if ("eliminarDireccion".equals(action)) {
            int idDireccionCliente = Integer.parseInt(request.getParameter("id"));
            int result = ClienteDao.eliminarDireccion(idDireccionCliente);

            if (result > 0) {
                response.sendRedirect(request.getContextPath() + "/customer/account/addressbook.jsp");
            } else {
                response.getWriter().println("Error al eliminar la dirección.");
            }
        }   else if ("eliminarTarjeta".equals(action)) {
            int idTarjetaCliente = Integer.parseInt(request.getParameter("id"));
            int result = ClienteDao.eliminarTarjeta(idTarjetaCliente);

            if (result > 0) {
                response.sendRedirect(request.getContextPath() + "/customer/account/wallet.jsp");
            } else {
                response.getWriter().println("Error al eliminar la tarjeta.");
            }
        }
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
        String action = request.getParameter("action");

        if ("registrar".equals(action)) {
            String nombre = request.getParameter("nombre");
            String apellido = request.getParameter("apellido");
            String email = request.getParameter("email");
            String password = request.getParameter("password");

            Cliente cliente = new Cliente();
            cliente.setNombre(nombre);
            cliente.setApellido(apellido);
            cliente.setEmail(email);
            cliente.setPassword(password);

            int result = ClienteDao.registrarCliente(cliente);

            if (result > 0) {
                response.sendRedirect(request.getContextPath() + "/index.jsp");
            } else {
                response.getWriter().println("Error al registrar cliente.");
            }
        } else if ("actualizarCliente".equals(action)) {

            int idCliente = Integer.parseInt(request.getParameter("idCliente"));
            String nombre = request.getParameter("nombre");
            String apellido = request.getParameter("apellido");
            String email = request.getParameter("email");
            String password = request.getParameter("password");

            Cliente cli = new Cliente();
            cli.setIdCliente(idCliente);
            cli.setNombre(nombre);
            cli.setApellido(apellido);
            cli.setEmail(email);
            cli.setPassword(password);

            int result = ClienteDao.actualizarCliente(cli);

            if (result > 0) {
                
                HttpSession sesion = request.getSession(false);
                if (sesion != null) {
                    Cliente clienteActualizado = ClienteDao.obtenerClientePorId(idCliente);
                    sesion.setAttribute("cliente", clienteActualizado);
                }

                response.sendRedirect(request.getContextPath() + "/customer/account/panel.jsp");
                
            } else {
                response.getWriter().println("Error al actualizar la información.");
            }

        } else if ("registrarDireccion".equals(action)) {

            int idCliente = Integer.parseInt(request.getParameter("idCliente"));
            String nombreDireccion = request.getParameter("nombreDireccion");
            String direccion = request.getParameter("direccion");
            int tipoVivienda = Integer.parseInt(request.getParameter("tipoVivienda"));
            String referencia = request.getParameter("referencia");
            String telefono = request.getParameter("telefono");

            Direccion dire = new Direccion();
            dire.setIdCliente(idCliente);
            dire.setNombreDireccion(nombreDireccion);
            dire.setDireccion(direccion);
            dire.setTipoVivienda(tipoVivienda);
            dire.setReferencia(referencia);
            dire.setTelefono(telefono);

            int result = ClienteDao.registrarDireccion(dire);

            if (result > 0) {
                response.sendRedirect(request.getContextPath() + "/customer/account/addressbook.jsp");
            } else {
                response.getWriter().println("Error al reigstrar la direccion.");
            }
        } else if ("actualizarDireccion".equals(action)) {

            int idDireccionCliente = Integer.parseInt(request.getParameter("idDireccionCliente"));
            int idCliente = Integer.parseInt(request.getParameter("idCliente"));
            String nombreDireccion = request.getParameter("nombreDireccion");
            String direccion = request.getParameter("direccion");
            int tipoVivienda = Integer.parseInt(request.getParameter("tipoVivienda"));
            String referencia = request.getParameter("referencia");
            String telefono = request.getParameter("telefono");

            Direccion dire = new Direccion();
            dire.setIdDireccionCliente(idDireccionCliente);
            dire.setIdCliente(idCliente);
            dire.setNombreDireccion(nombreDireccion);
            dire.setDireccion(direccion);
            dire.setTipoVivienda(tipoVivienda);
            dire.setReferencia(referencia);
            dire.setTelefono(telefono);

            int result = ClienteDao.actualizarDireccion(dire);

            if (result > 0) {
                response.sendRedirect(request.getContextPath() + "/customer/account/addressbook.jsp");
            } else {
                response.getWriter().println("Error al actualizar la direccion.");
            }
        }else if ("registrarTarjeta".equals(action)) {

            int idCliente = Integer.parseInt(request.getParameter("idCliente"));
            String nombreTarjeta = request.getParameter("nombreTarjeta");
            int metodoPago = Integer.parseInt(request.getParameter("metodoPago"));
            String fechaExpiracion = request.getParameter("fechaExpiracion");
            int tipoTarjeta = Integer.parseInt(request.getParameter("tipoTarjeta"));
            String numeroTarjeta = request.getParameter("numeroTarjeta");

            Tarjeta tar = new Tarjeta();
            tar.setIdCliente(idCliente);
            tar.setNombreTarjeta(nombreTarjeta);
            tar.setMetodoPago(metodoPago);
            tar.setFechaExpiracion(fechaExpiracion);
            tar.setTipoTarjeta(tipoTarjeta);
            tar.setNumeroTarjeta(numeroTarjeta);

            int result = ClienteDao.registrarTarjeta(tar);

            if (result > 0) {
                response.sendRedirect(request.getContextPath() + "/customer/account/wallet.jsp");
            } else {
                response.getWriter().println("Error al registrar la tarjeta.");
            }
        }
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