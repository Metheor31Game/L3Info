import java.util.ArrayList;
import java.util.Collections;
import java.util.Random;

/**
 * Classe représentant l'algorithme de chiffrement DES (Data Encryption
 * Standard).
 * 
 */
public class DES {
  static public int taille_bloc = 64;
  static public int taille_sous_bloc = 32;
  public int nb_ronde = 16;
  public int rondeActuelle = 0;
  static public int[] tab_decalage;
  static int[] perm_initiale;

  static int[] perm_initiale_inv;

  static int[] PC1;

  static int[] PC2;

  static public int[] P;

  static public int[] E;

  static public int[][] Stab;

  public ArrayList<Integer> masterKey;
  public ArrayList<ArrayList<Integer>> tab_cles;

  // constructeur DES
  public DES() {
    tableaux t = new tableaux();
    this.masterKey = new ArrayList<>();
    this.tab_cles = new ArrayList<>();
    DES.perm_initiale = t.getPermInitiale();
    DES.perm_initiale_inv = t.getPermInitialeInv();
    DES.PC1 = t.getPC1();
    DES.PC2 = t.getPC2();
    DES.P = t.getP();
    DES.E = t.getE();
    DES.Stab = t.getStab();
    DES.tab_decalage = t.getTabDecalage();

  }

  // Surcharge du constructeur de DES permettant de choisir sa propre masterKey
  public DES(String MasterKey) {
    this.masterKey = this.stringToBits(MasterKey);
    tableaux t = new tableaux();
    this.tab_cles = new ArrayList<>();
    DES.perm_initiale = t.getPermInitiale();
    DES.perm_initiale_inv = t.getPermInitialeInv();
    DES.PC1 = t.getPC1();
    DES.PC2 = t.getPC2();
    DES.P = t.getP();
    DES.E = t.getE();
    DES.Stab = t.getStab();
    DES.tab_decalage = t.getTabDecalage();
  }

  /**
   * Convertit une chaîne de caractères en une liste de bits.
   * 
   * @param message_clair le message à convertir
   * @return la liste de bits représentant le message
   */
  public ArrayList<Integer> stringToBits(String message_clair) {
    ArrayList<Integer> message_code = new ArrayList<>();
    for (int i = 0; i < message_clair.length(); i++) {
      String binaryString = String.format("%8s", Integer.toBinaryString((int) message_clair.charAt(i))).replace(' ',
          '0');
      for (char bit : binaryString.toCharArray()) {
        message_code.add(Character.getNumericValue(bit));
      }
    }
    // Compléter avec des zéros pour atteindre un multiple de 64 bits
    while (message_code.size() % 64 != 0) {
      message_code.add(0);
    }
    return message_code;
  }

  /**
   * Convertit une liste de bits en chaîne de caractères.
   * 
   * @param message_code la liste de bits
   * @return la chaîne de caractères correspondante
   */

  public String bitsToString(ArrayList<Integer> message_code) {
    StringBuilder message_clair = new StringBuilder();
    int size = message_code.size();

    // Vérifiez que la taille de message_code est un multiple de 8
    if (size % 8 != 0) {
      throw new IllegalArgumentException("La taille de message_code doit être un multiple de 8");
    }

    for (int i = 0; i < size; i += 8) {
      int charCode = 0;
      for (int j = 0; j < 8; j++) {
        charCode = (charCode << 1) | message_code.get(i + j);
      }
      message_clair.append((char) charCode);
    }
    return message_clair.toString();
  }

  /**
   * Génère une MasterKey de 64 bits de manière aléatoire.
   * 
   * @return la MasterKey sous forme de liste d'entiers
   */
  public ArrayList<Integer> genereMasterKey() {
    this.masterKey.clear();
    for (int i = 0; i < 64; i++) {
      this.masterKey.add(new Random().nextInt(2));
      // DES.masterKey.add(1);
    }
    return this.masterKey;
  }

