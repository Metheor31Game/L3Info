import java.awt.*;
import javax.swing.*;

public class TDES_GUI extends JFrame {
    private JButton crypteButton;
    private JButton decrypteButton;
    private JButton menuButton;
    private JButton choisirFichierButton;
    private JRadioButton choisirMotDePasseRadio;
    private JRadioButton cleAleatoireRadio;
    private JTextField motDePasseField;
    private GUIListener guiListener;

    public TDES_GUI() {
        this.setTitle("Triple DES");
        this.setSize(800, 600);
        this.getContentPane().setBackground(Color.black);
        this.setLocationRelativeTo(null);
        this.setResizable(false);

        // Initialise le listener
        guiListener = new GUIListener(this);

        // Affiche les boutons du menu principal
        afficherMenu();

        setVisible(true);
    }

    // Méthode pour afficher le menu principal avec les boutons "Crypter" et
    // "Décrypter"
    public void afficherMenu() {
        // Supprimer tous les composants existants
        getContentPane().removeAll();

        // Créer les boutons
        crypteButton = new JButton("Crypter");
        decrypteButton = new JButton("Décrypter");

        // Configurer les couleurs des boutons
        crypteButton.setForeground(Color.white);
        crypteButton.setBackground(Color.black);
        decrypteButton.setForeground(Color.white);
        decrypteButton.setBackground(Color.black);

        // Utiliser GridBagLayout pour centrer les boutons
        setLayout(new GridBagLayout());
        GridBagConstraints gbc = new GridBagConstraints();
        gbc.insets = new Insets(10, 10, 30, 10);
        gbc.gridx = 0;
        gbc.gridy = 0;

        add(crypteButton, gbc);
        gbc.gridy = 1;
        add(decrypteButton, gbc);

        // Ajouter les listeners aux boutons
        crypteButton.addActionListener(guiListener);
        decrypteButton.addActionListener(guiListener);

        // Rafraîchir l'interface
        revalidate();
        repaint();
    }

    // Méthode pour afficher le menu de chiffrement
    public void cryptage() {
        System.out.println("Méthode de cryptage appelée");

        // Supprimer les anciens composants et configurer le layout
        getContentPane().removeAll();
        setLayout(new BorderLayout());

        // Afficher le bouton Menu en haut à gauche
        afficherBoutonMenu();

        // Panneau pour le bouton "Choisir un fichier" à gauche
        JPanel leftPanel = new JPanel(new FlowLayout(FlowLayout.LEFT));
        leftPanel.setBackground(Color.black);
        choisirFichierButton = new JButton("Choisir un fichier");
        leftPanel.add(choisirFichierButton);
        add(leftPanel, BorderLayout.WEST);

        // Panneau pour les options de clé à droite
        JPanel rightPanel = new JPanel();
        rightPanel.setLayout(new BoxLayout(rightPanel, BoxLayout.Y_AXIS));
        rightPanel.setBackground(Color.LIGHT_GRAY);
        rightPanel.setBorder(BorderFactory.createEmptyBorder(10, 10, 10, 10)); // Espacement

        // Créer les boutons radio pour les options de clé
        choisirMotDePasseRadio = new JRadioButton("Choisir un mot de passe");
        cleAleatoireRadio = new JRadioButton("Clé aléatoire");
        ButtonGroup keyOptionGroup = new ButtonGroup();
        keyOptionGroup.add(choisirMotDePasseRadio);
        keyOptionGroup.add(cleAleatoireRadio);
        rightPanel.add(choisirMotDePasseRadio);
        rightPanel.add(cleAleatoireRadio);

        // Champ de texte pour entrer le mot de passe de 24 caractères
        motDePasseField = new JTextField(24); // Limite à 24 caractères
        motDePasseField.setEnabled(false); // Désactivé par défaut
        motDePasseField.setVisible(false); // Caché par défaut
        motDePasseField.setSize(70, 30);
        motDePasseField.getDocument().addDocumentListener(new PasswordDocumentListener(motDePasseField, 24));
        rightPanel.add(motDePasseField);

        // Ajout des listeners pour activer/désactiver et afficher/cacher le champ de
        // mot de passe
        choisirMotDePasseRadio.addActionListener(e -> {
            motDePasseField.setSize(70, 30);
            motDePasseField.setEnabled(true);
            motDePasseField.setVisible(true);
            rightPanel.revalidate(); // Rafraîchit l'affichage du panel
            rightPanel.repaint();
        });
        cleAleatoireRadio.addActionListener(e -> {
            motDePasseField.setEnabled(false);
            motDePasseField.setVisible(false);
            rightPanel.revalidate(); // Rafraîchit l'affichage du panel
            rightPanel.repaint();
        });

        // Ajouter le panneau à droite
        add(rightPanel, BorderLayout.EAST);

        // Rafraîchir l'interface
        revalidate();
        repaint();
    }

    // Méthode pour gérer le déchiffrement
    public void decryptage() {
        System.out.println("Méthode de déchiffrement appelée");
        // Supprimer les anciens composants et configurer le layout
        getContentPane().removeAll();
        setLayout(new BorderLayout());

        // Créer le bouton Menu en haut à gauche
        menuButton = new JButton("Menu");
        menuButton.setForeground(Color.white);
        menuButton.setBackground(Color.black);

        // Ajouter l'ActionListener pour revenir au menu principal
        menuButton.addActionListener(e -> afficherMenu());

        // Ajouter le bouton Menu en haut à gauche
        JPanel topPanel = new JPanel(new BorderLayout());
        topPanel.setBackground(Color.black);
        topPanel.add(menuButton, BorderLayout.WEST);
        add(topPanel, BorderLayout.NORTH);

        // Rafraîchir l'interface
        revalidate();
        repaint();
    }

    // Méthode pour afficher le bouton "Menu" en haut à gauche
    private void afficherBoutonMenu() {
        menuButton = new JButton("Menu");
        menuButton.setForeground(Color.white);
        menuButton.setBackground(Color.black);

        // Ajouter l'ActionListener pour revenir au menu principal
        menuButton.addActionListener(e -> afficherMenu());

        JPanel topPanel = new JPanel(new BorderLayout());
        topPanel.setBackground(Color.black);
        topPanel.add(menuButton, BorderLayout.WEST);
        add(topPanel, BorderLayout.NORTH);
    }

    public static void main(String[] args) {
        new TDES_GUI();
    }
}
