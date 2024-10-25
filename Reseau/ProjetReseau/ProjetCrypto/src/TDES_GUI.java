import java.awt.BorderLayout;
import java.awt.Color;
import java.awt.GridBagConstraints;
import java.awt.GridBagLayout;
import java.awt.Insets;
import javax.swing.JButton;
import javax.swing.JFrame;
import javax.swing.JPanel;

public class TDES_GUI extends JFrame {

    public TDES_GUI() {
        this.setTitle("Triple DES");
        this.setSize(800, 600);
        this.getContentPane().setBackground(Color.black);
        this.setLocationRelativeTo(null);
        this.setResizable(false);

        JButton crypteButton = new JButton("Crypter");
        JButton decrypteButton = new JButton("Décrypter");

        crypteButton.setForeground(Color.white);
        crypteButton.setBackground(Color.black);
        decrypteButton.setForeground(Color.white);
        decrypteButton.setBackground(Color.black);

        setLayout(new GridBagLayout());
        GridBagConstraints gbc = new GridBagConstraints();
        gbc.insets = new Insets(10, 10, 30, 10);
        gbc.gridx = 0;
        gbc.gridy = 0;

        add(crypteButton, gbc);
        gbc.gridy = 1;
        add(decrypteButton, gbc);

        GUIListener guiListener = new GUIListener(this);
        crypteButton.addActionListener(guiListener);
        decrypteButton.addActionListener(guiListener);
        addWindowListener(guiListener);

        setVisible(true);
    }

    // Méthode pour gérer le chiffrement
    public void cryptage() {
        System.out.println("Méthode de cryptage appelée");
        // Logique de cryptage à ajouter ici
    }

    // Méthode pour gérer le déchiffrement
    public void decryptage() {
        System.out.println("Méthode de décryptage appelée");
        // Logique de décryptage à ajouter ici
    }

    public static void main(String[] args) {
        TDES_GUI gui = new TDES_GUI();
    }
}