  /**
   * Applique une permutation à un bloc en fonction d'une table de permutation.
   * 
   * @param tab_permutation la table de permutation
   * @param bloc            le bloc à permuter
   * @return le bloc permuté
   */
  public ArrayList<Integer> permutation(int[] tab_permutation, ArrayList<Integer> bloc) {
    ArrayList<Integer> bloc_perm = new ArrayList<>(tab_permutation.length);
    for (int i = 0; i < tab_permutation.length; i++) {
      int index = tab_permutation[i] - 1;
      int nouvel_element = bloc.get(index);
      bloc_perm.add(nouvel_element);
    }
    return bloc_perm;
  }

  /**
   * Applique la permutation inverse à un bloc.
   * 
   * @param tab_permutation la table de permutation inverse
   * @param bloc            le bloc à permuter
   * @return le bloc avec la permutation inverse appliquée
   */
  public ArrayList<Integer> inv_permutation(int[] tab_permutation, ArrayList<Integer> bloc) {
    ArrayList<Integer> bloc_perm = new ArrayList<>(Collections.nCopies(64, 0)); // Crée une liste remplie de 0
    for (int i = 0; i < tab_permutation.length; i++) {
      int index = tab_permutation[i] - 1;
      bloc_perm.set(index, bloc.get(i)); // Applique la permutation correcte
    }
    return bloc_perm;
  }

  /**
   * Découpe un bloc en sous-blocs de taille définie. Bourre de zéros si
   * nécessaire.
   * 
   * @param bloc             le bloc à découper
   * @param taille_sous_bloc la taille des sous-blocs
   * @return la liste des sous-blocs
   */
  public ArrayList<ArrayList<Integer>> decoupage(ArrayList<Integer> bloc, int taille_sous_bloc) {
    ArrayList<ArrayList<Integer>> blocs = new ArrayList<>();
    for (int i = 0; i < bloc.size(); i += taille_sous_bloc) {
      ArrayList<Integer> sous_bloc = new ArrayList<>();
      for (int j = 0; j < taille_sous_bloc && (i + j) < bloc.size(); j++) {
        sous_bloc.add(bloc.get(i + j));
      }
      // Compléter le sous-bloc avec des zéros si nécessaire
      while (sous_bloc.size() < taille_sous_bloc) {
        sous_bloc.add(0);
      }
      blocs.add(sous_bloc);
    }
    return blocs;
  }

  /**
   * Recollage des sous-blocs pour reformer un bloc unique.
   * 
   * @param blocs la liste des sous-blocs
   * @return le bloc recollé
   */
  public ArrayList<Integer> recollage(ArrayList<ArrayList<Integer>> blocs) {
    ArrayList<Integer> nouveau_bloc = new ArrayList<>();
    for (ArrayList<Integer> bloc : blocs) {
      for (int element : bloc) {
        nouveau_bloc.add(element);
      }
    }
    return nouveau_bloc;
  }

  /**
   * Applique un décalage à gauche avec rotation circulaire d'un sous-bloc.
   * 
   * @param minicle le sous-bloc
   * @return le sous-bloc décalé à gauche
   */
  public ArrayList<Integer> decallage_gauche1(ArrayList<Integer> minicle) {
    ArrayList<Integer> nouvMiniCle = new ArrayList<>(minicle.subList(1, minicle.size())); // Décalage
    nouvMiniCle.add(0); // Ajoute le premier élément à la fin pour une rotation circulaire
    return nouvMiniCle;
  }

  /**
   * Applique un décalage à gauche sur plusieurs crans d'un sous-bloc.
   * 
   * @param minicle le sous-bloc
   * @param nb_cran le nombre de crans de décalage
   * @return le sous-bloc décalé
   */
  public ArrayList<Integer> decallage_gauche(ArrayList<Integer> minicle, int nb_cran) {
    ArrayList<Integer> drapeau = new ArrayList<>();
    for (int i = 0; i < nb_cran; i++) {
      drapeau = decallage_gauche1(minicle);
      minicle = drapeau;
    }
    return minicle;
  }

