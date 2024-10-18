import java.util.ArrayList;
import java.util.Random;

public class DES {
  static public int taille_bloc = 64;
  static public int taille_sous_bloc = 32;
  static public int nb_ronde = 1;
  static public ArrayList<Integer> tab_decalage = new ArrayList<>();
  static int[] perm_initiale = { 58, 50, 42, 34, 26, 18, 10, 2,
      60, 52, 44, 36, 28, 20, 12, 4,
      62, 54, 46, 38, 30, 22, 14, 6,
      64, 56, 48, 40, 32, 24, 16, 8,
      57, 49, 41, 33, 25, 17, 9, 1,
      59, 51, 43, 35, 27, 19, 11, 3,
      61, 53, 45, 37, 29, 21, 13, 5,
      63, 55, 47, 39, 31, 23, 15, 7 };
  static int[] perm_initiale_inv = { 40, 8, 48, 16, 56, 24, 64, 32,
      39, 7, 47, 15, 55, 23, 63, 31,
      38, 6, 46, 14, 54, 22, 62, 30,
      37, 5, 45, 13, 53, 21, 61, 29,
      36, 4, 44, 12, 52, 20, 60, 28,
      35, 3, 43, 11, 51, 19, 59, 27,
      34, 2, 42, 10, 50, 18, 58, 26,
      33, 1, 41, 9, 49, 17, 57, 25 };

  static int[] PC1 = { 57, 49, 41, 33, 25, 17, 9,
      1, 58, 50, 42, 34, 26, 18,
      10, 2, 59, 51, 43, 35, 27,
      19, 11, 3, 60, 52, 44, 36,
      63, 55, 47, 39, 31, 23, 15,
      7, 62, 54, 46, 38, 30, 22,
      14, 6, 61, 53, 45, 37, 29,
      21, 13, 5, 28, 20, 12, 4 };

  static int[] PC2 = { 14, 17, 11, 24, 1, 5, 3, 28,
      15, 6, 21, 10, 23, 19, 12, 4,
      26, 8, 16, 7, 27, 20, 13, 2,
      41, 52, 31, 37, 47, 55, 30, 40,
      51, 45, 33, 48, 44, 49, 39, 56,
      34, 53, 46, 42, 50, 36, 29, 32 };

  static public int[] S = { 16, 7, 20, 21, 29, 12, 28, 17,
      1, 15, 23, 26, 5, 18, 31, 10,
      2, 8, 24, 14, 32, 27, 3, 9,
      19, 13, 30, 6, 22, 11, 4, 25 };

  static public int[] E = { 32, 1, 2, 3, 4, 5, 4, 5, 6, 7, 8, 9, 8, 9, 10, 11, 12, 13, 12, 13, 14, 15, 16, 17, 16, 17,
      18, 19, 20, 21, 20, 21, 22, 23, 24, 25, 24, 25, 26, 27, 28, 29, 28, 29, 30, 31, 32, 1 };

  static ArrayList<Integer> masterKey;
  static ArrayList<ArrayList<Integer>> tab_cles;

  public DES() {
    DES.masterKey = new ArrayList<>();
    DES.tab_cles = new ArrayList<>();

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
    return message_code;
  }

  public String bitsToString(ArrayList<Integer> message_code) {
    StringBuilder message_clair = new StringBuilder();
    String parts = "";
    for (int i = 0; i < message_code.size(); i++) {
      parts = parts + message_code.get(i);
      if (i % 8 == 7 || i == message_code.size() - 1) {
        while (parts.length() < 8) {
          parts = "0" + parts;
        }
        int charCode = Integer.parseInt(parts, 2);
        message_clair.append((char) charCode);
        parts = "";
      }
    }
    return message_clair.toString();
  }

  public ArrayList<Integer> genereMasterKey() {
    DES.masterKey.clear();
    for (int i = 0; i < 64; i++) {
      DES.masterKey.add(new Random().nextInt(2));
    }
    return DES.masterKey;
  }

  public ArrayList<Integer> permutation(int[] tab_permuation, ArrayList<Integer> bloc) {
    ArrayList<Integer> bloc_perm = new ArrayList<>();
    for (int i = 0; i < tab_permuation.length; i++) {
      int nouvel_element = bloc.get(tab_permuation[i] - 1);
      bloc_perm.add(nouvel_element);
    }
    return bloc_perm;
  }

  public ArrayList<Integer> inv_permutation(int[] tab_permuation, ArrayList<Integer> bloc) {
    ArrayList<Integer> bloc_perm = new ArrayList<>();
    for (int i = 0; i < 64; i++) {
      bloc_perm.add(0);
    }
    for (int i = 0; i < tab_permuation.length; i++) {
      bloc_perm.set(i, bloc.get(tab_permuation[i] - 1));
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
    ArrayList<Integer> nouvMiniCle = new ArrayList<>();
    for (int i = 1; i < minicle.size(); i++) { // Commence à l'indice 1 pour ignorer le premier élément
      nouvMiniCle.add(minicle.get(i));
    }
    nouvMiniCle.add(0); // Ajoute un 0 à la fin
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
    ArrayList<Integer> res = new ArrayList<>();
    for (int i = 0; i < a.size(); i++) {
      res.add(a.get(i) ^ b.get(i));
    }
    return res;
  }

  public void genereCle(int n) {
    ArrayList<Integer> cle = DES.masterKey;
    ArrayList<Integer> cle_perm = permutation(DES.PC1, cle);
    ArrayList<ArrayList<Integer>> blocs = decoupage(cle_perm, 28);
    ArrayList<ArrayList<Integer>> blocs2 = new ArrayList<>();
    for (ArrayList<Integer> bloc : blocs) {
      blocs2.add(decallage_gauche(bloc, n));
    }
    ArrayList<Integer> blocRecolles = recollage(blocs2);
    ArrayList<Integer> cle_i = permutation(PC2, blocRecolles);
    DES.tab_cles.add(cle_i);
  }

  public static void main(String[] args) {
    DES des = new DES();
    des.genereMasterKey();
    System.out.println(DES.masterKey);
    // String message_clair = "Bonjour les amis c'est tchoupi";
    // ArrayList<Integer> message_code = des.stringToBits(message_clair);
    // System.out.println(message_clair);
    // System.out.println(message_code);
    // System.out.println(des.bitsToString(message_code));
    System.out.println(DES.perm_initiale.length);
  }

}
