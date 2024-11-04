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

/*
 * Affichage de mon application
 */
public class TDES_GUI extends JFrame {
    private JButton crypteButton;
    private JButton decrypteButton;
    private JButton menuButton;
    private JButton choisirFichierButton;
    private JButton cryptButton;
    private JRadioButton choisirMotDePasseRadio;
    private JRadioButton cleAleatoireRadio;
    private JTextField motDePasseField;
    private GUIListener guiListener;
    private String masterKey;
    private JTextField motDePasField2;
    private String fileContent = "";

    /**
     * Constructeur de la classe TDES_GUI.
     * Initialise la fenêtre principale et affiche le menu.
     */
    public TDES_GUI() {
        this.setTitle("Triple DES");
        this.setSize(800, 600);
        this.getContentPane().setBackground(Color.black);
        this.setLocationRelativeTo(null);
        this.setResizable(false);

        guiListener = new GUIListener(this);

        afficherMenu();

        setVisible(true);
    }

    /**
     * Affiche le menu principal de l'application.
     */
    public void afficherMenu() {

        getContentPane().removeAll();

        crypteButton = new JButton("Crypter");
        decrypteButton = new JButton("Décrypter");

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

        crypteButton.addActionListener(guiListener);
        decrypteButton.addActionListener(guiListener);

        revalidate();
        repaint();
    }

    /**
     * Gère l'interface utilisateur pour le cryptage des fichiers.
     */
    public void cryptage() {

        getContentPane().removeAll();
        setLayout(new BorderLayout());

        afficherBoutonMenu();

        JPanel leftPanel = new JPanel(new FlowLayout(FlowLayout.LEFT));
        leftPanel.setBackground(Color.black);
        choisirFichierButton = new JButton("Choisir un fichier");
        choisirFichierButton.addActionListener(e -> selectFileAndLoadContent());
        leftPanel.add(choisirFichierButton);
        add(leftPanel, BorderLayout.WEST);

        JPanel rightPanel = new JPanel();
        rightPanel.setLayout(new BoxLayout(rightPanel, BoxLayout.Y_AXIS));
        rightPanel.setBackground(Color.LIGHT_GRAY);
        rightPanel.setBorder(BorderFactory.createEmptyBorder(10, 10, 10, 10)); // Espacement

        choisirMotDePasseRadio = new JRadioButton("Choisir un mot de passe");
        cleAleatoireRadio = new JRadioButton("Clé aléatoire");
        ButtonGroup keyOptionGroup = new ButtonGroup();
        keyOptionGroup.add(choisirMotDePasseRadio);
        keyOptionGroup.add(cleAleatoireRadio);
        rightPanel.add(choisirMotDePasseRadio);
        rightPanel.add(cleAleatoireRadio);

        motDePasseField = new JTextField(24);
        motDePasseField.setEnabled(false);
        motDePasseField.setVisible(false);
        motDePasseField.getDocument().addDocumentListener(new PasswordDocumentListener(motDePasseField, 50));
        rightPanel.add(motDePasseField);

        choisirMotDePasseRadio.addActionListener(e -> {
            motDePasseField.setEnabled(true);
            motDePasseField.setVisible(true);
            rightPanel.revalidate();
            rightPanel.repaint();
        });
        cleAleatoireRadio.addActionListener(e -> {
            motDePasseField.setEnabled(false);
            motDePasseField.setVisible(false);
            rightPanel.revalidate();
            rightPanel.repaint();
        });

        cryptButton = new JButton("Crypter");
        cryptButton.addActionListener(e -> crypter());
        rightPanel.add(Box.createVerticalStrut(20));
        rightPanel.add(cryptButton);

        add(rightPanel, BorderLayout.EAST);

        revalidate();
        repaint();
    }

