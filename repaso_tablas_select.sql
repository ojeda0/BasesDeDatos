use banco;

-- 1. Crear tablas a partir de datos en otras tablas

-- 1.1. Crea una tabla con un registro donde diga tu nombre
CREATE TABLE mi_nombre as SELECT 'Octavio';
SELECT * FROM mi_nombre;

-- 1.2. Crea la tabla cuentas sin movimiento
CREATE TABLE cuentas_sin_mov AS 
	SELECT c.cod_cuenta, c.saldo, concat(cl.nombre, cl.apellidos) FROM cuenta c
	LEFT JOIN movimiento m using (cod_cuenta)
    JOIN cliente cl using (cod_cliente)
	WHERE m.cod_cuenta is null;

SELECT * FROM cuentas_sin_mov;

-- 1.3. Crea una tabla con movimientos de tipo Ingreso
CREATE TABLE movimientos_por_ingreso as 
	SELECT m.num_mov_mes, m.importe, tm.descripcion FROM movimiento m
	JOIN tipo_movimiento tm using (cod_tipo_mov)
	WHERE tm.descripcion = 'Ingreso en efectivo';
    
-- 2. Insertar datos en tabla B a partir de datos en tabla A

-- 2.1. Inserta los nombres completos de aquellos clientes que terminan en 2
-- en una tabla temporal llamada clientes_terminan_2
CREATE TABLE clientes_terminan_2 (
	nombre_completo varchar(250)
);

INSERT INTO clientes_terminan_2 
	SELECT concat(nombre, apellidos) from cliente where nombre like '%2';

SELECT * FROM clientes_terminan_2;

-- 2.2. Inserta en la tabla sucursales_pobres aquellas sucursales
-- con menos de 10.000 euros de capital
CREATE TABLE sucursal_pobre (
	cod_sucursal bigint,
    direccion varchar(255),
    capital_anio_anterior decimal(16,2)
);

INSERT INTO sucursal_pobre 
	SELECT * FROM sucursal
	WHERE capital_anio_anterior < 10000;
    
SELECT * FROM sucursal_pobre;


-- 3. Modificación o borrado de datos resultantes de subquerys
-- 3.1. Borra todos los clientes que no tienen cuenta
DELETE FROM cliente 
WHERE cod_cliente NOT IN (
	SELECT distinct cod_cliente FROM cuenta
);

-- Incrementa un 10% el saldo de aquellas cuentas que no han hecho "Retirada cajero"
UPDATE cuenta SET saldo = saldo *1.1 
WHERE cod_cuenta IN (
	SELECT DISTINCT cod_cuenta FROM movimiento 
	WHERE cod_tipo_mov not in (
		SELECT cod_tipo_mov FROM tipo_movimiento tm 
		WHERE tm.descripcion = 'Retirada cajero'
	)
);

-- Incrementa un 5% el capital del año anterior para aquellas sucursales
-- que tienen algunas cuentas con un interes por debajo del 0.4

SELECT * FROM movimiento;