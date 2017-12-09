use festivali;

insert into Filmski_festival values
(1,'Movie Fest', 'Kneza Milosa 3'),
(2,'Stars', 'Zagrebacka 11'),
(3,'Cinema fest','Pozeska 76')
;

insert into Film values
(1,'Neobicna sudbina Ameli Pulen',90),
(2,'Viki Kristina Barselona',100),
(3,'Bekstvo iz Sosenga',75),
(4,'Pijanista',120)

;

insert into Projektuje values
('15.12.2017 u 17h',3,1,1),
('16.12.2017 u 20h',3,1,2),
('15.12.2017 u 19h',4,2,2),
('15.12.2017 u 17h',3,2,3),
('15.12.2017 u 17h',3,3,4),
('15.12.2017 u 17h',3,3,1)

;

insert into Brosura_filma values
('Jean Jeunet ','Audrey Tautou, Mathieu Kassovitz',2001,1),
('Vudi Alen','Penelope Kruz, Scarlet Johansson ',2007,2),
('Frank Darabont','Tim Robinson, Morgan Freeman',1994,3),
('Roman Polanski','Adrien Brody Emilia Fox',2002,4)

;

insert into Gledalac values
(1, 'Petar', 'Peric'),
(2, 'Zivko', 'Zivkovic'),
(3, 'Jelena', 'Jelic'),
(4, 'Nikola', 'Nikolic'),
(5, 'Laza', 'Lazic'),
(6, 'Zoran', 'Zoric'),
(7, 'Marija', 'Stojic'),
(8, 'Mara', 'Maric')
;

insert into Deca values
(30,12,3),
(30,10,4),
(50,4,7)


;

insert into Odrasli values
(10,1),
(10,2),
(0,5),
(0,6)

;


insert into Novinari values
(100, 'Danas',8)

;

insert into Karta values
(11,'1A','Slobodno',300, 1,1 ),
(12,'2A','Slobodno',300, 1,1 ),
(13,'3A','Slobodno',300, 1,1 ),
(21,'1A','Slobodno',300, 1,2 ),
(22,'2A','Slobodno',300, 1,2 ),
(23,'3A','Slobodno',300, 1,2 ),

(31,'1B','Slobodno',400, 2,2 ),
(32,'2B','Slobodno',400, 2,2 ),
(33,'3B','Slobodno',400, 2,2 ),
(34,'4B','Slobodno',400, 2,2 ),
(41,'1B','Slobodno',300, 2,3 ),
(42,'2B','Slobodno',300, 2,3 ),
(43,'3B','Slobodno',300, 2,3 ),

(51,'1C','Slobodno',400, 3,4 ),
(52,'2C','Slobodno',400, 3,4 ),
(53,'3C','Slobodno',400, 3,4 ),
(61,'1C','Slobodno',200, 3,1 ),
(62,'2C','Slobodno',200, 3,1 ),
(63,'3C','Slobodno',200, 3,1 )



;

insert into Kupuje values
(1,21,1,2),
(2,22, 1,2),
(3,32,2,2),
(4,34,2,2),
(5,61,3,1),
(8,11, 1,1),
(7,12,1,1),
(6,63,3,4)
;




