CREATE DATABASE IF NOT EXISTS baseball;

USE baseball;

CREATE TABLE tiposCliente (
  id INT NOT NULL,
  nombreTipo VARCHAR(50) NOT NULL
);

CREATE TABLE descuentos (
  id INT NOT NULL,
  porcentajeDescuento DECIMAL(3,1) NOT NULL
);

CREATE TABLE equipos (
  id INT NOT NULL,
  nombreEquipo VARCHAR(50) NOT NULL,
  cantJugadores INT NOT NULL
);

CREATE TABLE clientes (
  cedula VARCHAR(20) NOT NULL,
  nombre VARCHAR(50) NOT NULL,
  apellido VARCHAR(50) NOT NULL,
  telefono VARCHAR(20) NOT NULL,
  correo VARCHAR(50) NOT NULL,
  direccion VARCHAR(50) NOT NULL,
  equipo_id INT,
  tipoCliente_id INT NOT NULL
);

CREATE TABLE cargosEmpleado (
  id INT NOT NULL,
  nombreCargo VARCHAR(50) NOT NULL
);

CREATE TABLE empleados (
  cedula VARCHAR(20) NOT NULL,
  nombre VARCHAR(50) NOT NULL,
  apellido VARCHAR(50) NOT NULL,
  telefono VARCHAR(50) NOT NULL,
  correo VARCHAR(50) NOT NULL,
  direccion VARCHAR(50) NOT NULL,
  cargoEmpleado_id INT NOT NULL
);

CREATE TABLE proveedores (
  id INT NOT NULL,
  nombre VARCHAR(50) NOT NULL,
  telefono VARCHAR(50) NOT NULL,
  correo VARCHAR(50) NOT NULL,
  direccion VARCHAR(50) NOT NULL,
  codigoPostal VARCHAR(10) NOT NULL
);

CREATE TABLE inventarios (
  id INT NOT NULL,
  cantidadStock INT NOT NULL
);

CREATE TABLE articulos (
  id INT NOT NULL,
  nombre VARCHAR(50) NOT NULL,
  descripcionArticulo VARCHAR(255) NOT NULL,
  precio DECIMAL(10,2) NOT NULL,
  inventario_id INT NOT NULL,
  proveedor_id INT NOT NULL
);

CREATE TABLE envios (
  id INT NOT NULL,
  nombreEmpresa VARCHAR(50) NOT NULL,
  direccion VARCHAR(50) NOT NULL,
  telefono VARCHAR(50) NOT NULL
);

CREATE TABLE pedidos (
  id INT NOT NULL,
  cliente_id VARCHAR(20) NOT NULL,
  envio_id INT NOT NULL
);

CREATE TABLE articulos_pedido (
  id INT NOT NULL,
  pedido_id INT NOT NULL,
  articulo_id INT NOT NULL,
  cantidad INT NOT NULL
);

CREATE TABLE tiposPago (
  id INT NOT NULL,
  nombreTipo VARCHAR(50) NOT NULL
);

CREATE TABLE quejasCliente (
  id INT NOT NULL,
  descripcionQueja VARCHAR(255) NOT NULL,
  empleado_id VARCHAR(20) NOT NULL,
  cliente_id VARCHAR(20) NOT NULL
);

CREATE TABLE quejasEquipo (
  id INT NOT NULL,
  descripcionQueja VARCHAR(255) NOT NULL,
  empleado_id VARCHAR(20) NOT NULL,
  equipo_id INT NOT NULL
);

CREATE TABLE compras (
  id INT NOT NULL,
  totalPago DECIMAL(10,2) NOT NULL,
  fechaCompra DATE NOT NULL,
  horaCompra TIME NOT NULL,
  pedido_id INT NOT NULL,
  cliente_id VARCHAR(20) NOT NULL,
  empleado_id VARCHAR(20) NOT NULL,
  tipoPago_id INT NOT NULL
);


-- PRIMARY KEYS
ALTER TABLE tiposCliente ADD CONSTRAINT PK_TiposCliente_Id PRIMARY KEY (id);
ALTER TABLE tiposCliente MODIFY id INT NOT NULL AUTO_INCREMENT;

ALTER TABLE descuentos ADD CONSTRAINT PK_Descuentos_Id PRIMARY KEY (id);
ALTER TABLE descuentos MODIFY id INT NOT NULL AUTO_INCREMENT;

ALTER TABLE equipos ADD CONSTRAINT PK_Equipos_Id PRIMARY KEY (id);
ALTER TABLE equipos MODIFY id INT NOT NULL AUTO_INCREMENT;

ALTER TABLE clientes ADD CONSTRAINT PK_Clientes_Cedula PRIMARY KEY (cedula);

ALTER TABLE cargosEmpleado ADD CONSTRAINT PK_CargosEmpleado_Id PRIMARY KEY (id);
ALTER TABLE cargosEmpleado MODIFY id INT NOT NULL AUTO_INCREMENT;

ALTER TABLE empleados ADD CONSTRAINT PK_Empleados_Cedula PRIMARY KEY (cedula);

ALTER TABLE proveedores ADD CONSTRAINT PK_Proveedores_Id PRIMARY KEY (id);
ALTER TABLE proveedores MODIFY id INT NOT NULL AUTO_INCREMENT;

ALTER TABLE inventarios ADD CONSTRAINT PK_Inventarios_Id PRIMARY KEY (id);
ALTER TABLE inventarios MODIFY id INT NOT NULL AUTO_INCREMENT;

ALTER TABLE articulos ADD CONSTRAINT PK_Articulos_Id PRIMARY KEY (id);
ALTER TABLE articulos MODIFY id INT NOT NULL AUTO_INCREMENT;

