drop database if exists pl_sql;
create database pl_sql;
use pl_sql;

create table alumno (
	id bigint primary key auto_increment,
    nombre_alumno varchar(255),
    usuario varchar(255),
    fechaCreacion date,
    fechaModificacion date
);

create table historico (
	id_alumno bigint,
	nombre_alumno_antiguo varchar(255),
    nombre_alumno_actual varchar(255),
    fechaModificacion date
);

delimiter $$
create trigger ejemplo_1 before insert on alumno for each row begin
	set new.nombre_alumno = upper(new.nombre_alumno);
end$$

create trigger ejemplo_2 before insert on alumno for each row begin
	set new.usuario = current_user();
    set new.fechaCreacion = current_date();
end$$

create trigger ejemplo_3 before update on alumno for each row begin
	set new.fechaModificacion = current_date();
end$$

create trigger ejemplo_4 after update on alumno for each row begin
	insert into historico values 
		(old.id, old.nombre_alumno, new.nombre_alumno, now());
end$$
delimiter ;

insert into alumno (nombre_alumno)
values
	('Paquito'),
    ('Pedrita'),
    ('Juan de la Palmilla');

select * from alumno;

update alumno a set a.nombre_alumno = 'PAQUITO2'
where a.nombre_alumno = 'PAQUITO';

select * from alumno;