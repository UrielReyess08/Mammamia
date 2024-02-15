create table categoria
(
    idCategoria int(2) auto_increment
        primary key,
    nombre      varchar(50)  not null,
    descripcion varchar(200) null,
    estado      tinyint(1)   not null
);

create table cliente
(
    idCliente int(6) auto_increment
        primary key,
    nombre    varchar(50) not null,
    apellido  varchar(50) not null,
    email     varchar(80) not null,
    password  varchar(20) not null,
    constraint cliente_pk
        unique (email)
);

create table direccioncliente
(
    idDireccionCliente int(2) auto_increment
        primary key,
    idCliente          int(6)       not null,
    nombreDireccion    varchar(25)  not null,
    direccion          varchar(100) not null,
    tipoVivienda       tinyint      not null,
    referencia         varchar(50)  null,
    telefono           varchar(9)   not null,
    constraint nombreDireccion
        unique (nombreDireccion),
    constraint direccioncliente_ibfk_1
        foreign key (idCliente) references cliente (idCliente)
);

create table pedido
(
    idPedido        int(6) auto_increment
        primary key,
    idCliente       int(2)        not null,
    receptor        varchar(50)   not null,
    direccion       varchar(100)  not null,
    tipoVivienda    tinyint(1)    not null,
    referencia      varchar(50)   not null,
    telefono        varchar(9)    not null,
    metodoPago      tinyint(1)    not null,
    fechaExpiracion varchar(10)   not null,
    tipoTarjeta     tinyint(1)    not null,
    numeroTarjeta   varchar(25)   not null,
    horaPedido      datetime      not null,
    estado          tinyint(1)    not null,
    total           decimal(6, 2) not null,
    constraint pedido_ibfk_1
        foreign key (idCliente) references cliente (idCliente)
);

create index idCliente
    on pedido (idCliente);

create table producto
(
    idProducto  int(3) auto_increment
        primary key,
    idCategoria int(2)        not null,
    nombre      varchar(50)   not null,
    descripcion varchar(200)  not null,
    precio      decimal(5, 2) not null,
    stock       int(3)        not null,
    estado      tinyint(1)    not null,
    constraint producto_ibfk_1
        foreign key (idCategoria) references categoria (idCategoria)
);

create table detallepedido
(
    idDetallePedido int(7) auto_increment
        primary key,
    idPedido        int(6) not null,
    idProducto      int(3) not null,
    cantidad        int(3) null,
    constraint detallepedido_ibfk_1
        foreign key (idPedido) references pedido (idPedido),
    constraint detallepedido_ibfk_2
        foreign key (idProducto) references producto (idProducto)
);

create index idPedido
    on detallepedido (idPedido);

create index idProducto
    on detallepedido (idProducto);

create index idCategoria
    on producto (idCategoria);

create table tarjetacliente
(
    idTarjetaCliente int(2) auto_increment
        primary key,
    idCliente        int(6)      not null,
    nombreTarjeta    varchar(25) not null,
    metodoPago       tinyint     not null,
    fechaExpiracion  varchar(10) not null,
    tipoTarjeta      tinyint     not null,
    numeroTarjeta    varchar(25) not null,
    constraint tarjetacliente_pk
        unique (nombreTarjeta),
    constraint tarjetacliente_ibfk_1
        foreign key (idCliente) references cliente (idCliente)
);

create index idCliente
    on tarjetacliente (idCliente);

create table usuario
(
    idUsuario int(6) auto_increment
        primary key,
    email     varchar(80)  not null,
    password  varchar(150) not null,
    rol       varchar(150) not null,
    estado    tinyint(1)   not null,
    constraint usuario_pk
        unique (email)
);

INSERT INTO `cliente` (`idCliente`, `nombre`, `apellido`, `email`, `password`)
VALUES (1, 'Cliente', 'Varios', 'clienteVarios@gmail.com', 'cliente123'),
       (2, 'Romina', 'Fernandez', 'romina45@gmail.com', 'romina123'),
       (3, 'Juan', 'Hernandez', 'juan63@gmail.com', 'juan123'),
       (4, 'Ericka', 'Flores', 'ericka38@gmail.com', 'ericka123'),
       (5, 'Carlos', 'Diaz', 'carlos45@gmail.com', 'carlos123');

INSERT INTO `direccioncliente` (`idDireccionCliente`, `idCliente`, `nombreDireccion`, `direccion`, `tipoVivienda`,
                                `referencia`, `telefono`)
VALUES (1, 2, 'Mi Casa', 'Av. Lima 123', 2, 'Altura del Parque Central', '967543892'),
       (2, 2, 'Mi Trabajo', 'Av. Brasil 45', 4, 'Paradero', '945325678'),
       (3, 5, 'Depa 1', 'Av. Miraflores 12', 1, 'Parque', '954364578'),
       (4, 3, 'Dulce Hogar', 'Av. Surco 34', 3, 'Altura de Supermercado', '956378264'),
       (5, 4, 'Casa Hotel', 'Calle Francia 16', 5, 'Ovalo', '965743089');

INSERT INTO `tarjetacliente` (`idTarjetaCliente`, `idCliente`, `nombreTarjeta`, `metodoPago`, `fechaExpiracion`,
                              `tipoTarjeta`, `numeroTarjeta`)
