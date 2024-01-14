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
import model.Categoria;

/**
 *
 * @author daiko
 */
public class CategoriaDao {

    public static List<Categoria> listarCategorias() {
        List<Categoria> listaCategorias = new ArrayList<Categoria>();
        try {
            Connection con = getConnection();
            PreparedStatement ps = con.prepareStatement(
                    "SELECT * FROM categoria WHERE estado = 1");
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                Categoria cat = new Categoria();
                cat.setIdCategoria(rs.getInt("idCategoria"));
                cat.setNombre(rs.getString("nombre"));
                cat.setDescripcion(rs.getString("descripcion"));
                cat.setEstado(rs.getInt("estado"));
                listaCategorias.add(cat);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        return listaCategorias;
    }
    
    public static int actualizarCategoria(Categoria cat){
        int estado = 0;
        try {
            Connection con = getConnection();
            PreparedStatement ps = con.prepareStatement("UPDATE categoria SET nombre=?, descripcion=? WHERE idCategoria=?;");
            ps.setString(1, cat.getNombre());
            ps.setString(2, cat.getDescripcion());
            ps.setInt(3, cat.getIdCategoria());
            
            estado = ps.executeUpdate();
        }catch (Exception e){
            System.out.println(e);
        }
        
        return estado;
    }
}
