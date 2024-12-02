DROP DATABASE IF EXISTS coupedumonde;
CREATE DATABASE coupedumonde;

CREATE TABLE Equipe
   (
    noEquipe INT PRIMARY KEY,
    nomEquipe VARCHAR(40) NOT NULL,
	poule VARCHAR(1) NOT NULL
   ) ;
   
CREATE TABLE Joueur
   (
    noJoueur INT  PRIMARY KEY AUTO_INCREMENT,
    nomJoueur VARCHAR(40),
	prenomJoueur VARCHAR(40),
	lEquipe INT,
	CONSTRAINT fkJoueurEquipe FOREIGN KEY (lEquipe) REFERENCES Equipe(noEquipe)
   ) ;
   

   
CREATE TABLE Stade
	(
	noStade INT PRIMARY KEY,
	nomStade VARCHAR(40),
	ville VARCHAR(40)
	);


CREATE TABLE Matchs
   (
    noMatch INT  PRIMARY KEY AUTO_INCREMENT,
    equipe1 INT,
	CONSTRAINT fkMatchEquipe1 FOREIGN KEY (equipe1) REFERENCES Equipe(noEquipe),
    equipe2 INT,
	CONSTRAINT fkMatchEquipe2 FOREIGN KEY (equipe2) REFERENCES Equipe(noEquipe),
	score1 INT,
	score2 INT,
	nbEssai1 INT,
	nbEssai2 INT,
	phase VARCHAR(40),
	leStade INT,
	CONSTRAINT fkMatchLeStade FOREIGN KEY (leStade) REFERENCES Stade(noStade),
	dateMatch DATE
   ) ;
	
   
INSERT INTO Equipe VALUES
(1,'France','A'),   
(2,'Italie','A'),   
(3,'Nouvelle Zelande','A'),   
(4,'Uruguay','A'),   
(5,'Namibie','A'),   
(6,'Irlande','B'), 
(7,'Afrique du Sud','B'), 
(8,'Ecosse','B'), 
(9,'Tonga','B'), 
(10,'Roumanie','B'), 
(11,'Pays de Galles','C'),
(12,'Fidji','C'),
(13,'Australie','C'),
(14,'Georgie','C'),
(15,'Portugal','C'),
(16,'Angleterre','D'),
(17,'Japon','D'),
(18,'Samoa','D'),
(19,'Argentine','D'),
(20,'Chili','D');


INSERT INTO Joueur  (nomJoueur, prenomJoueur, lEquipe)  VALUES
('Hastoy','Antoine',1),
('Jalibert','Matthieu',1),
('Jaminet','Melvyn',1),
('Ramos','Thomas',1),
('Dupont','Antoine',1),
('Couilloud','Baptiste',1),
('Lucu','Maxime',1),
('Fickou','Gael',1),
('Mauvaka','Peato',1),
('Marchand','Julien',1),
('Bourgarit','Pierre',1),
('Alldritt','Gregory',1),
('Cros','Francois',1),
('Macalou','Sekou',1),
('Ollivion','Charles',1),

('Allan','Tommaso',2),
('Da Re','Giacomo',2),
('Garbisi','Paolo',2),
('Capuozzo','Ange',2),
('Varnet','Stephen',2),
('Garbisi','Alessandro',2),
('Page-Relo','Martin',2),
('Odogwu','Paolo',2),
('Bigi','Luca',2),
('Faiva','Hame',2),
('Nicotera','Giacomo',2),
('Cannone','Lorenzo',2),
('Halafihi','Toa',2),
('Pettinelli','Giovanni',2),
('Lamaro','Michele',2),

('Mo Unga','Richie',3),
('Barrett','Beauden',3),
('Ioane','Rieko',3),
('Barrett','Jordie',3),
('Lienert-Brown','Anton',3),
('Couilloud','Baptiste',3),
('Mckenzie','Damian',3),
('Smith','Aaron',3),
('Papalii','Dalton',3),
('Jacobson','Luke',3),
('Frizell','Shannon',3),
('Taylor','Codie',3),
('Coles','Dane',3),
('Saeva','Ardie',3),
('Blackadder','Ethan',3),


