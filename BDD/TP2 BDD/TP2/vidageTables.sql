-- on vide les tables avant les tests
	
DELETE FROM aEcrit;
DELETE FROM Contrat;
DELETE FROM Exemplaire;
DELETE FROM Livre;
DELETE FROM Client;
DELETE FROM Auteur;
DELETE FROM Editeur;

ALTER SEQUENCE cleClient RESTART WITH 1;
ALTER SEQUENCE cleAuteur RESTART WITH 1;
ALTER SEQUENCE cleLivre RESTART WITH 1;
ALTER SEQUENCE cleExemplaire RESTART WITH 1;