  /**
   * Applique l'opération XOR entre deux listes de bits de même taille.
   * 
   * @param a première liste de bits
   * @param b deuxième liste de bits
   * @return le résultat du XOR
   */
  public ArrayList<Integer> xor(ArrayList<Integer> a, ArrayList<Integer> b) {
    if (a.size() != b.size()) {
      throw new IllegalArgumentException("Les deux tableaux doivent avoir la même taille pour effectuer un XOR");
    }
    ArrayList<Integer> res = new ArrayList<>();
    for (int i = 0; i < a.size(); i++) {
      res.add(a.get(i) ^ b.get(i));
    }
    return res;
  }

  /**
   * Génère d'avance toutes les clés en fonction de la MasterKey
   */
  public void genereCle() {
    ArrayList<Integer> cle = this.masterKey;
    ArrayList<Integer> cle_perm = permutation(DES.PC1, cle);
    ArrayList<ArrayList<Integer>> blocs = decoupage(cle_perm, 28);

    for (int n = 0; n < this.nb_ronde; n++) {
      ArrayList<ArrayList<Integer>> blocs2 = new ArrayList<>();
      for (ArrayList<Integer> bloc : blocs) {
        blocs2.add(decallage_gauche(bloc, DES.tab_decalage[n])); // Applique le décalage avec le nombre de crans n
      }
      // Recollage et permutation PC2 pour générer la clé ronde
      ArrayList<Integer> blocRecolles = recollage(blocs2);
      ArrayList<Integer> cle_i = permutation(PC2, blocRecolles);
      this.tab_cles.add(cle_i); // Ajoute la clé générée à la liste des clés de rondes
    }
  }

  /**
   * Applique la fonction S à un sous-bloc de 6 bits, en fonction de la ronde
   * actuelle.
   * 
   * @param tableau la liste de bits d'entrée
   * @return la liste de bits réduite
   */
  public ArrayList<Integer> fonction_S(ArrayList<Integer> tableau) {
    ArrayList<Integer> tab_res = new ArrayList<>(4);
    for (int i = 0; i < 4; i++) {
      tab_res.add(0); // Initialiser avec des zéros
    }

    int ligne = tableau.get(0) * 2 + tableau.get(5);
    int colonne = tableau.get(1) * 8 + tableau.get(2) * 4 + tableau.get(3) * 2 + tableau.get(4);
    int valeur = DES.Stab[this.rondeActuelle % 8][ligne * 16 + colonne];
    String binary_valeur = String.format("%4s", Integer.toBinaryString(valeur)).replace(' ', '0');

    for (int i = 0; i < binary_valeur.length(); i++) {
      tab_res.set(i, Integer.parseInt(String.valueOf(binary_valeur.charAt(i))));
    }

    return tab_res;
  }

  /**
   * Applique la fonction de chiffrement f sur un bloc de bits.
   * 
   * @param bloc le bloc à chiffrer
   * @return le bloc après application de la fonction f
   */
  public ArrayList<Integer> fonction_f(ArrayList<Integer> bloc) {
    ArrayList<Integer> bloc_perm = permutation(DES.E, bloc);
    ArrayList<Integer> bloc_xor = xor(bloc_perm, this.tab_cles.get(this.rondeActuelle));
    ArrayList<ArrayList<Integer>> blocs = decoupage(bloc_xor, 6);
    ArrayList<ArrayList<Integer>> bloc_res = new ArrayList<>();
    for (ArrayList<Integer> b : blocs) {
      bloc_res.add(fonction_S(b));
    }
    ArrayList<Integer> bloc_res2 = recollage(bloc_res);
    ArrayList<Integer> bloc_res3 = permutation(DES.P, bloc_res2);
    return bloc_res3;

  }

