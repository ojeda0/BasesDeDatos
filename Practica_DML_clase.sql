use banco;

select * from movimiento;
select * from tipo_movimiento;

-- EJ 1. a) Crea una tabla llamada reintegros con aquellos movimientos de tipo "Retirada cajero”
create table reintegros as
	select m.* from movimiento m
    join tipo_movimiento tm using (cod_tipo_mov)
    where tm.descripcion = 'Retirada Cajero';
    
select * from reintegros;

select * from cliente;
select * from cuenta;

-- EJ 2. a) Crea la tabla cuentas_clientes y almacena el nombre del cliente, el código de la cuenta y el saldo de la misma
create table cuentas_clientes as
	select cl.nombre, cu.cod_cuenta, cu.saldo from cliente cl
    join cuenta cu using (cod_cliente);
    
select * from cuentas_clientes;

select * from cuenta;
select * from cliente;

-- EJ 3. a) Elimina los clientes sin cuentas
delete from cliente
where cod_cliente not in (select cod_cliente from cuenta);
    
insert into cliente (apellidos, nombre, direccion)
values
	("De la Palmilla", "Juan", "La Palmilla");

-- EJ 4. a) Modifica el ID de un cliente que tenga cuentas asociadas. Debes de poder hacerlo, para ello decide cómo va a implicar esto en el resto de tablas donde se referencia dicho ID.
select * from cuenta;

alter table cuenta
drop constraint cuenta_ibfk_1;

alter table cuenta
add constraint cuenta_ibfk_1 foreign key (cod_cliente) references cliente(cod_cliente) on update cascade;

update cliente
set cod_cliente = 20
where cod_cliente = 1;

-- EJ 1. b) Crea una tabla llamada sucursales_oro con las sucursales cuyo capital del año anterior supera a la media
select * from sucursal;

create table sucursales_oro as
	select * from sucursal
	where capital_anio_anterior > (select round(avg(capital_anio_anterior)) as media_capital from sucursal);
    
select * from sucursales_oro;

-- EJ 2. b) Crea la tabla cuentas_sucursal donde se almacenará la dirección de la sucursal, el código de la cuenta y el nombre y apellidos del cliente propietario de dicha cuenta.
create table cuentas_sucursal (
	direccion varchar(250),
    cod_cuenta bigint,
    cliente varchar(250)
);

insert into cuentas_sucursal (
	select s.direccion, c.cod_cuenta, concat_ws(" ", cl.nombre, cl.apellidos) as cliente from sucursal s
	join cuenta c using (cod_sucursal)
	join cliente cl using (cod_cliente)
);

select * from cuentas_sucursal;

-- EJ 3. b) Elimina las cuentas sin movimientos
delete from cuenta 
where cod_cuenta not in (select cod_cuenta from movimiento);

-- EJ 4. b) Elimina el tipo de movimiento “Retirada cajero”. Has de poder hacerlo así que, decide justificadamente como va a afectar esta eliminación en el resto del sistema.
describe movimiento;

alter table movimiento
modify cod_tipo_mov int;

alter table movimiento
drop constraint movimiento_ibfk_2;

alter table movimiento
add constraint movimiento_ibfk_2 foreign key (cod_tipo_mov) references tipo_movimiento(cod_tipo_mov) on delete set null;

delete from tipo_movimiento where descripcion = 'Retirada cajero';

select * from movimiento;

-- EJ 1. c) Crea una tabla llamadas clientes_residuales con los clientes que no tienen cuenta.
create table clientes_residuales as
	select * from cliente where cod_cliente not in (
		select cod_cliente from cuenta
	);
select * from clientes_residuales;
    
-- EJ 1. d) Crea una tabla llamada cuentas_inactivas con las cuentas que no tienen movimientos en el último año. Mostrará el saldo el nombre y los apellidos del cliente.
create table cuentas_inactivas as
	select cu.saldo, cl.nombre, cl.apellidos from cuenta cu
    join cliente cl using (cod_cliente)
    where cod_cuenta not in (
		select cod_cuenta from movimiento 
        where anio >= YEAR(NOW()) - 1
	);
select * from cuentas_inactivas;

-- EJ 1. e) Crea una tabla llamada movimientos_antiguos con aquellos movimientos realizados hace más de cinco años. La información que almacenará será importe, hora día año y descripción del tipo de movimiento.
create table movimientos_antiguos as
	select m.importe, concat_ws(" ", m.hora, m.dia, m.anio) as fecha, tm.descripcion from movimiento m
	join tipo_movimiento tm using (cod_tipo_mov)
	where m.anio < YEAR(NOW()) - 5;
    
select * from movimientos_antiguos;

-- EJ 2. c)  Crea la tabla movimientos donde aparezca el importe, la fecha (en una misma columna) y la descripción del tipo para aquellos importes que superen 
-- los 1000 euros y están realizados por clientes cuyo nombre empieza por A. (No hay que mostrar nada del cliente).
create table movimientos as
	select m.importe, concat_ws(" ", m.dia, m.hora, m.anio) as fecha, tm.descripcion from movimiento m
	join tipo_movimiento tm using (cod_tipo_mov)
	join cuenta cu using (cod_cuenta)
	join cliente cl using (cod_cliente)
	where m.importe > 1000 and
		cl.nombre like "A%";

-- EJ 3. c)  Elimina los tipos de movimiento nunca utilizados
delete from tipo_movimiento
where cod_tipo_mov not in (
	select cod_tipo_mov from movimiento
    );
    
-- EJ 3. d)  Añade el prefijo OFF_ al nombre del cliente para aquellos clientes que no realizan movimientos desde hace 2 años.
update cliente cl set nombre = concat('OFF_', cl.nombre) 
where cl.cod_cliente in (
	select cu.cod_cliente from cuenta cu
	where cu.cod_cuenta not in (
		select m.cod_cuenta from movimiento m
		where m.anio > YEAR(NOW()) - 2
	)
);

select * from cliente;

-- Modifica el nombre del tipo de movimiento mas utilizado añandiendo el sufijo _GOLD
update tipo_movimiento tm set tm.descripcion = concat(tm.descripcion, '_GOLD')
where cod_tipo_mov = (
	select cod_tipo_mov from movimiento
	group by cod_tipo_mov
	order by count(*) desc
	limit 1
);