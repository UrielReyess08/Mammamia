// $("tr #Cantidad").change(function (e) {
//     e.preventDefault(); // Evita que se recargue la página
//     var idp = $(this).closest('tr').find('#id').val(); // Obtiene el ID del producto
//     var cantidad = $(this).val(); // Obtiene la cantidad actualizada
//     var url = "controlCarrito?accion=ActualizarCantidad"; // La URL del servlet
//
//     // Realiza una solicitud AJAX al servlet con los datos actualizados
//     $.ajax({
//         type: 'POST',
//         url: url,
//         data: {id: idp, cantidad: cantidad},
//         success: function (data, textStatus, jqXHR) {
//             // Aquí puedes añadir código para actualizar la vista, por ejemplo, el subtotal
//             // del producto y el total del carrito si es necesario.
//         },
//         error: function (jqXHR, textStatus, errorThrown) {
//             // Manejo de errores en la solicitud AJAX
//             console.error('Error al actualizar la cantidad: ' + textStatus);
//         }
//     });
// });
//
