package controller;

import java.io.*;

import dao.UsuarioDao;
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

        switch (action) {
            case "editarCliente":
                int idCliente = Integer.parseInt(request.getParameter("id"));
                Cliente cli = ClienteDao.obtenerClientePorId(idCliente);

                request.setAttribute("cli", cli);
                request.getRequestDispatcher("/customer/account/edit.jsp").forward(request, response);
                return;

            case "editarDireccion":
                int idDireccionCliente = Integer.parseInt(request.getParameter("id"));
                Direccion dire = ClienteDao.obtenerDireccionPorId(idDireccionCliente);

                request.setAttribute("dire", dire);
                request.getRequestDispatcher("/customer/account/edit/addressbook.jsp").forward(request, response);
                return;

            case "eliminarDireccion":
                int idDireccionEliminar = Integer.parseInt(request.getParameter("id"));
                int result = ClienteDao.eliminarDireccion(idDireccionEliminar);

                if (result > 0) {
                    response.sendRedirect(request.getContextPath() + "/customer/account/addressbook.jsp");
                }
                return;

            case "eliminarTarjeta":
                int idTarjetaEliminar = Integer.parseInt(request.getParameter("id"));
                int resultEliminar = ClienteDao.eliminarTarjeta(idTarjetaEliminar);

                if (resultEliminar > 0) {
                    response.sendRedirect(request.getContextPath() + "/customer/account/wallet.jsp");
                } else {
                    response.getWriter().println("Error al eliminar la tarjeta.");
                }
                return;
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

        switch (action) {
            case "registrar":
                String nombre = request.getParameter("nombre");
                String apellido = request.getParameter("apellido");
                String email = request.getParameter("email");
                String password = request.getParameter("password");

                UsuarioDao usuarioDao = new UsuarioDao();
                if (usuarioDao.emailUsuario(email)) {
                    request.setAttribute("errorRegistro", "Correo no válido.");
                    request.getRequestDispatcher("/customer/register.jsp").forward(request, response);
                    return;
                }

                Cliente cliRegistrar = new Cliente();
                cliRegistrar.setNombre(nombre);
                cliRegistrar.setApellido(apellido);
                cliRegistrar.setEmail(email);
                cliRegistrar.setPassword(password);

                int resultRegistrar = ClienteDao.registrarCliente(cliRegistrar);

                if (resultRegistrar > 0) {
                    response.sendRedirect(request.getContextPath() + "/customer/login.jsp");
                } else {
                    request.setAttribute("errorRegistro", "Error al crear la cuenta.");
                    request.getRequestDispatcher("/customer/register.jsp").forward(request, response);
                }
                return;

            case "actualizarCliente":
                int idCli = Integer.parseInt(request.getParameter("idCliente"));
                String nombreCli = request.getParameter("nombre");
                String apellidoCli = request.getParameter("apellido");
                String emailCli = request.getParameter("email");
                String passwordCli = request.getParameter("password");

                Cliente cliActualizar = new Cliente();
                cliActualizar.setIdCliente(idCli);
                cliActualizar.setNombre(nombreCli);
                cliActualizar.setApellido(apellidoCli);
                cliActualizar.setEmail(emailCli);
                cliActualizar.setPassword(passwordCli);

                int resultActualizar = ClienteDao.actualizarCliente(cliActualizar);

                if (resultActualizar > 0) {

                    HttpSession sesion = request.getSession(false);
                    if (sesion != null) {
                        Cliente clienteActualizado = ClienteDao.obtenerClientePorId(idCli);
                        sesion.setAttribute("cliente", clienteActualizado);
                    }

                    response.sendRedirect(request.getContextPath() + "/customer/account/panel.jsp");

                } else {

                    cliActualizar = ClienteDao.obtenerClientePorId(idCli);
                    request.setAttribute("cli", cliActualizar);
                    
                    request.setAttribute("errorActualizarCli", "Error al actualizar la información.");
                    request.getRequestDispatcher("/customer/account/edit.jsp").forward(request, response);
                }

                return;

            case "registrarDireccion":
                int idCliente = Integer.parseInt(request.getParameter("idCliente"));
                String nombreDireccion = request.getParameter("nombreDireccion");
                String direccion = request.getParameter("direccion");
                int tipoVivienda = Integer.parseInt(request.getParameter("tipoVivienda"));
                String referencia = request.getParameter("referencia");
                String telefono = request.getParameter("telefono");

                Direccion direRegistrar = new Direccion();
                direRegistrar.setIdCliente(idCliente);
                direRegistrar.setNombreDireccion(nombreDireccion);
                direRegistrar.setDireccion(direccion);
                direRegistrar.setTipoVivienda(tipoVivienda);
                direRegistrar.setReferencia(referencia);
                direRegistrar.setTelefono(telefono);

                int resultRegistarDire = ClienteDao.registrarDireccion(direRegistrar);

                if (resultRegistarDire > 0) {
                    response.sendRedirect(request.getContextPath() + "/customer/account/addressbook.jsp");
                } else {
                    request.setAttribute("errorRegistrarDire", "Error al registrar la dirección.");
                    request.getRequestDispatcher("/customer/account/register/addressbook.jsp").forward(request, response);
                }

                return;

            case "actualizarDireccion":
                int idDireCliente = Integer.parseInt(request.getParameter("idDireccionCliente"));
                int idClienteDire = Integer.parseInt(request.getParameter("idCliente"));
                String nombreDire = request.getParameter("nombreDireccion");
                String direCliente = request.getParameter("direccion");
                int tipoViviendaDire = Integer.parseInt(request.getParameter("tipoVivienda"));
                String referenciaDire = request.getParameter("referencia");
                String telefonoDire = request.getParameter("telefono");

                Direccion direActualizar = new Direccion();
                direActualizar.setIdDireccionCliente(idDireCliente);
                direActualizar.setIdCliente(idClienteDire);
                direActualizar.setNombreDireccion(nombreDire);
                direActualizar.setDireccion(direCliente);
                direActualizar.setTipoVivienda(tipoViviendaDire);
                direActualizar.setReferencia(referenciaDire);
                direActualizar.setTelefono(telefonoDire);

                int resultAcualizarDire = ClienteDao.actualizarDireccion(direActualizar);

                if (resultAcualizarDire > 0) {
                    response.sendRedirect(request.getContextPath() + "/customer/account/addressbook.jsp");
                } else {
                    
                    direActualizar = ClienteDao.obtenerDireccionPorId(idDireCliente);
                    request.setAttribute("dire", direActualizar);
                    
                    request.setAttribute("errorActualizarDire", "Error al actualizar la dirección.");
                    request.getRequestDispatcher("/customer/account/edit/addressbook.jsp").forward(request, response);
                }
                return;

            case "registrarTarjeta":
                int idClienteTar = Integer.parseInt(request.getParameter("idCliente"));
                String nombreTar = request.getParameter("nombreTarjeta");
                int metodoPagoTar = Integer.parseInt(request.getParameter("metodoPago"));
                String fechaExpTar = request.getParameter("fechaExpiracion");
                int tipoTar = Integer.parseInt(request.getParameter("tipoTarjeta"));
                String numeroTar = request.getParameter("numeroTarjeta");

                Tarjeta tar = new Tarjeta();
                tar.setIdCliente(idClienteTar);
                tar.setNombreTarjeta(nombreTar);
                tar.setMetodoPago(metodoPagoTar);
                tar.setFechaExpiracion(fechaExpTar);
                tar.setTipoTarjeta(tipoTar);
                tar.setNumeroTarjeta(numeroTar);

                int resultRegistrarTar = ClienteDao.registrarTarjeta(tar);

                if (resultRegistrarTar > 0) {
                    response.sendRedirect(request.getContextPath() + "/customer/account/wallet.jsp");
                } else {
                    //FALTA ACTUALIZAR
                    response.getWriter().println("Error al registrar la tarjeta.");
                }
                return;
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