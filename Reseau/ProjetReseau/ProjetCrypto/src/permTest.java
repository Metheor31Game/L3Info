import static org.junit.Assert.assertEquals;

import java.util.ArrayList;
import java.util.Random;

import org.junit.Before;
import org.junit.Test;

public class permTest {
    @Before
    public void setup() {
    }
    
    @Test
    public void testPermutation() {
        DES des = new DES();
        ArrayList<Integer> bloc_perm = new ArrayList<>();
        Random r = new Random();
        for (int i = 0; i < 64; i++){
            bloc_perm.add(r.nextInt(2));
        }
        ArrayList<Integer> bloc_drap = new ArrayList<>();
        bloc_drap = des.permutation(DES.perm_initiale, bloc_perm);
        assertEquals(bloc_perm, des.inv_permutation(DES.perm_initiale_inv, bloc_drap));
    }
}
