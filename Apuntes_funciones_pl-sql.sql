drop database if exists pl_sql;
create database pl_sql;
use pl_sql;


delimiter $$
create function saluda(nombre varchar(255)) returns varchar(255) deterministic begin
	return concat('Hola mundo soy ', nombre);
end$$

create function suma(numero1 int, numero2 int) returns int deterministic begin
	declare resultado int;
    set resultado = numero1 + numero2;
	return resultado;
end$$

create function calcular_precio(precio_sin_iva double, descuento int) returns double deterministic begin
    declare precio_con_iva double;
    declare precio_total_rebajado double;
    
    set precio_con_iva = precio_sin_iva * 1.21;
    set precio_total_rebajado = precio_con_iva - ((descuento/100) * precio_con_iva);
    
    return round(precio_total_rebajado, 2);
end$$

create function mayor_menor_edad(edad int) returns varchar(255) deterministic begin
	declare mensaje varchar(255);
    
    if(edad < 18) then
		set mensaje = 'Eres menor de edad';
	else
		set mensaje = 'Eres mayor de edad';
    end if;
    
    return mensaje;
end$$

create function factorial(numero int) returns int deterministic begin
	declare acumulador int;
    declare valor_actual int;
    set acumulador = 1;
    set valor_actual = numero;
    
    while valor_actual > 1 do
		set acumulador = acumulador * valor_actual;
        set valor_actual = valor_actual - 1;
    end while;
    
    return acumulador;
    
end$$
delimiter ;


select saluda('Abraham') as funcion_saludar;
select suma(2,3) as funcion_suma;
select calcular_precio(200, 50) as funcion_calcular_precio;
select mayor_menor_edad(17) as funcion_mayor_menor_edad;
select mayor_menor_edad(18) as funcion_mayor_menor_edad;
select factorial(5) as funcion_factorial;