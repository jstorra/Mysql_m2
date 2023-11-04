CREATE DATABASE IF NOT EXISTS factura_abc;

USE factura_abc;

CREATE TABLE clientes (
  cedula VARCHAR(20) NOT NULL,
  nombre VARCHAR(50) NOT NULL,
  direccion VARCHAR(50) NOT NULL,
  correoElectronico VARCHAR(50) NOT NULL
);

CREATE TABLE proveedores (
  id INT NOT NULL,
  nombre VARCHAR(50) NOT NULL,
  direccion VARCHAR(50) NOT NULL,
  correoElectronico VARCHAR(50) NOT NULL,
  telefono VARCHAR(50) NOT NULL
);

CREATE TABLE productos (
  id INT NOT NULL,
  nombre VARCHAR(50) NOT NULL,
  precio DECIMAL(10,2) NOT NULL,
  cantidadStock INT NOT NULL,
  nivelPedidos INT NOT NULL,
  proveedor_id INT NOT NULL
);

CREATE TABLE pedidos (
  id INT NOT NULL,
  fechaPedido DATE NOT NULL,
  cliente_id VARCHAR(20) NOT NULL
);

CREATE TABLE detalle_pedido (
  id INT NOT NULL,
  producto_id INT NOT NULL,
  pedido_id INT NOT NULL,
  cantidadSolicitada INT NOT NULL
);

CREATE TABLE facturas (
  id INT NOT NULL,
  fechaFacturacion DATE NOT NULL,
  pedido_id INT NOT NULL
);

CREATE TABLE detalle_factura (
  id INT NOT NULL,
  factura_id INT NOT NULL,
  producto_id INT NOT NULL,
  cantidadEnviada INT NOT NULL,
  precioUnidad DECIMAL(10,2) NOT NULL
);

CREATE TABLE tiposPago (
  id INT NOT NULL,
  nombreTipo VARCHAR(50) NOT NULL
);

CREATE TABLE compras (
  id INT NOT NULL,
  totalPago DECIMAL(10,2) NOT NULL,
  fechaPago DATE NOT NULL,
  horaPago TIME NOT NULL,
  tipoPago_id INT NOT NULL,
  factura_id INT NOT NULL,
  cliente_id VARCHAR(20) NOT NULL
);


-- PRIMARY KEYS
ALTER TABLE clientes ADD CONSTRAINT PK_Clientes_Cedula PRIMARY KEY (cedula);

ALTER TABLE proveedores ADD CONSTRAINT PK_Proveedores_Id PRIMARY KEY (id);
ALTER TABLE proveedores MODIFY id INT NOT NULL AUTO_INCREMENT;

ALTER TABLE productos ADD CONSTRAINT PK_Productos_Id PRIMARY KEY (id);
ALTER TABLE productos MODIFY id INT NOT NULL AUTO_INCREMENT;

ALTER TABLE pedidos ADD CONSTRAINT PK_Pedidos_Id PRIMARY KEY (id);
ALTER TABLE pedidos MODIFY id INT NOT NULL AUTO_INCREMENT;


ALTER TABLE detalle_pedido ADD CONSTRAINT PK_Detalle_Pedido_Id PRIMARY KEY (id);
ALTER TABLE detalle_pedido MODIFY id INT NOT NULL AUTO_INCREMENT;

ALTER TABLE facturas ADD CONSTRAINT PK_Facturas_Id PRIMARY KEY (id);
ALTER TABLE facturas MODIFY id INT NOT NULL AUTO_INCREMENT;

ALTER TABLE detalle_factura ADD CONSTRAINT PK_Detalle_Factura_Id PRIMARY KEY (id);
ALTER TABLE detalle_factura MODIFY id INT NOT NULL AUTO_INCREMENT;

ALTER TABLE tiposPago ADD CONSTRAINT PK_TiposPago_Id PRIMARY KEY (id);
ALTER TABLE tiposPago MODIFY id INT NOT NULL AUTO_INCREMENT;

ALTER TABLE compras ADD CONSTRAINT PK_Compras_Id PRIMARY KEY (id);
ALTER TABLE compras MODIFY id INT NOT NULL AUTO_INCREMENT;


-- UIDS
ALTER TABLE clientes ADD CONSTRAINT UC_Clientes_Correo UNIQUE (correoElectronico);

ALTER TABLE proveedores ADD CONSTRAINT UC_Proveedores_Correo UNIQUE (correoElectronico);

ALTER TABLE productos ADD CONSTRAINT UC_Productos_Nombre UNIQUE (nombre);

ALTER TABLE tiposPago ADD CONSTRAINT UC_TiposPago_NombreTipo UNIQUE (nombreTipo);


-- FOREIGN KEYS
ALTER TABLE productos ADD CONSTRAINT FK_Productos_Proveedor_id FOREIGN KEY (proveedor_id) REFERENCES proveedores (id);

ALTER TABLE pedidos ADD CONSTRAINT FK_Pedidos_Cliente_id FOREIGN KEY (cliente_id) REFERENCES clientes (cedula);

ALTER TABLE detalle_pedido ADD CONSTRAINT FK_Detalle_pedido_Producto_id FOREIGN KEY (producto_id) REFERENCES productos (id);
ALTER TABLE detalle_pedido ADD CONSTRAINT FK_Detalle_pedido_Pedido_id FOREIGN KEY (pedido_id) REFERENCES pedidos (id);

ALTER TABLE facturas ADD CONSTRAINT FK_Facturas_Pedido_id FOREIGN KEY (pedido_id) REFERENCES pedidos (id);

ALTER TABLE detalle_factura ADD CONSTRAINT FK_Detalle_factura_Factura_id FOREIGN KEY (factura_id) REFERENCES facturas (id);
ALTER TABLE detalle_factura ADD CONSTRAINT FK_Detalle_factura_Producto_id FOREIGN KEY (producto_id) REFERENCES productos (id);

ALTER TABLE compras ADD CONSTRAINT FK_Compras_TipoPago_id FOREIGN KEY (tipoPago_id) REFERENCES tiposPago (id);
ALTER TABLE compras ADD CONSTRAINT FK_Compras_Factura_id FOREIGN KEY (factura_id) REFERENCES facturas (id);
ALTER TABLE compras ADD CONSTRAINT FK_Compras_Cliente_id FOREIGN KEY (cliente_id) REFERENCES clientes (cedula);