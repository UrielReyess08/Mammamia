package model;

public class DetallePedido {
    int detallePedido, idPedido, idProducto, cantidad;

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


}
