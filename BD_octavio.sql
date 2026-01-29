use gestion_deportiva;

insert into persona (dni, nombre, apellidos, fecha_nac)
values
	('20044309P', 'Abraham', 'Teba Ojeda', '2001-09-12');
    
select * from persona;
    
insert into jugador
values
	(23, 'Extremo derecho', '9', 2);

insert into patrocinador (nombre)
values
	('Patrocinios Juanito Palmilla');
    
select * from patrocinador;
    
insert into partido (fecha, puntos_a, puntos_b, id_equipo_a, id_equipo_b)
values
	('2026-01-23', 3, 0, 2, 1);
    
select * from partido;

insert into patrocina
values
	(8, 5);
    
-- Nombre de los patrocinadores a excepción de aquellos que empiezan por P
	select nombre
    from patrocinador
    where nombre not like 'P%';
    
-- Datos de las personas mayores de 20 años
	select *
    from persona
    where timestampdiff(year, fecha_nac, now()) > 20;
    
-- Muestra el nombre completo en una columna llamada nombre_completo de todas las personas cuyo dni contiene la g
	select concat_ws(' ', nombre, apellidos) as nombre_completo
    from persona
    where dni like '%G%';
    
-- Muestra ahora las iniciales formadas por la primera letra del nombre, primera letra del apellido y el año de la fecha de nacimiento
	select concat(left(nombre, 1), left(apellidos, 1), year(fecha_nac)) as iniciales
    from persona;
    
-- Muestra todos los dorsales de porteros y delanteros del sistema
	select dorsal
    from jugador
    where posicion in ('portero', 'delantero');
    
-- Muestra todos los jugadores del equipo 2
	select *
    from jugador
    where id_equipo = 2;
    
-- Muestra aquellos jugadores que no son extremos
	select *
    from jugador
    where posicion not like '%extremo%';
    
-- Muestra el jugador con el nombre de su posicion más largo (por nº de caracteres)
	select *
    from jugador
    order by length(posicion) desc 
    limit 1;
    
-- Muestra los patrocinadores que empiezan por P o acaban por A y su id es par
	select *
    from patrocinador
    where (nombre like 'P%' or nombre like '%A')
        and (id % 2 = 0);
        
-- Muestra el nombre del equipo y el id de entrenador de los equipos ubicados en Mairena
	select nombre, id_entrenador
    from equipo
    where localizacion like '%mairena%';
    
-- Muestra todas las localizaciones en las que hay equipos sin repetir
	select distinct localizacion
    from equipo;
    
-- Muestra los datos de los partidos donde ha ganado el equipo a
	select * 
    from partido
    where puntos_a > puntos_b;
    
-- Muestra todos los datos de los partidos con una diferencia de goles de mas de 4
	select *
    from partido
    where (puntos_a - puntos_b >= 4) or (puntos_b - puntos_a >= 4);
    
-- Muestra los partidos perdidos por a jugados entre enero y marzo de 2026
	select *
    from partido
    where puntos_b > puntos_a 
		and fecha between '2026-01-01' and '2026-03-31';
        
-- ---------------------------------------------------------------------------------------

use almacen;

select * from almacen;

-- Cuantos dias faltan para que se comercialice el producto Huawei free clips
	select timestampdiff(day, now(), fecha_comer)
	from almacen
	where producto = "Huawei Free Clips";

-- Mostrar el nombre del producto y el redondeo entero de su precio para aquellos adquiridos al proveedor apple (27)
	select producto, round(precio_unit) as redondeo_precio
    from almacen
    where id_proveedor = 27;
    
-- Mostrar el nombre del producto y el redondeo entero de su precio para aquellos adquiridos al proveedor apple (27) o que su precio supere los 500
	select producto, round(precio_unit) as redondeo_precio
    from almacen
    where (id_proveedor = 27) 
		or (precio_unit > 500);
        
-- Mostrar el nombre del producto y el redondeo entero de su precio para aquellos adquiridos al proveedor apple (27) o que su precio supere los 500
-- Todos los productos que se muestren deben cumplir que su cantidad sea inferior ectrictamente a la cantidad máxima que podemos almacenar de ellos
	select producto, round(precio_unit) as redondeo_precio, cantidad, cantidad_max
    from almacen
    where (id_proveedor = 27 or precio_unit > 500)
        and cantidad < cantidad_max;
        
-- Muestra aquellos productos cuya cantidad máxima es un número par, estan adquiridas a proveedores cuyo id se encuentra entre 20 y 30
-- y su nombre contiene la i o la a
	select producto, cantidad_max, id_proveedor
    from almacen
    where cantidad_max % 2 = 0 
		and id_proveedor between 20 and 30 
		and (producto like '%i%' or producto like '%a%');
        
-- Muestra aquellos productos comercializados en 2024 cuya diferencia entre cantidad_max y actual supera las 30 unidades o su precio unitario es
-- inferior a 500
	select *
    from almacen
    where year(fecha_comer) = 2024
		and ((cantidad_max - cantidad) > 30 or (precio_unit < 500));
        
-- Muestra aquellos productos comercializados en 2024 cuya diferencia entre cantidad_max y actual supera las 30 unidades o su precio unitario es
-- inferior a 500 para todos aquellos productos adquiridos a los proveedores 27 o 29
	select *
    from almacen
    where year(fecha_comer) = 2024
		and ((cantidad_max - cantidad) > 30 or (precio_unit < 500))
        and id_proveedor in (27, 29);
        
-- Muestrame el producto más caro
	select *
    from almacen
    order by precio_unit desc
    limit 1;
    
    -- Funciones de agregado
    select MAX(precio_unit) from almacen;
    select MIN(precio_unit) from almacen;
    select SUM(precio_unit) from almacen;
    select avg(precio_unit) from almacen;
    select count(*) from almacen;
    
    select MAX(precio_unit), id_proveedor 
    from almacen
    group by id_proveedor;
    
    -- Subconsulta del producto más caro
    select * 
    from almacen 
    where precio_unit = (select MAX(precio_unit) from almacen);
    
-- Muestra para cada proveedor el num de productos que tiene
	select count(producto), id_proveedor
    from almacen
    group by id_proveedor;
    
-- Muestra para cada proveedor la cantidad total de productos que tiene
	select SUM(cantidad), id_proveedor
    from almacen
    group by id_proveedor;
    
-- Muestra para cada proveedor la cantidad total de productos que tiene ordenado de mayor a menor
	select SUM(cantidad) as cantidad_total, id_proveedor
    from almacen
    group by id_proveedor
    order by cantidad_total desc;
    
-- Muestra para cada proveedor la cantidad total de productos que tiene ordenado de mayor a menor para los proveedores 26 y 29
	select SUM(cantidad) as cantidad_total, id_proveedor
    from almacen
    where id_proveedor in (26, 29)
    group by id_proveedor
    order by cantidad_total desc;
    
-- Muestra para cada proveedor la cantidad total de productos que tiene ordenado de mayor a menor para los proveedores 26 y 29 siempre y cuando dicha cantidad supere los 120
	select SUM(cantidad) as cantidad_total, id_proveedor
    from almacen
    where id_proveedor in (26, 29)
    group by id_proveedor
    having cantidad_total > 120
    order by cantidad_total desc;