ALTER TABLE envios ADD CONSTRAINT PK_Envios_Id PRIMARY KEY (id);
ALTER TABLE envios MODIFY id INT NOT NULL AUTO_INCREMENT;

ALTER TABLE pedidos ADD CONSTRAINT PK_Pedidos_Id PRIMARY KEY (id);
ALTER TABLE pedidos MODIFY id INT NOT NULL AUTO_INCREMENT;

ALTER TABLE articulos_pedido ADD CONSTRAINT PK_Articulos_Pedido_Id PRIMARY KEY (id);
ALTER TABLE articulos_pedido MODIFY id INT NOT NULL AUTO_INCREMENT;

ALTER TABLE tiposPago ADD CONSTRAINT PK_TiposPago_Id PRIMARY KEY (id);
ALTER TABLE tiposPago MODIFY id INT NOT NULL AUTO_INCREMENT;

ALTER TABLE quejasCliente ADD CONSTRAINT PK_QuejasCliente_Id PRIMARY KEY (id);
ALTER TABLE quejasCliente MODIFY id INT NOT NULL AUTO_INCREMENT;

ALTER TABLE quejasEquipo ADD CONSTRAINT PK_QuejasEquipo_Id PRIMARY KEY (id);
ALTER TABLE quejasEquipo MODIFY id INT NOT NULL AUTO_INCREMENT;

ALTER TABLE compras ADD CONSTRAINT PK_Compras_Id PRIMARY KEY (id);
ALTER TABLE compras MODIFY id INT NOT NULL AUTO_INCREMENT;


-- UIDS
ALTER TABLE tiposCliente ADD CONSTRAINT UC_TiposCliente_NombreTipo UNIQUE (nombreTipo);

ALTER TABLE equipos ADD CONSTRAINT UC_Equipos_NombreEquipo UNIQUE (nombreEquipo);

ALTER TABLE clientes ADD CONSTRAINT UC_Clientes_Correo UNIQUE (correo);

ALTER TABLE cargosEmpleado ADD CONSTRAINT UC_CargosEmpleado_NombreCargo UNIQUE (nombreCargo);

ALTER TABLE empleados ADD CONSTRAINT UC_Empleados_Correo UNIQUE (correo);

ALTER TABLE proveedores ADD CONSTRAINT UC_Proveedores_Nombre UNIQUE (nombre);
ALTER TABLE proveedores ADD CONSTRAINT UC_Proveedores_Correo UNIQUE (correo);

ALTER TABLE tiposPago ADD CONSTRAINT UC_TiposPago_NombreTipo UNIQUE (nombreTipo);


-- FOREIGN KEYS
ALTER TABLE equipos ADD CONSTRAINT FK_Equipos_CantJugadores FOREIGN KEY (cantJugadores) REFERENCES descuentos (id);

ALTER TABLE clientes ADD CONSTRAINT FK_Clientes_Equipo_id FOREIGN KEY (equipo_id) REFERENCES equipos (id);
ALTER TABLE clientes ADD CONSTRAINT FK_Clientes_TipoCliente_id FOREIGN KEY (tipoCliente_id) REFERENCES tiposCliente (id);

ALTER TABLE empleados ADD CONSTRAINT FK_Empleados_CargoEmpleado_id FOREIGN KEY (cargoEmpleado_id) REFERENCES cargosEmpleado (id);

ALTER TABLE articulos ADD CONSTRAINT FK_Articulos_Inventario_id FOREIGN KEY (inventario_id) REFERENCES inventarios (id);
ALTER TABLE articulos ADD CONSTRAINT FK_Articulos_Proveedor_id FOREIGN KEY (proveedor_id) REFERENCES proveedores (id);

ALTER TABLE pedidos ADD CONSTRAINT FK_Pedidos_Cliente_id FOREIGN KEY (cliente_id) REFERENCES clientes (cedula);
ALTER TABLE pedidos ADD CONSTRAINT FK_Pedidos_Envio_id FOREIGN KEY (envio_id) REFERENCES envios (id);

ALTER TABLE articulos_pedido ADD CONSTRAINT FK_Articulos_pedido_Pedido_id FOREIGN KEY (pedido_id) REFERENCES pedidos (id);
ALTER TABLE articulos_pedido ADD CONSTRAINT FK_Articulos_pedido_Articulo_id FOREIGN KEY (articulo_id) REFERENCES articulos (id);

ALTER TABLE quejasCliente ADD CONSTRAINT FK_QuejasCliente_Empleado_id FOREIGN KEY (empleado_id) REFERENCES empleados (cedula);
ALTER TABLE quejasCliente ADD CONSTRAINT FK_QuejasCliente_Cliente_id FOREIGN KEY (cliente_id) REFERENCES clientes (cedula);

ALTER TABLE quejasEquipo ADD CONSTRAINT FK_QuejasEquipo_Empleado_id FOREIGN KEY (empleado_id) REFERENCES empleados (cedula);
ALTER TABLE quejasEquipo ADD CONSTRAINT FK_QuejasEquipo_Equipo_id FOREIGN KEY (equipo_id) REFERENCES equipos (id);

ALTER TABLE compras ADD CONSTRAINT FK_Compras_Pedido_id FOREIGN KEY (pedido_id) REFERENCES pedidos (id);
ALTER TABLE compras ADD CONSTRAINT FK_Compras_Cliente_id FOREIGN KEY (cliente_id) REFERENCES clientes (cedula);
ALTER TABLE compras ADD CONSTRAINT FK_Compras_Empleado_id FOREIGN KEY (empleado_id) REFERENCES empleados (cedula);
ALTER TABLE compras ADD CONSTRAINT FK_Compras_TipoPago_id FOREIGN KEY (tipoPago_id) REFERENCES tiposPago (id);