-- Modelo MySQL - Base de datos Pokémon
-- Engine: InnoDB

DROP DATABASE IF EXISTS pokemon;
CREATE DATABASE pokemon;
USE pokemon;

CREATE TABLE tipo (
    id_tipo INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(30) NOT NULL UNIQUE
) ENGINE=InnoDB;

CREATE TABLE vence_a (
    tipo_fuerte INT NOT NULL,
    tipo_debil INT NOT NULL,
    PRIMARY KEY (tipo_fuerte, tipo_debil),
    FOREIGN KEY (tipo_fuerte) REFERENCES tipo(id_tipo),
    FOREIGN KEY (tipo_debil) REFERENCES tipo(id_tipo)
) ENGINE=InnoDB;

CREATE TABLE movimiento (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(50) NOT NULL,
    puntos_ataque INT,
    puntos_poder INT,
    precision_mov INT
) ENGINE=InnoDB;

CREATE TABLE set_movimientos (
    id_set INT AUTO_INCREMENT PRIMARY KEY,
    mov_1 INT,
    mov_2 INT,
    mov_3 INT,
    mov_4 INT,
    FOREIGN KEY (mov_1) REFERENCES movimiento(id),
    FOREIGN KEY (mov_2) REFERENCES movimiento(id),
    FOREIGN KEY (mov_3) REFERENCES movimiento(id),
    FOREIGN KEY (mov_4) REFERENCES movimiento(id)
) ENGINE=InnoDB;

CREATE TABLE region (
    id_region INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(20) NOT NULL UNIQUE
) ENGINE=InnoDB;

CREATE TABLE ciudad (
    id_ciudad INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(50) NOT NULL,
    region INT NOT NULL,
    FOREIGN KEY (region) REFERENCES region(id_region)
) ENGINE=InnoDB;

CREATE TABLE generacion (
    id_generacion INT AUTO_INCREMENT PRIMARY KEY,
    region INT NOT NULL,
    anyo_descubrimiento INT,
    FOREIGN KEY (region) REFERENCES region(id_region)
) ENGINE=InnoDB;

CREATE TABLE pokemon (
    id_pokemon INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(50) NOT NULL,
    originario INT,
    set_movimientos INT,
    tipo INT NOT NULL,
    FOREIGN KEY (originario) REFERENCES region(id_region),
    FOREIGN KEY (set_movimientos) REFERENCES set_movimientos(id_set),
    FOREIGN KEY (tipo) REFERENCES tipo(id_tipo)
) ENGINE=InnoDB;

CREATE TABLE entrenador (
    id_entrenador INT AUTO_INCREMENT PRIMARY KEY,
    nombre INT NOT NULL,
    lleva_zapatillas TINYINT(1),
    dinero DECIMAL(16,2),
    nacido_en INT,
    FOREIGN KEY (nacido_en) REFERENCES ciudad(id_ciudad)
) ENGINE=InnoDB;

CREATE TABLE gimnasio (
    id_gym INT AUTO_INCREMENT PRIMARY KEY,
    lider INT,
    num_entrenadores INT,
    ciudad INT NOT NULL,
    FOREIGN KEY (lider) REFERENCES entrenador(id_entrenador),
    FOREIGN KEY (ciudad) REFERENCES ciudad(id_ciudad)
) ENGINE=InnoDB;

CREATE TABLE entrenamiento (
    id_entrenador INT NOT NULL,
    id_pokemon INT NOT NULL,
    nivel INT,
    ataque INT,
    defensa INT,
    ataque_esp INT,
    defensa_esp INT,
    velocidad INT,
    puntos_salud INT,
    inicio_entrenamiento DATE,
    naturaleza VARCHAR(50),
    habilidad VARCHAR(50),
    PRIMARY KEY (id_entrenador, id_pokemon),
    FOREIGN KEY (id_entrenador) REFERENCES entrenador(id_entrenador),
    FOREIGN KEY (id_pokemon) REFERENCES pokemon(id_pokemon)
) ENGINE=InnoDB;

-- ============================================
-- DATOS DE EJEMPLO - MODELO POKÉMON (MySQL)
-- ============================================

