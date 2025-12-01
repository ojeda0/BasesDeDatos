-- Cabecera
drop database if exists empresa_boletin1;
create database empresa_boletin1;
use empresa_boletin1;

-- Ejercicio 1 crear tablas
create table Empleados(
	DNI char(9) primary key,
    Nombre varchar(20) not null,
    Apellido1 varchar(20),
    Apellido2 varchar(20),
    Direccion varchar(20),
    Ciudad varchar(20),
    Municipio varchar(20),
    Cod_postal char(5),
    Sexo char(1),
    Fecha_nac date
);