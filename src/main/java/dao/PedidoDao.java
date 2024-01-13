package dao;

import model.Carrito;
import model.Pedido;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import static conexion.Conexion.getConnection;

public class PedidoDao {

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
            PreparedStatement ps = con.prepareStatement("INSERT INTO pedido (idCliente, receptor, direccion, tipoVivienda, referencia, telefono, metodoPago, fechaExpiracion, tipoTarjeta, numeroTarjeta, horaPedido, estado, total) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)");
            ps.setInt(1, pedido.getIdCliente());
            ps.setString(2, pedido.getReceptor());
            ps.setString(3, pedido.getDireccion());
            ps.setInt(4, pedido.getTipoVivienda());
            ps.setString(5, pedido.getReferencia());
            ps.setString(6, pedido.getTelefono());
            ps.setInt(7, pedido.getMetodoPago());
            ps.setString(8, pedido.getFechaExpiracion());
            ps.setInt(9, pedido.getTipoTarjeta());
            ps.setString(10, pedido.getNumeroTarjeta());
            ps.setString(11, obtenerFechaActual());
            ps.setInt(12, 1);
            ps.setDouble(13, pedido.getTotal());

            estado = ps.executeUpdate();

            String SQL = "SELECT @@IDENTITY AS idPedido";
            ResultSet rs = ps.executeQuery(SQL);
            rs.next();
            idPedido = rs.getInt("idPedido");
            rs.close();

            for (Carrito detalle : pedido.getDetalleCompra()){
                SQL = "INSERT INTO detallepedido (idPedido, idProducto, cantidad) VALUES (?, ?, ?)";
                ps = con.prepareStatement(SQL);
                ps.setInt(1, idPedido);
                ps.setInt(2, detalle.getIdProducto());
                ps.setInt(3, detalle.getCantidad());

                estado = ps.executeUpdate();

            }


        } catch (Exception e){

        }
        return estado;
    }
}
