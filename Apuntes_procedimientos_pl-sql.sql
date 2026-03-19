drop database if exists pl_sql;
create database pl_sql;
use pl_sql;

delimiter $$
create procedure saluda(in nombre varchar(255), out mensaje varchar(255)) begin
	set mensaje = concat('Hola mundo soy ', nombre);
end$$
delimiter ;

call saluda('Abraham', @mensaje);


-- Ejemplo procedimiento IN 

delimiter $$
create procedure saluda_2(in nombre varchar(255)) begin
	select concat_ws(' ', 'Hola', nombre);
end$$
delimiter ;

call saluda_2('Abraham'); -- Paso por literal

set @nombre = 'Abraham';
call saluda_2(@nombre); -- Paso por valor


-- Haz un procedimiento que dado tu nombre muestre un mensaje del tipo
-- Hola tu_nombre tiene X letras

delimiter $$
create procedure letras_nombre(in nombre varchar(255)) begin
	select concat_ws(' ', 'Hola, el nombre', nombre, 'tiene', length(nombre), 'letras');
end$$
delimiter ;

set @nombre = 'Abraham';
call letras_nombre(@nombre);


-- Acceso a datos desde procedures

delimiter $$
create procedure crea_tabla_alumno() begin
	create table alumno(
		id bigint primary key auto_increment,
        nombre_alumno varchar(255)
    );
end$$

create procedure insert_data(in nombre varchar(255)) begin
	insert into alumno (nombre_alumno)
    values
		(nombre);
end$$
delimiter ;

call crea_tabla_alumno();
call insert_data('Pedro');
call insert_data('Julio');
call insert_data('Juan de la Palmilla');

select * from alumno;


-- Procedimiento que salude a todos los alumnos (necesitamos cursor)

delimiter $$
create procedure saluda_alumnos() begin
	-- Variables
    declare fin boolean default false;
    declare nombre varchar(255);
    
    -- Cursor
    declare cursor_alumno cursor for (select nombre_alumno from alumno);
    
    -- Handler (manejador)
    declare continue handler for not found set fin = true;
    
    -- Abrir cursor
    open cursor_alumno;
    
    -- Recorrer cursos
    bucle: loop
		fetch cursor_alumno into nombre;
        
        if(fin = true) then
			leave bucle;
        end if;
    
        select concat_ws(' ', 'Hola', nombre) as saludo;
        
	end loop;
    
    -- cerrar cursor
    close cursor_alumno;
end$$
delimiter ;

call saluda_alumnos();

-- Crea un procedimiento que por cada nombre de la tabla
-- alumnos muestre un mensaje del tipo Hola nombre_alumno
-- tu nombre tiene x letras, para aquellos que terminen por a
-- muestra un mensaje al final diciendo "Has llamado a este procedimiento n veces"

delimiter $$
create procedure mensaje_alumnos(inout veces int) begin
	-- Variables
    declare fin boolean default false;
    declare nombre varchar(255);
    
    -- Cursor
    declare cursor_mensaje cursor for 
    (select a.nombre_alumno from alumno a where a.nombre_alumno like '%a');
    
    -- Handler (manejador)
    declare continue handler for not found set fin = true;
    
    -- Abrir cursor
    open cursor_mensaje;
    
    -- Recorrer
    bucle: loop
		fetch cursor_mensaje into nombre;
        
        if(fin = true) then
			leave bucle;
        end if;
        
        select concat_ws(' ', 'Hola', nombre, 'tu nombre tiene', length(nombre), 'letras') as mensaje;
    
    end loop;
    
    -- Cerrar cursor
    close cursor_mensaje;
    
    set veces = veces + 1;
    
    if(veces = 1) then
		select concat_ws(' ', 'Has llamado a este procedimiento', veces, 'vez') as mensaje_vez;
	else
		select concat_ws(' ', 'Has llamado a este procedimiento', veces, 'veces') as mensaje_veces;
    end if;
    
end$$
delimiter ;

set @veces = 0;
call mensaje_alumnos(@veces);