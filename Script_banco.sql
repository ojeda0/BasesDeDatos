DROP DATABASE IF EXISTS banco;
CREATE DATABASE banco;
USE banco;

CREATE TABLE Cliente (
    cod_cliente INT AUTO_INCREMENT,
    apellidos   VARCHAR(100) NOT NULL,
    nombre      VARCHAR(100) NOT NULL,
    direccion   VARCHAR(200),
    PRIMARY KEY (cod_cliente)
);

CREATE TABLE Sucursal (
    cod_sucursal        INT AUTO_INCREMENT,
    direccion           VARCHAR(200),
    capital_anio_anterior DECIMAL(15,2),
    PRIMARY KEY (cod_sucursal)
);

CREATE TABLE Cuenta (
    cod_cuenta   INT AUTO_INCREMENT,
    saldo        DECIMAL(15,2) NOT NULL,
    interes      DECIMAL(5,2),
    cod_cliente  INT NOT NULL,
    cod_sucursal INT NOT NULL,
    PRIMARY KEY (cod_cuenta),
    FOREIGN KEY (cod_cliente)
        REFERENCES Cliente(cod_cliente),
    FOREIGN KEY (cod_sucursal)
        REFERENCES Sucursal(cod_sucursal)
);

CREATE TABLE Tipo_movimiento (
    cod_tipo_mov INT AUTO_INCREMENT,
    descripcion  VARCHAR(100),
    salida       BOOLEAN,
    PRIMARY KEY (cod_tipo_mov)
);

CREATE TABLE Movimiento (
    mes          INT,
    num_mov_mes  INT,
    importe      DECIMAL(15,2) NOT NULL,
    hora         TIME,
    dia          INT,
    anio         INT,
    cod_cuenta   INT NOT NULL,
    cod_tipo_mov INT NOT NULL,
    PRIMARY KEY (mes, num_mov_mes),
    FOREIGN KEY (cod_cuenta)
        REFERENCES Cuenta(cod_cuenta),
    FOREIGN KEY (cod_tipo_mov)
        REFERENCES Tipo_movimiento(cod_tipo_mov)
);

USE banco;

-- =============================================
-- 1. Insertar CLIENTES (15 Registros)
-- =============================================
INSERT INTO Cliente (apellidos, nombre, direccion) VALUES 
('García López', 'Juan', 'Calle Mayor 12, Madrid'),
('Martínez Ruiz', 'María', 'Av. de la Constitución 45, Sevilla'),
('Fernández Pérez', 'Antonio', 'Plaza España 3, Barcelona'),
('González Díaz', 'Laura', 'C/ Gran Vía 99, Madrid'),
('Rodríguez Sánchez', 'Carlos', 'Paseo de la Castellana 200, Madrid'),
('López Gómez', 'Ana', 'Calle Larios 5, Málaga'),
('Sánchez Romero', 'David', 'Av. del Puerto 10, Valencia'),
('Pérez Gil', 'Elena', 'Calle Betis 22, Sevilla'),
('Gómez Vázquez', 'Javier', 'Rúa do Franco 8, Santiago'),
('Ruiz Serrano', 'Sofía', 'Calle San Fernando 1, Bilbao'),
('Díaz Castro', 'Manuel', 'Av. Marítima 33, Las Palmas'),
('Hernández Muñoz', 'Lucía', 'Plaza Mayor 1, Salamanca'),
('Jiménez Torres', 'Pablo', 'Calle Alfonso X 50, Murcia'),
('Álvarez Flores', 'Carmen', 'Paseo Zorrilla 12, Valladolid'),
('Moreno Iglesia', 'Roberto', 'Calle Real 4, Coruña');

-- =============================================
-- 2. Insertar SUCURSALES (5 Registros)
-- =============================================
INSERT INTO Sucursal (direccion, capital_anio_anterior) VALUES 
('Sucursal Central Madrid', 5000000.00),
('Sucursal Norte Barcelona', 3500000.50),
('Sucursal Sur Sevilla', 2100000.00),
('Sucursal Este Valencia', 2800000.75),
('Sucursal Oeste Bilbao', 1900000.25);

