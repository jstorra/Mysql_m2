CREATE DATABASE IF NOT EXISTS biblioteca;

USE biblioteca;

CREATE TABLE autor (
  id INT NOT NULL,
  nombre VARCHAR(50) NOT NULL,
  direccion VARCHAR(50) NOT NULL,
  urlPagina VARCHAR(255)
);

CREATE TABLE editor (
  id INT NOT NULL,
  nombre VARCHAR(50) NOT NULL,
  direccion VARCHAR(50) NOT NULL,
  telefono VARCHAR(20) NOT NULL,
  urlPagina VARCHAR(255)
);

CREATE TABLE libro (
  isbn VARCHAR(20) NOT NULL,
  titulo VARCHAR(50) NOT NULL,
  fechaPublicacion DATE NOT NULL,
  precio DECIMAL(10,2) NOT NULL,
  autor_id INT NOT NULL,
  editor_id INT NOT NULL
);

CREATE TABLE almacen (
  id INT NOT NULL,
  direccion VARCHAR(50) NOT NULL,
  telefono VARCHAR(20) NOT NULL
);

CREATE TABLE stock (
  almacen_id INT NOT NULL,
  libro_id VARCHAR(20) NOT NULL,
  cantidad INT NOT NULL
);

CREATE TABLE cliente (
  cedula VARCHAR(20) NOT NULL,
  nombre VARCHAR(50) NOT NULL,
  apellido VARCHAR(50) NOT NULL,
  correo VARCHAR(50) NOT NULL,
  telefono VARCHAR(20) NOT NULL
);

CREATE TABLE carritoCompra (
  id INT NOT NULL,
  cliente_id VARCHAR(20) NOT NULL
);

CREATE TABLE contenido_carrito (
  carrito_id INT NOT NULL,
  libro_id VARCHAR(20) NOT NULL,
  cantidad INT NOT NULL
);

CREATE TABLE repartidor (
  id INT NOT NULL,
  nombreRepartidor VARCHAR(50) NOT NULL
);

CREATE TABLE opcionEnvio (
  id INT NOT NULL,
  nombreOpcion VARCHAR(50) NOT NULL
);

CREATE TABLE tiposPago (
  id INT NOT NULL,
  nombreTipo VARCHAR(50) NOT NULL
);

CREATE TABLE pedido (
  id INT NOT NULL,
  carrito_id INT NOT NULL,
  direccionFact VARCHAR(50) NOT NULL,
  direccionEnv VARCHAR(50) NOT NULL,
  repartidor_id INT NOT NULL,
  opcionEnvio_id INT NOT NULL,
  tipoPago_id INT NOT NULL,
  notificacionCorreo_id INT NOT NULL
);

CREATE TABLE notificacionCorreo (
  id INT NOT NULL,
  contenido VARCHAR(255) NOT NULL,
  fechaEnvio DATE NOT NULL
);


-- PRIMARY KEYS
ALTER TABLE autor ADD CONSTRAINT PK_Autor_Id PRIMARY KEY (id);
ALTER TABLE autor MODIFY id INT NOT NULL AUTO_INCREMENT;

ALTER TABLE editor ADD CONSTRAINT PK_Editor_Id PRIMARY KEY (id);
ALTER TABLE editor MODIFY id INT NOT NULL AUTO_INCREMENT;

ALTER TABLE libro ADD CONSTRAINT PK_Libro_Isbn PRIMARY KEY (isbn);

ALTER TABLE almacen ADD CONSTRAINT PK_Almacen_Id PRIMARY KEY (id);
ALTER TABLE almacen MODIFY id INT NOT NULL AUTO_INCREMENT;

ALTER TABLE cliente ADD CONSTRAINT PK_Cliente_Cedula PRIMARY KEY (cedula);

ALTER TABLE carritoCompra ADD CONSTRAINT PK_CarritoCompra_Id PRIMARY KEY (id);
ALTER TABLE carritoCompra MODIFY id INT NOT NULL AUTO_INCREMENT;

ALTER TABLE repartidor ADD CONSTRAINT PK_Repartidor_Id PRIMARY KEY (id);
ALTER TABLE repartidor MODIFY id INT NOT NULL AUTO_INCREMENT;

