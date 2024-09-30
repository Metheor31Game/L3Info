
import java.sql.*;
public class TestConnection {

	public static void main(String[] args) {
		// TODO Auto-generated method stub

	    try
	    {
	      //étape 1: charger la classe de driver
	      Class.forName("org.postgresql.Driver");
	      
	      //étape 2: créer l'objet de connexion
	      Connection conn = DriverManager.getConnection("jdbc:postgresql://localhost:5433/librairie","userpostgres","userpostgres");
	      
	      //étape 3: créer l'objet statement 
	      Statement stmt = conn.createStatement();
	      
	      //étape 4: exécuter la requête
	      ResultSet res = stmt.executeQuery("SELECT * FROM editeur");
	      FenetreEditeur fe = new FenetreEditeur();
	      
	      //étape 5: impression du résultat de la requête
	      while(res.next())
	        System.out.println(res.getString(1)+"  "+res.getString(2));
	      
	      //étape 6: fermeture de l'objet de connexion
	      conn.close();
	    }
	    catch(Exception e){ 
	      System.out.println(e);
	    }
	}

}
