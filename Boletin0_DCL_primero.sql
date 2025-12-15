-- EJ 1. Entramos como root y mostramos los permisos que tenemos
	show grants; -- Lo hacemos como root

-- EJ 2. Creamos usuario admin con todos los privilegios
	-- create user administrador identified by 'pass_admin'; -- Lo hacemos como root
	-- grant all privileges on *.* to administrador; -- Lo hacemos como root

-- EJ 3. Ahora, cerramos sesión y nos conectamos con este nuevo usuario guardando su conexión
	-- Ahora estamos conectados como administrador
    
-- EJ 4. Mostramos un listado con todos los usuarios disponibles en el sistema y posteriormente sólo aquél que se encuentra conectado actualmente
	select user from mysql.user; -- Lo hacemos como administrador
    select user(); -- Lo hacemos como administrador
    
-- EJ 5. Muestra los permisos asociados al usuario conectado a la base de datos
	show grants for current_user(); -- Lo hacemos como administrador