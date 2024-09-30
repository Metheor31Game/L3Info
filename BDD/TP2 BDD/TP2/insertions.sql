INSERT INTO Editeur VALUES
('editeur1','adresse1'),
('editeur2','adresse2'),
('editeur3','adresse3'),
('editeur4','adresse4');

INSERT INTO Auteur VALUES
(NEXTVAL('cleAuteur'),'nomAuteur1','prenomAuteur1','emailAuteur1'),
(NEXTVAL('cleAuteur'),'nomAuteur2','prenomAuteur2','emailAuteur2'),
(NEXTVAL('cleAuteur'),'nomAuteur3','prenomAuteur3','emailAuteur3'),
(NEXTVAL('cleAuteur'),'nomAuteur4','prenomAuteur4','emailAuteur4');

INSERT INTO Client VALUES
(NEXTVAL('cleClient'),'nomClient1','prenomClient1','emailClient1'),
(NEXTVAL('cleClient'),'nomClient2','prenomClient2','emailClient2'),
(NEXTVAL('cleClient'),'nomClient3','prenomClient3','emailClient3'),
(NEXTVAL('cleClient'),'nomClient4','prenomClient4','emailClient4'),
(NEXTVAL('cleClient'),'nomClient5','prenomClient5','emailClient5');

INSERT INTO Livre VALUES
(NEXTVAL('cleLivre'),'BD','titre1',10,'editeur1'),
(NEXTVAL('cleLivre'),'POCHE','titre2',10,'editeur2'),
(NEXTVAL('cleLivre'),'BD','titre3',10,'editeur2'),
(NEXTVAL('cleLivre'),'POCHE','titre4',10,'editeur3');

INSERT INTO Exemplaire VALUES
(NEXTVAL('cleExemplaire'),1,1,'12/05/2023'),
(NEXTVAL('cleExemplaire'),1,2,'12/05/2023'),
(NEXTVAL('cleExemplaire'),2,2,'12/05/2023'),
(NEXTVAL('cleExemplaire'),2,3,'12/05/2023'),
(NEXTVAL('cleExemplaire'),3,4,'12/05/2023'),
(NEXTVAL('cleExemplaire'),1,5,'12/05/2023');

INSERT INTO Contrat VALUES
(1,'editeur1'),
(2,'editeur2'),
(3,'editeur2'),
(4,'editeur3');

INSERT INTO AEcrit VALUES
(1,1),
(2,2),
(3,3),
(4,4);