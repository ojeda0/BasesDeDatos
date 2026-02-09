use ejemplo_joins;

-- 1. Cual es el chupachups con chicle más comido
select ch.*
from come c
	join chupachups ch on ch.id = c.id_chupachups
where ch.tiene_chicle
group by ch.id
order by count(c.id_chupachups) desc
limit 1;

-- 2. Cual es el chupachups sin chicle menos comido
select ch.*
from come c
	join chupachups ch on ch.id = c.id_chupachups
where ch.tiene_chicle is false
group by ch.id
order by count(c.id_chupachups) asc
limit 1;

-- 3. Cual es la media de niños que comen chupachups con chicle
select ch.tiene_chicle, round(count(c.id_niño)/(select count(*) from niño) * 100, 1) as media_niños
from come c
    join chupachups ch on ch.id = c.id_chupachups
where ch.tiene_chicle is true
group by ch.tiene_chicle;