('Etcheverry','Felipe',4),
('Silva','Rodrigo',4),
('Arata','Santiago',4),
('Alvarez','Santiago',4),
('Ormaechea','Augustin',4),
('Alonso','Juan Manuel',4),
('Vilaseca','Andres',4),
('Inciarte','Thomas',4),
('Kessler','German',4),
('Pujadas','Guillermo',4),
('Deus','Carlos',4),
('Diana','Manuel',4),
('Ardao','Manuel',4),
('Bianchi','Lucas',4),
('Dosantos','Eric',4),

('Loubser','Cliven',5),
('Van Der Bergh','Andre',5),
('Swanepoel','Tiaan',5),
('Rossouw','Divan',5),
('Theron','Jacques',5),
('Blaauw','Oela',5),
('Kisting','Helarius',5),
('Stevens','Damian',5),
('Nortje','Obert',5),
('Van Jaarsvel','Torsten',5),
('Van Der Westhuizen','Louis',5),
('Booysen','Adriaan',5),
('Hardwick','Richard',5),
('Katjijeko','Max',5),
('Retief','Johan',5),


('Byrne','Ross',6),
('Sexton','Johnny',6),
('Crowley','Jack',6),
('Keenan','Hugo',6),
('Casey','Craig',6),
('Murray','Conor',6),
('Gibson Park','Jamison',6),
('Aki','Bunee',6),
('Kelleher','Ronan',6),
('Sheehan','Dan',6),
('Herring','Rob',6),
('Conan','Jack',6),
('Doris','Caelan',6),
('Baird','Ryan',6),
('Beirne','Tadhg',6),


('Libbok','Manie',7),
('Le Roux','Willie',7),
('De Klerk','Faf',7),
('Hendrikse','Jaden',7),
('Reinach','Cobus',7),
('Williams','Grant',7),
('Esterhuizen','Andre',7),
('Kriel','Jesse',7),
('Fourie','Deon',7),
('Mbonhambi','Mbongeni',7),
('Wiese','Jasper',7),
('Kwagga','Smith',7),
('Kolisi','Siya',7),
('Van Staden','Marco',7),
('Du Toit','Pieter Steph',7),


('Healy','Ben',8),
('Russel','Finn',8),
('Kinghorn','Blair',8),
('Smith','Ollie',8),
('White','Ben',8),
('Horne','George',8),
('Price','Ali',8),
('Redpath','Cameron',8),
('Turner','George',8),
('Ashman','Ewan',8),
('Matthews','Johnny',8),
('Fagerson','Matt',8),
('Dempsey','Jack',8),
('Ritchie','Jamie',8),
('Watson','Hamish',8),


('Pellegrini','Patrick',9),
('Havili','William',9),
('Piutau','Salesi',9),
('Taumoefolau','Kyren',9),
('Pulu','Augustine',9),
('Takulua','Sonatane',9),
('Paea','Manusiu',9),
('Ahki','Pita',9),
('Ngauamo','Paula',9),
('Anga Elangi','Sione',9),
('Moli','Sam',9),
('Vailanu','Sione',9),
('Fifita','Vaea',9),
('Talitui','Sione',9),
('Finau','Penitoa',9),


('Nichitean','Luca',10),
('Boldor','Tudor',10),
('Simionescu','Marius',10),
('Conache','Alin',10),
('Surugiu','Florin',10),
('Rupanu','Gabriel',10),
('Manumua','Tevita',10),
('Graure','Mihai',10),
('Bardasu','Florin',10),
('Irimescu','Robert',10),
('Gorin','Andre',10),
('Stratila','Damian',10),
('Chirica','Cristian',10),
('Rosu','Florian',10),
('Boboc','Cristi',10),


('Biggar','Dan',11),
('Costelow','Sam',11),
('Anscombe','Gareth',11),
('Williams','Liam',11),
('Halfpenny','Leigh',11),
('Davies','Gareth',11),
('Williams','Tomos',11),
('Williams','Johnny',11),
('Elias','Ryan',11),
('Dee','Elliot',11),
('Lake','Dewi',11),
('Faletau','Taulupe',11),
('Wainwright','Aaron',11),
('Morgan','Jac',11),
('Lydiate','Dan',11),


('Droasese','Ilaisa',12),
('Lomani','Frank',12),
('Nayacalevu','Waisea',12),
('Kuruvoli','Simione',12),
('Matawalu','Peni',12),
('Botitu','Vilimoni',12),
('Ravoulou','Kalaveti',12),
('Tuqiri','Emosi',12),
('Togiatama','Zuriel',12),
('Ikanivere','Tevita',12),
('Matavesi','Samuel',12),
('Mata','Viliame',12),
('Miramira','Vilive',12),
('Botia','Levani',12),
('Tagitagivalu','Lekima',12),


