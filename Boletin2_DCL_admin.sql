use centro_educativo; -- Lo hacemos como administrador

-- EJ 1. Realiza una vista que muestre el nombre y el apellido de todos los alumnos.
	-- Lo hacemos todo como administrador.
	create or replace view nombre_apellidos_alumnos as
    select
		alumno.id_alum id_alumno,
        alumno.nombre,
        alumno.apellidos
	from alumno
    ;
    
	select * from nombre_apellidos_alumnos;

-- EJ 2. Realiza una vista que muestre el nombre del alumno junto a la asignatura que está matriculada
	-- Lo hacemos todo como administrador
    create or replace view nombre_alumnos_asignatura as
    select
		matriculado.id_alum id_alumno,
        alumno.nombre nombre_alumno,
        alumno.apellidos apellidos_alumno,
        matriculado.id_asig id_asignatura,
        asignatura.nombre nombre_asignatura
    from matriculado, alumno, asignatura
    where alumno.id_alum = matriculado.id_alum
		and matriculado.id_asig = asignatura.id_asig
    ;
    
    select * from nombre_alumnos_asignatura;