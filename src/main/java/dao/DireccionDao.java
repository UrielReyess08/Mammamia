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
import model.Direccion;

/**
 *
 * @author daiko
 */
public class DireccionDao {

    public List<Direccion> obtenerDireccionesCliente(int idCliente) {
        List<Direccion> direcciones = new ArrayList<>();

        try {
            Connection con = getConnection();
            PreparedStatement ps = con.prepareStatement("SELECT * FROM direccioncliente WHERE idCliente = ?");
            ps.setInt(1, idCliente);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                Direccion direccion = new Direccion();
                direccion.setIdDireccionCliente(rs.getInt("idDireccionCliente"));
                direccion.setIdCliente(rs.getInt("idCliente"));
                direccion.setNombreDireccion(rs.getString("nombreDireccion"));
                direccion.setDireccion(rs.getString("direccion"));
                direccion.setTipoVivienda(rs.getString("tipoVivienda"));
                direccion.setReferencia(rs.getString("referencia"));
                direccion.setTelefono(rs.getString("telefono"));

                direcciones.add(direccion);
            }
        } catch (Exception e) {
            e.printStackTrace(); // Maneja la excepción adecuadamente en tu aplicación
        }

        return direcciones;
    }
}
