package model;

import java.util.List;

public class Pedido {
    public Pedido() {
    }

    int idPedido;

    public int getIdPedido() {
        return idPedido;
    }

    public void setIdPedido(int idPedido) {
        this.idPedido = idPedido;
    }

    public int getIdCliente() {
        return idCliente;
    }

    public void setIdCliente(int idCliente) {
        this.idCliente = idCliente;
    }

    public List<Carrito> getDetallePedido() {
        return detallePedido;
    }

    public void setDetallePedido(List<Carrito> detallePedido) {
        this.detallePedido = detallePedido;
    }

    public String getReceptor() {
        return receptor;
    }

    public void setReceptor(String receptor) {
        this.receptor = receptor;
    }

    int idCliente;
    List<Carrito> detallePedido;
    String receptor;
    String direccion;
    String referencia;
    String telefono;
    String fechaExpiracion;

    public String getDireccion() {
        return direccion;
    }

    public void setDireccion(String direccion) {
        this.direccion = direccion;
    }

    public String getReferencia() {
        return referencia;
    }

    public void setReferencia(String referencia) {
        this.referencia = referencia;
    }

    public String getTelefono() {
        return telefono;
    }

    public void setTelefono(String telefono) {
        this.telefono = telefono;
    }

    public String getFechaExpiracion() {
        return fechaExpiracion;
    }

    public void setFechaExpiracion(String fechaExpiracion) {
        this.fechaExpiracion = fechaExpiracion;
    }

    public String getNumeroTarjeta() {
        return numeroTarjeta;
    }

    public void setNumeroTarjeta(String numeroTarjeta) {
        this.numeroTarjeta = numeroTarjeta;
    }

    public Pedido(int idCliente, List<Carrito> detallePedido, String receptor, String direccion, String referencia, String telefono, String fechaExpiracion, String numeroTarjeta) {
        this.idCliente = idCliente;
        this.detallePedido = detallePedido;
        this.receptor = receptor;
        this.direccion = direccion;
        this.referencia = referencia;
        this.telefono = telefono;
        this.fechaExpiracion = fechaExpiracion;
        this.numeroTarjeta = numeroTarjeta;
    }

    String numeroTarjeta;


}
