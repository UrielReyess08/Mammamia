/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dao;

import static conexion.Conexion.getConnection;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;
import model.DetallePedido;
import model.Producto;

/**
 *
 * @author daiko
 */
public class ReportesDao {

    public static List<Producto> obtenerInventario() {
        List<Producto> listaInventario = new ArrayList<Producto>();
        try {
            Connection con = getConnection();
            PreparedStatement ps = con.prepareStatement("SELECT idProducto, nombre, stock FROM producto ORDER BY idProducto ASC;");
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                Producto prod = new Producto();
                prod.setIdProducto(rs.getInt("idProducto"));
                prod.setNombre(rs.getString("nombre"));
                prod.setStock(rs.getInt("stock"));
                listaInventario.add(prod);
            }
        } catch (Exception e) {
            System.out.println(e);
        }
        return listaInventario;
    }

    public int obtenerCantidadClienteRegistrados() {
        int cantClientes = 0;
        try {
            Connection con = getConnection();
            PreparedStatement ps = con.prepareStatement("SELECT COUNT(idCliente) FROM cliente WHERE idCliente <> 1;");
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                cantClientes = rs.getInt(1);
            }

        } catch (Exception e) {
            System.out.println(e);
        }
        return cantClientes;
    }

    public int obtenerCantidadPedidoClientesRegistrados() {
        int cantPedRegistrados = 0;
        try {
            Connection con = getConnection();
            PreparedStatement ps = con.prepareStatement("SELECT COUNT(idCliente) FROM pedido WHERE idCliente <> 1;");
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                cantPedRegistrados = rs.getInt(1);
            }

        } catch (Exception e) {
            System.out.println(e);
        }
        return cantPedRegistrados;
    }

    public int obtenerCantidadPedidoClientesInvitados() {
        int cantPedInvitados = 0;
        try {
            Connection con = getConnection();
            PreparedStatement ps = con.prepareStatement("SELECT COUNT(idCliente) FROM pedido WHERE idCliente = 1;");
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                cantPedInvitados = rs.getInt(1);
            }

        } catch (Exception e) {
            System.out.println(e);
        }
        return cantPedInvitados;
    }

    public int obtenerPedidoFecha(String fecha) {
        int cantPedidos = 0;
        try {
            Connection con = getConnection();
            PreparedStatement ps = con.prepareStatement("SELECT COUNT(*) FROM pedido WHERE DATE(horaPedido)=?");
            ps.setString(1, fecha);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                cantPedidos = rs.getInt(1);
            }
              
        } catch (Exception e) {
            System.out.println(e);
        }
        return cantPedidos;
    }

    public int obtenerInformeFinanciero(int year) {
        int totalIngresos = 0;
        try {
            Connection con = getConnection();
            PreparedStatement ps = con.prepareStatement("SELECT SUM(total) FROM pedido WHERE YEAR(horaPedido)=?;");
            ps.setInt(1, year);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                totalIngresos = rs.getInt(1);
            }

        } catch (Exception e) {
            System.out.println(e);
        }
        return totalIngresos;
    }

    public DetallePedido obtenerProductoMasVendido(int year) {
        DetallePedido productoVendido = null;
        try {
            Connection con = getConnection();
            PreparedStatement ps = con.prepareStatement("SELECT dp.idProducto, p.nombre AS nombre_producto, SUM(dp.cantidad) AS total_vendido FROM detallePedido dp INNER JOIN producto p ON dp.idProducto = p.idProducto INNER JOIN pedido pe ON dp.idPedido = pe.idPedido WHERE YEAR(pe.horaPedido)=? GROUP BY dp.idProducto, p.nombre ORDER BY total_vendido DESC LIMIT 1;");
            ps.setInt(1, year);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                int idProducto = rs.getInt("idProducto");
                String nombreProducto = rs.getString("nombre_producto");
                int totalVenta = rs.getInt("total_vendido");
                productoVendido = new DetallePedido(idProducto, nombreProducto, totalVenta);
            }

        } catch (Exception e) {
            System.out.println(e);
        }
        return productoVendido;
    }
}
