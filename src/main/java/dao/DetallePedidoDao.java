/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dao;

import static connection.Conexion.getConnection;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;
import model.DetallePedido;
/**
 *
 * @author daiko
 */
public class DetallePedidoDao {

    public static List<DetallePedido> listarDetallePedido(int idPedido) {
        List<DetallePedido> listaDetalles = new ArrayList<>();
        try {
            Connection con = getConnection();
            PreparedStatement ps = con.prepareStatement(
                    "SELECT det.idDetalleVenta, det.idPedido, prod.nombre, det.cantidad FROM detallepedido det INNER JOIN producto prod ON det.idProducto = prod.idProducto WHERE idPedido=?");
            ps.setInt(1, idPedido);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                DetallePedido det = new DetallePedido();
                det.setIdDetalleVenta(rs.getInt("idDetalleVenta"));
                det.setIdPedido(rs.getInt("idPedido"));
                det.setNombre(rs.getString("nombre"));
                //det.setIdProducto(rs.getInt("idProducto"));
                det.setCantidad(rs.getInt("cantidad"));
                listaDetalles.add(det);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        return listaDetalles;
    }
}
