CREATE DATABASE IF NOT EXISTS alquiler;

USE alquiler;

CREATE TABLE clientes (
  cedula VARCHAR(20) NOT NULL,
  nombre VARCHAR(50) NOT NULL,
  apellido VARCHAR(50) NOT NULL,
  correo VARCHAR(50) NOT NULL,
  direccion VARCHAR(50) NOT NULL,
  numeroCelular VARCHAR(20) NOT NULL,
  fechaNacimiento DATE NOT NULL
);

CREATE TABLE licencias (
  id VARCHAR(20) NOT NULL,
  fechaExpedicion DATE NOT NULL,
  expedidor VARCHAR(50) NOT NULL,
  restricciones VARCHAR(255) NOT NULL,
  cliente_id VARCHAR(20) NOT NULL
);

CREATE TABLE categoriasLicencia (
  id VARCHAR(2) NOT NULL,
  descripcion VARCHAR(255) NOT NULL
);

CREATE TABLE categoria_licencia (
  licencia_id VARCHAR(20) NOT NULL,
  categoria_id VARCHAR(2) NOT NULL
);

CREATE TABLE marcas (
  id INT NOT NULL,
  nombreMarca VARCHAR(20) NOT NULL
);

CREATE TABLE modelos (
  id INT NOT NULL,
  nombreModelo VARCHAR(20) NOT NULL
);

CREATE TABLE colores (
  id INT NOT NULL,
  nombreColor VARCHAR(20) NOT NULL
);

CREATE TABLE gamas (
  id INT NOT NULL,
  nombreGama VARCHAR(20) NOT NULL,
  seguro_id INT
);

CREATE TABLE seguros (
  id INT NOT NULL,
  nombreSeguro VARCHAR(50) NOT NULL
);

CREATE TABLE estados (
  id INT NOT NULL,
  nombreEstado VARCHAR(20) NOT NULL
);

CREATE TABLE tiposVehiculo (
  id INT NOT NULL,
  nombreTipo VARCHAR(20) NOT NULL
);

CREATE TABLE vehiculos (
  numeroPlaca VARCHAR(10) NOT NULL,
  precioAlquiler DECIMAL(10,2) NOT NULL,
  diasMinimos INT NOT NULL,
  estado_id INT NOT NULL,
  color_id INT NOT NULL,
  marca_id INT NOT NULL,
  modelo_id INT NOT NULL,
  gama_id INT NOT NULL,
  tipoVehiculo_id INT NOT NULL
);

CREATE TABLE multas (
  valorMulta DECIMAL(10,2) NOT NULL,
  factura_id INT NOT NULL
);

CREATE TABLE facturas (
  id INT NOT NULL,
  fechaEntrega DATE NOT NULL,
  estadoEntrega VARCHAR(20) NOT NULL,
  detalleEntrega VARCHAR(255) NOT NULL,
  fechaDevolucionEsperada DATE NOT NULL,
  pagoTotal DECIMAL(10,2) NOT NULL,
  vehiculo_id VARCHAR(10) NOT NULL,
  cliente_id VARCHAR(20) NOT NULL,
  tipoPago_id INT NOT NULL,
  fechaDevolucionReal DATE,
  estadoDevolucion VARCHAR(20),
  detalleDevolucion VARCHAR(255)
);

CREATE TABLE tiposPago (
  id INT NOT NULL,
  nombreTipo VARCHAR(50) NOT NULL
);


-- PRIMARY KEYS
ALTER TABLE clientes ADD CONSTRAINT PK_Clientes_Cedula PRIMARY KEY (cedula);

ALTER TABLE licencias ADD CONSTRAINT PK_Licencias_Id PRIMARY KEY (id);

ALTER TABLE categoriasLicencia ADD CONSTRAINT PK_CategoriasLicencia_Id PRIMARY KEY (id);

ALTER TABLE marcas ADD CONSTRAINT PK_Marcas_Id PRIMARY KEY (id);
ALTER TABLE marcas MODIFY id INT NOT NULL AUTO_INCREMENT;

ALTER TABLE modelos ADD CONSTRAINT PK_Modelos_Id PRIMARY KEY (id);
ALTER TABLE modelos MODIFY id INT NOT NULL AUTO_INCREMENT;

ALTER TABLE colores ADD CONSTRAINT PK_Colores_Id PRIMARY KEY (id);
ALTER TABLE colores MODIFY id INT NOT NULL AUTO_INCREMENT;

