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

-- Ejercicio 2 insertar registros, 3 por cada tabla
insert into empresa_boletin1.Empleados 
values
	('53257665S', 'Juan', 'de la Palmilla', 'Julay', 'C/ Compi, Nº20', 'Málaga', 'La Palmilla', '29590', 'H', '1978-09-25'),
    ('Y1158354L', 'Octavio', 'Montero', 'Oliva', 'C/ Mairena, Nº15', 'Sevilla', 'Mairena', '41250', 'H', '1989-05-20'),
    ('E67099002', 'Mario', 'García', 'Santos', 'C/ Laureano, Nº30', 'Sevilla', 'El Viso del Alcor', '41520', 'H', '2005-03-18');
    
select * from Empleados;

insert into empresa_boletin1.Historial_salarial(DNI_empl, Salario, Fecha_inicio)
values
	('53257665S', 2000.00, '2025-01-20'),
    ('Y1158354L', 1500.00, '2025-02-15'),
    ('E67099002', 1200.00, '2025-01-29');
    
select * from Historial_salarial;

insert into empresa_boletin1.Departamento(Nombre, DNI_jefe, Presupuesto)
values
	('La ofi', '53257665S', 5000.00),
    ('Marketing', 'Y1158354L', 9000.00),
    ('Toplane', 'E67099002', 7000.00);
    
select * from Departamento;

insert into empresa_boletin1.Universidad(Nombre, Ciudad, Cod_postal)
values
	('Grieta del Invocador', 'Zaun', '54321'),
    ('Botlane', 'Noxus', '41321'),
    ('Midlane', 'Piltover', '41123');
    
select * from Universidad;

insert into empresa_boletin1.Estudio(DNI_empl, Cod_univ, Titulo, Especialidad)
values
	('53257665S', 1, 'El más mejor', 'Ser el mejor'),
    ('Y1158354L', 2, 'El King', 'Ser el king'),
    ('E67099002', 3, 'Top inters EUW', 'Mario Creation');
    
select * from Estudio;

insert into empresa_boletin1.Trabajo(Nombre, Salario_max, Salario_min)
values
	('Grietero', 4000.00, 1000.00),
    ('Inter', 1000.00, 500.00),
    ('Troll', 1000.00, 500.00);
    
select * from Trabajo;

insert into empresa_boletin1.Historial_laboral(DNI_empl, Cod_trabajo, Cod_dpto, Fecha_inicio, DNI_super)
values
	('53257665S', 1, 1, '2025-02-20', 'E67099002'),
    ('Y1158354L', 2, 2, '2025-02-15', 'E67099002'),
    ('E67099002', 3, 3, '2025-02-02', 'Y1158354L');
    
select * from Historial_laboral;
    
-- No podemos insertar ya que da error en el sexo, por el check de H, M. Cambiamos la P por H.
insert into empresa_boletin1.Empleados(DNI, Nombre, Apellido1, Apellido2, Sexo)
values
	('111222', 'Sergio', 'Palma', 'Entrena', 'H'),
    ('222333', 'Lucía', 'Ortega', 'Plus', null);
    
select * from Empleados;

-- No podemos insertar ya que da error al ser null el cod_trabajo y cod_dpto, forman parte de la clave.
-- También tenemos un problema de integridad referencial, ya que no tenemos creado el cod_trabajo y cod_dpto creados en ninguna tabla.
-- insert into empresa_boletin1.Historial_laboral
-- values
	-- ('111222', null, null, '1996-06-16', null, '222333');
    
-- select * from Historial_laboral;

-- Ahora vamos a eliminar los 2 empleados que hemos insertado
delete from Empleados where DNI='111222';
delete from Empleados where DNI='222333';

select * from Empleados;

-- Ejercicio 3 modificar tablas y columnas
alter table Trabajo add column Dificultad char(1);
alter table Trabajo add constraint check_dificultad check (Dificultad between '1' and '5');

describe Trabajo;

alter table Departamento add column Planta int default 0;
alter table Departamento add column Numero_puerta int default 1;

select * from Departamento;

alter table Empleados add constraint check_sevilla check ((Ciudad != 'Sevilla') or (Ciudad = 'Sevilla' and Fecha_nac is not null));
alter table Empleados rename column Municipio to Localidad;

describe Empleados;

alter table Historial_salarial add constraint check_salario check (Salario >= 0);

-- A partir de aqui es copiado del octavio ctrl c  ctrl v

select * from Empleados;

-- (PRUEBA QUE FALLA) Ejemplo de insert que viola la restriccion creada anteriormente
-- insert into Empleados values 
	-- ('34567990C', 'Pedro', 'Lopez', 'Ruiz', 'C/ Luna 5', 'Sevilla', 'Sevilla', '41001', 'M', null);
    
-- (PRUEBA QUE NO FALLA) Ejemplo de insert valido
insert into Empleados values 
	('34567990C', 'Pedro', 'Lopez', 'Ruiz', 'C/ Luna 5', 'Sevilla', 'Sevilla', '41001', 'M', '1991-01-23');

-- Vamos a tratar de saltarnos la restriccion tocando solo la fecha_nac
select * from Empleados;
-- update Empleados set fecha_nac = null where dni = '34567990C';

alter table Empleados;

alter table Departamento add constraint chk_presupuesto_positivo check (presupuesto >= 0); -- Alla donde haya un valor economico

-- Se pueden aplicar varios cambios en una misma consulta
-- alter table Empleados
	-- modify nombre varchar(20) null, -- añadimos el null para asegurarnos que pilla la restriccion "nulable" es equivalente a no ponerlo
    -- modify direccion varchar(50), -- Al no tener que cambiar el nombre usamos modify
    -- rename column municipio to localidad; -- Forma actual de hacerlo (No necesita redefinir el tipo)
    
-- Forma anterior de hacerlo (necesita redefinirlo completamente). Solo aplica al cambio de municipio -> localidad
-- alter table empleado change municipio localidad int;

-- drop table estudio;
-- drop table universidad;

alter table estudio drop constraint fk_estudio_universidad;
alter table estudio add constraint fk_estudio_universidad foreign key (cod_univ) references universidad(cod_univ) on update cascade;
update universidad set cod_univ = 7 where cod_univ = 1;

select * from estudio;