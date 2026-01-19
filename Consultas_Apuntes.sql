-- Mostrar valores por pantalla
	select 'Hola mundo'; -- varchar
	select 10; -- numero
	select 15.20; -- decimal
    select true; -- booleans
    
-- Operadores matemáticos
	select 5 + 4 as suma; -- se puede quitar el as
    select 5 * 20 as multiplicación;
    select 5 as primer_número, 'X' as operador, 26 as segundo_número, 5 * 26 as resultado;
    select 10/2 as division;
    select 10 div 3 as division_entera;
    select 10 % 3 as modulo;
    
-- Operadores de comparación
	select 1 = 2;
    select 1 = 1;
    select 2 <= 1 as mayor_igual;
    select 1 != 2;
    select !true negacion;
    
-- Operadores lógicos (AND, OR, XOR, NOT)
	select false and false;
    select true and false;
    select false and true;
    select true and true;
    
    select false or false;
    select true or false;
    select false or true;
    select true or true;
    
-- Operadores especiales (in, between, like, distinct)
	select 5 in (1,2,3,4);
    select 5 not in (1,2,3,4);
    select 5 in (1,2,3,4,5);
    
    select 5 between 1 and 6;
    
    select 'Pepe' = 'P%';
    select 'Pepe' like 'P%';
    
-- Algunas funciones
	select current_user();
    select current_date();
    select now();
    select current_time();
    select database();
    
    select upper('hola');
    select lower('HOLA');
    select length('Juan el pestoso');
    select concat('Juan', 'el', 'pestes');
    select concat_ws(' ', 'Juan', 'el', 'pestes');
    
    select reverse('ABCDEFG');
    select round(128.1456, 2);
    select truncate(128.1456, 2);
    
    select abs(-23);
    select sqrt(25);
    select pow(2, 2);
    
    select datediff(now(), '1976-01-01') div 365;
    select year(now());
    select month(now());
    select date_format(now(), '%d/%m/%y');
    select date_format(now(), 'Hoy es %W, estamos a %d de %M del %Y') as Fecha;
    
    select if(1000 > 5000, 'Eres rico', 'Te aguantas');
    select if(7000 > 5000, 'Eres rico', 'Te aguantas');
    
	select trim('     paco   ');
	select trim('     paco y santi   ');
    select left('Juan', 1);
    select right('Singa', 2);
    select substring('JUANELPESTES', 7, 6);
    select replace ('PACO-DE-LUCIA', '-', ' ');
    
    select round(rand() * 10); -- Lo multiplicamos por el numero maximo que queremos y redondeamos