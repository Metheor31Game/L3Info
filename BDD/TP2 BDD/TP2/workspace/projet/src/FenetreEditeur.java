import java.awt.BorderLayout;
import java.awt.GridLayout;

import javax.swing.*;

public class FenetreEditeur extends JFrame{
	
	private JLabel l1, l2;
	private JTextField jt1, jt2;
	private JButton b;
	
	public FenetreEditeur(){
		super("création d'un éditeur");
		this.setLayout(new BorderLayout());
		JPanel p1 = new JPanel(new GridLayout(2,1));
		JPanel p2 = new JPanel(new GridLayout(2,1));
		this.l1 = new JLabel("nom de l'editeur : ");
		this.l2 = new JLabel("adresse de l'editeur : ");
		this.jt1 = new JTextField();
		this.jt2 = new JTextField();
		this.b = new JButton("envoyer");
		p1.add(l1);
		p1.add(l2);
		p2.add(jt1);
		p2.add(jt2);
		this.add(p1,BorderLayout.WEST);
		this.add(p2,BorderLayout.CENTER);
		this.add(b,BorderLayout.SOUTH);
		b.addMouseListener(new EcouteurBoutonEditeur(jt1,jt2,this));
		this.setSize(400,250);
		this.setVisible(true);
	}
	
	public static void main(String[] args) {
		// TODO Auto-generated method stub
		FenetreEditeur f = new FenetreEditeur();
	}

}