-- TIPOS
INSERT INTO tipo (id_tipo, nombre) VALUES
(1,'Planta'),(2,'Fuego'),(3,'Agua'),(4,'Eléctrico'),
(5,'Normal'),(6,'Roca'),(7,'Tierra'),(8,'Psíquico');

-- VENTAJAS DE TIPO
INSERT INTO vence_a (tipo_fuerte, tipo_debil) VALUES
(1,7),(2,1),(3,2),(4,3),(6,2),(7,4),(8,5);

-- REGIONES
INSERT INTO region (id_region, nombre) VALUES
(1,'Kanto'),(2,'Johto'),(3,'Hoenn');

-- CIUDADES
INSERT INTO ciudad (id_ciudad, nombre, region) VALUES
(1,'Pueblo Paleta',1),
(2,'Ciudad Verde',1),
(3,'Ciudad Azafrán',1),
(4,'Pueblo Primavera',2),
(5,'Ciudad Malvalona',3);

-- GENERACIONES
INSERT INTO generacion (id_generacion, region, anyo_descubrimiento) VALUES
(1,1,1996),(2,2,1999),(3,3,2002);

-- MOVIMIENTOS
INSERT INTO movimiento (id, nombre, puntos_ataque, puntos_poder, precision_mov) VALUES
(1,'Placaje',40,35,100),
(2,'Látigo Cepa',45,25,100),
(3,'Ascuas',40,25,100),
(4,'Pistola Agua',40,25,100),
(5,'Impactrueno',40,30,100),
(6,'Arañazo',40,35,100),
(7,'Psíquico',90,10,100),
(8,'Avalancha',75,10,90),
(9,'Excavar',80,10,100);

-- SETS DE MOVIMIENTOS
INSERT INTO set_movimientos (id_set, mov_1, mov_2, mov_3, mov_4) VALUES
(1,1,2,NULL,NULL),
(2,1,6,3,NULL),
(3,1,4,NULL,NULL),
(4,1,5,NULL,NULL),
(5,8,1,NULL,NULL),
(6,9,1,NULL,NULL),
(7,7,1,NULL,NULL);

-- POKÉMON
INSERT INTO pokemon (id_pokemon, nombre, originario, set_movimientos, tipo) VALUES
(1,'Bulbasaur',1,1,1),
(2,'Ivysaur',1,1,1),
(3,'Charmander',1,2,2),
(4,'Charmeleon',1,2,2),
(5,'Squirtle',1,3,3),
(6,'Wartortle',1,3,3),
(7,'Pikachu',1,4,4),
(8,'Raichu',1,4,4),
(9,'Onix',1,5,6),
(10,'Diglett',1,6,7),
(11,'Alakazam',1,7,8);

-- ENTRENADORES
INSERT INTO entrenador (id_entrenador, nombre, lleva_zapatillas, dinero, nacido_en) VALUES
(1,101,1,2500.00,1),
(2,102,0,1800.50,2),
(3,103,1,3200.75,3),
(4,104,1,1500.00,4);

-- GIMNASIOS
INSERT INTO gimnasio (id_gym, lider, num_entrenadores, ciudad) VALUES
(1,1,12,2),
(2,3,8,3),
(3,4,6,5);

-- ENTRENAMIENTOS
INSERT INTO entrenamiento VALUES
(1,1,15,49,49,65,65,45,45,'2024-01-10','Audaz','Espesura'),
(1,7,20,55,40,50,50,90,35,'2024-02-01','Alegre','Electricidad Estática'),
(2,3,18,52,43,60,50,65,39,'2024-01-20','Firme','Mar Llamas'),
(3,11,42,50,45,135,95,120,55,'2023-12-05','Miedosa','Foco Interno'),
(4,9,30,45,160,30,45,70,35,'2024-01-15','Plácida','Cabeza Roca');


-- EJERCICIOS

-- 1. Muestra el número de pokémon entrenados por cada entrenador.
select e.id_entrenador, count(en.id_pokemon) as total_pokemon
from entrenador e
join entrenamiento en on e.id_entrenador = en.id_entrenador
group by e.id_entrenador;

-- 2. Muestra para cada pokémon su nombre, el nombre de su región y el año de descubrimiento.
select p.nombre, r.nombre as region, g.anyo_descubrimiento
from pokemon p
join region r on p.originario = r.id_region
join generacion g on r.id_region = g.region;

