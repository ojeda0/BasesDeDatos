drop database if exists pl_sql;
create database pl_sql;
use pl_sql;

delimiter $$
create procedure saluda(in nombre varchar(255), out mensaje varchar(255)) begin
	set mensaje = concat('Hola mundo soy ', nombre);
end$$
delimiter ;

call saluda('Abraham', @mensaje);