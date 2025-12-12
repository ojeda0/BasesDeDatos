-- Cabecera
drop database if exists daw_pesca;
create database daw_pesca;
use daw_pesca;

-- Crear tablas
create table especie(
	id bigint primary key auto_increment,
    nombre_comun varchar(250),
    nombre_cientifico varchar(250),
    origen varchar(250)
);

-- describe especie;

create table senuelo(
	id bigint primary key auto_increment,
    nombre varchar(250) unique not null,
    marca varchar(250),
    precio decimal(16,2)
);

-- describe senuelo;

create table provincia(
	id bigint primary key auto_increment,
    nombre varchar(250) unique not null,
    pais varchar(250)
);

-- describe provincia;

create table localidad(
	id bigint primary key auto_increment,
    nombre varchar(250) unique not null,
    cod_postal char(5),
    id_provincia bigint not null,
    constraint fk_localidad_provincia foreign key (id_provincia) references provincia(id)
);

-- describe localidad;

create table club(
	id bigint primary key auto_increment,
    sede varchar(250),
    num_socios int,
    nombre varchar(250) unique not null
);

-- describe club;

create table pescador(
	dni char(9) primary key,
    fecha_nac date,
    nombre varchar(250) unique not null,
    apellidos varchar(250),
    telefono char(13), 		-- guardaremos los telefonos como +34 654857463 (13 caracteres)
    dni_maestro char(9),
    id_localidad bigint,
    id_club bigint,
	constraint fk_pescador_pescador foreign key (dni_maestro) references pescador(dni),
    constraint fk_pescador_localidad foreign key (id_localidad) references localidad(id),
    constraint fk_pescador_club foreign key (id_club) references club(id)
);

-- describe pescador;

create table embalse(
	id bigint primary key auto_increment,
    nombre varchar(250) unique not null,
    capacidad decimal(16,2),
    porcentaje_nivel decimal(5,2),
    anyo_presa year,
    id_localidad bigint not null,
    constraint fk_embalse_localidad foreign key (id_localidad) references localidad(id),
    constraint check_anyo_presa check (anyo_presa <= 2025)
);

-- describe embalse;

create table captura(
	dni_pescador char(9),
    id_especie bigint,
    id_senuelo bigint,
    id_embalse bigint,
    fecha_hora date,
    peso decimal(16,2),
    desde_orilla boolean default true,
    tamanyo decimal(16,2),
    constraint pk_captura primary key (dni_pescador, id_especie, id_senuelo, id_embalse, fecha_hora),
    constraint fk_captura_pescador foreign key (dni_pescador) references pescador(dni),
    constraint fk_captura_especie foreign key (id_especie) references especie(id),
    constraint fk_captura_senuelo foreign key (id_senuelo) references senuelo(id),
    constraint fk_captura_embalse foreign key (id_embalse) references embalse(id)
);

-- describe captura;

create table licencia(
	nir char(7) primary key,
    tipo varchar(250),
    seg_vigente boolean,
    dni_pescador char(9) unique not null,
    constraint fk_licencia_pescador foreign key (dni_pescador) references pescador(dni)
);

-- describe licencia;

create table patrocinador(
	id bigint primary key auto_increment,
    nombre varchar(250) unique not null,
    precio decimal(16,2)
);

-- describe patrocinador;

create table patrocinador_club(
	id_club bigint,
    id_patrocinador bigint,
    constraint pk_patrocinador_club primary key (id_club, id_patrocinador),
    constraint fk_patrocinador_club_club foreign key (id_club) references club(id),
    constraint fk_patrocinador_club_patrocinador foreign key (id_patrocinador) references patrocinador(id)
);

-- describe patrocinador_club;

create table tienda(
	id_patrocinador bigint primary key,
    es_fisica boolean,
    anyo_apertura year,
    id_localidad bigint not null,
    constraint fk_tienda_patrocinador foreign key (id_patrocinador) references patrocinador(id),
    constraint fk_tienda_localidad foreign key (id_localidad) references localidad(id)
);

-- describe tienda;

create table marca(
	id_patrocinador bigint primary key,
    tipo varchar(250),
    fabricante varchar(250),
    constraint fk_marca_patrocinador foreign key (id_patrocinador) references patrocinador(id)
);

-- describe marca;

-- Insertar datos
insert into provincia(nombre, pais)
values
	('Sevilla', 'España'),
    ('Murcia', 'España');
    
insert into localidad(nombre, cod_postal, id_provincia)
values
	('Alcalá de Guadaíra', '41500', 1),
    ('Alhama', '50200', 2);
    
insert into club(sede, num_socios, nombre)
values
	('Central', 100, 'Grieta del Pescador'),
    ('Secundaria', 40, 'Pescabichos');

insert into pescador(dni, fecha_nac, nombre, apellidos, telefono, dni_maestro, id_localidad, id_club)
values
	('30044402C', '2001-06-13', 'Jax', 'El Pescador', '+34 675453187', null, 1, 1),
    ('40055502P', '2001-07-15', 'Juanito', 'de la Palmilla', '+34 684576312', '30044402C', 2, 2);
    
insert into especie(nombre_comun, nombre_cientifico, origen)
values
	('Trucha', 'Carpe Diem', 'Agua'),
    ('Pez globo', 'Globis Gordis', 'Agua');
    
insert into senuelo(nombre, marca, precio)
values
	('Rojo grande', 'Nike', 19.99),
    ('Azul pequeño', 'Adidas', 15.99);
    
insert into embalse(nombre, capacidad, porcentaje_nivel, anyo_presa, id_localidad)
values
	('Embalse Willy', 200, 70.5, 2006, 1),
    ('Embalse Washington', 100, 30.4, 2010, 2);
    
insert into captura(dni_pescador, id_especie, id_senuelo, id_embalse, fecha_hora, peso, desde_orilla, tamanyo)
values
	('30044402C', 1, 1, 1, '2025-12-03', 55.45, true, 10.50),
    ('40055502P', 2, 2, 2, '2025-12-10', 40.25, false, 15.50),
    ('30044402C', 1, 2, 1, '2025-12-11', 50.20, true, 12.60);
    
select * from pescador;
select * from especie;
select * from senuelo;
select * from embalse;
select * from captura;

alter table embalse rename column porcentaje_nivel to nivel_actual;

select * from embalse;

alter table captura drop constraint fk_captura_embalse;
alter table captura add constraint fk_captura_embalse foreign key (id_embalse) references embalse(id) on delete cascade;
delete from embalse where id=1;

select * from embalse;

alter table captura drop constraint fk_captura_pescador;
alter table captura add constraint fk_captura_pescador foreign key (dni_pescador) references pescador(dni) on update cascade;
alter table licencia drop constraint fk_licencia_pescador;
alter table licencia add constraint fk_licencia_pescador foreign key (dni_pescador) references pescador(dni) on update cascade;
alter table pescador drop constraint fk_pescador_pescador;
alter table pescador add constraint fk_pescador_pescador foreign key (dni_maestro) references pescador(dni) on update cascade;
-- update pescador set dni='60077703L' where dni='30044402C';

select * from pescador;
select * from captura;