ALTER TABLE opcionEnvio ADD CONSTRAINT PK_OpcionEnvio_Id PRIMARY KEY (id);
ALTER TABLE opcionEnvio MODIFY id INT NOT NULL AUTO_INCREMENT;

ALTER TABLE tiposPago ADD CONSTRAINT PK_TiposPago_Id PRIMARY KEY (id);
ALTER TABLE tiposPago MODIFY id INT NOT NULL AUTO_INCREMENT;

ALTER TABLE pedido ADD CONSTRAINT PK_Pedido_Id PRIMARY KEY (id);
ALTER TABLE pedido MODIFY id INT NOT NULL AUTO_INCREMENT;

ALTER TABLE notificacionCorreo ADD CONSTRAINT PK_NotificacionCorreo_Id PRIMARY KEY (id);
ALTER TABLE notificacionCorreo MODIFY id INT NOT NULL AUTO_INCREMENT;


-- UIDS
ALTER TABLE autor ADD CONSTRAINT UC_Autor_UrlPagina UNIQUE (urlPagina);

ALTER TABLE editor ADD CONSTRAINT UC_Editor_Nombre UNIQUE (nombre);
ALTER TABLE editor ADD CONSTRAINT UC_Editor_UrlPagina UNIQUE (urlPagina);

ALTER TABLE libro ADD CONSTRAINT UC_Libro_Titulo UNIQUE (titulo);

ALTER TABLE cliente ADD CONSTRAINT UC_Libro_Correo UNIQUE (correo);

ALTER TABLE repartidor ADD CONSTRAINT UC_Repartidor_NombreRepartidor UNIQUE (nombreRepartidor);

ALTER TABLE opcionEnvio ADD CONSTRAINT UC_OpcionEnvio_NombreOpcion UNIQUE (nombreOpcion);

ALTER TABLE tiposPago ADD CONSTRAINT UC_TiposPago_NombreTipo UNIQUE (nombreTipo);


-- FOREIGN KEYS
ALTER TABLE libro ADD CONSTRAINT FK_Libro_Autor_id FOREIGN KEY (autor_id) REFERENCES autor (id);
ALTER TABLE libro ADD CONSTRAINT FL_Libro_Editor_id FOREIGN KEY (editor_id) REFERENCES editor (id);

ALTER TABLE stock ADD CONSTRAINT FK_Stock_Almacen_id FOREIGN KEY (almacen_id) REFERENCES almacen (id);
ALTER TABLE stock ADD CONSTRAINT FK_Stock_Libro_id FOREIGN KEY (libro_id) REFERENCES libro (isbn);

ALTER TABLE carritoCompra ADD CONSTRAINT FK_CarritoCompra_Cliente_id FOREIGN KEY (cliente_id) REFERENCES cliente (cedula);

ALTER TABLE contenido_carrito ADD CONSTRAINT FK_Contenido_carrito_Carrito_id FOREIGN KEY (carrito_id) REFERENCES carritoCompra (id);
ALTER TABLE contenido_carrito ADD CONSTRAINT FK_Contenido_carrito_Libro_id FOREIGN KEY (libro_id) REFERENCES libro (isbn);

ALTER TABLE pedido ADD CONSTRAINT FK_Pedido_Carrito_id FOREIGN KEY (carrito_id) REFERENCES carritoCompra (id);
ALTER TABLE pedido ADD CONSTRAINT FK_Pedido_Repartidor_id FOREIGN KEY (repartidor_id) REFERENCES repartidor (id);
ALTER TABLE pedido ADD CONSTRAINT FK_Pedido_OpcionEnvio_id FOREIGN KEY (opcionEnvio_id) REFERENCES opcionEnvio (id);
ALTER TABLE pedido ADD CONSTRAINT FK_Pedido_TipoPago_id FOREIGN KEY (tipoPago_id) REFERENCES tiposPago (id);
ALTER TABLE pedido ADD CONSTRAINT FK_Pedido_NotificacionCorreo_id FOREIGN KEY (notificacionCorreo_id) REFERENCES notificacionCorreo (id);