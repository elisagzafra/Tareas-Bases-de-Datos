--
-- creamos tabla email
--  
create table email (
  email_user varchar(500) NOT NULL ,
  email_address varchar(500) NOT NULL
);

-- 
-- insertamos valores en tabla email
INSERT INTO email VALUES ('Wanda Maximoff', 'wanda.maximoff@avengers.org'); ------
INSERT INTO email VALUES ('Pietro Maximoff', 'pietro@mail.sokovia.ru'); ---------
INSERT INTO email VALUES ('Erik Lensherr', 'fuck_you_charles@brotherhood.of.evil.mutants.space'); ------
INSERT INTO email VALUES ('Charles Xavier', 'i.am.secretely.filled.with.hubris@xavier-school-4-gifted-youngste.');
INSERT INTO email VALUES ('Anthony Edward Stark', '	iamironman@avengers.gov');---------
INSERT INTO email VALUES ('Steve Rogers', 'americas_ass@anti_avengers');
INSERT INTO email VALUES ('The Vision', 'vis@westview.sword.gov');-------
INSERT INTO email VALUES ('Clint Barton', 'bul@lse.ye');--------
INSERT INTO email VALUES ('Natasha Romanov', 'blackwidow@kgb.ru');--------
INSERT INTO email VALUES ('Thor', 'god_of_thunder-^_^@royalty.asgard.gov');
INSERT INTO email VALUES ('Logan', 'wolverine@cyclops_is_a_jerk.com');-------
INSERT INTO email VALUES ('Ororo Monroe', 'ororo@weather.co');--------
INSERT INTO email VALUES ('Scott Summers', 'o@x');
INSERT INTO email VALUES ('Nathan Summers', 'cable@xfact.or');---------
INSERT INTO email VALUES ('Groot', 'iamgroot@asgardiansofthegalaxyledbythor.quillsux');--------
INSERT INTO email VALUES ('Nebula', 'idonthaveelektras@complex.thanos'); --------
INSERT INTO email VALUES ('Gamora', 'thefiercestwomaninthegalaxy@thanos.');
INSERT INTO email VALUES ('Rocket', 'shhhhhhhh@darknet.ru'); --------

--
-- creamos query que regrese direcciones de correo invalidas
select e.email_address 
from email e 
where e.email_address like '%@%.%' ;

