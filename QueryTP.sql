DROP DATABASE IF EXISTS banco_db;
CREATE DATABASE IF NOT EXISTS banco_db;
USE banco_db;

-- PROVINCIAS
CREATE TABLE provincias (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(40) NOT NULL
);


select * from usuarios;
select * from cuentas;
select * from clientes;
select * from Prestamos;

-- LOCALIDADES
CREATE TABLE localidades (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(50) NOT NULL,
    provincia_id INT,
    FOREIGN KEY (provincia_id) REFERENCES provincias(id)
);

-- USUARIOS
CREATE TABLE usuarios (
    id_usuario INT PRIMARY KEY AUTO_INCREMENT,
    usuario VARCHAR(50) UNIQUE,
    contrasena VARCHAR(100),
    tipo_usuario VARCHAR(20),
    activo BOOLEAN,
    fecha_creacion DATETIME,
    fecha_modificacion DATETIME
);

-- CLIENTES
CREATE TABLE clientes (
    id_cliente INT PRIMARY KEY AUTO_INCREMENT,
    id_usuario INT,
    dni VARCHAR(20) UNIQUE,
    nombre VARCHAR(50),
    apellido VARCHAR(50),
    sexo VARCHAR(10),
    nacionalidad VARCHAR(30),
    fecha_nacimiento DATE,
    direccion VARCHAR(100),
    correo_electronico VARCHAR(100),
    telefono VARCHAR(20),
    fecha_alta DATETIME,
    activo BOOLEAN,
    id_localidad INT,
    id_provincia INT,
    FOREIGN KEY (id_usuario) REFERENCES usuarios(id_usuario),
    FOREIGN KEY (id_localidad) REFERENCES localidades(id),
    FOREIGN KEY (id_provincia) REFERENCES provincias(id)
);

-- ADMINISTRADORES
CREATE TABLE administradores (
    id_administrador INT PRIMARY KEY AUTO_INCREMENT,
    id_usuario INT,
    nombre VARCHAR(50),
    apellido VARCHAR(50),
    dni VARCHAR(20) UNIQUE,
    email VARCHAR(100),
    telefono VARCHAR(20),
    fecha_alta DATETIME,
    FOREIGN KEY (id_usuario) REFERENCES usuarios(id_usuario)
);

-- TIPOS_CUENTA
CREATE TABLE tipos_cuenta (
    id_tipo_cuenta INT PRIMARY KEY AUTO_INCREMENT,
    descripcion VARCHAR(50),
    activo BOOLEAN
);

-- CUENTAS
CREATE TABLE cuentas (
    id_cuenta INT PRIMARY KEY AUTO_INCREMENT,
    id_cliente INT,
    id_tipo_cuenta INT,
    numero_cuenta VARCHAR(20) UNIQUE,
    cbu VARCHAR(22),
    saldo DECIMAL(15,2),
    fecha_creacion DATETIME,
    activa BOOLEAN,
    FOREIGN KEY (id_cliente) REFERENCES clientes(id_cliente),
    FOREIGN KEY (id_tipo_cuenta) REFERENCES tipos_cuenta(id_tipo_cuenta)
);

-- TIPOS_MOVIMIENTO
CREATE TABLE tipos_movimiento (
    id_tipo_movimiento INT PRIMARY KEY AUTO_INCREMENT,
    descripcion VARCHAR(50),
    tipo VARCHAR(20),
    activo BOOLEAN
);

-- MOVIMIENTOS
CREATE TABLE movimientos (
    id_movimiento INT PRIMARY KEY AUTO_INCREMENT,
    id_cuenta INT,
    id_tipo_movimiento INT,
    concepto VARCHAR(100),
    importe DECIMAL(15,2),
    fecha DATETIME,
    detalle VARCHAR(200),
    FOREIGN KEY (id_cuenta) REFERENCES cuentas(id_cuenta),
    FOREIGN KEY (id_tipo_movimiento) REFERENCES tipos_movimiento(id_tipo_movimiento)
);

-- PRESTAMOS
CREATE TABLE prestamos (
    id_prestamo INT PRIMARY KEY AUTO_INCREMENT,
    id_cliente INT,
    id_cuenta_deposito INT,
    monto_pedido DECIMAL(15,2),
    cantidad_cuotas INT,
    monto_cuota DECIMAL(15,2),
    monto_total DECIMAL(15,2),
    estado VARCHAR(20),
    fecha_pedido DATETIME,
    fecha_autorizacion DATETIME,
    autorizado_por INT,
    observaciones VARCHAR(200),
    FOREIGN KEY (id_cliente) REFERENCES clientes(id_cliente),
    FOREIGN KEY (id_cuenta_deposito) REFERENCES cuentas(id_cuenta),
    FOREIGN KEY (autorizado_por) REFERENCES administradores(id_administrador)
);

