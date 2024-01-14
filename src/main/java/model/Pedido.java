package model;

import java.util.List;

public class Pedido {
    public Pedido() {
    }

    int idPedido;
    int tipoVivienda;
    int metodoPago;
    int tipoTarjeta;

    public int getTipoVivienda() {
        return tipoVivienda;
    }

    public void setTipoVivienda(int tipoVivienda) {
        this.tipoVivienda = tipoVivienda;
    }

    public int getMetodoPago() {
        return metodoPago;
    }

    public void setMetodoPago(int metodoPago) {
        this.metodoPago = metodoPago;
    }

    public int getTipoTarjeta() {
        return tipoTarjeta;
    }

    public void setTipoTarjeta(int tipoTarjeta) {
        this.tipoTarjeta = tipoTarjeta;
    }

    public int getEstado() {
        return estado;
    }

    public void setEstado(int estado) {
        this.estado = estado;
    }

    int estado;

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

    String numeroTarjeta;

    public Pedido(int tipoVivienda, int metodoPago, int tipoTarjeta, int estado, int idCliente, List<Carrito> detallePedido, String receptor, String direccion, String referencia, String telefono, String fechaExpiracion, String numeroTarjeta, double total) {
        this.tipoVivienda = tipoVivienda;
        this.metodoPago = metodoPago;
        this.tipoTarjeta = tipoTarjeta;
        this.estado = estado;
        this.idCliente = idCliente;
        this.detallePedido = detallePedido;
        this.receptor = receptor;
        this.direccion = direccion;
        this.referencia = referencia;
        this.telefono = telefono;
        this.fechaExpiracion = fechaExpiracion;
        this.numeroTarjeta = numeroTarjeta;
        this.total = total;
    }

    public double getTotal() {
        return total;
    }

    public void setTotal(double total) {
        this.total = total;
    }

    double total;


}
