import java.awt.BorderLayout;
import java.awt.GridLayout;

import javax.swing.*;

public class FenetreClient extends JFrame{
	private JLabel l1, l2, l3, l4;
	private JTextField  jt2, jt3, jt4;
	private JButton b;
	
	public FenetreClient(){
		super("création d'un client");
		this.setLayout(new BorderLayout());
		JPanel p1 = new JPanel(new GridLayout(4,1));
		JPanel p2 = new JPanel(new GridLayout(4,1));
		this.l2 = new JLabel("nom du iencli : ");
		this.l3 = new JLabel("prenom du iencli : ");
		this.l4 = new JLabel("adresse du iencli : ");
		this.jt2 = new JTextField();
		this.jt3 = new JTextField();
		this.jt4 = new JTextField();
		this.b = new JButton("envoyer");
		p1.add(l2);
		p1.add(l3);
		p1.add(l4);
		p2.add(jt2);
		p2.add(jt3);
		p2.add(jt4);
		this.add(p1,BorderLayout.WEST);
		this.add(p2,BorderLayout.CENTER);
		this.add(b,BorderLayout.SOUTH);
		b.addMouseListener(new EcouteurBoutonClient(jt2, jt3, jt4, this));
		this.setSize(400,250);
		this.setVisible(true);
	}
	
	public static void main(String[] args) {
		// TODO Auto-generated method stub
		FenetreClient f = new FenetreClient();
	}

}
