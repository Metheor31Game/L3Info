import java.util.ArrayList;
import java.util.Arrays;
import java.util.Collections;
import java.util.Random;

public class DES {
  static public int taille_bloc = 64;
  static public int taille_sous_bloc = 32;
  static public int nb_ronde = 1;
  static public int rondeActuelle = 0;
  static public ArrayList<Integer> tab_decalage = new ArrayList<>();
  static int[] perm_initiale;

  static int[] perm_initiale_inv;

  static int[] PC1;

  static int[] PC2;

  static public int[] P;

  static public int[] E;

  static public int[][] Stab;

  static ArrayList<Integer> masterKey;
  static ArrayList<ArrayList<Integer>> tab_cles;

  public DES() {
    tableaux t = new tableaux();
    DES.masterKey = new ArrayList<>();
    DES.tab_cles = new ArrayList<>();
    DES.perm_initiale = t.getPermInitiale();
    DES.perm_initiale_inv = t.getPermInitialeInv();
    DES.PC1 = t.getPC1();
    DES.PC2 = t.getPC2();
    DES.P = t.getP();
    DES.E = t.getE();
    DES.Stab = t.getStab();

  }

  // Faire attention de remplir de 0 si le machin n'atteint pas un multiple de 64
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

  public ArrayList<Integer> genereMasterKey() {
    DES.masterKey.clear();
    for (int i = 0; i < 64; i++) {
      DES.masterKey.add(new Random().nextInt(2));
      // DES.masterKey.add(1);
    }
    return DES.masterKey;
  }

  public ArrayList<Integer> permutation(int[] tab_permutation, ArrayList<Integer> bloc) {
    ArrayList<Integer> bloc_perm = new ArrayList<>(tab_permutation.length);
    for (int i = 0; i < tab_permutation.length; i++) {
      int index = tab_permutation[i] - 1;
      if (index < 0 || index >= bloc.size()) {
        throw new IllegalArgumentException("Index de permutation invalide : " + index);
      }
      int nouvel_element = bloc.get(index);
      bloc_perm.add(nouvel_element);
    }
    return bloc_perm;
  }

  public ArrayList<Integer> inv_permutation(int[] tab_permutation, ArrayList<Integer> bloc) {
    ArrayList<Integer> bloc_perm = new ArrayList<>(Collections.nCopies(64, 0)); // Crée une liste remplie de 0
    for (int i = 0; i < tab_permutation.length; i++) {
      int index = tab_permutation[i] - 1;
      bloc_perm.set(index, bloc.get(i)); // Applique la permutation correcte
    }
    return bloc_perm;
  }

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

  public ArrayList<Integer> recollage(ArrayList<ArrayList<Integer>> blocs) {
    ArrayList<Integer> nouveau_bloc = new ArrayList<>();
    for (ArrayList<Integer> bloc : blocs) {
      for (int element : bloc) {
        nouveau_bloc.add(element);
      }
    }
    return nouveau_bloc;
  }

  public ArrayList<Integer> decallage_gauche1(ArrayList<Integer> minicle) {
    ArrayList<Integer> nouvMiniCle = new ArrayList<>(minicle.subList(1, minicle.size())); // Décalage
    nouvMiniCle.add(minicle.get(0)); // Ajoute le premier élément à la fin pour une rotation circulaire
    return nouvMiniCle;
  }

  public ArrayList<Integer> decallage_gauche(ArrayList<Integer> minicle, int nb_cran) {
    ArrayList<Integer> drapeau = new ArrayList<>();
    for (int i = 0; i < nb_cran; i++) {
      drapeau = decallage_gauche1(minicle);
      minicle = drapeau;
    }
    return minicle;
  }

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

  public void genereCle(int n) {
    ArrayList<Integer> cle = DES.masterKey;
    ArrayList<Integer> cle_perm = permutation(DES.PC1, cle); // Permutation initiale PC1
    ArrayList<ArrayList<Integer>> blocs = decoupage(cle_perm, 28);
    ArrayList<ArrayList<Integer>> blocs2 = new ArrayList<>();

    // Décalage circulaire des blocs
    for (ArrayList<Integer> bloc : blocs) {
      blocs2.add(decallage_gauche(bloc, n)); // Applique le décalage avec le nombre de crans n
    }

    // Recollage et permutation PC2 pour générer la clé ronde
    ArrayList<Integer> blocRecolles = recollage(blocs2);
    ArrayList<Integer> cle_i = permutation(PC2, blocRecolles);
    DES.tab_cles.add(cle_i); // Ajoute la clé générée à la liste des clés de rondes
  }

  public ArrayList<Integer> fonction_S(ArrayList<Integer> tableau) {
    ArrayList<Integer> tab_res = new ArrayList<>(4);
    for (int i = 0; i < 4; i++) {
      tab_res.add(0); // Initialiser avec des zéros
    }

    int ligne = tableau.get(0) * 2 + tableau.get(5);
    int colonne = tableau.get(1) * 8 + tableau.get(2) * 4 + tableau.get(3) * 2 + tableau.get(4);
    int valeur = DES.Stab[DES.rondeActuelle][ligne * 16 + colonne];
    String binary_valeur = String.format("%4s", Integer.toBinaryString(valeur)).replace(' ', '0');

    for (int i = 0; i < binary_valeur.length(); i++) {
      tab_res.set(i, Integer.parseInt(String.valueOf(binary_valeur.charAt(i))));
    }

    return tab_res;
  }

