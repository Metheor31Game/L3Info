import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import java.awt.event.WindowEvent;
import java.awt.event.WindowListener;
import javax.swing.JButton;

public class GUIListener implements WindowListener, ActionListener {
    private TDES_GUI gui;

    public GUIListener(TDES_GUI gui) {
        this.gui = gui;
    }

    @Override
    public void actionPerformed(ActionEvent e) {
        // Vérifie quel bouton a été cliqué
        JButton source = (JButton) e.getSource();
        if (source.getText().equals("Crypter")) {
            System.out.println("Bouton Chiffrer cliqué");
            gui.cryptage();
        } else if (source.getText().equals("Décrypter")) {
            System.out.println("Bouton Déchiffrer cliqué");
            gui.decryptage();
        }
    }

    // Méthodes du WindowListener pour gérer les événements de fenêtre
    @Override
    public void windowOpened(WindowEvent e) {
    }

    @Override
    public void windowClosing(WindowEvent e) {
        System.out.println("Fermeture");
        gui.dispose();
    }

    @Override
    public void windowClosed(WindowEvent e) {
    }

    @Override
    public void windowIconified(WindowEvent e) {
    }

    @Override
    public void windowDeiconified(WindowEvent e) {
    }

    @Override
    public void windowActivated(WindowEvent e) {
    }

    @Override
    public void windowDeactivated(WindowEvent e) {
    }
}
