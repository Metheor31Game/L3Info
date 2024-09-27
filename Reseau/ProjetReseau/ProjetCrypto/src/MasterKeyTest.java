import static org.junit.Assert.assertEquals;

import java.util.ArrayList;
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
        
        for (int i = 0; i < 10; i++){
            des.genereMasterKey();
            cles.add(DES.masterKey);
        }
        for (ArrayList<Integer> cle:cles){
            System.out.println(cles);
            assertEquals(64, cle.size());
        }


    }
    
    
    @Test
    public void testPerm() {
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


