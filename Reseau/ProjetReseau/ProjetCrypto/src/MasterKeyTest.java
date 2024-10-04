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
            System.out.println(cles);
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
        ArrayList<Integer> bloc_perm = new ArrayList<>();
        Random r = new Random();
        for (int i = 0; i < 1280; i++) {
            bloc_perm.add(r.nextInt(2));
        }
        ArrayList<ArrayList<Integer>> blocs = des.decoupage(bloc_perm, 64);
        assertEquals(20, blocs.size());

        ArrayList<Integer> nouveaubloc = des.recollage(blocs);

        assertEquals(bloc_perm, nouveaubloc);

    }

    @Test
    public void testDecallage() {
        DES des = new DES();
        ArrayList<Integer> minicle = new ArrayList<>();
        for (int i = 0; i < 28; i++) {
            minicle.add(i);
        }
        ArrayList<Integer> minicle2 = des.decallage_gauche(minicle);
        ArrayList<Integer> verid = new ArrayList<>();
        for (int i = 1; i < 28; i++) {
            verid.add(i);
        }
        verid.add(0);
        assertEquals(verid, minicle2);
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

}
