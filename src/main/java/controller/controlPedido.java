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
import java.io.PrintWriter;
import java.util.List;
import model.Pedido;

/**
 *
 * @author daiko
 */
@WebServlet("/ControlPedido") // url del servlet
public class controlPedido extends HttpServlet {

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
        
        // FILTRO REVISAR CODIGO
        // Valor del parámetro idPedido
        String idPedidoParam = request.getParameter("idPedido");

        // Validacion de idPedido
        if (idPedidoParam != null && !idPedidoParam.isEmpty()) {
            try {
                int idPedido = Integer.parseInt(idPedidoParam);

                // Pedido de idPedido
                Pedido pedido = PedidoDao.obtenerPedidoPorId(idPedido);
                
                // Validacion para id no existente
                if(pedido == null){
                    String errorId  = "No existe ningún pedido con ese ID";
                    System.out.println(errorId);
                    request.setAttribute("errorId", errorId);
                }

                // Agregar Pedido
                request.setAttribute("filteredPedido", pedido);
                
            } catch (NumberFormatException e) {
                String errorNumber = "El ID solo acepta números";
                System.out.println(errorNumber);
                
                request.setAttribute("errorNumber", errorNumber);
            }
        }else {
            // Limpiar Pedido
            List<Pedido> listaPedidos = PedidoDao.listarPedidos();
            request.setAttribute("list", listaPedidos);
        }

        // Redireccion
        request.getRequestDispatcher("/admin/pedidos.jsp").forward(request, response);
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

        // Declarar variables
        int idPedido = Integer.parseInt(request.getParameter("idPedido"));
        int nuevoEstado = Integer.parseInt(request.getParameter("newEstado"));

        Pedido pedido = new Pedido();
        pedido.setIdPedido(idPedido);
        pedido.setEstado(nuevoEstado);

        int result = PedidoDao.actualizarEstado(pedido);
        
        // Redireccion
        response.sendRedirect(request.getContextPath() + "/admin/pedidos.jsp");
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
