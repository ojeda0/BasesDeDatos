-- Cabecera
drop database if exists empresa_turismo;
create database empresa_turismo;
use empresa_turismo;

-- Ejercicio 1, crear tablas
create table Proveedores(
	ID bigint primary key auto_increment,
    CIF char(9) not null unique,
    Nombre varchar(250) not null unique,
    Pais varchar(250),
    URL varchar(250) default 'www.default.es'
);

describe Proveedores;

create table Agentes(
	ID bigint primary key auto_increment,
    Nombre varchar(250) not null unique,
    Apellidos varchar(250),
    Telefono char(9),
    Tipo char(1)
    constraint check_tipo check (upper(Tipo) in ('C','N'))
);

describe Agentes;

create table Reservas(
	Localizador char(6) primary key,
    Fecha_checkin date,
    Precio_coste decimal(5,2),
    Precio_venta decimal(5,2),
    ID_proveedor bigint,
    ID_agente bigint,
    constraint fk_reservas_proveedores foreign key (ID_proveedor) references Proveedores(ID),
    constraint fk_reservas_agentes foreign key (ID_agente) references Agentes(ID),
    constraint check_precio check (Precio_coste < Precio_venta)
);

describe Reservas;

-- Ejercicio 2, introducir datos
insert into empresa_turismo.Proveedores(CIF, Nombre, Pais)
values
	('R5502108C', 'Jet2Travel', 'España'),
	('D76506849', 'Corendon', 'Turquía');

select * from Proveedores;

insert into empresa_turismo.Agentes(Nombre, Apellidos, Telefono, Tipo)
values
	('Eduardo', 'Ruiz Salvador', '953639337', 'C'),
    ('Elisa', 'Cáceres Pulido', '971408799', 'N');
    
select * from Agentes;

insert into empresa_turismo.Reservas(Localizador, Fecha_checkin, Precio_coste, Precio_venta, ID_proveedor, ID_agente)
values
	('ZN5DSC', '2022-10-19', 150.12, 299.9, 1, 1),
    ('SF3XSR', '2022-12-30', 194.64, 275, 1, 2),
    ('XL14LH', '2023-04-06', 701, 881.50, 2, 1);
    
select * from Reservas;

-- Ejercicio 3, eliminar proveedor Corendon
alter table Reservas drop constraint fk_reservas_proveedores;
alter table Reservas add constraint fk_reservas_proveedores foreign key (ID_proveedor) references Proveedores(ID) on delete cascade;
delete from Proveedores where ID=2;

select * from Proveedores;
select * from Reservas;

-- Ejercicio 4, Cambiar código de agente de Elisa
alter table Reservas drop constraint fk_reservas_agentes;
alter table Reservas add constraint fk_reservas_agentes foreign key (ID_agente) references Agentes(ID) on update cascade;
update Agentes set ID=7 where ID=2;

select * from Reservas;

-- Ejercicio 5, agregar nuevo tipo de agente
alter table Agentes drop constraint check_tipo;
alter table Agentes modify Tipo char(2);
alter table Agentes add constraint check_tipo check (upper(Tipo) in ('C','N','ST'));

select * from Agentes;

-- Ejercicio 6, borrar todas las table
drop table Reservas;
drop table Agentes;
drop table Proveedores;