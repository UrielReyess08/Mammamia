package model;

public class DetallePedido {
    int detallePedido, idPedido, idProducto, cantidad;
    int totalVenta; String nombreProducto;

    public DetallePedido(int idProducto, String nombreProducto, int totalVenta) {
        this.idProducto = idProducto;
        this.nombreProducto = nombreProducto;
        this.totalVenta = totalVenta;
    }

    public DetallePedido(int detallePedido, int idPedido, int idProducto, int cantidad) {
        this.detallePedido = detallePedido;
        this.idPedido = idPedido;
        this.idProducto = idProducto;
        this.cantidad = cantidad;
    }

    public DetallePedido() {
    }

    public int getDetallePedido() {
        return detallePedido;
    }

    public void setDetallePedido(int detallePedido) {
        this.detallePedido = detallePedido;
    }

    public int getIdPedido() {
        return idPedido;
    }

    public void setIdPedido(int idPedido) {
        this.idPedido = idPedido;
    }

    public int getIdProducto() {
        return idProducto;
    }

    public void setIdProducto(int idProducto) {
        this.idProducto = idProducto;
    }

    public int getCantidad() {
        return cantidad;
    }

    public void setCantidad(int cantidad) {
        this.cantidad = cantidad;
    }

    String nombre;

    public String getNombre() {
        return nombre;
    }

    public void setNombre(String nombre) {
        this.nombre = nombre;
    }

    public String getNombreProducto() {
        return nombreProducto;
    }

    public void setNombreProducto(String nombreProducto) {
        this.nombreProducto = nombreProducto;
    }

    public int getTotalVenta() {
        return totalVenta;
    }

    public void setTotalVenta(int totalVenta) {
        this.totalVenta = totalVenta;
    }

}
