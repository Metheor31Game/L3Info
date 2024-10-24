import java.util.ArrayList;

/**
 * Classe représentant l'algorithme de chiffrement Triple DES (3DES).
 * 
 * Le processus de chiffrement Triple DES se déroule en trois étapes :
 * - Le message est chiffré avec la première clé (DES1).
 * - Le résultat est déchiffré avec la deuxième clé (DES2).
 * - Enfin, le résultat est chiffré à nouveau avec la troisième clé (DES3).
 * 
 */
public class TripleDES {
    DES des1;
    DES des2;
    DES des3;

    public TripleDES() {
        this.des1 = new DES();
        this.des2 = new DES();
        this.des3 = new DES();
    }

    /**
     * Chiffre un message en utilisant le triple chiffrement DES.
     * Le message est chiffré trois fois avec trois clés différentes (DES1 -> DES2
     * -> DES3).
     * 
     * @param message_clair le message à chiffrer
     * @return une liste d'entiers représentant le message chiffré en bits
     */
    public ArrayList<Integer> crypte(String message_clair) {
        ArrayList<Integer> code1 = des1.crypte(message_clair);
        String message_code1 = des1.bitsToString(code1);
        ArrayList<Integer> code2 = des2.crypte(message_code1);
        String message_code2 = des2.bitsToString(code2);
        ArrayList<Integer> code3 = des3.crypte(message_code2);
        return code3;
    }

    /**
     * Déchiffre un message en utilisant le triple déchiffrement DES.
     * Le message est déchiffré trois fois en utilisant le processus inverse du
     * chiffrement (DES3 -> DES2 -> DES1).
     * 
     * @param code3 la liste d'entiers représentant le message chiffré
     * @return le message déchiffré sous forme de chaîne de caractères
     */
    public String decrypte(ArrayList<Integer> code3) {
        String decrypte1 = des3.decrypte(code3);
        ArrayList<Integer> decrypte1_ArrayList = des3.stringToBits(decrypte1);
        String decrypte2 = des2.decrypte(decrypte1_ArrayList);
        ArrayList<Integer> decrypte2_ArrayList = des2.stringToBits(decrypte2);
        String decrypte3 = des1.decrypte(decrypte2_ArrayList);
        return decrypte3;
    }

    public static void main(String[] args) {
        TripleDES TDES = new TripleDES();
        String message_clair = "Bonjour les amis c'est tchoupi et doudou";
        ArrayList<Integer> code = TDES.crypte(message_clair);
        System.out.println(code);
        String message_decrypte = TDES.decrypte(code);
        System.out.println(message_clair);
        System.out.println(message_decrypte);

    }

}
