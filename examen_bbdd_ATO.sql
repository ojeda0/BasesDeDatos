-- Cabecera
drop database if exists examen_taller;
create database examen_taller;
use examen_taller;

-- Creamos tablas ej 1 y 2
create table empleado(
	id bigint primary key auto_increment,
    nombre varchar(250),
    salario decimal(6,2),
    constraint chk_salario check (salario <= 2300.00)
);

-- describe empleado;

create table pieza(
	id bigint primary key auto_increment,
    fecha_fabricacion date,
    marca varchar(250),
    modelo varchar(250),
    constraint chk_fecha_fabricacion check (fecha_fabricacion > '1990-01-01')
);

-- describe pieza;

create table propietario(
	dni char(9) primary key,
    nombre varchar(250) not null unique,
    apellidos varchar(250),
    es_mayor_edad boolean default true
);

-- describe propietario;

create table vehiculo(
	num_bastidor char(17) primary key,
    combustible varchar(250),
    marca varchar(250),
    modelo varchar(250),
    dni_propietario char(9) not null,
    constraint fk_vehiculo_propietario foreign key (dni_propietario) references propietario(dni),
    constraint chk_combustible check (upper(combustible) in ('HIBRIDO', 'ELECTRICO', 'ENCHUFABLE'))
);

-- describe vehiculo;

create table arreglo(
	id_empleado bigint,
    id_pieza bigint,
    num_bastidor_vehiculo char(17),
    fecha date,
    precio decimal(16,2),
    constraint pk_arreglo primary key (id_empleado, id_pieza, num_bastidor_vehiculo, fecha),
    constraint fk_arreglo_empleado foreign key (id_empleado) references empleado(id),
    constraint fk_arreglo_pieza foreign key (id_pieza) references pieza(id),
    constraint fk_arreglo_vehiculo foreign key (num_bastidor_vehiculo) references vehiculo(num_bastidor)
);

-- describe arreglo;

-- Ejercicio 3
alter table arreglo drop constraint fk_arreglo_pieza;
alter table arreglo add constraint fk_arreglo_pieza foreign key (id_pieza) references pieza(id) on delete cascade;
delete from pieza where id=1;

-- Ejercicio 4
alter table vehiculo add column cilindrada int default 2000;

-- select * from vehiculo;

-- Ejercicio 5
alter table pieza drop column fecha_fabricacion;
-- si eliminamos el campo fecha_fabricacion, tenemos una constraint que verifica que la fecha no sea anterior a '1990-01-01'. El sistema es inteligente y no hay errores ya que también borra la constraint.

describe pieza;