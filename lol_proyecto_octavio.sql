drop database if exists lol_proyecto;
create database lol_proyecto;
use lol_proyecto;

create table region (
	id bigint primary key auto_increment,
    nombre varchar(250),
	entorno varchar(250),
    magia varchar(250),
    gobierno varchar(250)
);

create table campeon (
	id bigint primary key auto_increment,
	nombre varchar(250),
    linea varchar(250),
    rol varchar(250),
    region_id bigint,
    constraint fk_campeon_region foreign key (region_id) references region (id)
);

insert into region (nombre, entorno, magia, gobierno)
values
	('Demacia', 'Cumbres albas y bastiones de petricita', 'Estrictamente prohibida y castigada', 'Monarquía feudal aristocrática'),
	('Noxus', 'Estepas áridas y fortalezas oscuras', 'Herramienta bélica muy valorada', 'Imperio expansionista por meritocracia'),
	('Jonia', 'Archipiélago de naturaleza prístina', 'Energía fluida, armónica y abundante', 'Provincias pacíficas y monasterios'),
	('Freljord', 'Tundra glacial despiadada', 'Poder ancestral del hielo puro', 'Sociedad tribal matriarcal'),
	('Aguas Estancadas', 'Archipiélago portuario y callejones turbios', 'Hechicería oscura de las profundidades', 'Sindicatos de contrabando y piratería'),
	('Piltover', 'Urbe brillante sobre acantilados', 'Tecnología Hextech refinada', 'Oligarquía de clanes mercantiles'),
	('Zaun', 'Submundo industrial asfixiante', 'Aumentos Quimtech tóxicos', 'Barones del crimen tecnoquímico'),
	('Shurima', 'Desierto de dunas y oasis ocultos', 'Poder celestial de la Ascensión', 'Imperio antiguo en reconstrucción'),
	('Targon', 'Pico montañoso inalcanzable', 'Vínculos astrales y Aspectos divinos', 'Teocracia dividida (Solari y Lunari)'),
	('Islas de la Sombra', 'Tierra marchita cubierta de Niebla Negra', 'Nigromancia y corrupción de almas', 'Dominio del Rey Arruinado'),
	('Ixtal', 'Selva densa e inexplorada', 'Dominio erudito de la magia elemental', 'Autocracia aislacionista (Los Yun Tal)'),
	('El Vacío', 'Dimensión abisal incomprensible', 'Corrupción biológica consumidora', 'Mente colmena insaciable'),
	('Ciudad de Bandle', 'Reino espiritual caprichoso', 'Glamour y hechicería yordle salvaje', 'Comunidad libre y desenfrenada');
    
select * from region;

insert into campeon (nombre, linea, rol, region_id)
values
	('Garen', 'Ruta Superior', 'Combatiente Pesado', 1),
    ('Lux', 'Ruta Central', 'Lanzadora de Conjuros', 1),
    ('Darius', 'Ruta Superior', 'Ejecutor Frontal', 2),
    ('Katarina', 'Ruta Central', 'Asesina de Ráfaga', 2),
    ('Ahri', 'Ruta Central', 'Hechicera Móvil', 3),
    ('Lee Sin', 'Zona de Jungla', 'Luchador Acrobático', 3),
    ('Ashe', 'Ruta Inferior', 'Tiradora de Utilidad', 4),
    ('Sejuani', 'Zona de Jungla', 'Vanguardia Acorazada', 4),
    ('Miss Fortune', 'Ruta Inferior', 'Artillera de Área', 5),
    ('Vi', 'Zona de Jungla', 'Iniciadora Brusca', 6),
    ('Jinx', 'Ruta Inferior', 'Cañonera Frenética', 7),
    ('Azir', 'Ruta Central', 'Comandante de Zonas', 8),
    ('Leona', 'Apoyo Táctico', 'Protectora de Iniciación', 9),
    ('Thresh', 'Apoyo Táctico', 'Controlador de Masas', 10),
    ('Qiyana', 'Ruta Central', 'Manipuladora del Entorno', 11),
    ('Kha''Zix', 'Zona de Jungla', 'Cazador Furtivo', 12),
    ('Teemo', 'Ruta Superior', 'Hostigador de Trampas', 13),
    ('Sylas', 'Ruta Central', 'Mago Escaramuzador', 1),
    ('Fiora', 'Ruta Superior', 'Duelista de Precisión', 1),
    ('Swain', 'Ruta Central', 'Táctico Arcano', 2),
    ('Draven', 'Ruta Inferior', 'Tirador Temerario', 2),
    ('Yasuo', 'Ruta Central', 'Espadachín Ágil', 3),
    ('Akali', 'Ruta Central', 'Asesina Sombría', 3),
    ('Braum', 'Apoyo Táctico', 'Defensor Inquebrantable', 4),
    ('Lissandra', 'Ruta Central', 'Hechicera de Control', 4),
    ('Gangplank', 'Ruta Superior', 'Estratega de Pólvora', 5),
    ('Pyke', 'Apoyo Táctico', 'Ejecutor Furtivo', 5),
    ('Caitlyn', 'Ruta Inferior', 'Francotiradora Precisa', 6),
    ('Jayce', 'Ruta Superior', 'Artífice Transformable', 6),
    ('Ekko', 'Zona de Jungla', 'Viajero Temporal', 7),
    ('Warwick', 'Zona de Jungla', 'Cazador Sanguinario', 7),
    ('Nasus', 'Ruta Superior', 'Coloso Escalonado', 8),
    ('Sivir', 'Ruta Inferior', 'Lanzadora de Chakram', 8),
    ('Pantheon', 'Ruta Superior', 'Guerrero Implacable', 9),
    ('Diana', 'Zona de Jungla', 'Creciente Lunar', 9),
    ('Viego', 'Zona de Jungla', 'Soberano Arruinado', 10),
    ('Hecarim', 'Zona de Jungla', 'Jinete Espectral', 10),
    ('Neeko', 'Ruta Central', 'Ilusionista Floral', 11),
    ('Malphite', 'Ruta Superior', 'Monolito Imparable', 11),
    ('Kai''Sa', 'Ruta Inferior', 'Cazadora Evolutiva', 12),
    ('Vel''Koz', 'Apoyo Táctico', 'Artillero Geométrico', 12),
    ('Tristana', 'Ruta Inferior', 'Artillera Explosiva', 13),
    ('Lulu', 'Apoyo Táctico', 'Encantadora Feérica', 13);
    
select * from campeon;