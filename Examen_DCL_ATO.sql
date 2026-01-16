-- EJ 1
	-- Lo hacemos como root
    create user 'alumno'@'localhost' identified by '1234' account lock;
    grant all privileges on *.* to 'alumno'@'localhost' with grant option;
    
-- EJ 2
	-- Lo hacemos como root
    alter user 'alumno'@'localhost' account unlock;
    alter user 'alumno'@'localhost' identified by '123456';
    show grants for 'alumno'@'localhost';
    
    -- Lo hacemos como alumno, creado recientemente y mostramos su informacion
    select current_user();
    
-- EJ 3
	-- Lo hacemos como alumno
    create database jardines;
    use jardines;
    
    create table jardin (
		id bigint primary key auto_increment,
        localidad varchar(250),
        nombre varchar(250),
        es_publico boolean
    );
    
    create table flores (
		id bigint primary key auto_increment,
        nombre_comun varchar(250),
        nombre_cientifico varchar(250),
        color varchar(250),
        id_jardin bigint,
        constraint fk_flores_jardin foreign key (id_jardin) references jardin(id)
    );
    
-- EJ 4
	-- Lo hacemos como alumno
    create user 'insertador'@'%' identified by '1234';
    grant insert on jardines.* to 'insertador'@'%' with grant option;
    
    create user 'consultor'@'%' identified by '1234';
    grant select on jardines.* to 'consultor'@'%' with grant option;
    
    create user 'visor'@'%' identified by '1234';
    grant create view, drop, select on jardines.* to 'visor'@'%' with grant option; -- Le damos el permiso drop también ya que create or replace, ese replace lleva drop por detras. Select tambien lo necesita
    
-- EJ 5
	-- Lo hacemos como insertador
    insert into jardin (localidad, nombre, es_publico)
    values
		('Alcalá de Guadaíra', 'Jardín Fuentes', true),
        ('Dos Hermanas', 'Jardín Colores', false);
    
    insert into flores (nombre_comun, nombre_cientifico, color, id_jardin)
    values
		('Margarita', 'Margarus Blancalus', 'Blanco', 1),
        ('Amapola', 'Amapolus Rojulus', 'Rojo', 2);
        
	-- Lo hacemos como consultor
    select * from jardin;
    select * from flores;
    
    -- Lo hacemos como visor
    create or replace view vista_jardin_flores as
    select
		jardin.id id_jardin,
        jardin.localidad localidad_jardin,
        jardin.nombre nombre_jardin,
        jardin.es_publico,
        flores.id id_flor,
        flores.nombre_comun nombre_comun_flor,
        flores.nombre_cientifico nombre_cientifico_flor,
        flores.color color_flor,
        flores.id_jardin id_jardin_pertenece
	from jardin, flores
    where jardin.id = flores.id_jardin
    ;
    
    select * from vista_jardin_flores;
    
-- EJ 6
	-- Lo hacemos como root
    revoke all privileges, grant option from 'alumno'@'localhost';
    grant drop on jardines.vista_jardin_flores to 'alumno'@'localhost';
    
    -- Lo hacemos como alumno
    drop view jardines.vista_jardin_flores;
    
-- EJ 7
	-- Lo hacemos como root
    revoke all privileges, grant option from 'visor'@'%';
    grant create view on jardines.* to 'visor'@'%';
    show grants for 'visor'@'%';
    drop user 'visor'@'%';
    select * from mysql.user; -- Podemos ver que se ha borrado del sistema