  /**
   * Chiffre un message clair en utilisant l'algorithme DES.
   * 
   * @param message_clair le message à chiffrer
   * @return la liste des bits représentant le message chiffré
   */
  public ArrayList<Integer> crypte(String message_clair) {
    if (this.masterKey.isEmpty()) {
      this.genereMasterKey();
    }
    this.tab_cles = new ArrayList<>();
    this.genereCle();
    ArrayList<Integer> message_code = this.stringToBits(message_clair);

    ArrayList<ArrayList<Integer>> blocs = this.decoupage(message_code, 64);
    ArrayList<Integer> bloc_final = new ArrayList<>();
    for (ArrayList<Integer> bloc : blocs) {
      ArrayList<Integer> bloc_perm = this.permutation(DES.perm_initiale, bloc);

      ArrayList<ArrayList<Integer>> bloc_droit_gauche = this.decoupage(bloc_perm, 32);
      ArrayList<Integer> bloc_gauche = bloc_droit_gauche.get(0);
      ArrayList<Integer> bloc_droit = bloc_droit_gauche.get(1);

      // Boucle pour effectuer le nombre de rondes spécifié par nb_ronde
      for (int i = 0; i < this.nb_ronde; i++) {
        this.rondeActuelle = i;
        ArrayList<Integer> bloc_gauche_temp = new ArrayList<>(bloc_gauche);
        bloc_gauche = bloc_droit;
        bloc_droit = xor(bloc_gauche_temp, fonction_f(bloc_droit));
      }

      ArrayList<ArrayList<Integer>> bloc_droit_gauche_final = new ArrayList<>();
      bloc_droit_gauche_final.add(bloc_gauche);
      bloc_droit_gauche_final.add(bloc_droit);
      ArrayList<Integer> bloc_perm_inv = this.permutation(DES.perm_initiale_inv, recollage(bloc_droit_gauche_final));
      bloc_final.addAll(bloc_perm_inv);
    }
    // String resultat = this.bitsToString(bloc_perm_inv);
    return bloc_final;
  }

  /**
   * Déchiffre un message chiffré en utilisant l'algorithme DES.
   * 
   * @param message_bits le message chiffré sous forme de bits
   * @return le message déchiffré sous forme de chaîne de caractères
   */
  public String decrypte(ArrayList<Integer> message_bits) {
    this.tab_cles = new ArrayList<>();
    this.genereCle();

    ArrayList<ArrayList<Integer>> blocs = this.decoupage(message_bits, 64);
    ArrayList<Integer> bloc_final = new ArrayList<>();
    for (ArrayList<Integer> bloc : blocs) {
      ArrayList<Integer> bloc_perm = this.permutation(DES.perm_initiale, bloc);

      ArrayList<ArrayList<Integer>> bloc_droit_gauche = this.decoupage(bloc_perm, 32);
      ArrayList<Integer> bloc_gauche = bloc_droit_gauche.get(0);
      ArrayList<Integer> bloc_droit = bloc_droit_gauche.get(1);

      for (int i = this.nb_ronde - 1; i >= 0; i--) {
        this.rondeActuelle = i;
        ArrayList<Integer> bloc_droit_temp = new ArrayList<>(bloc_droit);
        bloc_droit = bloc_gauche;
        bloc_gauche = xor(bloc_droit_temp, fonction_f(bloc_gauche));
      }

      ArrayList<ArrayList<Integer>> bloc_droit_gauche_final = new ArrayList<>();
      bloc_droit_gauche_final.add(bloc_gauche);
      bloc_droit_gauche_final.add(bloc_droit);
      ArrayList<Integer> bloc_perm_inv = this.permutation(DES.perm_initiale_inv, recollage(bloc_droit_gauche_final));
      bloc_final.addAll(bloc_perm_inv);
    }

    String resultat = this.bitsToString(bloc_final);
    return resultat;
  }

  @SuppressWarnings("unused")
  public static void main(String[] args) {
    DES des = new DES("azertyui");
    String message_clair = "Bonjour les amis c'est tchoupi";
    ArrayList<Integer> Array_code = des.crypte(message_clair);
    String message_code = des.bitsToString(Array_code);
    String message_de_nouveau_clair = des.decrypte(Array_code);

    System.out.println(message_clair);
    System.out.println(message_code);
    System.out.println(message_de_nouveau_clair);

  }

}