-- CUOTAS_PRESTAMO
CREATE TABLE cuotas_prestamo (
    id_cuota INT PRIMARY KEY AUTO_INCREMENT,
    id_prestamo INT,
    numero_cuota INT,
    monto_cuota DECIMAL(15,2),
    fecha_vencimiento DATE,
    fecha_pago DATE,
    estado VARCHAR(20),
    id_cuenta_pago INT,
    FOREIGN KEY (id_prestamo) REFERENCES prestamos(id_prestamo),
    FOREIGN KEY (id_cuenta_pago) REFERENCES cuentas(id_cuenta)
);

-- TRANSFERENCIAS
CREATE TABLE transferencias (
    id_transferencia INT PRIMARY KEY AUTO_INCREMENT,
    id_cuenta_origen INT,
    id_cuenta_destino INT,
    concepto VARCHAR(100),
    importe DECIMAL(15,2),
    fecha DATETIME,
    estado VARCHAR(20),
    FOREIGN KEY (id_cuenta_origen) REFERENCES cuentas(id_cuenta),
    FOREIGN KEY (id_cuenta_destino) REFERENCES cuentas(id_cuenta)
);




-- PROVINCIAS
INSERT INTO provincias (nombre) VALUES 
('Buenos Aires'),
('Córdoba');

-- LOCALIDADES
INSERT INTO localidades (nombre, provincia_id) VALUES 
('Mar del Plata', 1),
('Don Torcuato', 1),
('Córdoba Capital', 2),
('Villa Carlos Paz', 2);

-- USUARIOS
INSERT INTO usuarios (usuario, contrasena, tipo_usuario, activo, fecha_creacion, fecha_modificacion) VALUES 
('admin1', 'admin123', 'admin', true, NOW(), NOW()),
('cliente1', 'pass123', 'cliente', true, NOW(), NOW());

-- ADMINISTRADORES
INSERT INTO administradores (id_usuario, nombre, apellido, dni, email, telefono, fecha_alta) VALUES 
(1, 'Ana', 'García', '22334455', 'ana.admin@banco.com', '1144556677', NOW());

-- CLIENTES
INSERT INTO clientes (id_usuario, dni, nombre, apellido, sexo, nacionalidad, fecha_nacimiento, direccion, correo_electronico, telefono, fecha_alta, activo, id_localidad, id_provincia) VALUES 
(2, '12345678', 'Juan', 'Pérez', 'Masculino', 'Argentina', '1990-05-10', 'Calle Falsa 123', 'juan@example.com', '1133445566', NOW(), true, 2, 1);

-- TIPOS_CUENTA
INSERT INTO tipos_cuenta (descripcion, activo) VALUES 
('Caja de Ahorro', true),
('Cuenta Corriente', true);

-- CUENTAS
INSERT INTO cuentas (id_cliente, id_tipo_cuenta, numero_cuenta, cbu, saldo, fecha_creacion, activa) VALUES 
(1, 1, '1234567890', '0001234560000000000012', 10000.00, NOW(), true);

-- TIPOS_MOVIMIENTO
INSERT INTO tipos_movimiento (descripcion, tipo, activo) VALUES 
('Depósito', 'Crédito', true),
('Extracción', 'Débito', true);

-- MOVIMIENTOS
INSERT INTO movimientos (id_cuenta, id_tipo_movimiento, concepto, importe, fecha, detalle) VALUES 
(1, 1, 'Depósito inicial', 10000.00, NOW(), 'Primer depósito al abrir la cuenta');

-- PRESTAMOS
INSERT INTO prestamos (id_cliente, id_cuenta_deposito, monto_pedido, cantidad_cuotas, monto_cuota, monto_total, estado, fecha_pedido) VALUES 
(1, 1, 50000.00, 12, 4500.00, 54000.00, 'Pendiente', NOW());

-- CUOTAS_PRESTAMO
INSERT INTO cuotas_prestamo (id_prestamo, numero_cuota, monto_cuota, fecha_vencimiento, estado) VALUES 
(1, 1, 4500.00, '2025-07-01', 'Pendiente');

-- TRANSFERENCIAS
INSERT INTO transferencias (id_cuenta_origen, id_cuenta_destino, concepto, importe, fecha, estado) VALUES 
(1, 1, 'Transferencia de prueba', 1000.00, NOW(), 'Completada');