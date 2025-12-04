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
    Fecha_nac date,
    constraint check_sexo check (upper(Sexo) in ('H', 'M'))
);

describe Empleados;

create table Historial_salarial(
	DNI_empl char(9),
    Salario decimal(6,2),
    Fecha_inicio date,
    Fecha_fin date,
    constraint pk_historial_salarial primary key (DNI_empl, Salario, Fecha_inicio),
    constraint fk_historial_salarial_empleados foreign key (DNI_empl) references Empleados(DNI),
    constraint check_fecha_historial_salarial check (Fecha_fin > Fecha_inicio)
);

describe Historial_salarial;

create table Departamento(
	Cod_dpto bigint primary key auto_increment,
	Nombre varchar(30) not null unique,
    DNI_jefe char(9),
    Presupuesto decimal(6,2) not null,
    constraint fk_departamento_empleados foreign key (DNI_jefe) references Empleados(DNI)
);

describe Departamento;

create table Universidad(
	Cod_univ bigint primary key auto_increment,
    Nombre varchar(30) not null,
    Ciudad varchar(20),
    Cod_postal char(5)
);

describe Universidad;

create table Estudio(
	DNI_empl char(9),
    Cod_univ bigint,
    Fecha_fin date,
    Titulo varchar(30) not null,
    Especialidad varchar(30),
    constraint pk_estudio primary key (DNI_empl, Cod_univ),
    constraint fk_estudio_empleado foreign key (DNI_empl) references Empleados(DNI),
    constraint fk_estudio_universidad foreign key (Cod_univ) references Universidad(Cod_univ)
);

describe Estudio;

create table Trabajo(
	Cod_trabajo bigint primary key auto_increment,
    Nombre varchar(20) not null unique,
    Salario_max decimal(6,2) not null,
    Salario_min decimal(6,2) not null,
    constraint check_salario_trabajo check (Salario_max > Salario_min)
);

describe Trabajo;

create table Historial_laboral(
	DNI_empl char(9),
    Cod_trabajo bigint,
    Cod_dpto bigint,
    Fecha_inicio date not null,
    Fecha_fin date,
    DNI_super char(9),
    constraint pk_historial_laboral primary key (DNI_empl, Cod_trabajo, Cod_dpto),
    constraint fk_historial_laboral_empleados_super foreign key (DNI_super) references Empleados(DNI),
    constraint fk_historial_laboral_empleados foreign key (DNI_empl) references Empleados(DNI),
    constraint fk_historial_laboral_trabajo foreign key (Cod_trabajo) references Trabajo(Cod_trabajo),
    constraint fk_historial_laboral_departamento foreign key (Cod_dpto) references Departamento(Cod_dpto),
    constraint check_fecha_historial_laboral check (Fecha_fin > Fecha_inicio)
);

describe Historial_laboral;

-- Ejercicio 2 insertar registros
insert into empresa_boletin1.Empleados 
values
	('53257665S', 'Juan', 'de la Palmilla', 'Julay', 'C/ Compi, Nº20', 'Málaga', 'La Palmilla', '29590', 'H', '1978-09-25'),
    ('Y1158354L', 'Octavio', 'Montero', 'Oliva', 'C/ Mairena, Nº15', 'Sevilla', 'Mairena', '41250', 'H', '1989-05-20'),
    ('E67099002', 'Mario', 'García', 'Santos', 'C/ Laureano, Nº30', 'Sevilla', 'El Viso del Alcor', '41520', 'H', '2005-03-18');
    
select * from Empleados;