    /**
     * Méthode appelée pour effectuer le cryptage.
     */
    private void crypter() {
        if (this.fileContent.isEmpty()) {
            JOptionPane.showMessageDialog(this, "Vous devez choisir un fichier", "Fichier",
                    JOptionPane.INFORMATION_MESSAGE);
            return;
        }

        if (generateKey()) {
            System.out.println(this.masterKey);
            TripleDES TDES = new TripleDES(this.masterKey);
            String fichierCrypte = TDES.bitsToString(TDES.crypte(fileContent));

            JFileChooser fileChooser = new JFileChooser();
            fileChooser.setDialogTitle("Enregistrer le fichier chiffré");

            int userSelection = fileChooser.showSaveDialog(this);

            if (userSelection == JFileChooser.APPROVE_OPTION) {
                File fichier = fileChooser.getSelectedFile();

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

    /**
     * Ouvre un dialogue de sélection de fichier et charge le contenu du fichier
     * sélectionné.
     */
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

    /**
     * Gère l'interface utilisateur pour le décryptage des fichiers.
     */
    public void decryptage() {

        getContentPane().removeAll();
        setLayout(new BorderLayout());

        afficherBoutonMenu();

        JPanel leftPanel = new JPanel(new FlowLayout(FlowLayout.LEFT));
        leftPanel.setBackground(Color.black);
        choisirFichierButton = new JButton("Choisir un fichier");
        choisirFichierButton.addActionListener(e -> selectFileAndLoadContent());
        leftPanel.add(choisirFichierButton);
        add(leftPanel, BorderLayout.WEST);

        JPanel rightPanel = new JPanel();
        rightPanel.setLayout(new BoxLayout(rightPanel, BoxLayout.Y_AXIS));
        rightPanel.setBackground(Color.LIGHT_GRAY);
        rightPanel.setBorder(BorderFactory.createEmptyBorder(10, 10, 10, 10));

        JLabel enterKeyLabel = new JLabel("Entrez votre mot de passe ou votre clé :");
        motDePasField2 = new JTextField(24);
        rightPanel.add(enterKeyLabel);
        rightPanel.add(Box.createVerticalStrut(10));
        rightPanel.add(motDePasField2);

        add(rightPanel, BorderLayout.EAST);

        cryptButton = new JButton("Decrypter");
        cryptButton.addActionListener(e -> decrypter());
        rightPanel.add(Box.createVerticalStrut(20));
        rightPanel.add(cryptButton);

        revalidate();
        repaint();
    }

    /**
     * Méthode appelée pour effectuer le décryptage.
     */
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

            JFileChooser fileChooser = new JFileChooser();
            fileChooser.setDialogTitle("Enregistrer le fichier décrypté");
            int userSelection = fileChooser.showSaveDialog(this);

            if (userSelection == JFileChooser.APPROVE_OPTION) {
                File fileToSave = fileChooser.getSelectedFile();

                String filePath = fileToSave.getAbsolutePath();
                if (!filePath.endsWith(".txt")) {
                    filePath += ".txt";
                }

                try (BufferedWriter writer = new BufferedWriter(new FileWriter(filePath))) {
                    writer.write(fichier_decrypte);
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

    /**
     * Génère une clé à partir du mot de passe saisi par l'utilisateur.
     * 
     * @return true si la clé a été générée avec succès, false sinon.
     */
    private boolean generateKey() {
        if (choisirMotDePasseRadio.isSelected()) {

            if (motDePasseField.getText().length() == 24) {
                masterKey = motDePasseField.getText();
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

            masterKey = generateRandomKey(24);
            return true;
        }
        return false;
    }

    /**
     * Définit la clé maître à partir du mot de passe fourni.
     * 
     * @param masterKey La clé maître à définir.
     * @return true, car la clé est toujours définie avec succès.
     */
    private boolean generateKey(String masterKey) {
        this.masterKey = masterKey;
        return true;
    }

    /**
     * Génère une clé aléatoire de la longueur spécifiée.
     * 
     * @param length La longueur de la clé à générer.
     * @return La clé aléatoire générée sous forme de chaîne.
     */
    private String generateRandomKey(int length) {
        String characters = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789";
        Random random = new Random();
        StringBuilder sb = new StringBuilder(length);
        for (int i = 0; i < length; i++) {
            sb.append(characters.charAt(random.nextInt(characters.length())));
        }
        return sb.toString();
    }

    /**
     * Affiche le bouton de retour au menu.
     */
    private void afficherBoutonMenu() {
        menuButton = new JButton("Menu");
        menuButton.setForeground(Color.white);
        menuButton.setBackground(Color.black);

        menuButton.addActionListener(e -> afficherMenu());

        JPanel topPanel = new JPanel(new BorderLayout());
        topPanel.setBackground(Color.black);
        topPanel.add(menuButton, BorderLayout.WEST);
        add(topPanel, BorderLayout.NORTH);
    }

    /**
     * Méthode principale pour exécuter l'application.
     * 
     * @param args Les arguments de la ligne de commande.
     */
    public static void main(String[] args) {
        new TDES_GUI();
    }
}