  public ArrayList<Integer> fonction_f(ArrayList<Integer> bloc) {
    ArrayList<Integer> bloc_perm = permutation(DES.E, bloc);
    ArrayList<Integer> bloc_xor = xor(bloc_perm, DES.tab_cles.get(DES.rondeActuelle));
    ArrayList<ArrayList<Integer>> blocs = decoupage(bloc_xor, 6);
    ArrayList<ArrayList<Integer>> bloc_res = new ArrayList<>();
    for (ArrayList<Integer> b : blocs) {
      bloc_res.add(fonction_S(b));
    }
    ArrayList<Integer> bloc_res2 = recollage(bloc_res);
    ArrayList<Integer> bloc_res3 = permutation(DES.P, bloc_res2);
    return bloc_res3;

  }

  public String crypte(String message_clair) {
    this.genereMasterKey();
    ArrayList<Integer> message_code = this.stringToBits(message_clair);
    System.out.println("Message en bits : " + message_code);

    ArrayList<ArrayList<Integer>> blocs = this.decoupage(message_code, 64);
    ArrayList<Integer> bloc_final = new ArrayList<>();
    for (ArrayList<Integer> bloc : blocs) {
      ArrayList<Integer> bloc_perm = this.permutation(DES.perm_initiale, bloc);
      System.out.println("Bloc après permutation initiale : " + bloc_perm);

      ArrayList<ArrayList<Integer>> bloc_droit_gauche = this.decoupage(bloc_perm, 32);
      ArrayList<Integer> bloc_gauche = bloc_droit_gauche.get(0);
      ArrayList<Integer> bloc_droit = bloc_droit_gauche.get(1);

      // Boucle pour effectuer le nombre de rondes spécifié par nb_ronde
      for (int i = 0; i < DES.nb_ronde; i++) {
        this.genereCle(i);
        DES.rondeActuelle = i;
        ArrayList<Integer> bloc_gauche_temp = new ArrayList<>(bloc_gauche);
        bloc_gauche = bloc_droit;
        bloc_droit = xor(bloc_gauche_temp, fonction_f(bloc_droit));
        System.out
            .println("Après ronde " + (i + 1) + " : bloc_gauche = " + bloc_gauche + ", bloc_droit = " + bloc_droit);
      }

      bloc_final.addAll(bloc_droit);
      bloc_final.addAll(bloc_gauche);
    }
    ArrayList<Integer> bloc_perm_inv = this.permutation(DES.perm_initiale_inv, bloc_final);
    System.out.println("Bloc après permutation inverse : " + bloc_perm_inv);

    String resultat = this.bitsToString(bloc_perm_inv);
    System.out.println("Résultat final : " + resultat);
    return resultat;
  }

  public String decrypte(String message_code) {
    ArrayList<Integer> message_bits = this.stringToBits(message_code);
    System.out.println("Message en bits : " + message_bits);

    ArrayList<ArrayList<Integer>> blocs = this.decoupage(message_bits, 64);
    ArrayList<Integer> bloc_final = new ArrayList<>();
    for (ArrayList<Integer> bloc : blocs) {
      ArrayList<Integer> bloc_perm = this.permutation(DES.perm_initiale_inv, bloc);
      System.out.println("Bloc après permutation initiale : " + bloc_perm);

      ArrayList<ArrayList<Integer>> bloc_droit_gauche = this.decoupage(bloc_perm, 32);
      ArrayList<Integer> bloc_gauche = bloc_droit_gauche.get(0);
      ArrayList<Integer> bloc_droit = bloc_droit_gauche.get(1);

      // Boucle pour effectuer le nombre de rondes spécifié par nb_ronde en ordre
      // inverse
      for (int i = DES.nb_ronde - 1; i >= 0; i--) {
        this.genereCle(i); // Utilise les sous-clés dans l'ordre inverse
        DES.rondeActuelle = i;
        ArrayList<Integer> bloc_droit_temp = new ArrayList<>(bloc_droit);
        bloc_droit = bloc_gauche;
        bloc_gauche = xor(bloc_droit_temp, fonction_f(bloc_droit));
        System.out.println(
            "Après ronde " + (DES.nb_ronde - i) + " : bloc_gauche = " + bloc_gauche + ", bloc_droit = " + bloc_droit);
      }

      bloc_final.addAll(bloc_droit);
      bloc_final.addAll(bloc_gauche);
    }
    ArrayList<Integer> bloc_perm_inv = this.permutation(DES.perm_initiale, bloc_final);
    System.out.println("Bloc après permutation inverse : " + bloc_perm_inv);

    String resultat = this.bitsToString(bloc_perm_inv);
    System.out.println("Résultat final : " + resultat);
    return resultat;
  }

  public static void main(String[] args) {
    DES des = new DES();
    String message_clair = "Bonjour";
    String message_code = des.crypte(message_clair);
    System.out.println(message_code);

    String message_clair2 = des.decrypte(message_code);
    System.out.println(message_clair2);
    System.out.println(message_clair2.length());

  }

}
