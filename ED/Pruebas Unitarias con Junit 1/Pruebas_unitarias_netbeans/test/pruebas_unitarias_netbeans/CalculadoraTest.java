/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
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
public class CalculadoraTest {
    /**
     * Test of suma method, of class Calculadora.
     */
    @Test
    public void testSuma() {
        System.out.println("suma");
        Calculadora instance = new Calculadora(20, 10);
        int expResult = 30;
        int result = instance.suma();
        assertEquals(expResult, result);
    }

    /**
     * Test of resta method, of class Calculadora.
     */
    @Test
    public void testResta() {
        System.out.println("resta");
        Calculadora instance = new Calculadora(20, 10);
        int expResult = 10;
        int result = instance.resta();
        assertEquals(expResult, result);
    }

    /**
     * Test of multiplica method, of class Calculadora.
     */
    @Test
    public void testMultiplica() {
        System.out.println("multiplica");
        Calculadora instance = new Calculadora(20, 10);
        int expResult = 200;
        int result = instance.multiplica();
        assertEquals(expResult, result);
    }

    /**
     * Test of divide method, of class Calculadora.
     */
    @Test
    public void testDivide() {
        System.out.println("divide");
        Calculadora instance = new Calculadora(20, 10);
        int expResult = 2;
        int result = instance.divide();
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
