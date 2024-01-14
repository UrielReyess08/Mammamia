package dao;

import model.Carrito;
import model.Pedido;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

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
            ps = con.prepareStatement("INSERT INTO pedido (idCliente, receptor, direccion, referencia, telefono, fechaExpiracion, numeroTarjeta, tipoVivienda, metodoPago, tipoTarjeta, estado, horaPedido, total) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)");
            ps.setInt(1, pedido.getIdCliente());
            ps.setString(2, pedido.getReceptor());
            ps.setString(3, pedido.getDireccion());
            ps.setString(4, pedido.getReferencia());
            ps.setString(5, pedido.getTelefono());
            ps.setString(6, pedido.getFechaExpiracion());
            ps.setString(7, pedido.getNumeroTarjeta());
            ps.setInt(8, pedido.getTipoVivienda());
            ps.setInt(9, pedido.getMetodoPago());
            ps.setInt(10, pedido.getTipoTarjeta());
            ps.setInt(11, pedido.getEstado());
            ps.setString(12, obtenerFechaActual());
            ps.setDouble(13, pedido.getTotal());

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

    public static List<Pedido> listarPedidos() {
        List<Pedido> listaPedidos = new ArrayList<Pedido>();
        try {
            Connection con = getConnection();
            PreparedStatement ps = con.prepareStatement(
                    "SELECT ped.idPedido, cli.nombre, cli.apellido, ped.receptor, ped.direccion, ped.metodoPago, ped.horaPedido, ped.estado, ped.total FROM pedido ped INNER JOIN cliente cli ON ped.idCliente = cli.idCliente WHERE estado=0 OR estado=1 ORDER BY idPedido ASC;");
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                Pedido ped = new Pedido();
                ped.setIdPedido(rs.getInt("idPedido"));
                ped.setNombre(rs.getString("nombre"));
                ped.setApellido(rs.getString("apellido"));
                ped.setReceptor(rs.getString("receptor"));
                ped.setDireccion(rs.getString("direccion"));
                ped.setMetodoPago(rs.getInt("metodoPago"));
                ped.setHoraPedido(rs.getString("horaPedido"));
                ped.setEstado(rs.getInt("estado"));
                ped.setTotal(rs.getDouble("total"));
                listaPedidos.add(ped);
            }

        } catch (Exception e) {
            System.out.println(e);
        }

        return listaPedidos;
    }

    public static int actualizarEstado(Pedido ped) {
        int est = 0;
        try {
            Connection con = getConnection();
            PreparedStatement ps = con.prepareStatement("UPDATE pedido SET estado=? WHERE idPedido=?");
            ps.setInt(1, ped.getEstado());
            ps.setInt(2, ped.getIdPedido());
            est = ps.executeUpdate();
        } catch (Exception e) {
            System.out.println(e);
        }
        return est;
    }

    public static Pedido obtenerPedidoPorId(int idPedido) {
        Pedido pedido = null;
        try {
            Connection con = getConnection();
            PreparedStatement ps = con.prepareStatement("SELECT ped.idPedido, cli.nombre, cli.apellido, ped.receptor, ped.direccion, ped.metodoPago, ped.horaPedido, ped.estado, ped.total FROM pedido ped INNER JOIN cliente cli ON ped.idCliente = cli.idCliente WHERE idPedido=?");
            ps.setInt(1, idPedido);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                pedido = new Pedido();
                pedido.setIdPedido(rs.getInt("idPedido"));
                pedido.setNombre(rs.getString("nombre"));
                pedido.setApellido(rs.getString("apellido"));
                pedido.setReceptor(rs.getString("receptor"));
                pedido.setDireccion(rs.getString("direccion"));
                pedido.setMetodoPago(rs.getInt("metodoPago"));
                pedido.setHoraPedido(rs.getString("horaPedido"));
                pedido.setEstado(rs.getInt("estado"));
                pedido.setTotal(rs.getDouble("total"));
            }

        } catch (Exception e) {
            System.out.println(e);
        }
        return pedido;
    }

    public static List<Pedido> listarEntregas() {
        List<Pedido> listaEntregas = new ArrayList<Pedido>();
        try {
            Connection con = getConnection();
            PreparedStatement ps = con.prepareStatement(
                    "SELECT idPedido, horaPedido, estado FROM pedido WHERE estado=0 ORDER BY idPedido ASC;");
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                Pedido ent = new Pedido();
                ent.setIdPedido(rs.getInt("idPedido"));
                ent.setHoraPedido(rs.getString("horaPedido"));
                ent.setEstado(rs.getInt("estado"));
                listaEntregas.add(ent);
            }

        } catch (Exception e) {
            System.out.println(e);
        }

        return listaEntregas;
    }

    public static Pedido obtenerEntregaporId(int idPedido) {
        Pedido entrega = null;
        try {
            Connection con = getConnection();
            PreparedStatement ps = con.prepareStatement("SELECT idPedido, receptor, direccion, tipoVivienda, referencia, telefono, horaPedido, estado, total FROM pedido WHERE idPedido=?");
            ps.setInt(1, idPedido);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                entrega = new Pedido();
                entrega.setIdPedido(rs.getInt("idPedido"));
                entrega.setReceptor(rs.getString("receptor"));
                entrega.setDireccion(rs.getString("direccion"));
                entrega.setTipoVivienda(rs.getInt("tipoVivienda"));
                entrega.setReferencia(rs.getString("referencia"));
                entrega.setTelefono(rs.getString("telefono"));
                entrega.setHoraPedido(rs.getString("horaPedido"));
                entrega.setEstado(rs.getInt("estado"));
                entrega.setTotal(rs.getDouble("total"));
            }

        } catch (Exception e) {
            System.out.println(e);
        }
        return entrega;
    }
}
