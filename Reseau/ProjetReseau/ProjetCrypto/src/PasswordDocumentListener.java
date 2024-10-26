import javax.swing.event.DocumentEvent;
import javax.swing.event.DocumentListener;
import javax.swing.JTextField;

public class PasswordDocumentListener implements DocumentListener {
    private JTextField textField;
    private int maxLength;

    public PasswordDocumentListener(JTextField textField, int maxLength) {
        this.textField = textField;
        this.maxLength = maxLength;
    }

    @Override
    public void insertUpdate(DocumentEvent e) {
        limitText();
    }

    @Override
    public void removeUpdate(DocumentEvent e) {
        limitText();
    }

    @Override
    public void changedUpdate(DocumentEvent e) {
        limitText();
    }

    // Limite le nombre de caractères à maxLength
    private void limitText() {
        if (textField.getText().length() > maxLength) {
            textField.setText(textField.getText().substring(0, maxLength));
        }
    }
}