-- =============================================
-- 3. Insertar TIPOS DE MOVIMIENTO (5 Registros)
-- =============================================
-- salida = 1 (TRUE) es dinero que sale, 0 (FALSE) es dinero que entra
INSERT INTO Tipo_movimiento (descripcion, salida) VALUES 
('Ingreso en efectivo', 0),
('Retirada Cajero', 1),
('Transferencia Recibida', 0),
('Transferencia Enviada', 1),
('Pago con Tarjeta', 1);

-- =============================================
-- 4. Insertar CUENTAS (20 Registros)
-- =============================================
-- Asignamos clientes (1-15) y sucursales (1-5) aleatoriamente
INSERT INTO Cuenta (saldo, interes, cod_cliente, cod_sucursal) VALUES 
(1500.50, 0.01, 1, 1),
(25000.00, 0.05, 1, 2),
(340.20, 0.00, 2, 3),
(10500.00, 0.02, 3, 1),
(50.00, 0.00, 4, 4),
(9800.75, 0.03, 5, 1),
(1200.00, 0.01, 6, 2),
(5000.00, 0.01, 7, 3),
(300.00, 0.00, 8, 3),
(45000.00, 0.05, 9, 5),
(120.50, 0.00, 10, 5),
(6700.00, 0.02, 11, 4),
(890.00, 0.01, 12, 1),
(2300.00, 0.01, 13, 2),
(150.00, 0.00, 14, 3),
(9999.99, 0.03, 15, 4),
(100.00, 0.00, 2, 1), -- El cliente 2 tiene otra cuenta
(5000.00, 0.02, 5, 5), -- El cliente 5 tiene otra cuenta
(750.00, 0.01, 8, 2), -- El cliente 8 tiene otra cuenta
(0.00, 0.00, 1, 3),   -- El cliente 1 tiene otra cuenta vacía
(750.00, 0.12, 8, 2);


-- =============================================
-- 5. Insertar MOVIMIENTOS (60 Registros)
-- =============================================
-- Nota: La PK es (mes, num_mov_mes). 
-- Asumimos que num_mov_mes es un contador único global por mes según tu diseño.
-- Distribuimos movimientos en los meses 1, 2 y 3 del año 2024.

-- MOVIMIENTOS ENERO (Mes 1) - 20 Movimientos
INSERT INTO Movimiento (mes, num_mov_mes, importe, hora, dia, anio, cod_cuenta, cod_tipo_mov) VALUES
(1, 1, 100.00, '09:00:00', 10, 2024, 1, 1), -- Ingreso
(1, 2, 50.00, '10:30:00', 11, 2024, 1, 2),  -- Retirada
(1, 3, 200.00, '11:00:00', 12, 2024, 2, 3), -- Transf Recibida
(1, 4, 20.00, '12:15:00', 12, 2024, 3, 5),  -- Pago Tarjeta
(1, 5, 500.00, '13:00:00', 13, 2024, 4, 1),
(1, 6, 60.00, '14:20:00', 14, 2024, 5, 2),
(1, 7, 1000.00, '09:10:00', 15, 2024, 6, 3),
(1, 8, 50.00, '18:00:00', 15, 2024, 7, 5),
(1, 9, 30.00, '19:30:00', 16, 2024, 1, 5),
(1, 10, 150.00, '08:00:00', 17, 2024, 8, 4), -- Transf Enviada
(1, 11, 300.00, '09:45:00', 18, 2024, 9, 1),
(1, 12, 20.00, '10:00:00', 19, 2024, 10, 2),
(1, 13, 1200.00, '11:30:00', 20, 2024, 11, 3),
(1, 14, 40.00, '12:45:00', 21, 2024, 12, 5),
(1, 15, 500.00, '13:15:00', 22, 2024, 13, 1),
(1, 16, 100.00, '14:00:00', 23, 2024, 14, 2),
(1, 17, 75.00, '15:30:00', 24, 2024, 15, 5),
(1, 18, 2000.00, '16:00:00', 25, 2024, 16, 3),
(1, 19, 50.00, '17:45:00', 26, 2024, 17, 2),
(1, 20, 100.00, '18:15:00', 27, 2024, 18, 1);