VALUES (1, 2, 'Tarjeta Diamante', 1, '11/27', 1, '4389504321456743'),
       (2, 2, 'Tarjeta Gold', 2, '12/27', 1, '4325647845321456'),
       (3, 5, 'Tarjeta Interbank', 1, '10/27', 1, '4213789654098765'),
       (4, 3, 'Mi Tarjeta', 3, '12/27', 2, '4367890765432567'),
       (5, 4, 'Tarjetita', 1, '10/27', 1, '4213786954301945');

INSERT INTO `usuario` (`idUsuario`, `email`, `password`, `rol`, `estado`)
VALUES (1, 'ventas@mammamia.pe', '12345', 'Encargado Ventas', 1),
       (2, 'almacen@mammamia.pe', '123', 'Encargado Almacen', 1),
       (3, 'repartidor@mammamia.pe', '123456', 'Repartidor', 1),
       (4, 'admin@mammamia.pe', '1234856', 'Administrador', 1);

INSERT INTO `categoria` (`idCategoria`, `nombre`, `descripcion`, `estado`)
VALUES (1, 'Pizzas', 'Las mejores Pizzas de Miraflores.', 1),
       (2, 'Bebidas', 'Las mejores bebidas de Miraflores.', 1),
       (3, 'Pastas', 'Las mejores pastas de Miraflores.', 1),
       (4, 'Postres', 'Los mejores postres de Miraflores.', 1);

INSERT INTO `producto` (`idProducto`, `idCategoria`, `nombre`, `descripcion`, `precio`, `stock`, `estado`)
VALUES (1, 1, 'Mammamia Suprema', 'Pizza hawaiana con mucha pina.', 32.90, 15, 1),
       (2, 1, 'Pizza Margarita', 'Pizza con un rico sabor.', 23.90, 22, 1),
       (3, 1, 'Pizza Marinara', 'Pizza con salsa de tomate.', 24.00, 20, 1),
       (4, 1, 'Pizza Napolitana', 'Pizza con masa gomosaa.', 23.90, 24, 1),
       (5, 1, 'Pizza Pepperoni', 'Pizza con mozarella y pepperoni.', 24.90, 26, 1),
       (6, 1, 'Pizza 4 Quesos', 'Pizza con cuatro quesos diferentes.', 25.00, 18, 1),
       (7, 3, 'Lasagna de Carne', 'Lasagna con carne molida.', 20.00, 15, 1),
       (8, 3, 'Lasagna de Espinaca', 'Lasagna con espinaca y queso.', 18.00, 17, 1),
       (9, 3, 'Lasagna de Tomate', 'Lasagna con salsa de tomate y mozarella.', 22.00, 15, 1),
       (10, 2, 'Chicha Morada', 'Chicha morada con zumo de limon.', 15.00, 24, 1),
       (11, 2, 'Limonada', 'Jugo de zumo de limon.', 14.00, 20, 1),
       (12, 2, 'Jugo de Fresa', 'Jugo de extracto de fresa.', 15.00, 18, 1),
       (13, 4, 'Crema Voletada', 'Postre de dulce de leche.', 9.90, 24, 1),
       (14, 4, 'Suspiro Limeno', 'Postre hecho de leche.', 10.00, 23, 1),
       (15, 4, 'Tiramisu', 'Postre frio hecho en capas.', 12.00, 14, 1);

INSERT INTO `pedido` (`idPedido`, `idCliente`, `receptor`, `direccion`, `tipoVivienda`, `referencia`, `telefono`,
                      `metodoPago`, `fechaExpiracion`, `tipoTarjeta`, `numeroTarjeta`, `horaPedido`, `estado`, `total`)
VALUES (1, 2, 'Romina', 'Av. Lima 123', 2, 'Altura del Parque Central', '967543892', 1, '11/27', 1, '4389504321456743',
        '2024-02-14 18:43:29', 1, 119.60),
       (2, 3, 'Fausto Hernandez', 'Av. Surco 34', 3, 'Altura de Supermercado', '956378264', 3, '12/27', 2,
        '4367890765432567', '2024-02-14 18:51:27', 1, 43.80),
       (3, 4, 'Ericka', 'Calle Francia 16', 5, 'Ovalo', '965743089', 1, '10/27', 1, '4213786954301945',
        '2024-02-14 18:52:24', 1, 137.60),
       (4, 5, 'Sofia Flores', 'Av. Miraflores 12', 1, 'Parque', '954364578', 1, '10/27', 1, '4213789654098765',
        '2024-02-14 18:52:57', 1, 170.40),
       (5, 3, 'Juan', 'Av. Surco 34', 3, 'Altura de Supermercado', '956378264', 3, '12/27', 2, '4367890765432567',
        '2024-02-14 18:54:19', 1, 52.80);

INSERT INTO `detallepedido` (`idDetallePedido`, `idPedido`, `idProducto`, `cantidad`)
VALUES (1, 1, 1, 3),
       (2, 1, 10, 1),
       (3, 2, 13, 1),
       (4, 2, 11, 2),
       (5, 3, 8, 1),
       (6, 3, 1, 3),
       (7, 3, 10, 1),
       (8, 4, 1, 5),
       (9, 5, 1, 1),
       (10, 5, 11, 1);