('Gordon','Carter',13),
('Kellaway','Andrew',13),
('Jorgensen','Max',13),
('White','Nic',13),
('Mcdermott','Tate',13),
('Fines Leleiwasa','Issac',13),
('Perese','Izaia',13),
('Foketi','Lalakai',13),
('Faessler','Matt',13),
('Uelese','Jordan',13),
('Valetini','Rob',13),
('Porecki','David',13),
('Gleeson','Langi',13),
('Hooper','Tom',13),
('Kemeny','Josh',13),


('Abzhandadze','Tedo',14),
('Matkava','Luka',14),
('Niniashvili','Davit',14),
('Khmaladze','Lasha',14),
('Peranidze','Tengiz',14),
('Lobzhanidze','Vasil',14),
('Aprasidze','Gela',14),
('Sharikadze','Merab',14),
('Mamukashvili','Shalva',14),
('Nioradze','Luka',14),
('Jalagonia','Tornike',14),
('Saignadze','Beka',14),
('Zamtaradze','Tengizi',14),
('Ivanishvili','Luka',14),
('Tsutskiridze','Giorgi',14),


('Portela','Jeronimo',15),
('Moura','Joris',15),
('Cardoso Pinto','Manuel',15),
('Sousa Guedes','Nuno',15),
('Lucas','Pedro',15),
('Belo','Joao',15),
('Marques','Samuel',15),
('Bettencourt','Pedro',15),
('Tadjer','Mike',15),
('Diniz','Duarte',15),
('Campergue','Lionel',15),
('De Freitas','Thibault',15),
('Granate','Joao',15),
('Simoes','Rafael',15),
('Picao','Manuel',15),


('Mitchell','Alex',16),
('Youngs','Ben',16),
('Care','Danny',16),
('May','Jonny',16),
('Farrel','Owen',16),
('Malins','Max',16),
('Lawrence','Ollie',16),
('Marchant','Joe',16),
('Walker','Jack',16),
('Dan','Theo',16),
('George','Jamie',16),
('Ludlam','Lewis',16),
('Ribbans','David',16),
('Vunipola','Billy',16),
('Earl','Ben',16),


('Matsuda','Rikiya',17),
('Lee','Seungsin',17),
('Ogura','Jumpei',17),
('Yamanaka','Ryohei',17),
('Matsushima','Kotaro',17),
('Saito','Naoto',17),
('Nagare','Yutaka',17),
('Fukuda','Kenta',17),
('Horie','Shota',17),
('Horikoshi','Kosuke',17),
('Sakate','Atishi',17),
('Himeno','Kasuki',17),
('Labischagne','Pieter',17),
('Gunter','Ben',17),
('Fukui','Shota',17),


('Toala','Danny',18),
('Matavao','Melani',18),
('Taumateine','Jonathan',18),
('Enari','Ereatara',18),
('Seuteni','Ulupano',18),
('Leali Fano','Christian',18),
('Leuila','Alai D angelo',18),
('Sopoaga','Lima',18),
('Niuia','ray',18),
('Lam','Seilala',18),
('Malolo','Sama',18),
('Fa Aso O','Sootala',18),
('Lee','Fritz',18),
('Luatua','Steven',18),
('Taufua','Sa Jordan',18),


('Carreras','Santiago',19),
('Sanchez','Nicolas',19),
('Bogado','Martin',19),
('Cruz Mallia','Juan',19),
('Cubelli','Tomas',19),
('Bertranou','Gonzalo',19),
('Bazan Velez','Lautaro',19),
('Moroni','Matias',19),
('Ruiz','Ignacio',19),
('Montoya','Julian',19),
('Creevy','Augustin',19),
('Isa','Facundo',19),
('Kremer','Marcos',19),
('Petti Pagadizabal','Guido',19),
('Rubiolo','Pedro',19),


('Carvallo','Lukas',20),
('Torrealba','Marcello',20),
('Herreros','Nicolas',20),
('Garafulic','Matias',20),
('Ignacio Larenas','Jose',20),
('Saavedra','Domingo',20),
('Fernandez','Rodrigo',20),
('Urroz','Francisco',20),
('Dussaillant','Tomas',20),
('Bohme','Augusto',20),
('Escobar','Diego',20),
('Martinez','Raimundo',20),
('Sigren','Martin',20),
('Escobar','Alfonso',20),
('Orchad','Thomas',20);