-- 3. Muestra junto a cada pokemon, el nombre de su entrenador, y el nombre de los cuatro movimientos que conoce.
select p.nombre as pokemon,
	en.nombre as entrenador,
	m1.nombre as mov_1,
    m2.nombre as mov_2,
    m3.nombre as mov_3,
    m4.nombre as mov_4
from pokemon p
join entrenamiento tr on p.id_pokemon = tr.id_pokemon
join entrenador en on tr.id_entrenador = en.id_entrenador
left join set_movimientos sm on p.set_movimientos = sm.id_set
left join movimiento m1 on sm.mov_1 = m1.id
left join movimiento m2 on sm.mov_2 = m2.id
left join movimiento m3 on sm.mov_3 = m3.id
left join movimiento m4 on sm.mov_4 = m4.id;
    
-- 4. Muestra para qué tipos es débil planta.
select t2.nombre as es_debil_contra
from tipo t1
join vence_a v on t1.id_tipo = v.tipo_debil
join tipo t2 on v.tipo_fuerte = t2.id_tipo
where t1.nombre = 'Planta';

-- 5. Muestra la media de entrenadores que hay en los gimnasios para cada región.
select r.nombre, avg(g.num_entrenadores) as media_entrenadores
from region r
join ciudad c on r.id_region = c.region
join gimnasio g on c.id_ciudad = g.ciudad
group by r.nombre;

-- 6. Muestra el movimiento con menor precisión.
select nombre, precision_mov
from movimiento
order by precision_mov asc
limit 1;

-- 7. Muestra el número total de pokémon que existen en una determinada región (ej. Kanto).
select r.nombre, count(p.id_pokemon) as total_pokemon
from region r
join pokemon p on r.id_region = p.originario
where r.nombre = 'Kanto';

-- 8. Pokémon que empiezan por V, su tipo empieza por F y originario de ciudad que termina por O.
select p.nombre
from pokemon p
join tipo t on p.tipo = t.id_tipo
join region r on p.originario = r.id_region
join ciudad c on r.id_region = c.region
where p.nombre like 'V%' 
  and t.nombre like 'F%' 
  and c.nombre like '%o';
  
-- 9. Lista de pokémon que han aprendido "Placaje" (sin duplicados).
select distinct p.nombre
from pokemon p
join set_movimientos sm on p.set_movimientos = sm.id_set
join movimiento m on m.id in (sm.mov_1, sm.mov_2, sm.mov_3, sm.mov_4)
where m.nombre = 'Placaje';

-- 10. Pokémon que no han aprendido ningún ataque (set_movimientos nulo).
select nombre 
from pokemon 
where set_movimientos is null;

-- 11. Ranking (nombre y nivel) de los 10 pokémon con mayor nivel que no sean tipo fantasma y su velocidad no supere al ataque especial.
select p.nombre, e.nivel
from pokemon p
join entrenamiento e on p.id_pokemon = e.id_pokemon
join tipo t on p.tipo = t.id_tipo
where t.nombre != 'Fantasma' 
  and e.velocidad <= e.ataque_esp
order by e.nivel desc
limit 10;

-- 12. Listado de todas las habilidades existentes en el sistema.
select distinct habilidad 
from entrenamiento;

-- 13. Media de dinero de entrenadores por ciudad que NO entrenen a "Charizard"
select c.nombre, round(avg(e.dinero), 2) as media_dinero
from entrenador e
join ciudad c on e.nacido_en = c.id_ciudad
left join entrenamiento en on e.id_entrenador = en.id_entrenador
left join pokemon p on en.id_pokemon = p.id_pokemon and p.nombre = 'Charizard'
where p.id_pokemon is null
group by c.nombre;

-- 14. Media de ahorros de entrenadores por región para aquellos que superan los 1500 euros
select r.nombre, round(avg(e.dinero), 2) as media_ahorro
from entrenador e
join ciudad c on e.nacido_en = c.id_ciudad
join region r on c.region = r.id_region
where e.dinero > 1500
group by r.nombre;

-- 15. Mensaje "X vence a Y" basado en tipos. Nota: Esta consulta asume una comparativa simple entre dos IDs de Pokémon
-- No sé hacerla, me da fallo