package pruebas_unitarias_netbeans;

import org.junit.After;
import org.junit.AfterClass;
import org.junit.Before;
import org.junit.BeforeClass;
import org.junit.Test;
import static org.junit.Assert.*;

/**
 *
 * @author David
 */
public class CalculadoraTest2 {
    private Calculadora calcu;
    private int result;
    
    @Before
    public void creaCalculadora() {
        calcu = new Calculadora(20,10);
    }
    
    @After
    public void borraCalculadora() {
        calcu = null;
    }

    /**
     * Test of suma method, of class Calculadora.
     */
    @Test
    public void testSuma() {
        System.out.println("suma");
        int expResult = 30;
        int result = calcu.suma();
        assertEquals(expResult, result);
    }

    /**
     * Test of resta method, of class Calculadora.
     */
    @Test
    public void testResta() {
        System.out.println("resta");
        int expResult = 10;
        int result = calcu.resta();
        assertEquals(expResult, result);
    }

    /**
     * Test of multiplica method, of class Calculadora.
     */
    @Test
    public void testMultiplica() {
        System.out.println("multiplica");
        int expResult = 200;
        int result = calcu.multiplica();
        assertEquals(expResult, result);
    }

    /**
     * Test of divide method, of class Calculadora.
     */
    @Test
    public void testDivide() {
        System.out.println("divide");
        int expResult = 2;
        int result = calcu.divide();
        assertEquals(expResult, result);
    }

    /**
     * Test of divide0 method, of class Calculadora.
     */
    @Test(expected=java.lang.ArithmeticException.class)
    public void testDivide0() {
        System.out.println("divide0");
        Calculadora instance = new Calculadora(20, 0);
        int expResult = 0;
        int result = instance.divide0();
        assertNotSame(expResult, result);
    }
}