-- MOVIMIENTOS FEBRERO (Mes 2) - 20 Movimientos
INSERT INTO Movimiento (mes, num_mov_mes, importe, hora, dia, anio, cod_cuenta, cod_tipo_mov) VALUES
(2, 1, 60.00, '09:05:00', 1, 2024, 1, 5),
(2, 2, 100.00, '10:10:00', 2, 2024, 2, 1),
(2, 3, 500.00, '11:20:00', 3, 2024, 4, 4),
(2, 4, 30.00, '12:30:00', 4, 2024, 5, 2),
(2, 5, 1500.00, '13:40:00', 5, 2024, 6, 3),
(2, 6, 25.00, '14:50:00', 6, 2024, 7, 5),
(2, 7, 200.00, '15:00:00', 7, 2024, 8, 1),
(2, 8, 100.00, '16:10:00', 8, 2024, 9, 2),
(2, 9, 3000.00, '17:20:00', 9, 2024, 10, 3),
(2, 10, 45.00, '18:30:00', 10, 2024, 11, 5),
(2, 11, 80.00, '08:45:00', 11, 2024, 12, 1),
(2, 12, 60.00, '09:55:00', 12, 2024, 13, 2),
(2, 13, 150.00, '11:05:00', 13, 2024, 14, 4),
(2, 14, 90.00, '12:15:00', 14, 2024, 15, 5),
(2, 15, 2500.00, '13:25:00', 15, 2024, 16, 3),
(2, 16, 40.00, '14:35:00', 16, 2024, 17, 2),
(2, 17, 120.00, '15:45:00', 17, 2024, 18, 1),
(2, 18, 55.00, '16:55:00', 18, 2024, 19, 5),
(2, 19, 200.00, '18:00:00', 19, 2024, 20, 1),
(2, 20, 300.00, '19:10:00', 20, 2024, 1, 4);

-- MOVIMIENTOS MARZO (Mes 3) - 20 Movimientos
INSERT INTO Movimiento (mes, num_mov_mes, importe, hora, dia, anio, cod_cuenta, cod_tipo_mov) VALUES
(3, 1, 1000.00, '08:30:00', 1, 2024, 2, 3),
(3, 2, 50.00, '09:40:00', 2, 2024, 3, 2),
(3, 3, 75.00, '10:50:00', 3, 2024, 4, 5),
(3, 4, 500.00, '12:00:00', 4, 2024, 1, 1),
(3, 5, 20.00, '13:10:00', 5, 2024, 6, 2),
(3, 6, 400.00, '14:20:00', 6, 2024, 7, 4),
(3, 7, 150.00, '15:30:00', 7, 2024, 8, 1),
(3, 8, 35.00, '16:40:00', 8, 2024, 9, 5),
(3, 9, 800.00, '17:50:00', 9, 2024, 10, 3),
(3, 10, 60.00, '19:00:00', 10, 2024, 11, 2),
(3, 11, 100.00, '08:15:00', 11, 2024, 12, 1),
(3, 12, 200.00, '09:25:00', 12, 2024, 13, 4),
(3, 13, 50.00, '10:35:00', 13, 2024, 14, 5),
(3, 14, 300.00, '11:45:00', 14, 2024, 15, 1),
(3, 15, 70.00, '12:55:00', 15, 2024, 16, 2),
(3, 16, 1200.00, '14:05:00', 16, 2024, 17, 3),
(3, 17, 90.00, '15:15:00', 17, 2024, 18, 5),
(3, 18, 150.00, '16:25:00', 18, 2024, 19, 1),
(3, 19, 40.00, '17:35:00', 19, 2024, 20, 2),
(3, 20, 500.00, '18:45:00', 20, 2024, 1, 3);