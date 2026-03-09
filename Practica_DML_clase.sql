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