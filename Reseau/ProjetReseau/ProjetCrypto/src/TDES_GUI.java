import java.awt.BorderLayout;
import java.awt.Color;
import java.awt.FlowLayout;
import java.awt.GridBagConstraints;
import java.awt.GridBagLayout;
import java.awt.Insets;
import java.nio.file.Files;
import java.io.File;
import java.io.FileWriter;
import java.io.IOException;
import java.io.BufferedWriter;
import java.util.ArrayList;
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
import javax.swing.JLabel;

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
    private JTextField motDePasField2;
    private String fileContent = "";

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
        choisirFichierButton.addActionListener(e -> selectFileAndLoadContent());
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
        if (this.fileContent.isEmpty()) {
            JOptionPane.showMessageDialog(this, "Vous devez choisir un fichier", "Fichier",
                    JOptionPane.INFORMATION_MESSAGE);
            return;
        }

        if (generateKey()) {
            TripleDES TDES = new TripleDES(this.masterKey);
            String fichierCrypte = TDES.bitsToString(TDES.crypte(fileContent));

            JFileChooser fileChooser = new JFileChooser();
            fileChooser.setDialogTitle("Enregistrer le fichier chiffré");

            int userSelection = fileChooser.showSaveDialog(this);

            if (userSelection == JFileChooser.APPROVE_OPTION) {
                File fichier = fileChooser.getSelectedFile();

                // Vérifie et ajoute l'extension .txt si nécessaire
                if (!fichier.getName().toLowerCase().endsWith(".txt")) {
                    fichier = new File(fichier.getAbsolutePath() + ".txt");
                }

                try {
                    Files.write(fichier.toPath(), fichierCrypte.getBytes());
                    JOptionPane.showMessageDialog(this, "Fichier chiffré enregistré avec succès.", "Succès",
                            JOptionPane.INFORMATION_MESSAGE);
                } catch (IOException ex) {
                    JOptionPane.showMessageDialog(this, "Erreur lors de l'écriture du fichier.", "Erreur",
                            JOptionPane.ERROR_MESSAGE);
                    ex.printStackTrace();
                }
            }
        }
    }

    private void selectFileAndLoadContent() {
        JFileChooser fileChooser = new JFileChooser();
        int result = fileChooser.showOpenDialog(this);

        if (result == JFileChooser.APPROVE_OPTION) {
            try {
                File selectedFile = fileChooser.getSelectedFile();
                fileContent = new String(Files.readAllBytes(selectedFile.toPath()));
                JOptionPane.showMessageDialog(this, "Fichier chargé avec succès.", "Confirmation",
                        JOptionPane.INFORMATION_MESSAGE);
            } catch (IOException ex) {
                JOptionPane.showMessageDialog(this, "Erreur lors de la lecture du fichier.", "Erreur",
                        JOptionPane.ERROR_MESSAGE);
                ex.printStackTrace();
            }
        }
    }

    public void decryptage() {
        System.out.println("Méthode de décryptage appelée");

        // Supprimer les anciens composants et configurer le layout
        getContentPane().removeAll();
        setLayout(new BorderLayout());

        // Afficher le bouton Menu en haut à gauche
        afficherBoutonMenu();

        // Panneau pour le bouton "Choisir un fichier" à gauche
        JPanel leftPanel = new JPanel(new FlowLayout(FlowLayout.LEFT));
        leftPanel.setBackground(Color.black);
        choisirFichierButton = new JButton("Choisir un fichier");
        choisirFichierButton.addActionListener(e -> selectFileAndLoadContent());
        leftPanel.add(choisirFichierButton);
        add(leftPanel, BorderLayout.WEST);

        // Panneau pour entrer la clé ou le mot de passe à droite
        JPanel rightPanel = new JPanel();
        rightPanel.setLayout(new BoxLayout(rightPanel, BoxLayout.Y_AXIS));
        rightPanel.setBackground(Color.LIGHT_GRAY);
        rightPanel.setBorder(BorderFactory.createEmptyBorder(10, 10, 10, 10)); // Espacement

        JLabel enterKeyLabel = new JLabel("Entrez votre mot de passe ou votre clé :");
        motDePasField2 = new JTextField(24);
        rightPanel.add(enterKeyLabel);
        rightPanel.add(Box.createVerticalStrut(10)); // Espacement
        rightPanel.add(motDePasField2);

        // Ajouter le panneau à droite
        add(rightPanel, BorderLayout.EAST);

        // Ajout du bouton de decryptage
        cryptButton = new JButton("Decrypter");
        cryptButton.addActionListener(e -> decrypter());
        rightPanel.add(Box.createVerticalStrut(20)); // Espacement avant le bouton
        rightPanel.add(cryptButton);

        // Rafraîchir l'interface
        revalidate();
        repaint();
    }

    public void decrypter() {
        if (this.fileContent.isEmpty()) {
            JOptionPane.showMessageDialog(this, "Vous devez choisir un fichier", "Fichier",
                    JOptionPane.INFORMATION_MESSAGE);
            return;
        }
        if (motDePasField2.getText().length() != 24) {
            JOptionPane.showMessageDialog(this,
                    "Le mot de passe doit contenir exactement 24 caractères. Le votre en contient : "
                            + motDePasField2.getText().length(),
                    "Erreur",
                    JOptionPane.ERROR_MESSAGE);
            return;
        }

        if (generateKey(motDePasField2.getText())) {
            TripleDES TDES = new TripleDES(this.masterKey);
            ArrayList<Integer> Array_crypt = TDES.stringToBits(fileContent);
            String fichier_decrypte = TDES.decrypte(Array_crypt).trim();
            System.out.println(this.masterKey);
            System.out.println(fileContent);
            System.out.println(fichier_decrypte);

            // Demander à l'utilisateur de choisir le chemin et le nom du fichier
            JFileChooser fileChooser = new JFileChooser();
            fileChooser.setDialogTitle("Enregistrer le fichier décrypté");
            int userSelection = fileChooser.showSaveDialog(this);

            if (userSelection == JFileChooser.APPROVE_OPTION) {
                File fileToSave = fileChooser.getSelectedFile();

                // Vérifier si l'utilisateur a donné une extension
                String filePath = fileToSave.getAbsolutePath();
                if (!filePath.endsWith(".txt")) {
                    filePath += ".txt"; // Ajouter .txt si aucune extension n'est fournie
                }

                try (BufferedWriter writer = new BufferedWriter(new FileWriter(filePath))) {
                    writer.write(fichier_decrypte); // Écrire le contenu décrypté dans le fichier
                    JOptionPane.showMessageDialog(this, "Fichier enregistré avec succès à : " + filePath,
                            "Succès", JOptionPane.INFORMATION_MESSAGE);
                } catch (IOException e) {
                    JOptionPane.showMessageDialog(this,
                            "Erreur lors de l'enregistrement du fichier : " + e.getMessage(),
                            "Erreur", JOptionPane.ERROR_MESSAGE);
                }
            }
        }
    }

    // Méthode pour générer la clé en fonction de l'option sélectionnée
    private boolean generateKey() {
        if (choisirMotDePasseRadio.isSelected()) {
            // Utiliser le mot de passe comme clé
            if (motDePasseField.getText().length() == 24) {
                masterKey = motDePasseField.getText();
                System.out.println("Clé générée à partir du mot de passe : " + masterKey);
                return true;
            } else {
                JOptionPane.showMessageDialog(this,
                        "Le mot de passe doit contenir exactement 24 caractères. Le votre en contient : "
                                + motDePasseField
                                        .getText()
                                        .length(),
                        "Erreur",
                        JOptionPane.ERROR_MESSAGE);
                return false;
            }
        } else if (cleAleatoireRadio.isSelected()) {
            // Générer une clé aléatoire de 24 caractères
            masterKey = generateRandomKey(24);
            System.out.println("Clé aléatoire générée : " + masterKey);
            return true;
        }
        return false;
    }

    private boolean generateKey(String masterKey) {
        this.masterKey = masterKey;
        return true;
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
