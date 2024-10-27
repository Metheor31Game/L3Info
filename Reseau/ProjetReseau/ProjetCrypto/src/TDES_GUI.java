import java.awt.BorderLayout;
import java.awt.Color;
import java.awt.FlowLayout;
import java.awt.GridBagConstraints;
import java.awt.GridBagLayout;
import java.awt.Insets;
import java.nio.file.Files;
import java.io.File;
import java.io.IOException;
import java.util.Random;

import javax.swing.BorderFactory;
import javax.swing.Box;
import javax.swing.BoxLayout;
import javax.swing.ButtonGroup;
import javax.swing.JButton;
import javax.swing.JFileChooser;
import javax.swing.JFrame;
import javax.swing.JOptionPane;
import javax.swing.JPanel;
import javax.swing.JRadioButton;
import javax.swing.JTextField;

public class TDES_GUI extends JFrame {
    private JButton crypteButton;
    private JButton decrypteButton;
    private JButton menuButton;
    private JButton choisirFichierButton;
    private JButton cryptButton; // Bouton "Crypter" en bas du bloc gris
    private JRadioButton choisirMotDePasseRadio;
    private JRadioButton cleAleatoireRadio;
    private JTextField motDePasseField;
    private GUIListener guiListener;
    private String masterKey; // Variable pour stocker la clé
    String fileContent = "";

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
        choisirFichierButton.addActionListener(e -> selectFile());
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
        motDePasseField.getDocument().addDocumentListener(new PasswordDocumentListener(motDePasseField, 50));
        rightPanel.add(motDePasseField);

        // Ajout des listeners pour activer/désactiver et afficher/cacher le champ de
        // mot de passe
        choisirMotDePasseRadio.addActionListener(e -> {
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

        // Bouton "Crypter" en bas du bloc gris
        cryptButton = new JButton("Crypter");
        cryptButton.addActionListener(e -> crypter());
        rightPanel.add(Box.createVerticalStrut(20)); // Espacement avant le bouton
        rightPanel.add(cryptButton);

        // Ajouter le panneau à droite
        add(rightPanel, BorderLayout.EAST);

        // Rafraîchir l'interface
        revalidate();
        repaint();
    }

    private void crypter() {
        if (this.fileContent == "") {
            JOptionPane.showMessageDialog(this, "Vous devez choisir un fichier", "Fichier",
                    JOptionPane.INFORMATION_MESSAGE);
            return;

        }
        generateKey();

    }

    private void selectFile() {
        JFileChooser fileChooser = new JFileChooser();
        int result = fileChooser.showOpenDialog(this);

        if (result == JFileChooser.APPROVE_OPTION) {
            try {
                // Récupérer le fichier sélectionné
                File selectedFile = fileChooser.getSelectedFile();

                // Lire le contenu du fichier et le stocker dans fileContent
                fileContent = new String(Files.readAllBytes(selectedFile.toPath()));

                // Afficher une confirmation à l'utilisateur
                JOptionPane.showMessageDialog(this, "Fichier chargé avec succès.", "Confirmation",
                        JOptionPane.INFORMATION_MESSAGE);
            } catch (IOException ex) {
                JOptionPane.showMessageDialog(this, "Erreur lors de la lecture du fichier.", "Erreur",
                        JOptionPane.ERROR_MESSAGE);
                ex.printStackTrace();
            }
        }
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

    // Méthode pour générer la clé en fonction de l'option sélectionnée
    private void generateKey() {
        if (choisirMotDePasseRadio.isSelected()) {
            // Utiliser le mot de passe comme clé
            if (motDePasseField.getText().length() == 24) {
                masterKey = motDePasseField.getText();
                System.out.println("Clé générée à partir du mot de passe : " + masterKey);
            } else {
                JOptionPane.showMessageDialog(this,
                        "Le mot de passe doit contenir exactement 24 caractères. Le votre en contient : "
                                + motDePasseField
                                        .getText()
                                        .length(),
                        "Erreur",
                        JOptionPane.ERROR_MESSAGE);
            }
        } else if (cleAleatoireRadio.isSelected()) {
            // Générer une clé aléatoire de 24 caractères
            masterKey = generateRandomKey(24);
            System.out.println("Clé aléatoire générée : " + masterKey);
        }
    }

    // Méthode pour générer une chaîne aléatoire de longueur spécifiée
    private String generateRandomKey(int length) {
        String characters = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789";
        Random random = new Random();
        StringBuilder sb = new StringBuilder(length);
        for (int i = 0; i < length; i++) {
            sb.append(characters.charAt(random.nextInt(characters.length())));
        }
        return sb.toString();
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
