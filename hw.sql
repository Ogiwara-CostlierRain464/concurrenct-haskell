drop table if exists prefecture;
create table prefecture
(
    pref_id int,
    name text,
    area box,
    capital text,
    population int,
    size int
);

insert into prefecture(pref_id, name, area, capital, population, size) 
values (1, 'HOKKAIDO', box('(3,3)', '(4,4)'), 'SAPPORO', 5000000, 80000);
insert into prefecture(pref_id, name, area, capital, population, size) 
values (2, 'AOMORI', box('(2.5,2.5)', '(3,3)'), 'AOMORI', 100000, 3000);
insert into prefecture(pref_id, name, area, capital, population, size) 
values (3, 'NAGANO', box('(2,2)', '(2.5,2.5)'), 'MATSUMOTO', 300000, 6000);
insert into prefecture(pref_id, name, area, capital, population, size) 
values (4, 'YAMANASHI', box('(0.5,0.5)', '(1.2,1.2)'), 'KOFU', 300000, 4000);
insert into prefecture(pref_id, name, area, capital, population, size) 
values (5, 'TOKYO', box('(1,-1)', '(2,-3)'), 'TOKYO', 10000000, 3000);

insert into prefecture(pref_id, name, area, capital, population, size) 
values (6, 'HYOUGO', box('(-1,1)', '(-2,2)'), 'KOBE', 100000, 5000);
insert into prefecture(pref_id, name, area, capital, population, size) 
values (7, 'KUMAMOTO', box('(-1,-1)', '(-1.5,-1.5)'), 'KUMAMOTO', 90000, 5000);
insert into prefecture(pref_id, name, area, capital, population, size) 
values (8, 'KAGOSHIMA', box('(-2.9,-2.9)', '(-4,-4)'), 'KAGOSHIMA',41000, 5000);
insert into prefecture(pref_id, name, area, capital, population, size) 
values (9, 'NAGASAKI', box('(-2,-1)', '(-3,-2)'), 'NAGASAKI', 20000, 3000);
insert into prefecture(pref_id, name, area, capital, population, size) 
values (10, 'OKINAWA', box('(-5,-5)', '(-7,-7)'), 'NAHA', 10000, 300);


drop table if exists volcano;
create table volcano
(
    mount_id int,
    name text,
    place point,
    type int,
    height int,
    dangerness boolean
);

insert into volcano(mount_id, name, place, type, height, dangerness) 
values (1, 'ASAMA', '(2,2)', 0, 3000, 't');
insert into volcano(mount_id, name, place, type, height, dangerness) 
values (2, 'FUJI', '(1,1)' , 1, 1000, 'f');
insert into volcano(mount_id, name, place, type, height, dangerness) 
values (3, 'RISHIRI', '(3,3)', 2, 1500, 't');
insert into volcano(mount_id, name, place, type, height, dangerness) 
values (4, 'IZU_OSHIMA', '(1,-1)', 0, 2000, 'f');
insert into volcano(mount_id, name, place, type, height, dangerness) 
values (5, 'UNZEN', '(-2,-1)', 1, 2500, 't');
insert into volcano(mount_id, name, place, type, height, dangerness) 
values (6, 'ASO', '(-1,-1)', 2, 1000, 'f');
insert into volcano(mount_id, name, place, type, height, dangerness) 
values (7, 'SAKURA', '(-2,-2)', 0, '400', 't');

drop table if exists eruption;
create table eruption 
(
    mount_id int,
    time timestamptz,
    victims int
);
insert into eruption (mount_id, time, victims) values (1, '1960/1/1', 50000);
insert into eruption (mount_id, time, victims) values (1, '1840/1/1', 20000);
insert into eruption (mount_id, time, victims) values (2, '300/1/1', 1000);
insert into eruption (mount_id, time, victims) values (3, '600/1/1', 300);
insert into eruption (mount_id, time, victims) values (3, '1200/1/1', 2000);
insert into eruption (mount_id, time, victims) values (3, '1800/1/1', 100000);
insert into eruption (mount_id, time, victims) values (4, '1870/1/1', 5660);
insert into eruption (mount_id, time, victims) values (4, '1950/1/1', 3994);
insert into eruption (mount_id, time, victims) values (4, '1980/1/1', 2444);
insert into eruption (mount_id, time, victims) values (5, '400/1/1', 2111);
insert into eruption (mount_id, time, victims) values (5, '600/1/1', 5000);
insert into eruption (mount_id, time, victims) values (6, '1300/1/1', 5000);
insert into eruption (mount_id, time, victims) values (7, '2000/1/1', 2000);
insert into eruption (mount_id, time, victims) values (7, '1900/1/1', 1000);

create or replace function volcano_belongs_to(int)
returns int as
$body$
select sq.pref_id from (
    select prefecture.pref_id
    from prefecture, volcano
    where volcano.mount_id=$1 and prefecture.area @> volcano.place
) as sq;
$body$
language sql;

create or replace function nearest_from(point)
returns int as 
$body$
select sq.mount_id from (
    select mount_id, place <-> $1 as d 
    from volcano order by d asc limit 1
) as sq;
$body$
language sql;

create or replace function is_eruption_in_time_range(int, timestamptz, timestamptz)
returns boolean as
$body$
select sq is not null from (
    select * 
    from eruption 
    where mount_id=$1 and $2 <= time and time <= $3 
) as sq;
$body$
language sql;