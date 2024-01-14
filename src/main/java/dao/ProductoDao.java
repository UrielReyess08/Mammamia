package dao;

import model.Producto;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import static conexion.Conexion.getConnection;

public class ProductoDao {
    public static List<Producto> listarPizzas() {
        List<Producto> list = new ArrayList<Producto>();
        try {
            Connection con = getConnection();
            PreparedStatement ps = con.prepareStatement("SELECT idProducto, nombre, descripcion, precio FROM producto WHERE estado = 1 AND idCategoria = ?");
            ps.setInt(1, 1);
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

    public static List<Producto> listarBebidas() {
        List<Producto> list = new ArrayList<Producto>();
        try {
            Connection con = getConnection();
            PreparedStatement ps = con.prepareStatement("SELECT idProducto, nombre, descripcion, precio FROM producto WHERE estado = 1 AND idCategoria = ?");
            ps.setInt(1, 2);
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

    public static List<Producto> listarPastas() {
        List<Producto> list = new ArrayList<Producto>();
        try {
            Connection con = getConnection();
            PreparedStatement ps = con.prepareStatement("SELECT idProducto, nombre, descripcion, precio FROM producto WHERE estado = 1 AND idCategoria = ?");
            ps.setInt(1, 3);
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

    public static List<Producto> listarPostres() {
        List<Producto> list = new ArrayList<Producto>();
        try {
            Connection con = getConnection();
            PreparedStatement ps = con.prepareStatement("SELECT idProducto, nombre, descripcion, precio FROM producto WHERE estado = 1 AND idCategoria = ?");
            ps.setInt(1, 4);
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
            PreparedStatement ps = con.prepareStatement("SELECT idProducto, idCategoria, nombre, descripcion, precio, stock FROM producto WHERE idProducto = ?");
            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                p = new Producto();
                p.setIdProducto(rs.getInt("idProducto"));
                p.setIdCategoria(rs.getInt("idCategoria"));
                p.setNombre(rs.getString("nombre"));
                p.setDescripcion(rs.getString("descripcion"));
                p.setPrecio(rs.getDouble("precio"));
                p.setStock(rs.getInt("stock"));
            }
        } catch (Exception e) {

        }
        return p;
    }

    public static List<Producto> listarProductos() {
        List<Producto> listaProductos = new ArrayList<Producto>();
        try {
            Connection con = getConnection();
            PreparedStatement ps = con.prepareStatement(
                    "SELECT prod.idProducto, cat.nombre as nombreCategoria, prod.nombre, prod.descripcion, prod.precio, prod.stock, prod.estado FROM producto prod INNER JOIN categoria cat ON prod.idCategoria = cat.idCategoria WHERE prod.estado = 1");
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                Producto prod = new Producto();
                prod.setIdProducto(rs.getInt("idProducto"));
                prod.setNombreCategoria(rs.getString("nombreCategoria"));
                prod.setNombre(rs.getString("nombre"));
                prod.setDescripcion(rs.getString("descripcion"));
                prod.setPrecio(rs.getDouble("precio"));
                prod.setStock(rs.getInt("stock"));
                prod.setEstado(rs.getInt("estado"));
                listaProductos.add(prod);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        return listaProductos;
    }

    public static int actualizarProducto(Producto prod) {
        int estado = 0;
        try {
            Connection con = getConnection();
            PreparedStatement ps = con.prepareStatement("UPDATE producto SET idCategoria=?, nombre=?, descripcion=?, precio=?, stock=?, estado=? WHERE idProducto=?;");
            ps.setInt(1, prod.getIdCategoria());
            ps.setString(2, prod.getNombre());
            ps.setString(3, prod.getDescripcion());
            ps.setDouble(4, prod.getPrecio());
            ps.setInt(5, prod.getStock());
            ps.setInt(6, prod.getEstado());
            ps.setInt(7, prod.getIdProducto());

            estado = ps.executeUpdate();
        } catch (Exception e) {
            System.out.println(e);
        }

        return estado;
    }

    public static Producto obtenerProductoPorId(int idProducto) {
        Producto producto = null;
        try {
            Connection con = getConnection();
            PreparedStatement ps = con.prepareStatement("SELECT idProducto, idCategoria, nombre, descripcion, precio, stock, estado FROM producto WHERE idProducto=?");
            ps.setInt(1, idProducto);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                producto = new Producto();
                producto.setIdProducto(rs.getInt("idProducto"));
                producto.setIdCategoria(rs.getInt("idCategoria"));
                producto.setNombre(rs.getString("nombre"));
                producto.setDescripcion(rs.getString("descripcion"));
                producto.setPrecio(rs.getDouble("precio"));
                producto.setStock(rs.getInt("stock"));
                producto.setEstado(rs.getInt("estado"));
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
        return producto;
    }

    public static int actualizarEstado(Producto prod) {
        int est = 0;
        try {
            Connection con = getConnection();
            PreparedStatement ps = con.prepareStatement("UPDATE producto SET estado=? WHERE idProducto=?");
            ps.setInt(1, prod.getEstado());
            ps.setInt(2, prod.getIdProducto());
            est = ps.executeUpdate();
        } catch (Exception e) {
            System.out.println(e);
        }
        return est;
    }
    
    public static int registrarProducto(Producto prod) {
        int estado = 0;
        try {
            Connection con = getConnection();
            PreparedStatement ps = con.prepareStatement("INSERT INTO producto(idCategoria, nombre, descripcion, precio, stock, estado) VALUES (?,?,?,?,?,?) ");
            ps.setInt(1, prod.getIdCategoria());
            ps.setString(2, prod.getNombre());
            ps.setString(3, prod.getDescripcion());
            ps.setDouble(4, prod.getPrecio());
            ps.setInt(5, prod.getStock());
            ps.setInt(6, prod.getEstado());

            estado = ps.executeUpdate();
        } catch (Exception e) {
            System.out.println(e);
        }
        return estado;
    }
}
