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

  static int PC1, PC2;
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
    for (int i = 0; i < message_code.size(); i++){
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
    for (int i = 0; i < 64; i++) {
      DES.masterKey.add(new Random().nextInt(2));
    }
    return DES.masterKey;
  }

  public ArrayList<Integer> xor(ArrayList<Integer> a, ArrayList<Integer> b) {
    ArrayList<Integer> res = new ArrayList<>();
    for (int i = 0; i < a.size(); i++) {
      res.add(a.get(i) ^ b.get(i));
    }
    return res;
  }

  //TODO permutation

  public ArrayList<Integer> permutation(int[] tab_permuation, ArrayList<Integer> bloc){
    ArrayList<Integer> bloc_perm = new ArrayList<>();
    for (int i = 0; i < 64; i++){
      bloc_perm.add(0);
    }
    //TODO permuter les elements de bloc suivant le nombre dans chaque case de tab_perm





    return bloc_perm;
  }

  public static void main(String[] args) {
    DES des = new DES();
    des.genereMasterKey();
    // System.out.println(DES.masterKey);
    String message_clair = "Bonjour les amis c'est tchoupi";
    ArrayList<Integer> message_code = des.stringToBits(message_clair);
    System.out.println(message_clair);
    System.out.println(message_code);
    System.out.println(des.bitsToString(message_code));

  }

}
