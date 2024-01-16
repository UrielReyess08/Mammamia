package controller;

import java.io.*;

import dao.ClienteDao;
import dao.UsuarioDao;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import model.Cliente;
import model.Usuario;

@WebServlet(name = "controlLogin", value = "/controlLogin")
public class controlLogin extends HttpServlet {
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Validación para invitados
        String action = request.getParameter("action");

        if ("continuarComoInvitado".equals(action)) {
            ClienteDao daoCliente = new ClienteDao();
            Cliente invitado = daoCliente.obtenerClienteInvitado();

            if (invitado != null) {
                HttpSession session = request.getSession();
                session.setAttribute("cliente", invitado);
                session.setAttribute("isGuest", true);

                String redirectPage = (String) session.getAttribute("redirectPage");
                if (redirectPage != null) {
                    response.sendRedirect(redirectPage);
                } else {
                    response.sendRedirect(request.getContextPath() + "/menu.jsp");
                }
            }
        } else {
            // Parametros del form
            String email = request.getParameter("email");
            String password = request.getParameter("password");

            // Validación para administradores
            UsuarioDao daoUsuario = new UsuarioDao();
            Usuario usuario = new Usuario();
            usuario.setEmail(email);
            usuario.setPassword(password);

            if (daoUsuario.validarUsuario(usuario)) {
                HttpSession session = request.getSession();
                session.setAttribute("usuario", usuario);

                String rol = usuario.getRol();
                if ("Encargado Ventas".equals(rol)) {
                    response.sendRedirect(request.getContextPath() + "/admin/pedidos.jsp");
                } else if ("Encargado Almacen".equals(rol)) {
                    response.sendRedirect(request.getContextPath() + "/admin/inventario.jsp"); // Página para administradores de almacén
                } else if ("Repartidor".equals(rol)) {
                    response.sendRedirect(request.getContextPath() + "/admin/entregas.jsp"); // Página para repartidores
                }
                return;
            }

            // Validación para clientes
            ClienteDao daoCliente = new ClienteDao();
            Cliente cliente = new Cliente();
            cliente.setEmail(email);
            cliente.setPassword(password);

            if (daoCliente.validarCliente(cliente)) {
                HttpSession session = request.getSession();
                session.setAttribute("cliente", cliente);
                session.setAttribute("isLoggedIn", true);

                String redirectPage = (String) session.getAttribute("redirectPage");
                if (redirectPage != null) {
                    response.sendRedirect(redirectPage);
                } else {
                    response.sendRedirect("index.jsp");
                }
            } else {
                HttpSession session = request.getSession();
                session.setAttribute("error", "Credenciales Inválidas");
                response.sendRedirect(request.getContextPath() + "/customer/login.jsp");
            }
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