INSERT INTO Stade VALUES
(1,'Stade de France', 'Saint Denis'),
(2,'Stade Geoffroy Guichard', 'Saint Etienne'),
(3,'Matmut Atlantique', 'Bordeaux'),
(4,'Stade Velodrome', 'Marseille'),
(5,'Stade Pierre Mauroy', 'Lille'),
(6,'Allianz Riviera', 'Nice'),
(7,'Stade de la Beaujoire', 'Nantes'),
(8,'OL Stadium', 'Lyon'),
(9,'Stade Toulousain', 'Toulouse');



INSERT INTO Matchs (equipe1, equipe2, score1, score2,nbEssai1, nbEssai2, phase, leStade, dateMatch) VALUES
(1,3,27,13,2,1,'poule',1,'2023-09-08'),

(2,5,52,8,7,1,'poule',2,'2023-09-09'),
(6,10,82,8,12,1,'poule',2,'2023-09-09'),
(13,14,35,15,4,2,'poule',3,'2023-09-09'),
(16,19,27,10,0,1,'poule',1,'2023-09-09'),

(17,20,42,12,6,2,'poule',9,'2023-09-10'),
(7,8,18,3,2,1,'poule',4,'2023-09-10'),
(11,12,32,26,4,4,'poule',3,'2023-09-10'),

(1,4,27,12,3,2,'poule',5,'2023-09-14'),

(3,5,71,3,10,0,'poule',9,'2023-09-15'),

(18,20,43,10,5,1,'poule',3,'2023-09-16'),
(11,15,28,8,4,1,'poule',6,'2023-09-16'),
(6,9,59,16,8,1,'poule',7,'2023-09-16'),

(7,10,76,0,11,0,'poule',3,'2023-09-17'),
(12,13,22,15,1,2,'poule',2,'2023-09-17'), 
(16,17,34,12,4,0,'poule',6,'2023-09-17'),
	
(2,4,38,17,5,2,'poule',6,'2023-09-20'),

(1,5,96,0,13,0,'poule',4,'2023-09-21'),

(19,18,19,10,1,1,'poule',2,'2023-09-22'),

(14,15,18,18,2,2,'poule',9,'2023-09-23'),
(16,20,76,0,11,0,'poule',5,'2023-09-23'),
(6,7,13,8,1,1,'poule',1,'2023-09-23'),  

(8,9,45,17,7,2,'poule',6,'2023-09-24'),
(11,13,40,6,3,0,'poule',8,'2023-09-24'),

(4,5,36,26,5,2,'poule',8,'2023-09-27'),

(17,18,28,22,3,3,'poule',9,'2023-09-28'),

(3,2,96,17,14,2,'poule',8,'2023-09-29'),

(19,20,59,5,8,1,'poule',7,'2023-09-30'),
(12,14,17,12,2,0,'poule',3,'2023-09-30'),
(8,10,84,0,12,0,'poule',5,'2023-09-30'),

(13,15,34,14,5,2,'poule',2,'2023-10-01'),
(7,9,49,18,7,3,'poule',4,'2023-10-01'),

(3,4,74,0,11,0,'poule',8,'2023-10-05'),

(1,2,60,7,8,1,'poule',8,'2023-10-06'),

(11,14,43,19,6,3,'poule',7,'2023-10-07'),
(16,18,18,17,2,2,'poule',5,'2023-10-07'),
(6,8,36,14,3,2,'poule',1,'2023-10-07'),

(19,17,39,27,5,3,'poule',7,'2023-10-08'),
(9,10,45,24,7,3,'poule',5,'2023-10-08'),
(15,12,24,23,3,2,'poule',9,'2023-10-08'),

(19,11,29,17,2,2,'quart de finale',4,'2023-10-14'),
(3,6,28,24,3,2,'quart de finale',1,'2023-10-14'),
(16,12,30,24,2,3,'quart de finale',4,'2023-10-15'),
(7,1,29,28,4,3,'quart de finale',1,'2023-10-15'),

(3,19,44,6,7,0,'demi finale',1,'2023-10-20'),
(7,16,16,15,1,0,'demi finale',1,'2023-10-21'),

(16,19,26,23,2,2,'petite finale',1,'2023-10-27'),
(7,3,12,11,0,1,'finale',1,'2023-10-28');



