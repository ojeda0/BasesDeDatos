-- EJ 1. Entramos como root y mostramos los permisos que tenemos
	show grants; -- Lo hacemos como root
    -- show grants for 'root'@'localhost';
    -- show grants for current_user();
    -- select * from mysql.user where user = 'root';

-- EJ 2. Creamos usuario admin con todos los privilegios
	-- create user 'administrador'@'%' identified by 'pass_admin'; -- Creamos el usuario de forma global con %, % es cualquier IP
    -- create user 'administrador'@'localhost' identified by 'pass_admin'; -- Creamos el usuario de forma global con localhost, debemos cambiarlo después a la hora de hacer la conexión
	-- grant all privileges on *.* to 'administrador'@'%' with grant option; -- Lo hacemos como root y a parte con permisos manejables
    -- grant all privileges on *.* to 'administrador'@'localhost' with grant option; -- Lo hacemos como root y a parte con permisos manejables
    -- select * from mysql.user where user = 'administrador'; -- vemos los usuarios que se llamen administrador

-- EJ 3. Ahora, cerramos sesión y nos conectamos con este nuevo usuario guardando su conexión
	-- Ahora estamos conectados como administrador
    
-- EJ 4. Mostramos un listado con todos los usuarios disponibles en el sistema y posteriormente sólo aquél que se encuentra conectado actualmente
	select user from mysql.user; -- Lo hacemos como administrador
    select user(); -- Lo hacemos como administrador
    
-- EJ 5. Muestra los permisos asociados al usuario conectado a la base de datos
	-- show grants for current_user(); -- Lo hacemos como administrador
    show grants;
    
-- EJ 6. Crea una tabla “Alumno” que contenga dos campos Identificador y nombre e introduce 5 registros

	-- Creamos la cabecera para meter los datos, lo hacemos todo como administrador
    drop database if exists boletin0_dcl;
    create database boletin0_dcl;
    use boletin0_dcl;
    
    -- Creamos la tabla
	create table alumno(
		id bigint primary key auto_increment,
        nombre varchar(250)
    );
    
    -- Metemos 5 registros
    insert into alumno (nombre)
    values
		('Abraham'),
        ('Mario'),
        ('Agustín'),
        ('Miguel'),
        ('Rubén');
        
	select * from alumno;

-- EJ 7. Crea la tabla comentarios que tenga 3 campos, Identificador, comentario y alumno relacionado (fk) e introduce tres comentarios.
	-- Lo hacemos todo como administrador
    create table comentario(
		id bigint primary key auto_increment,
		comentario varchar(250),
        id_alumno bigint,
        constraint fk_comentario_alumno foreign key (id_alumno) references alumno(id)
    );
    
    insert into comentario (comentario, id_alumno)
    values
		('Juanito de la Palmilla el king', 1),
        ('Mario creation de manual', 2),
        ('Lolito de manual', 3);
        
	select * from comentario;

-- EJ 8. Crea la vista llamado comentarios_por_alumno que muestre un listado de comentarios realizados por alumnos
	
    create or replace view comentarios_por_alumno as
		select 
			comentario.id id_comentario, 
			comentario.comentario, 
			alumno.id id_alumno, 
			alumno.nombre
        from comentario, alumno 
        where comentario.id_alumno = alumno.id
	;
    
    -- select * from comentarios_por_alumno;
    
-- EJ 9. Quita a tu usuario los permisos para realizar consultas sobre la vista e intenta realizar una llamada a la vista anterior.
	
	-- revoke select on *.* from 'administrador'@'localhost';
    select * from comentarios_por_alumno;