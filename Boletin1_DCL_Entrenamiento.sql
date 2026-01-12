-- EJ 1. Crea un usuario llamado usuario_test bloqueado por defecto.
-- Lo hacemos como root
	create user 'usuario_test'@'localhost' identified by 'usuario_test' account lock;

-- EJ 2. Asóciale permisos de consulta sobre la tabla “tabla1” que se encuentra en la base de datos “prueba”.
-- Creamos la base de datos, la usamos y creamos la tabla como root
	create database prueba;
	use prueba;

	create table tabla1 (
		id bigint primary key auto_increment
	);

-- Ahora como root le damos permisos de consulta al usuario sobre tabla1
	grant select on prueba.tabla1 to 'usuario_test'@'localhost';

-- EJ 3. Ahora inicia sesión con este nuevo usuario y cambia su contraseña
	-- Tenemos que desbloquear el usuario como root para que nos deje iniciar sesión, lo hacemos como root
	alter user 'usuario_test'@'localhost' account unlock;
    
    -- Ya hemos creado la conexión y he iniciado sesión con el nuevo usuario usuario_test, vamos a cambiar nuestra propia contraseña con usuario_test
    set password = '1234';
    
-- EJ 4. Cambia el nombre de dicho usuario añadiendo un 2 al final.
	-- Tenemos que renombrar el usuario como root, ya que no tenemos permisos para cambiar nuestro nombre
	rename user 'usuario_test'@'localhost' to 'usuario_test2'@'localhost';
    
-- EJ 5. Crea una vista llamada “info_tabla1” que haga una consulta simple sobre la "tabla1".
	-- Tenemos que darle permisos a usuario_test2 para vistas, drop y select otra vez ya que le hemos cambiado el nombre, lo hacemos como root
	grant create view on prueba.* to 'usuario_test2'@'localhost';
    grant select on prueba.* to 'usuario_test2'@'localhost';
    grant drop on prueba.* to 'usuario_test2'@'localhost';

	-- Una vez tengamos permisos en usuario_test2, creamos la vista como usuario_test2
	create or replace view info_tabla1 as
    select
		tabla1.id
	from tabla1
    ;
    
-- EJ 6. Este usuario debe poder crear otro llamado “consulta_info” que tenga permisos de consulta sobre la vista anterior
	-- Debemos darle permisos de create user a usuario_test2, lo hacemos como root
	grant create user on *.* to 'usuario_test2'@'localhost' with grant option;

	-- Creamos el usuario consulta_info con usuario_test2 ahora que ya tenemos permisos
	create user 'consulta_info'@'localhost' identified by '1234';
    
    -- Con usuario_test2 le damos permisos de consulta al nuevo usuario ya que tenemos with grant option que nos ha dado permiso root
    grant select on prueba.info_tabla1 to 'consulta_info'@'localhost';
    
-- EJ 7. Una vez crees la vista, muestra su contenido desde el usuario “consulta_info”
	-- Iniciamos sesión con el usuario consulta_info y probamos a ver el contenido desde consulta_info
    select * from info_tabla1;
    
-- EJ 8. Una vez creada la vista y el usuario, quita los permisos que has tenido que otorgar al usuario “usuario_test2” para poder crearlos y déjale solamente los de consulta sobre
-- “tabla” dados en el ejercicio 2. Prueba que esta acción se ha realizado correctamente mostrando sus permisos.
	-- Nos logueamos como root para quitarle los permisos a usuario_test2 y solo les dejamos los mismos que el ejercicio 2, el permiso select en prueba.tabla1
	revoke all privileges, grant option from 'usuario_test2'@'localhost';
    grant select on prueba.tabla1 to 'usuario_test2'@'localhost';
    
    -- Como root miramos los permisos de usuario_test2 para comprobar que todo esta bien
    show grants for 'usuario_test2'@'localhost'; -- Podemos ver como solo tiene el permiso select en prueba.tabla1
    
-- EJ 9. Ahora añade todos los privilegios posibles a ese usuario para cualquier tabla de cualquier base de datos y vuelve a mostrar que la acción se ha realizado.
	-- Le damos todos los permisos como root y miramos los permisos
	grant all privileges on *.* to 'usuario_test2'@'localhost';
    show grants for 'usuario_test2'@'localhost';
    
-- EJ 10. Muestra ahora todos los usuarios del sistema y elimina el último creado.
	-- Como root
    select * from mysql.user;
    drop user 'consulta_info'@'localhost';