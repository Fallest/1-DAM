package pruebas_unitarias_netbeans;

import java.util.*;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.junit.runners.Parameterized;
import org.junit.runners.Parameterized.Parameters;
import static org.junit.Assert.*;

/**
 * Debe pasar 2 de 3 tests
 * @author David
 */
@RunWith(Parameterized.class)
public class CalculadoraTestSuma {
    private int numero1;
    private int numero2;
    private int result;

    public CalculadoraTestSuma(int numero1, int numero2, int result) {
        this.numero1 = numero1;
        this.numero2 = numero2;
        this.result = result;
    }
    
    @Parameters
    public static Collection<Object[]> numeros() {
        return Arrays.asList(new Object[] [] {{20,10,30}, {30,-2,28}, {5,2,4}});
    }
    
    /**
     * Test of suma method, of class Calculadora.
     */
    @Test
    public void testSuma() {
        System.out.println("suma");
        Calculadora calcu = new Calculadora(numero1, numero2);
        int expResult = result;
        int result = calcu.suma();
        assertEquals(expResult, result);
    }
}
