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

        switch (action) {
            case "editar":
                int idProducto = Integer.parseInt(request.getParameter("id"));
                Producto producto = ProductoDao.obtenerProductoPorId(idProducto);
                request.setAttribute("producto", producto);
                request.getRequestDispatcher("/admin/edit/producto.jsp").forward(request, response);
                return;

            case "buscar":
                String idProductoParam = request.getParameter("idProducto");

                if (idProductoParam != null && !idProductoParam.isEmpty()) {
                    try {
                        int idProd = Integer.parseInt(idProductoParam);
                        Producto prodBuscar = ProductoDao.obtenerProductoFiltro(idProd);

                        if (prodBuscar != null) {
                            request.setAttribute("filtroProducto", prodBuscar);
                        } else {
                            request.setAttribute("errorFiltro", "El producto no ha sido encontrado");
                            request.getRequestDispatcher("/admin/inventario.jsp").forward(request, response);
                        }

                    } catch (NumberFormatException e) {
                        request.setAttribute("errorFiltro", "El ID no es válido");
                        request.getRequestDispatcher("/admin/inventario.jsp").forward(request, response);
                    }

                }
                request.getRequestDispatcher("/admin/inventario.jsp").forward(request, response);
                return;

            default:
                request.setAttribute("errorFiltro", "Accion Inválida.");
                request.getRequestDispatcher("/admin/inventario.jsp").forward(request, response);
                return;
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

        switch (action) {
            case "actualizar":
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
                return;

            case "eliminar":
                int idProductoEliminar = Integer.parseInt(request.getParameter("idProducto"));

                Producto productoEliminar = new Producto();
                productoEliminar.setIdProducto(idProductoEliminar);
                productoEliminar.setEstado(0);
                int resultEliminar = ProductoDao.actualizarEstado(productoEliminar);

                response.sendRedirect(request.getContextPath() + "/admin/inventario.jsp");
                return;

            case "registrar":
                int idCategoriaRegistrar = Integer.parseInt(request.getParameter("idCategoria"));
                String nombreRegistrar = request.getParameter("nombre");
                String descripcionRegistrar = request.getParameter("descripcion");
                double precioRegistrar = Double.parseDouble(request.getParameter("precio"));
                int stockRegistrar = Integer.parseInt(request.getParameter("stock"));
                int estadoRegistrar = Integer.parseInt(request.getParameter("estado"));

                Producto productoRegistrar = new Producto();
                productoRegistrar.setIdCategoria(idCategoriaRegistrar);
                productoRegistrar.setNombre(nombreRegistrar);
                productoRegistrar.setDescripcion(descripcionRegistrar);
                productoRegistrar.setPrecio(precioRegistrar);
                productoRegistrar.setStock(stockRegistrar);
                productoRegistrar.setEstado(estadoRegistrar);

                int resultRegistrar = ProductoDao.registrarProducto(productoRegistrar);

                if (resultRegistrar > 0) {
                    response.sendRedirect(request.getContextPath() + "/admin/inventario.jsp");
                } else {
                    response.getWriter().println("Error al actualizar el producto.");
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
