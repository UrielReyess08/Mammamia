/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dao;

import static conexion.Conexion.getConnection;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import model.Cliente;

/**
 *
 * @author daiko
 */
public class ClienteDao {
    public boolean validarCliente(Cliente cli) {
        try {
            Connection con = getConnection();
            PreparedStatement ps = con.prepareStatement("SELECT * FROM cliente WHERE email=? AND password=?");
            ps.setString(1, cli.getEmail());
            ps.setString(2, cli.getPassword());
            ResultSet rs = ps.executeQuery();
            
            if (rs.next()) {
                cli.setIdCliente(rs.getInt("idCliente"));
                cli.setNombre(rs.getString("nombre"));
                cli.setApellido(rs.getString("apellido"));
                return true;
            }

        } catch (Exception e) {

        }
        return false;
    }

    public Cliente obtenerClienteInvitado() {
        try {
            Connection con = getConnection();
            PreparedStatement ps = con.prepareStatement("SELECT * FROM cliente WHERE idCliente = ?");
            ps.setInt(1, 3);
            ResultSet rs = ps.executeQuery();
            
            if(rs.next()){
                Cliente invitado = new Cliente();
                invitado.setIdCliente(rs.getInt("idCliente"));
                invitado.setNombre(rs.getString("nombre"));
                invitado.setApellido(rs.getString("apellido"));
                invitado.setEmail(rs.getString("email"));
                invitado.setPassword(rs.getString("password"));
                return invitado;
            }
        } catch (Exception e){
            
        }
        return null;
    }
}
