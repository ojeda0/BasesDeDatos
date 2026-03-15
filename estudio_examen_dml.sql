use banco;

-- 1. a)Crea una tabla llamada reintegros con aquellos movimientos de tipo “Retirada cajero”
create table reintegros as
	select mo.* from movimiento mo
    join tipo_movimiento tm using (cod_tipo_mov)
	where tm.descripcion = "Retirada cajero";
    
select * from reintegros;

-- 1. b) Crea una tabla llamada sucursales_oro con las sucursales cuyo capital del año anterior supera a la media
create table sucursales_oro as
	select * from sucursal
	where capital_anio_anterior > (
		select avg(capital_anio_anterior) from sucursal
	);

select * from sucursales_oro;
    
-- 1. c) Crea una tabla llamadas clientes_residuales con los clientes que no tienen cuenta.
create table clientes_residuales as
	select cl.* from cliente cl
	where cl.cod_cliente not in (
		select cu.cod_cliente from cuenta cu
	);

select * from clientes_residuales;

-- 1. d) Crea una tabla llamada cuentas_inactivas con las cuentas que no tienen movimientos en el último año. Mostrará el saldo el nombre y los apellidos del cliente.
create table cuentas_inactivas as
	select cu.saldo, concat_ws(" ", cl.nombre, cl.apellidos) as cliente from cuenta cu
	join cliente cl using (cod_cliente)
	where cu.cod_cuenta not in (
		select mo.cod_cuenta from movimiento mo
		where mo.anio >= year(now()) - 1
	);
    
select * from cuentas_inactivas;

-- 1. e) Crea una tabla llamada movimientos_antiguos con aquellos movimientos realizados hace más de cinco años. La información que almacenará será 
-- importe, hora día año y descripción del tipo de movimiento.
create table movimientos_antiguos as
	select mo.importe, concat_ws(" ", mo.hora, mo.dia, mo.anio) as fecha, tm.descripcion from movimiento mo
	join tipo_movimiento tm using (cod_tipo_mov)
	where mo.anio < year(now()) - 5;
    
select * from movimientos_antiguos;

-- 2. a) Crea la tabla cuentas_clientes y almacena el nombre del cliente, el código de la cuenta y el saldo de la misma.
create table cuentas_clientes as
	select cl.nombre, cu.cod_cuenta, cu.saldo from cliente cl
	join cuenta cu using (cod_cliente);
    
select * from cuentas_clientes;

-- 2. b) Crea la tabla cuentas_sucursal donde se almacenará la dirección de la sucursal, el código de la cuenta y el nombre y apellidos del cliente propietario
-- de dicha cuenta
create table cuentas_sucursal (
	direccion varchar(250),
    cod_cuenta bigint,
    cliente varchar(250)
);

insert into cuentas_sucursal (
	select su.direccion, cu.cod_cuenta, concat_ws(" ", cl.nombre, cl.apellidos) as cliente from cuenta cu
	join sucursal su using (cod_sucursal)
	join cliente cl using (cod_cliente)
);

select * from cuentas_sucursal;

-- 2. c)  Crea la tabla movimientos donde aparezca el importe, la fecha (en una misma columna) y la descripción del tipo para aquellos importes que superen
-- los 1000 euros y están realizados por clientes cuyo nombre empieza por A. (No hay que mostrar nada del cliente).
create table movimientos as
	select mo.importe, concat_ws(" ", mo.hora, mo.dia, mo.anio) as fecha, tm.descripcion from movimiento mo
	join tipo_movimiento tm using (cod_tipo_mov)
	join cuenta cu using (cod_cuenta)
	join cliente cl using (cod_cliente)
	where mo.importe > 1000 and
		cl.nombre like "A%";
        
select * from movimientos;

-- 3. a) Elimina los clientes sin cuentas
delete from cliente cl
where cl.cod_cliente not in (
	select cu.cod_cliente from cuenta cu
);

-- 3. b) Elimina las cuentas sin movimientos
delete from cuenta cu
where cu.cod_cuenta not in (
	select mo.cod_cuenta from movimiento mo
);

-- 3. c) Elimina los tipos de movimiento nunca utilizados
delete from tipo_movimiento tm
where tm.cod_tipo_mov not in (
	select mo.cod_tipo_mov from movimiento mo
);

-- 3. d) Añade el prefijo OFF_ al nombre del cliente para aquellos clientes que no realizan movimientos desde hace 2 años.
update cliente cl set nombre = concat('OFF_', cl.nombre)
where cl.cod_cliente not in (
	select cu.cod_cliente from cuenta cu
	where cu.cod_cuenta in (
		select mo.cod_cuenta from movimiento mo
		where anio >= year(now()) - 2
	)
);

-- 4. a) Modifica el ID de un cliente que tenga cuentas asociadas. Debes de poder hacerlo, para ello decide cómo va a implicar esto en el resto de tablas donde
-- se referencia dicho ID.
alter table cuenta drop constraint cuenta_ibfk_1;

alter table cuenta add constraint cuenta_ibfk_1 foreign key (cod_cliente) references cliente(cod_cliente) on update cascade;

update cliente cl set cl.cod_cliente = 255
where cl.cod_cliente = (
	select cu.cod_cliente from cuenta cu
    limit 1
);

select * from cliente;

-- 4. b) Elimina el tipo de movimiento “Retirada cajero”. Has de poder hacerlo así que, decide justificadamente como va a afectar esta eliminación en el
-- resto del sistema.
alter table movimiento drop constraint movimiento_ibfk_2;
alter table movimiento add constraint movimiento_ibfk_2 foreign key (cod_tipo_mov) references tipo_movimiento(cod_tipo_mov) on delete cascade;

delete from tipo_movimiento tm
where tm.descripcion = 'Retirada cajero';

select * from tipo_movimiento;
select * from movimiento;