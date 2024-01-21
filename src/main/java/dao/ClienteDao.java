/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dao;

import static conexion.Conexion.getConnection;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.*;
import model.Cliente;
import model.Direccion;
import model.Tarjeta;
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
            ps.setInt(1, 1);
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

    public static int registrarCliente(Cliente cli) {
        int estado = 0;
        try {
            Connection con = getConnection();
            PreparedStatement ps = con.prepareStatement("INSERT INTO cliente(nombre, apellido, email, password ) VALUES (?,?,?,?) ");
            ps.setString(1, cli.getNombre());
            ps.setString(2, cli.getApellido());
            ps.setString(3, cli.getEmail());
            ps.setString(4, cli.getPassword());

            estado = ps.executeUpdate();
        } catch (Exception e) {
            System.out.println(e);
        }
        return estado;
    }
    
    public static Cliente obtenerClientePorId(int idCliente){
        Cliente cliente = null;
        try {
            Connection con = getConnection();
            PreparedStatement ps = con.prepareStatement("SELECT idCliente, nombre, apellido, email, password FROM cliente WHERE idCliente=?");
            ps.setInt(1, idCliente);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                cliente = new Cliente();
                cliente.setIdCliente(rs.getInt("idCliente"));
                cliente.setNombre(rs.getString("nombre"));
                cliente.setApellido(rs.getString("apellido"));
                cliente.setEmail(rs.getString("email"));
                cliente.setPassword(rs.getString("password"));
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
        return cliente;
    }
    
    public static int actualizarCliente(Cliente cli){
        int est = 0;
        try {
            Connection con = getConnection();
            PreparedStatement ps = con.prepareStatement("UPDATE cliente SET nombre=?, apellido=?, email=?, password=? WHERE idCliente=?");
            ps.setString(1, cli.getNombre());
            ps.setString(2, cli.getApellido());
            ps.setString(3, cli.getEmail());
            ps.setString(4, cli.getPassword());
            ps.setInt(5, cli.getIdCliente());
            est = ps.executeUpdate();
        } catch (Exception e) {
            System.out.println(e);
        }
        return est;
    }

    // DIRECCIONES
    
    public List<Direccion> listarDireccionPorId(int idCliente) {
        List<Direccion> direcciones = new ArrayList<>();

        try {
            Connection con = getConnection();
            PreparedStatement ps = con.prepareStatement("SELECT * FROM direccioncliente WHERE idCliente = ?");
            ps.setInt(1, idCliente);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                Direccion dire = new Direccion();
                dire.setIdDireccionCliente(rs.getInt("idDireccionCliente"));
                dire.setIdCliente(rs.getInt("idCliente"));
                dire.setNombreDireccion(rs.getString("nombreDireccion"));
                dire.setDireccion(rs.getString("direccion"));
                dire.setTipoVivienda(rs.getInt("tipoVivienda"));
                dire.setReferencia(rs.getString("referencia"));
                dire.setTelefono(rs.getString("telefono"));

                direcciones.add(dire);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        return direcciones;
    }

    public static int registrarDireccion(Direccion direc) {
        int estado = 0;
        try {
            Connection con = getConnection();
            PreparedStatement ps = con.prepareStatement("INSERT INTO direccioncliente(idCliente, nombreDireccion, direccion, tipoVivienda, referencia, telefono) VALUES (?,?,?,?,?,?) ");
            ps.setInt(1, direc.getIdCliente());
            ps.setString(2, direc.getNombreDireccion());
            ps.setString(3, direc.getDireccion());
            ps.setInt(4, direc.getTipoVivienda());
            ps.setString(5, direc.getReferencia());
            ps.setString(6, direc.getTelefono());

            estado = ps.executeUpdate();
        } catch (Exception e) {
            System.out.println(e);
        }
        return estado;
    }

    public static Direccion obtenerDireccionPorId(int idDireccionCliente) {
        Direccion direccionCli = null;
        try {
            Connection con = getConnection();
            PreparedStatement ps = con.prepareStatement("SELECT idDireccionCliente, idCliente, nombreDireccion, direccion, tipoVivienda, referencia, telefono FROM direccioncliente WHERE idDireccionCliente=?");
            ps.setInt(1, idDireccionCliente);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                direccionCli = new Direccion();
                direccionCli.setIdDireccionCliente(rs.getInt("idDireccionCliente"));
                direccionCli.setIdCliente(rs.getInt("idCliente"));
                direccionCli.setNombreDireccion(rs.getString("nombreDireccion"));
                direccionCli.setDireccion(rs.getString("direccion"));
                direccionCli.setTipoVivienda(rs.getInt("tipoVivienda"));
                direccionCli.setReferencia(rs.getString("referencia"));
                direccionCli.setTelefono(rs.getString("telefono"));
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
        return direccionCli;
    }

    public static int actualizarDireccion(Direccion dire) {
        int est = 0;
        try {
            Connection con = getConnection();
            PreparedStatement ps = con.prepareStatement("UPDATE direccioncliente SET idCliente=?, nombreDireccion=?, direccion=?, tipoVivienda=?, referencia=?, telefono=? WHERE idDireccionCliente=?");
            ps.setInt(1, dire.getIdCliente());
            ps.setString(2, dire.getNombreDireccion());
            ps.setString(3, dire.getDireccion());
            ps.setInt(4, dire.getTipoVivienda());
            ps.setString(5, dire.getReferencia());
            ps.setString(6, dire.getTelefono());
            ps.setInt(7, dire.getIdDireccionCliente());
            est = ps.executeUpdate();
        } catch (Exception e) {
            System.out.println(e);
        }
        return est;
    }

    public static int eliminarDireccion(int idDireccionCliente) {
        int est = 0;
        try {
            Connection con = getConnection();
            PreparedStatement ps = con.prepareStatement("DELETE FROM direccioncliente WHERE idDireccionCliente=?");
            ps.setInt(1, idDireccionCliente);
            est = ps.executeUpdate();
        } catch (Exception e) {
            System.out.println(e);
        }
        return est;
    }
    
    // TARJETAS
    
    public List<Tarjeta> listarTarjetaPorId(int idCliente) {
        List<Tarjeta> tarjetas = new ArrayList<>();

        try {
            Connection con = getConnection();
            PreparedStatement ps = con.prepareStatement("SELECT * FROM tarjetacliente WHERE idCliente = ?");
            ps.setInt(1, idCliente);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                Tarjeta tar = new Tarjeta();
                tar.setIdTarjetaCliente(rs.getInt("idTarjetaCliente"));
                tar.setIdCliente(rs.getInt("idCliente"));
                tar.setNombreTarjeta(rs.getString("nombreTarjeta"));
                tar.setMetodoPago(rs.getInt("metodoPago"));
                tar.setFechaExpiracion(rs.getString("fechaExpiracion"));
                tar.setTipoTarjeta(rs.getInt("tipoTarjeta"));
                tar.setNumeroTarjeta(rs.getString("numeroTarjeta"));
                tarjetas.add(tar);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        return tarjetas;
    }
    
    public static int registrarTarjeta(Tarjeta tar) {
        int estado = 0;
        try {
            Connection con = getConnection();
            PreparedStatement ps = con.prepareStatement("INSERT INTO tarjetacliente(idCliente, nombreTarjeta, metodoPago, fechaExpiracion, tipoTarjeta, numeroTarjeta) VALUES (?,?,?,?,?,?) ");
            ps.setInt(1, tar.getIdCliente());
            ps.setString(2, tar.getNombreTarjeta());
            ps.setInt(3, tar.getMetodoPago());
            ps.setString(4, tar.getFechaExpiracion());
            ps.setInt(5, tar.getTipoTarjeta());
            ps.setString(6, tar.getNumeroTarjeta());

            estado = ps.executeUpdate();
        } catch (Exception e) {
            System.out.println(e);
        }
        return estado;
    }
    
    public static int eliminarTarjeta(int idTarjetaCliente) {
        int est = 0;
        try {
            Connection con = getConnection();
            PreparedStatement ps = con.prepareStatement("DELETE FROM tarjetacliente WHERE idTarjetaCliente=?");
            ps.setInt(1, idTarjetaCliente);
            est = ps.executeUpdate();
        } catch (Exception e) {
            System.out.println(e);
        }
        return est;
    }
}
