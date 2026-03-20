drop database if exists practica_tema9;
create database practica_tema9;
use practica_tema9;

-- EJ 1. FUNCIONES
-- a) Crea una función que dado dos números enteros devuelva la media de ambos numeros. Comprueba el resultado
delimiter $$
create function media(numero1 int, numero2 int) returns double deterministic begin
	return (numero1 + numero2) / 2;
end$$
delimiter ;

select media(5, 5);

-- b) Crea una función que dado una base y un exponente devuelva el resultado de la operación de potencia. Comprueba el resultado
delimiter $$
create function potencia(base int, exponente int) returns int deterministic begin
	declare resultado int;
    declare contador int;
    set resultado = 1;
    set contador = 0;
    
    while contador < exponente do
		set resultado = resultado * base;
        set contador = contador + 1;
    end while;
    
    return resultado;
end$$
delimiter ;

select potencia(2, 4);

-- EJ 2. PROCEDIMIENTOS
-- a)
delimiter $$
create procedure saludo(nombre_alumno varchar(255), inout veces int) begin

	if(nombre_alumno = '') then
		select 'El nombre no puede estar vacío.';
        set veces = 0;
    end if;
    
    if(veces = 1) then
		select concat_ws(' ', 'Hola', nombre_alumno, 'has llamado al procedimiento', veces, 'vez.') as mensaje;
	else 
		select concat_ws(' ', 'Hola', nombre_alumno, 'has llamado al procedimiento', veces, 'veces.')as mensaje;
    end if;

    set veces = veces + 1;
end$$
delimiter ;

set @veces = 0;
call saludo('Abraham', @veces);

-- EJ 3. Triggers / Disparadores
-- a)
create table alumno (
	id bigint primary key auto_increment,
	edad int,
    fechaNac date
);

create table alumnos_eliminados (
	id bigint,
	edad int,
    fechaNac date
);

delimiter $$
create trigger insertar_alumno before insert on alumno for each row begin
	set new.edad = timestampdiff(year, new.fechaNac, current_date());
end$$
delimiter ;

-- b)
delimiter $$
create trigger guardar_alumnos_eliminados after delete on alumno for each row begin
    insert into alumnos_eliminados (id, edad, fechaNac)
    values 
		(old.id, old.edad, old.fechaNac);
end$$
delimiter ;

-- EJ 4.
-- a)
delimiter $$
create procedure mensaje_alumnos() begin
    -- Variables
    declare fin boolean default false;
    declare nombre varchar(255);
    declare edad int;
    
    -- Cursor
    declare cursor_alumnos cursor for 
    (select nombre_alumno, edad from alumno where edad >= 18);
    
    -- Handler
    declare continue handler for not found set fin = true;
    
    -- Abrir cursor
    open cursor_alumnos;
    
    -- Recorrer
    bucle: loop
        fetch cursor_alumnos into nombre, edad;
        
        if (fin = true) then
            leave bucle;
        end if;
        
        select concat_ws(' ', 'Tu nombre es', nombre, 'y tienes', edad, 'años') as mensaje;
    
    end loop;
    
    -- Cerrar cursor
    close cursor_alumnos;
end$$
delimiter ;

call mensaje_alumnos();