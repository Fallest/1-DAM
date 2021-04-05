package pruebas_unitarias_netbeans;

import java.util.*;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.junit.runners.Parameterized;
import org.junit.runners.Parameterized.Parameters;
import static org.junit.Assert.*;

/**
 *
 * @author David
 */
@RunWith(Parameterized.class)
public class CalculadoraTest4 {
    private int numero1;
    private int numero2;
    private int result;

    public CalculadoraTest4(int numero1, int numero2, int result) {
        this.numero1 = numero1;
        this.numero2 = numero2;
        this.result = result;
    }
    
    @Parameters
    public static Collection<Object[]> numeros() {
        return Arrays.asList(new Object[] [] {{20,10,2}, {30,-2,-15}, {5,2,3}});
    }
    
    /**
     * Test of suma method, of class Calculadora.
     */
    ///@Test
    public void testSuma() {
        System.out.println("suma");
        Calculadora calcu = new Calculadora(numero1, numero2);
        int expResult = result;
        int result = calcu.suma();
        assertEquals(expResult, result);
    }

    /**
     * Test of resta method, of class Calculadora.
     */
    //@Test
    public void testResta() {
        System.out.println("resta");
        Calculadora calcu = new Calculadora(numero1, numero2);
        int expResult = result;
        int result = calcu.resta();
        assertEquals(expResult, result);
    }

    /**
     * Test of multiplica method, of class Calculadora.
     */
    //@Test
    public void testMultiplica() {
        System.out.println("multiplica");
        Calculadora calcu = new Calculadora(numero1, numero2);
        int expResult = result;
        int result = calcu.multiplica();
        assertEquals(expResult, result);
    }

    /**
     * Test of divide method, of class Calculadora.
     */
    @Test
    public void testDivide() {
        System.out.println("divide");
        Calculadora calcu = new Calculadora(numero1, numero2);
        int expResult = result;
        int result = calcu.divide();
        assertEquals(expResult, result);
    }

}
