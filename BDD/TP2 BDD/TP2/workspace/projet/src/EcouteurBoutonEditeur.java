
import java.awt.event.MouseEvent;
import java.awt.event.MouseListener;
import java.sql.*;
import javax.swing.JTextField;

public class EcouteurBoutonEditeur implements MouseListener{

	public JTextField jt1, jt2;
	private FenetreEditeur f;
	private static String URL = "jdbc:postgresql://localhost:5433/librairie";// cc2 est le nom de la base
	private static String login = "userpostgres"; // mettre votre login
	private static String password = "userpostgres"; // mettre votre mot de passe
	private Connection conn;

	public EcouteurBoutonEditeur(JTextField jt1, JTextField jt2, FenetreEditeur f){

		this.jt1 = jt1;
		this.jt2 = jt2;
		this.f = f;

	}

	@Override
	public void mouseClicked(MouseEvent e){
		// TODO Auto-generated method stub
		try {

			Class.forName("org.postgresql.Driver");
			conn = DriverManager.getConnection(URL, login, password);
			System.out.println("nom:" + jt1.getText() + "/adresse:" + jt2.getText());
			if (jt1.getText().isEmpty() || jt2.getText().isEmpty()) {
				throw new SQLException("Le nom et l'adresse ne peuvent pas etre nulles");
			} else {
				// requetePreparee est une requête précompilée : cela permet d'éviter les injections sql...
				PreparedStatement requetePreparee = conn.prepareStatement("INSERT INTO Editeur(nomediteur,adresse) VALUES (?,?)");
				requetePreparee.setString(1,jt1.getText());
				requetePreparee.setString(2,jt2.getText());				
				requetePreparee.executeUpdate();
			}


			conn.close();
			f.setVisible(false);

		}
		catch(SQLException erreurSQL) {
			//System.out.println(erreurSQL);
			//System.out.println(" code de l'erreur : "+erreurSQL.getErrorCode());
			//System.out.println(" message de l'erreur : "+erreurSQL.getMessage());
			String message = "";
			if (erreurSQL.getMessage() == "Le nom et l'adresse ne peuvent pas etre nulles") {
				message = erreurSQL.getMessage();
			} else {
				message = "ERREUR : Il ne peut pas y avoir deux editeurs avec le même nom";
			}
			FenetreErreur fe = new FenetreErreur(message);
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