import static org.junit.Assert.assertArrayEquals;
import static org.junit.Assert.assertEquals;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.Random;

import org.junit.Before;
import org.junit.Test;

public class MasterKeyTest {

    @Before
    public void setup() {

    }

    @Test
    public void testGenereMasterKey() {
        DES des = new DES();
        ArrayList<ArrayList<Integer>> cles = new ArrayList<>();

        for (int i = 0; i < 10; i++) {
            des.genereMasterKey();
            cles.add(DES.masterKey);
        }
        for (ArrayList<Integer> cle : cles) {
            assertEquals(64, cle.size());
        }

    }

    @Test
    public void testPerm() {
        DES des = new DES();
        ArrayList<Integer> bloc_perm = new ArrayList<>();
        Random r = new Random();
        for (int i = 0; i < 64; i++) {
            bloc_perm.add(r.nextInt(2));
        }
        ArrayList<Integer> bloc_drap = new ArrayList<>();
        bloc_drap = des.permutation(DES.perm_initiale, bloc_perm);
        assertEquals(bloc_perm, des.inv_permutation(DES.perm_initiale_inv, bloc_drap));

    }

    @Test
    public void testDecoupage() {
        DES des = new DES();

        // Bloc original
        ArrayList<Integer> bloc = new ArrayList<>(Arrays.asList(
                1, 2, 3, 4, 5, 6, 7, 8,
                9, 10, 11, 12, 13, 14, 15, 16,
                17, 18, 19, 20));
        int taille_sous_bloc = 8;

        // Découpage
        ArrayList<ArrayList<Integer>> blocs = des.decoupage(bloc, taille_sous_bloc);

        // Vérification des sous-blocs
        assertEquals(3, blocs.size());
        assertEquals(Arrays.asList(1, 2, 3, 4, 5, 6, 7, 8), blocs.get(0));
        assertEquals(Arrays.asList(9, 10, 11, 12, 13, 14, 15, 16), blocs.get(1));
        assertEquals(Arrays.asList(17, 18, 19, 20, 0, 0, 0, 0), blocs.get(2));

        // Recollage
        ArrayList<Integer> nouveau_bloc = des.recollage(blocs);

        // Vérification du bloc recollé
        assertEquals(bloc, nouveau_bloc);
    }

    @Test
    public void testDecallage() {
        DES des = new DES();
        ArrayList<Integer> minicle = new ArrayList<>(Arrays.asList(1, 0, 0, 1));
        ArrayList<Integer> expected = new ArrayList<>(Arrays.asList(0, 0, 1, 1));
        assertEquals(expected, des.decallage_gauche(minicle, 1));
        minicle = new ArrayList<>(Arrays.asList(0, 1, 1, 1));
        expected = new ArrayList<>(Arrays.asList(1, 1, 0, 1));
        assertEquals(expected, des.decallage_gauche(minicle, 2));

    }

    @Test
    public void testXor() {
        DES des = new DES(); // Assumant que la méthode xor est dans la classe DES

        ArrayList<Integer> a = new ArrayList<>(Arrays.asList(1, 0, 1, 0));
        ArrayList<Integer> b = new ArrayList<>(Arrays.asList(1, 1, 0, 0));

        ArrayList<Integer> expected = new ArrayList<>(Arrays.asList(0, 1, 1, 0));
        ArrayList<Integer> result = des.xor(a, b);

        assertEquals(expected, result);
    }

    @Test
    public void testGenereCle() {
        DES des = new DES();
        des.genereMasterKey();
        for (int i = 0; i < 10; i++) {
            des.genereCle(i);
        }
        // for (int i = 0; i < 10; i++) {
        // System.out.println(+i + " taille : " + DES.tab_cles.get(i).size() + "" +
        // DES.tab_cles.get(i));
        // }
    }

    @Test
    public void testFonction_S() {
        DES des = new DES();
        ArrayList<Integer> bloc = new ArrayList<>(Arrays.asList(1, 0, 1, 1, 0, 0));
        ArrayList<Integer> expected = new ArrayList<>(Arrays.asList(0, 0, 1, 0));

        // System.out.println(des.fonction_S(bloc));
        // System.out.println(expected);

        assertEquals(expected, des.fonction_S(bloc));

        DES.rondeActuelle = 1;
        expected = new ArrayList<>(Arrays.asList(1, 1, 1, 1));
    }

    @Test
    public void testFonction_F() {
        DES des = new DES();
        des.genereMasterKey();
        des.genereCle(1);
        // Génere moi une arraylist bloc de 32 bits aléatoires
        ArrayList<Integer> bloc = new ArrayList<>();
        Random r = new Random();
        for (int i = 0; i < 32; i++) {
            bloc.add(r.nextInt(2));
        }

        ArrayList<Integer> bloc2 = des.fonction_f(bloc);

        System.out.println(bloc);
        System.out.println(bloc2);

        assertEquals(32, bloc2.size());
    }

}
