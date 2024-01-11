$(document).ready(function () {
    $("tr #Cantidad").click(function (e) {
        var idp = $(this).parent().find('#id').val();
        var cantidad = $(this).parent().find('#Cantidad').val();
        var url = "controlCarrito?accion=ActualizarCantidad";
        console.log(idp, cantidad);
        $.ajax({
            type: 'POST',
            url: url,
            data: {
                id: idp,
                cantidad: cantidad
            },
            success: function (data, textStatus, jqXHR) {
                parent.location.href = "controlCarrito?accion=Carrito";
            }
        });
    });
});
