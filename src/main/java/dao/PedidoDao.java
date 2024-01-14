package dao;

import model.Carrito;
import model.Pedido;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import static conexion.Conexion.getConnection;

public class PedidoDao {

    PreparedStatement ps;
    ResultSet rs;

    public static String obtenerFechaActual() {
        java.util.Date fecha = new java.util.Date();
        java.text.SimpleDateFormat formato = new java.text.SimpleDateFormat("yyyy-MM-dd' 'HH:mm:ss");
        return formato.format(fecha);
    }
    public int generarPedido(Pedido pedido){
        int idPedido;
        int estado = 0;
        try {
            Connection con = getConnection();
            ps = con.prepareStatement("INSERT INTO pedido (idCliente, receptor, direccion, referencia, telefono, fechaExpiracion, numeroTarjeta) VALUES (?, ?, ?, ?, ?, ?, ?)");
            ps.setInt(1, pedido.getIdCliente());
            ps.setString(2, pedido.getReceptor());
            ps.setString(3, pedido.getDireccion());
            ps.setString(4, pedido.getReferencia());
            ps.setString(5, pedido.getTelefono());
            ps.setString(6, pedido.getFechaExpiracion());
            ps.setString(7, pedido.getNumeroTarjeta());

            estado = ps.executeUpdate();

            String SQL = "SELECT @@IDENTITY AS idPedido";
            rs = ps.executeQuery(SQL);
            rs.next();
            idPedido = rs.getInt("idPedido");
            rs.close();

            for (Carrito detalle : pedido.getDetallePedido()){
                SQL = "INSERT INTO detallepedido (idPedido, idProducto, cantidad) VALUES (?, ?, ?)";
                ps = con.prepareStatement(SQL);
                ps.setInt(1, idPedido);
                ps.setInt(2, detalle.getIdProducto());
                ps.setInt(3, detalle.getCantidad());

                estado = ps.executeUpdate();

            }


        } catch (Exception e){
            System.out.println(e);
        }
        return estado;
    }
}
