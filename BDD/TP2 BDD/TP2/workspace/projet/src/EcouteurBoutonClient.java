import java.awt.event.MouseEvent;
import java.awt.event.MouseListener;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;

import javax.swing.JTextField;


public class EcouteurBoutonClient implements MouseListener{

	public JTextField jt2, jt3, jt4;
	private FenetreClient c;
	private static String URL = "jdbc:postgresql://localhost:5433/librairie";// cc2 est le nom de la base
	private static String login = "userpostgres"; // mettre votre login
	private static String password = "userpostgres"; // mettre votre mot de passe
	private Connection conn;

	public EcouteurBoutonClient( JTextField jt2,JTextField jt3,JTextField jt4, FenetreClient c){

		this.jt2 = jt2;
		this.jt3 = jt3;
		this.jt4 = jt4;
		this.c = c;

	}

	@Override
	public void mouseClicked(MouseEvent e){
		// TODO Auto-generated method stub
		try {

			Class.forName("org.postgresql.Driver");
			conn = DriverManager.getConnection(URL, login, password);
			System.out.println("/nom:" + jt2.getText() + "/prenom" + jt3.getText() + "adresse" + jt4.getText());
			if (jt2.getText().isEmpty()) {
				throw new SQLException("Le nom et l'adresse ne peuvent pas etre nulles");
			} else {
				// requetePreparee est une requête précompilée : cela permet d'éviter les injections sql...
				PreparedStatement requetePreparee = conn.prepareStatement("INSERT INTO Client(nomclient,prenomclient,emailclient) VALUES (?,?,?)");
				requetePreparee.setString(1,jt2.getText());	
				requetePreparee.setString(2,jt3.getText());
				requetePreparee.setString(3,jt4.getText());	
				requetePreparee.executeUpdate();
			}


			conn.close();
			c.setVisible(false);

		}
		catch(SQLException erreurSQL) {
			//System.out.println(erreurSQL);
			//System.out.println(" code de l'erreur : "+erreurSQL.getErrorCode());
			//System.out.println(" message de l'erreur : "+erreurSQL.getMessage());
			String message = "";
			/*
			if (erreurSQL.getMessage() == "Le nom et l'adresse ne peuvent pas etre nulles") {
				message = erreurSQL.getMessage();
			} else {
				message = "ERREUR : Il ne peut pas y avoir deux editeurs avec le même nom";
			}
			*/
			FenetreErreur fe = new FenetreErreur(erreurSQL.getMessage());
		}
		catch(Exception exc){ 
			System.out.println(exc);
		}
		//f.setVisible(false);
	}

	@Override
	public void mousePressed(MouseEvent e) {
		// TODO Auto-generated method stub
		
	}

	@Override
	public void mouseReleased(MouseEvent e) {
		// TODO Auto-generated method stub
		
	}

	@Override
	public void mouseEntered(MouseEvent e) {
		// TODO Auto-generated method stub
		
	}

	@Override
	public void mouseExited(MouseEvent e) {
		// TODO Auto-generated method stub
		
	}
	
}
