/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import dao.DAO_Cliente;
import dao.DAO_Usuario;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.Cliente;
import model.Usuario;

import java.io.IOException;

/**
 *
 * @author daiko
 */
public class Control extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession existingSession = request.getSession(false);
        if (existingSession != null) {
            existingSession.invalidate();
        }

        String action = request.getParameter("action");

        if ("continuarComoInvitado".equals(action)) {
            DAO_Cliente daoCliente = new DAO_Cliente();
            Cliente invitado = daoCliente.obtenerClienteInvitado();

            if (invitado != null) {
                HttpSession session = request.getSession();
                session.setAttribute("cliente", invitado);
                session.setAttribute("isLoggedIn", true);

                String redirectPage = (String) session.getAttribute("redirectPage");
                if (redirectPage != null) {
                    response.sendRedirect(redirectPage);
                } else {
                    response.sendRedirect(request.getContextPath() + "/views/viewCliente/venta/menu/categorias/bebidas.jsp");
                }
            } else {
                response.sendRedirect(request.getContextPath() + "/error.jsp");//CREAR JSP DE ERROR
            }
        } else {
            // Parametros del form
            String email = request.getParameter("email");
            String password = request.getParameter("password");

            // Validación para usuarios administradores
            DAO_Usuario daoUsuario = new DAO_Usuario();
            Usuario usuario = new Usuario();
            usuario.setEmail(email);
            usuario.setPassword(password);

            if (daoUsuario.validar(usuario)) {
                HttpSession session = request.getSession();
                session.setAttribute("usuario", usuario);
                session.setAttribute("isLoggedIn", true);

                String rol = usuario.getRol();
                if ("EncargadoWeb".equals(rol)) {
                    response.sendRedirect(request.getContextPath() + "/views/viewAdmin/pedido/pedidos.jsp");
                } else if ("EncargadoAlmacen".equals(rol)) {
                    response.sendRedirect(request.getContextPath() + "..."); // Página para administradores de almacén
                } else if ("Repartidor".equals(rol)) {
                    response.sendRedirect(request.getContextPath() + "..."); // Página para repartidores
                }
                return;
            }

            
            // clientes
            // Objeto DAO
            DAO_Cliente daoCliente = new DAO_Cliente();
            // Objeto Cliente
            Cliente cliente = new Cliente();
            cliente.setEmail(email);
            cliente.setPassword(password);

            

            // Validacion
            if (daoCliente.validar(cliente)) {
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
                response.sendRedirect(request.getContextPath() + "/views/viewCliente/login/loginCliente.jsp");

                //request.setAttribute("error", "Credenciales Inválidas");
                //request.getRequestDispatcher("viewCliente/loginCliente.jsp").forward(request, response);
            }
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
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
