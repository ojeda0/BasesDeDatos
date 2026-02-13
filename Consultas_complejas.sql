use banco;

-- 1. Mostrar el saldo medio de todas las cuentas de la entidad bancaria.
	select round(avg(saldo), 2) as saldo_medio
    from cuenta;
    
-- 2. Mostrar la suma de los saldos de todas las cuentas bancarias.
	select round(sum(saldo), 2) as suma_saldos
    from cuenta;
    
-- 3. Mostrar el saldo mínimo, máximo y medio de todas las cuentas bancarias.
	select min(saldo) as saldo_minimo, max(saldo) as saldo_maximo, round(avg(saldo), 2) as saldo_medio
    from cuenta;
    
-- 4. Mostrar la suma de los saldos y el saldo medio de las cuentas bancarias agrupadas por su código de sucursal.
	select round(sum(saldo), 2) as suma_saldos, round(avg(saldo), 2) as saldo_medio, cod_sucursal
    from cuenta
    group by cod_sucursal;
    
-- 5. Para cada cliente del banco se desea conocer su código, la cantidad total que tiene depositada en la entidad y el número de cuentas abiertas.
	select cod_cliente, sum(saldo) as saldo_total, count(cod_cuenta) numero_cuentas
    from cuenta
    group by cod_cliente;
    
-- 6. Retocar la consulta anterior para que aparezca el nombre y apellidos de cada cliente en vez de su código de cliente.
	select concat_ws(' ', cliente.nombre, cliente.apellidos) as nombre_completo_cliente, sum(saldo) as saldo_total, count(cod_cuenta) numero_cuentas
    from cuenta
		join cliente on cliente.cod_cliente = cuenta.cod_cliente
    group by cliente.cod_cliente;
    
-- 7. Para cada sucursal del banco se desea conocer su dirección, el número de cuentas que tiene abiertas y la suma total que hay en ellas.
	select sucursal.cod_sucursal, direccion, count(cuenta.cod_cuenta) as numero_cuentas, sum(saldo) as saldo_total
    from sucursal
		join cuenta on sucursal.cod_sucursal = cuenta.cod_sucursal
	group by cod_sucursal;
    
-- 8. Mostrar el saldo medio y el interés medio de las cuentas a las que se le aplique un interés mayor del 10%, de las sucursales 1 y 2
	select round(avg(saldo), 2) as saldo_medio, round(avg(interes), 2) as interes_medio
    from cuenta
    where (interes * 100 > 10)
		and cod_sucursal in (1,2);
        
-- 9. Mostrar los tipos de movimientos de las cuentas bancarias, sus descripciones y el volumen total de dinero que se manejado en cada tipo de movimiento
	select tipo_movimiento.cod_tipo_mov, tipo_movimiento.descripcion, sum(movimiento.importe) as dinero_manejado
    from tipo_movimiento
		join movimiento on movimiento.cod_tipo_mov = tipo_movimiento.cod_tipo_mov
	group by tipo_movimiento.cod_tipo_mov;
    
-- 10. Mostrar cuál es la cantidad media que sacan de cajero los clientes de nuestro banco.
	select concat_ws(' ', cliente.nombre, cliente.apellidos) as nombre_completo, round(avg(importe), 2) as media_retirada_cajero
    from cliente
		join cuenta on cliente.cod_cliente = cuenta.cod_cliente
		join movimiento on cuenta.cod_cuenta = movimiento.cod_cuenta
	where movimiento.cod_tipo_mov = 2
    group by cuenta.cod_cliente;
    
-- Prueba
select *
from cliente
where nombre like 'A%o';

select * from cliente;