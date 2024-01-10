package model;

public class Carrito {

    int idProducto;

    public int getItem() {
        return item;
    }

    public void setItem(int item) {
        this.item = item;
    }

    int item;
    double precio;
    String nombre;

    public Carrito(int idProducto, double precio, String nombre) {
        this.idProducto = idProducto;
        this.precio = precio;
        this.nombre = nombre;
    }

    public int getIdProducto() {
        return idProducto;
    }

    public void setIdProducto(int idProducto) {
        this.idProducto = idProducto;
    }

    public double getPrecio() {
        return precio;
    }

    public void setPrecio(double precio) {
        this.precio = precio;
    }

    public String getNombre() {
        return nombre;
    }

    public void setNombre(String nombre) {
        this.nombre = nombre;
    }

    public Carrito() {
    }
}
