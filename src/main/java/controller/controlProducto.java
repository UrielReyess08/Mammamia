/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import dao.ProductoDao;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import model.Producto;

/**
 *
 * @author daiko
 */
@WebServlet("/ControlProducto")
public class controlProducto extends HttpServlet {

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
        String action = request.getParameter("action");

        if ("editar".equals(action)) {
            int idProducto = Integer.parseInt(request.getParameter("id"));
            Producto producto = ProductoDao.obtenerProductoPorId(idProducto);

            request.setAttribute("producto", producto);

            request.getRequestDispatcher("/admin/edit/producto.jsp").forward(request, response);
        }

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
        String action = request.getParameter("action");

        if ("actualizar".equals(action)) {
            int idProducto = Integer.parseInt(request.getParameter("idProducto"));
            int idCategoria = Integer.parseInt(request.getParameter("idCategoria"));
            String nombre = request.getParameter("nombre");
            String descripcion = request.getParameter("descripcion");
            double precio = Double.parseDouble(request.getParameter("precio"));
            int stock = Integer.parseInt(request.getParameter("stock"));
            int estado = Integer.parseInt(request.getParameter("estado"));

            Producto producto = new Producto();
            producto.setIdProducto(idProducto);
            producto.setIdCategoria(idCategoria);
            producto.setNombre(nombre);
            producto.setDescripcion(descripcion);
            producto.setPrecio(precio);
            producto.setStock(stock);
            producto.setEstado(estado);

            int result = ProductoDao.actualizarProducto(producto);

            if (result > 0) {
                response.sendRedirect(request.getContextPath() + "/admin/inventario.jsp");
            } else {
                response.getWriter().println("Error al actualizar el producto.");
            }

        } else if ("eliminar".equals(action)) {
            int idProducto = Integer.parseInt(request.getParameter("idProducto"));

            Producto producto = new Producto();
            producto.setIdProducto(idProducto);
            producto.setEstado(0);
            int result = ProductoDao.actualizarEstado(producto);

            response.sendRedirect(request.getContextPath() + "/admin/inventario.jsp");

        } else if ("registrar".equals(action)) {
            int idCategoria = Integer.parseInt(request.getParameter("idCategoria"));
            String nombre = request.getParameter("nombre");
            String descripcion = request.getParameter("descripcion");
            double precio = Double.parseDouble(request.getParameter("precio"));
            int stock = Integer.parseInt(request.getParameter("stock"));
            int estado = Integer.parseInt(request.getParameter("estado"));
            
            Producto producto = new Producto();
            producto.setIdCategoria(idCategoria);
            producto.setNombre(nombre);
            producto.setDescripcion(descripcion);
            producto.setPrecio(precio);
            producto.setStock(stock);
            producto.setEstado(estado);
            
            int result = ProductoDao.registrarProducto(producto);
            
            if (result > 0) {
                response.sendRedirect(request.getContextPath() + "/admin/inventario.jsp");
            } else {
                response.getWriter().println("Error al actualizar el producto.");
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
