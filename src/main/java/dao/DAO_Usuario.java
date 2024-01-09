/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dao;

import model.Usuario;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import static conexion.Conexion.getConnection;

/**
 *
 * @author daiko
 */
public class DAO_Usuario {
    
    public boolean validar(Usuario usu) {
        try {
            Connection con = getConnection();
            PreparedStatement ps = con.prepareStatement("SELECT * FROM usuario WHERE email=? AND password=?");
            ps.setString(1, usu.getEmail());
            ps.setString(2, usu.getPassword());
            ResultSet rs = ps.executeQuery();
            
            if (rs.next()) {
                usu.setIdUsuario(rs.getInt("idUsuario"));
                usu.setRol(rs.getString("rol"));
                usu.setActivo(rs.getBoolean("activo"));
                return true;
            }

        } catch (Exception e) {

        }
        return false;
    }
}
