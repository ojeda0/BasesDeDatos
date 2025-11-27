-- Cabecera
drop database if exists academia_idiomas;
create database academia_idiomas;
use academia_idiomas;

-- EJERCICIO 1 CREAR TABLAS
create table Personas(
	ID bigint primary key auto_increment,
	DNI char(9) unique not null,
	Nombre varchar(250) unique,
    Apellido1 varchar(250),
    Apellido2 varchar(250),
    Direccion varchar(250)
);

describe Personas;

create table Profesores(
	ID_persona bigint primary key,
    Titulo varchar(250),
    Gana decimal(7,2) not null,
    constraint fk_profesor_persona foreign key (ID_persona) references Personas(ID)
);

describe Profesores;

create table Cursos(
	Codigo bigint primary key auto_increment,
    Nombre varchar(250) unique,
    Maximo_alumnos int,
    Fecha_inicio date,
    Fecha_fin date,
    Num_horas int not null,
    ID_profesor bigint,
    constraint fk_curso_profesor foreign key (ID_profesor) references Profesores(ID_persona),
    constraint check_fechas check (Fecha_inicio < Fecha_fin)
);

describe Cursos;

create table Alumnos(
	ID_persona bigint primary key,
    Sexo char(1),
    Fecha_nacimiento date,
    Codigo_curso bigint not null,
    constraint fk_alumno_curso foreign key (Codigo_curso) references Cursos(Codigo),
    constraint fk_alumno_persona foreign key (ID_persona) references Personas(ID),
    constraint check_sexo check (upper(sexo) in ('H','M'))
);

describe Alumnos;

-- EJERCICIO 2 INSERTAR DATOS EN LAS TABLAS
insert into academia_idiomas.Personas(DNI, Nombre, Apellido1, Apellido2, Direccion)
values
	('76978084M', 'Juan', 'Arcos', 'López', 'Puerta negra, 4'),
	('50427865C', 'María', 'Oliva', 'Rubio', 'Juan Alfonso, 23'),
	('99857929W', 'Sara', 'Lemes', 'Sancho', 'Calle Viento, 1'),
	('23755174S', 'Lucas', 'Manilva', 'López', 'Alhamar, 4'),
	('03818863N', 'Antonia', 'Santos', 'Alcántara', 'Maniquí, 21'),
	('33577501P', 'Manuel', 'Baños', 'Rioseco', 'Jurel, 2'),
	('36107620N', 'José', 'Llorente', 'Escueto', 'Jarcha, 5'),
	('12345678J', 'Sergio', 'Navas', 'Rental', null);

select * from Personas;

insert into academia_idiomas.Profesores(ID_persona, Titulo, Gana)
values
	(1, 'Ing. Informático', 7500),
	(2, 'Lda. Fil. Inglesa', 4900),
	(3, 'Magisterio', 6100);

select * from Profesores;

insert into academia_idiomas.Cursos(Nombre, Maximo_alumnos, Fecha_inicio, Fecha_fin, Num_horas, ID_profesor)
values
	('Inglés Básico', 15, '2023-01-01', '2023-10-01', 120, 2),
	('Adm. Linux', null, '2023-02-03', null, 80, 1);

select * from Cursos;

insert into academia_idiomas.Alumnos(ID_persona, Sexo, Fecha_nacimiento, Codigo_curso)
values
	(4, 'H', '1970-01-01', 1),
	(5, 'M', null, 2),
	(6, null, null, 2),
	(7, 'H', '1990-02-03', 1);

select * from Alumnos;

-- EJERCICIO 3 INSERTAR FILA EN ALUMNOS PERO DA ERROR
-- insert into academia_idiomas.Alumnos(ID_persona, Sexo, Fecha_nacimiento, Codigo_curso)
-- values
	-- (8, 'P', null, null);

-- EJERCICIO 4 Añadir el campo edad de tipo numérico a la tabla PROFESORES.
alter table Profesores add Edad int;

select * from Profesores;

-- EJERCICIO 5 Añadir restricciones.
-- Si previamente a esta instrucción existen profesores que la incumplen, no podríamos poner el check.
alter table Profesores add constraint check_edad check (Edad>=18 and Edad<=65);
alter table Cursos add constraint check_maximo_alumnos check (Maximo_alumnos>=10);

-- Actualizar registros
update Cursos set Num_horas=101 where Num_horas < 100;
alter table Cursos add constraint check_num_horas check (Num_horas > 100);

select * from Cursos;
select * from Profesores;

-- Elimina el profesor 1
alter table Profesores drop constraint fk_profesor_persona;
alter table Profesores add constraint fk_profesor_persona foreign key (ID_persona) references Personas(ID) on delete cascade;
alter table Cursos drop constraint fk_curso_profesor;
alter table Cursos add constraint fk_curso_profesor foreign key (ID_profesor) references Profesores(ID_persona) on delete cascade;
alter table Alumnos drop constraint fk_alumno_curso;
alter table Alumnos add constraint fk_alumno_curso foreign key (Codigo_curso) references Cursos(Codigo) on delete cascade;
delete from Profesores where ID_persona=1;

select * from Profesores;
select * from Cursos;