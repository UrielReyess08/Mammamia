/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import dao.CategoriaDao;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;
import model.Categoria;

/**
 *
 * @author daiko
 */
@WebServlet("/ControlCategoria")
public class controlCategoria extends HttpServlet {

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
        String idCategoriaStr = request.getParameter("idCategoria");
        String newNombre = request.getParameter("nombre");
        String newDescripcion = request.getParameter("descripcion");

        if (idCategoriaStr != null && newNombre != null && newDescripcion != null) {
            try {
                int idCategoria = Integer.parseInt(idCategoriaStr);

                Categoria categoria = new Categoria();
                categoria.setIdCategoria(idCategoria);
                categoria.setNombre(newNombre);
                categoria.setDescripcion(newDescripcion);

                int result = CategoriaDao.actualizarCategoria(categoria);
                if (result > 0) {
                    response.sendRedirect(request.getContextPath() + "/admin/categorias.jsp");
                }

            } catch (Exception e) {
                request.setAttribute("errorCategoria", "Error al actualizar la categoría.");
                request.getRequestDispatcher("/admin/categorias.jsp").forward(request, response);
            }
        }
        request.setAttribute("errorCategoria", "Error al actualizar la categoría.");
        request.getRequestDispatcher("/admin/categorias.jsp").forward(request, response);
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
