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
    
-- EJ 6. Crea una tabla “Alumno” que contenga dos campos Identificador y nombre e introduce 5 registros

	-- Creamos la cabecera para metes los datos
    drop database if exists boletin0_dcl;
    create database boletin0_dcl;
    use boletin0_dcl;
    
	create table alumno(
		id bigint primary key auto_increment,
        nombre varchar(250)
    );
    
    insert into alumno (nombre) 
    values
		('Abraham'),
        ('Mario'),
        ('Agustín'),
        ('Miguel'),
        ('Rubén');
        
	select * from alumno;

-- EJ 7. Crea la tabla comentarios que tenga 3 campos, Identificador, comentario y alumno relacionado (fk) e introduce tres comentarios.
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