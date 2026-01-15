-- EJ 1. Crear usuario con nombre y apellidos de la Moodle, con contraseña, bloqueado por defecto y va ser administrador, todos los permisos posibles. Usuario global
	-- Lo hacemos como root
	create user 'ateboje1209'@'%' identified by '1234' account lock;
    grant all privileges on *.* to 'ateboje1209'@'%';
    
-- EJ 2. Desbloquear el usuario, logueate como el usuario y el usuario debe cambiar su propia contraseña, mostramos nuestros propios privilegios y el usuario conectado.
	-- Lo hacemos como root
    alter user 'ateboje1209'@'%' account unlock;
    
    -- Lo hacemos con el usuario creado, ateboje1209
    set password = '123456';
    show grants;
    select current_user();
    
-- EJ 3. El nuevo usuario creará el esquema de la base de datos
	-- Lo hacemos como ateboje1209
    create database practicas_simulacro;
    use practicas_simulacro;
    
    create table alumno(
		id bigint primary key auto_increment,
        nombre varchar(250),
        apellidos varchar(250)
    );
    
    create table empresa(
		cif char(9) primary key,
        sede varchar(250),
        nombre varchar(250)
    );
    
    create table alumno_empresa(
		id_alumno bigint,
        cif_empresa char(9),
        fecha_convenio date,
        es_dual boolean,
        constraint pk_id_cif_fecha primary key (id_alumno, cif_empresa, fecha_convenio),
        constraint fk_alumno_empresa_alumno foreign key (id_alumno) references alumno(id),
        constraint fk_alumno_empresa_empresa foreign key (cif_empresa) references empresa(cif)
    );
    
-- EJ 4. El usuario ateboje1209 creado tiene que crear 2 usuarios más, uno que sea escritor y otro lector, escritor mete datos y el lector consulta, usuarios locales. Escritor hace 1 insert en cada tabla y lector las consulta
	-- Lo hacemos como root
    grant all privileges on *.* to 'ateboje1209'@'%' with grant option;
    
    -- Lo hacemos como ateboje1209
    create user 'escritor'@'localhost' identified by '1234';
    grant insert on practicas_simulacro.* to 'escritor'@'localhost';
    grant select on practicas_simulacro.* to 'escritor'@'localhost';
    
    create user 'lector'@'localhost' identified by '1234';
    grant select on practicas_simulacro.* to 'lector'@'localhost';
    
    -- Lo hacemos como el usuario escritor, creado recientemente para insertar datos en las tablas
    use practicas_simulacro;
    insert into practicas_simulacro.alumno(nombre, apellidos)
    values
		('Juan', 'De la Palmilla');
        
	insert into practicas_simulacro.empresa(cif, sede, nombre)
    values
		('E30364640', 'Grieta del Invocador', 'Riot Games');
        
	insert into practicas_simulacro.alumno_empresa(id_alumno, cif_empresa, fecha_convenio, es_dual)
    values
		(1, 'E30364640', '2026-01-10', true);
        
	-- Lo hacemos como lector, creado recientemente para hacer las consultas de los datos
    use practicas_simulacro;
    select * from alumno;
    select * from empresa;
    select * from alumno_empresa;
    
-- EJ 5. Al usuario lector le vamos a dar permiso de vistas y va a crear una vista que muestre toda la informacion entre empresa y alumno
	-- Lo hacemos como ateboje1209
    grant create view, drop on practicas_simulacro.* to 'lector'@'localhost';
    
    -- Lo hacemos como lector
    use practicas_simulacro;
    create or replace view vista_alumno_empresa as
    select
		alumno.id id_alumno,
        alumno.nombre nombre_alumno,
        alumno.apellidos apellidos_alumno,
        empresa.cif cif_empresa,
        empresa.sede sede_empresa,
        empresa.nombre nombre_empresa,
        alumno_empresa.id_alumno id_alumno_convenio,
        alumno_empresa.cif_empresa cif_empresa_convenio,
        alumno_empresa.fecha_convenio,
        alumno_empresa.es_dual
	from alumno, empresa, alumno_empresa
    where alumno.id = alumno_empresa.id_alumno
		and empresa.cif = alumno_empresa.cif_empresa
    ;
    
    select * from vista_alumno_empresa;
    
-- EJ 6. Le quitamos a ateboje1209 todos los permisos y solo le dejamos el privilegio de select sobre la vista creada
	-- Lo hacemos como root
    revoke all privileges, grant option from 'ateboje1209'@'%';
    grant select on practicas_simulacro.vista_alumno_empresa to 'ateboje1209'@'%';
    
    -- Lo hacemos como ateboje1209
    use practicas_simulacro;
    select * from vista_alumno_empresa;
    show grants;