use centro_educativo;

-- EJ 1
select nombre 
from provincia;

-- EJ 2
select nombre, apellidos
from alumno;

	-- EJ 2 con concat de nombre completo
    select concat_ws(' ', nombre, apellidos) as nombre_completo
    from alumno;

-- EJ 3
select *
from asignatura;

-- EJ 4
select dni, nombre, apellidos
from profesor
order by dni asc;

-- EJ 5
select id_alum, dni, nombre, apellidos, fecha_nac as fecha_de_nacimiento, nacido_en
from alumno
order by fecha_nac asc;

-- EJ 6
select *
from alumno
where dni = '56846315M';

	-- EJ 6 con like
    select *
    from alumno
    where dni like '5684631%';

-- EJ 7
select *
from alumno
where nacido_en between 3 and 7;

-- EJ 8
select *
from profesor
where nacido_en in (1, 3, 5, 7);

-- EJ 9 
select *
from alumno
where fecha_nac between '1980-02-19' and '1984-07-20';

-- EJ 10
select *
from matriculado
where id_alum = 7;

-- EJ 11
select nombre, apellidos
from alumno
where timestampdiff(year, fecha_nac, curdate()) > 24;

-- EJ 12
select *
from alumno
where dni like '%Y';

-- EJ 13
select *
from alumno
where nombre like 'S%';

-- EJ 14
select nombre
from alumno
where nombre like '%n%';

-- EJ 15
select nombre
from alumno
where apellidos like '%z%';

-- EJ 16
select *
from alumno
where nombre = 'Manuel';

-- EJ 17
select *
from alumno
where nombre in ('Manuel', 'Cristina');

-- EJ 18
select *
from alumno
where dni like '2%';

-- EJ 19
select distinct nacido_en
from alumno;

-- EJ 20
select id_alum, id_asig, nota1, nota2, nota3, round(((nota1 + nota2 + nota3) / 3), 2) as nota_media
from matriculado
order by nota_media desc;

-- EJ 21
select *
from matriculado
where id_asig = 1
	and nota1 >= 5
	and nota2 >= 5
    and nota3 >= 5;
    
-- EJ 22
select *
from matriculado
where nota1 = 10
	or nota2 = 10
    or nota3 = 10;
    
-- EJ 23
select *
from matriculado
where id_asig = 2
	and (nota1 >= 5 or nota2 >= 5 or nota3 >= 5);
    
-- EJ 24
select *
from matriculado
where nota1 >= 5
order by nota2 asc, nota3 asc;