ALTER TABLE gamas ADD CONSTRAINT PK_Gamas_Id PRIMARY KEY (id);
ALTER TABLE gamas MODIFY id INT NOT NULL AUTO_INCREMENT;

ALTER TABLE seguros ADD CONSTRAINT PK_Seguros_Id PRIMARY KEY (id);
ALTER TABLE seguros MODIFY id INT NOT NULL AUTO_INCREMENT;

ALTER TABLE estados ADD CONSTRAINT PK_Estados_Id PRIMARY KEY (id);
ALTER TABLE estados MODIFY id INT NOT NULL AUTO_INCREMENT;

ALTER TABLE tiposVehiculo ADD CONSTRAINT PK_TiposVehiculo_Id PRIMARY KEY (id);
ALTER TABLE tiposVehiculo MODIFY id INT NOT NULL AUTO_INCREMENT;

ALTER TABLE vehiculos ADD CONSTRAINT PK_Vehiculos_Id PRIMARY KEY (numeroPlaca);

ALTER TABLE facturas ADD CONSTRAINT PK_Facturas_Id PRIMARY KEY (id);
ALTER TABLE facturas MODIFY id INT NOT NULL AUTO_INCREMENT;

ALTER TABLE tiposPago ADD CONSTRAINT PK_TiposPago_Id PRIMARY KEY (id);
ALTER TABLE tiposPago MODIFY id INT NOT NULL AUTO_INCREMENT;


-- UIDS
ALTER TABLE clientes ADD CONSTRAINT UC_Clientes_Correo UNIQUE (correo);

ALTER TABLE marcas ADD CONSTRAINT UC_Marcas_NombreMarca UNIQUE (nombreMarca);

ALTER TABLE modelos ADD CONSTRAINT UC_Modelos_NombreModelo UNIQUE (nombreModelo);

ALTER TABLE colores ADD CONSTRAINT UC_Colores_NombreColor UNIQUE (nombreColor);

ALTER TABLE gamas ADD CONSTRAINT UC_Gamas_NombreGama UNIQUE (nombreGama);

ALTER TABLE seguros ADD CONSTRAINT UC_Seguros_NombreSeguro UNIQUE (nombreSeguro);

ALTER TABLE estados ADD CONSTRAINT UC_Estados_NombreEstado UNIQUE (nombreEstado);

ALTER TABLE tiposVehiculo ADD CONSTRAINT UC_TiposVehiculo_NombreTipo UNIQUE (nombreTipo);

ALTER TABLE tiposPago ADD CONSTRAINT UC_TiposPago_NombreTipo UNIQUE (nombreTipo);


-- FOREIGN KEYS
ALTER TABLE licencias ADD FOREIGN KEY (cliente_id) REFERENCES clientes (cedula);

ALTER TABLE categoria_licencia ADD FOREIGN KEY (licencia_id) REFERENCES licencias (id);
ALTER TABLE categoria_licencia ADD FOREIGN KEY (categoria_id) REFERENCES categoriasLicencia (id);

ALTER TABLE gamas ADD FOREIGN KEY (seguro_id) REFERENCES seguros (id);

ALTER TABLE vehiculos ADD FOREIGN KEY (estado_id) REFERENCES estados (id);
ALTER TABLE vehiculos ADD FOREIGN KEY (color_id) REFERENCES colores (id);
ALTER TABLE vehiculos ADD FOREIGN KEY (marca_id) REFERENCES marcas (id);
ALTER TABLE vehiculos ADD FOREIGN KEY (modelo_id) REFERENCES modelos (id);
ALTER TABLE vehiculos ADD FOREIGN KEY (gama_id) REFERENCES gamas (id);
ALTER TABLE vehiculos ADD FOREIGN KEY (tipoVehiculo_id) REFERENCES tiposVehiculo (id);

ALTER TABLE multas ADD FOREIGN KEY (factura_id) REFERENCES facturas (id);

ALTER TABLE facturas ADD FOREIGN KEY (vehiculo_id) REFERENCES vehiculos (numeroPlaca);
ALTER TABLE facturas ADD FOREIGN KEY (cliente_id) REFERENCES clientes (cedula);
ALTER TABLE facturas ADD FOREIGN KEY (tipoPago_id) REFERENCES tiposPago (id);