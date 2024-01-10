package dao;

import model.Producto;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import static conexion.Conexion.getConnection;

public class ProductoDao {
    public static List<Producto> listar() {
        List<Producto> list = new ArrayList<Producto>();
        try {
            Connection con = getConnection();
            PreparedStatement ps = con.prepareStatement("SELECT idProducto, nombre, descripcion, precio FROM producto WHERE estado = 1");
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                Producto prod = new Producto();
                prod.setIdProducto(rs.getInt("idProducto"));
                prod.setNombre(rs.getString("nombre"));
                prod.setDescripcion(rs.getString("descripcion"));
                prod.setPrecio(rs.getDouble("precio"));
                list.add(prod);
            }
        } catch (Exception e) {
            System.out.println(e);
        }
        return list;
    }

    public Producto listarId(int id) {
        Producto p = null;
        try {
            Connection con = getConnection();
            PreparedStatement ps = con.prepareStatement("SELECT idProducto, nombre, descripcion, precio, stock FROM producto WHERE idProducto = ?");
            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                p = new Producto();
                p.setIdProducto(rs.getInt("idProducto"));
                p.setNombre(rs.getString("nombre"));
                p.setDescripcion(rs.getString("descripcion"));
                p.setPrecio(rs.getDouble("precio"));
                p.setStock(rs.getInt("stock"));
            }
        } catch (Exception e) {

        }
        return p;
    }
}
