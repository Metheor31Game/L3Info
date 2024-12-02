
import java.sql.*;
import java.util.Scanner;
/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

/**
 *
 * @author ngarric
 */
public class Tp3Etape2 {

	private static String URL = "jdbc:mysql://localhost:10002/coupedumonde";
	private static String login = "root";
	private static String password = "licinfo2020";
	private Connection connexion;
	private Statement stmt;

	public Tp3Etape2() {
		try {
			// Etablisement de la connexion avec la base
			connexion = DriverManager.getConnection(URL, login, password);
			stmt = connexion.createStatement();

		} catch (SQLException c) {
			System.out.println("Connexion echouee ou base de donnees inconnue : " + c);
		} catch (Exception d) {
			System.out.println("Problème sur connexion");
		}
	}

	public void menu() {

		int res = -1;
		while (res != 0) {
			// on propose à l'utilisateur de choisir entre plusieurs options
			Scanner scan = new Scanner(System.in);
			do {
				System.out.println("Menu\n0=Fin\n1=Afficher toutes les équipes d'une poule\n2=Afficher la liste des stades triés par nombre de matchs\n3=Ajouter un stade");
				res = scan.nextInt();
				if (res<0 || res > 3) {
					System.out.println("mauvais choix! Recommencez.");
				}
			} while (res<0 || res > 3);
			switch (res) {

			// affichage de tous les nomsde sports
			case 1:
				try {
					// on lance la requête
					System.out.println("Entrez le nom d'une poule : ");
					String poule = scan.next();
					PreparedStatement requetepreparee = connexion.prepareStatement("SELECT nomEquipe FROM Equipe WHERE poule = (?)");
					requetepreparee.setString(1, poule);
					ResultSet resultat = requetepreparee.executeQuery();
					

					
					// on parcourt le résultat
					if (!resultat.next()) {
						System.out.println("Pas de poule de ce nom");
					} else {
						while (resultat.next()) {
							
							System.out.println("Voici tous les noms de sports :");
							System.out.println(resultat.getString(1));
						}
					}
					System.out.println();
				} catch (SQLException c) {
					System.out.println("Pas de poule de ce nom : " + c);
				}
				break;
				
			// ajout d'un sport
			case 2:
				try {
					// saisie du nom du sport

					String requete = "SELECT nomStade, COUNT(noMatch) AS compte FROM Stade LEFT JOIN Matchs ON Stade.noStade = Matchs.leStade GROUP BY (nomStade) ORDER BY (compte) ASC";
					ResultSet resultat = stmt.executeQuery(requete);
					
					while (resultat.next()) {
						System.out.println(resultat.getString(1) + " " + resultat.getString(2));

					}
					System.out.println();

				} catch (SQLException c) {
					System.out.println("Problème lors de la trouvaille: " + c);
				}
				break;
				
			case 3:
				try {
					System.out.println("Entrez le nom du stade : ");
					String nom = scan.next();

					System.out.println("Entrez le nom de la ville : ");
					String ville = scan.next();

					PreparedStatement requetepreparee = connexion.prepareStatement("INSERT INTO Stade(nomStade,Ville) VALUES (?,?)");
					requetepreparee.setString(1, nom);
					requetepreparee.setString(2, ville);

					requetepreparee.executeUpdate();
					System.out.println("Truc inséré correctement");




				} catch (SQLException e) {
					System.out.println("Problème lors de l'insertion: " + e);
				}
			}
		}

		// fermeture de la connexion
		try {
			connexion.close();
			System.out.println("Programme terminé");
		} catch (SQLException c) {
			System.out.println("Problème de fermeture de connexion: " + c);
		}

	}

}
