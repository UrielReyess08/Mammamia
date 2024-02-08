/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import dao.PedidoDao;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import model.Pedido;

/**
 *
 * @author daiko
 */
@WebServlet("/ControlEntrega") // url del servlet
public class controlEntrega extends HttpServlet {

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

        String idPedidoParam = request.getParameter("idPedido");
        String action = request.getParameter("action");

        try {
            int idPedido = Integer.parseInt(idPedidoParam);

            switch (action) {
                case "confirmarEntrega":
                    Pedido pedConfirmar = new Pedido();
                    pedConfirmar.setIdPedido(idPedido);
                    pedConfirmar.setEstado(3);
                    int resultConfirmar = PedidoDao.actualizarEstado(pedConfirmar);

                    response.sendRedirect(request.getContextPath() + "/admin/entregas.jsp");
                    return;

                case "buscarEntrega":
                    int estado = PedidoDao.obtenerEstadoPedido(idPedido);

                    switch (estado) {
                        case 1:
                            Pedido pedBuscar = new Pedido();
                            pedBuscar.setIdPedido(idPedido);
                            pedBuscar.setEstado(2);
                            int resultBuscar = PedidoDao.actualizarEstado(pedBuscar);

                            response.sendRedirect(request.getContextPath() + "/admin/detalleEntrega.jsp?idPedido=" + idPedido);
                            return;

                        case -1:
                            request.setAttribute("errorEntrega", "El Pedido no ha sido encontrado.");
                            request.getRequestDispatcher("/admin/entregas.jsp").forward(request, response);
                            return;

                        default:
                            request.setAttribute("errorEntrega", "El Pedido ha sido entregado.");
                            request.getRequestDispatcher("/admin/entregas.jsp").forward(request, response);
                            return;
                    }
                default:
                    request.setAttribute("errorEntrega", "Accion Inválida.");
                    request.getRequestDispatcher("/admin/entregas.jsp").forward(request, response);
                    return;
            }
        } catch (NumberFormatException e) {
            request.setAttribute("errorEntrega", "El código no es válido.");
            request.getRequestDispatcher("/admin/entregas.jsp").forward(request, response);
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
