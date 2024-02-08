/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dao;

import static conexion.Conexion.getConnection;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import model.Usuario;

/**
 *
 * @author daiko
 */
public class UsuarioDao {
    public boolean validarUsuario(Usuario usu) {
        try {
            Connection con = getConnection();
            PreparedStatement ps = con.prepareStatement("SELECT * FROM usuario WHERE email=? AND password=?");
            ps.setString(1, usu.getEmail());
            ps.setString(2, usu.getPassword());
            ResultSet rs = ps.executeQuery();
            
            if (rs.next()) {
                usu.setIdUsuario(rs.getInt("idUsuario"));
                usu.setRol(rs.getString("rol"));
                usu.setEstado(rs.getInt("estado"));
                return true;
            }

        } catch (Exception e) {

        }
        return false;
    }

    public boolean emailUsuario(String email) {
        try {
            Connection con = getConnection();
            PreparedStatement ps = con.prepareStatement("SELECT * FROM usuario WHERE email=?");
            ps.setString(1, email);
            ResultSet rs = ps.executeQuery();

            return rs.next();
        } catch (Exception e) {
            
        }
        return false;
    }
}
