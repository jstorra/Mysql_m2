CREATE DATABASE IF NOT EXISTS modelo_de_datos_conceptuales;

USE modelo_de_datos_conceptuales;

CREATE TABLE tiposBolso (
  id INT NOT NULL,
  nombreTipo VARCHAR(50) NOT NULL
);

CREATE TABLE colores (
  id INT NOT NULL,
  nombreColor VARCHAR(50) NOT NULL
);

CREATE TABLE bolsos (
  id INT NOT NULL,
  precioUnidad DECIMAL(10,2) NOT NULL,
  cantidadStock INT NOT NULL,
  color_id INT NOT NULL,
  tipoBolso_id INT NOT NULL
);

CREATE TABLE proveedores (
  id INT NOT NULL,
  nombre VARCHAR(50) NOT NULL,
  correoElectronico VARCHAR(50) NOT NULL,
  direccion VARCHAR(50) NOT NULL,
  telefono VARCHAR(50) NOT NULL,
  codigoPostal VARCHAR(10)
);

CREATE TABLE proveedor_bolsos (
  proveedor_id INT NOT NULL,
  bolso_id INT NOT NULL
);

CREATE TABLE clientes (
  cedula VARCHAR(20) NOT NULL,
  nombre VARCHAR(50) NOT NULL,
  apellido VARCHAR(50) NOT NULL,
  correoElectronico VARCHAR(50) NOT NULL
);

CREATE TABLE empleados (
  cedula VARCHAR(20) NOT NULL,
  nombre VARCHAR(50) NOT NULL,
  apellido VARCHAR(50) NOT NULL,
  direccion VARCHAR(50) NOT NULL,
  telefono VARCHAR(50) NOT NULL,
  correoElectronico VARCHAR(50) NOT NULL
);

CREATE TABLE facturas (
  id INT NOT NULL,
  bolso_id INT NOT NULL,
  cliente_id VARCHAR(20) NOT NULL,
  empleado_id VARCHAR(20) NOT NULL
);

CREATE TABLE tiposPago (
  id INT NOT NULL,
  nombreTipo VARCHAR(50) NOT NULL
);

CREATE TABLE ventas (
  id INT NOT NULL,
  pagoTotal DECIMAL(10,2) NOT NULL,
  fechaVenta DATE NOT NULL,
  horaVenta TIME NOT NULL,
  factura_id INT NOT NULL,
  tipoPago_id INT NOT NULL
);


-- PRIMARY KEYS
ALTER TABLE tiposBolso ADD CONSTRAINT PK_TiposBolso_id PRIMARY KEY (id);
ALTER TABLE tiposBolso MODIFY id INT NOT NULL AUTO_INCREMENT;

ALTER TABLE colores ADD CONSTRAINT PK_Colores_id PRIMARY KEY (id);
ALTER TABLE colores MODIFY id INT NOT NULL AUTO_INCREMENT;

ALTER TABLE bolsos ADD CONSTRAINT PK_Bolsos_id PRIMARY KEY (id);
ALTER TABLE bolsos MODIFY id INT NOT NULL AUTO_INCREMENT;

ALTER TABLE proveedores ADD CONSTRAINT PK_Proveedores_id PRIMARY KEY (id);
ALTER TABLE proveedores MODIFY id INT NOT NULL AUTO_INCREMENT;

ALTER TABLE clientes ADD CONSTRAINT PK_Clientes_Cedula PRIMARY KEY (cedula);

ALTER TABLE empleados ADD CONSTRAINT PK_Empleados_Cedula PRIMARY KEY (cedula);

ALTER TABLE facturas ADD CONSTRAINT PK_Facturas_id PRIMARY KEY (id);
ALTER TABLE facturas MODIFY id INT NOT NULL AUTO_INCREMENT;

ALTER TABLE tiposPago ADD CONSTRAINT PK_TiposPago_id PRIMARY KEY (id);
ALTER TABLE tiposPago MODIFY id INT NOT NULL AUTO_INCREMENT;

ALTER TABLE ventas ADD CONSTRAINT PK_Ventas_id PRIMARY KEY (id);
ALTER TABLE ventas MODIFY id INT NOT NULL AUTO_INCREMENT;


-- UIDS
ALTER TABLE tiposBolso ADD CONSTRAINT UC_TiposBolso_NombreTipo UNIQUE (nombreTipo);

ALTER TABLE colores ADD CONSTRAINT UC_Colores_NombreColor UNIQUE (nombreColor);

ALTER TABLE proveedores ADD CONSTRAINT UC_Proveedores_Nombre UNIQUE (nombre);
ALTER TABLE proveedores ADD CONSTRAINT UC_Proveedores_Correo UNIQUE (correoElectronico);
ALTER TABLE proveedores ADD CONSTRAINT UC_Proveedores_Telefono UNIQUE (telefono);

ALTER TABLE clientes ADD CONSTRAINT UC_Clientes_Correo UNIQUE (correoElectronico);

ALTER TABLE empleados ADD CONSTRAINT UC_Empleados_Correo UNIQUE (correoElectronico);

ALTER TABLE tiposPago ADD CONSTRAINT UC_TiposPago_NombreTipo UNIQUE (nombreTipo);


-- FOREIGN KEYS
ALTER TABLE bolsos ADD CONSTRAINT FK_Bolsos_Color_id FOREIGN KEY (color_id) REFERENCES colores (id);
ALTER TABLE bolsos ADD FOREIGN KEY (tipoBolso_id) REFERENCES tiposBolso (id);

ALTER TABLE proveedor_bolsos ADD CONSTRAINT FK_Proveedor_bolsos_Proveedor_id FOREIGN KEY (proveedor_id) REFERENCES proveedores (id);
ALTER TABLE proveedor_bolsos ADD CONSTRAINT FK_Proveedor_bolsos_Bolso_id FOREIGN KEY (bolso_id) REFERENCES bolsos (id);

ALTER TABLE facturas ADD CONSTRAINT FK_Facturas_Bolso_id FOREIGN KEY (bolso_id) REFERENCES bolsos (id);
ALTER TABLE facturas ADD CONSTRAINT FK_Facturas_Cliente_id FOREIGN KEY (cliente_id) REFERENCES clientes (cedula);
ALTER TABLE facturas ADD CONSTRAINT FK_Facturas_Empleado_id FOREIGN KEY (empleado_id) REFERENCES empleados (cedula);

ALTER TABLE ventas ADD CONSTRAINT FK_Ventas_Factura_id FOREIGN KEY (factura_id) REFERENCES facturas (id);
ALTER TABLE ventas ADD CONSTRAINT FK_Ventas_TipoPago_id FOREIGN KEY (tipoPago_id) REFERENCES tiposPago (id);