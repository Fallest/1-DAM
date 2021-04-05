import static org.junit.Assert.*;

import org.junit.Test;

public class EmpleadoBRTest {

	@Test
	public void testCalculaSalarioBruto1() throws Exception {
		EmpleadoBR empleado = new EmpleadoBR();
		float resultadoReal = empleado.calculaSalarioBruto("vendedor", 2000.0f, 8.0f);
		float resultadoEsperado = 1360.0f;
		assertEquals(resultadoEsperado, resultadoReal, 0.01);
	}
	
	@Test
	public void testCalculaSalarioBruto2() throws Exception {
		EmpleadoBR empleado = new EmpleadoBR();
		float resultadoReal = empleado.calculaSalarioBruto("vendedor", 1500.0f, 3.0f);
		float resultadoEsperado = 1260.0f;
		assertEquals(resultadoEsperado, resultadoReal, 0.01);
	}
	
	@Test
	public void testCalculaSalarioBruto3() throws Exception {
		EmpleadoBR empleado = new EmpleadoBR();
		float resultadoReal = empleado.calculaSalarioBruto("vendedor", 1499.99f, 0.0f);
		float resultadoEsperado = 1100.0f;
		assertEquals(resultadoEsperado, resultadoReal, 0.01);
	}
	
	@Test
	public void testCalculaSalarioBruto4() throws Exception {
		EmpleadoBR empleado = new EmpleadoBR();
		float resultadoReal = empleado.calculaSalarioBruto("encargado", 1250.0f, 8.0f);
		float resultadoEsperado = 1760.0f;
		assertEquals(resultadoEsperado, resultadoReal, 0.01);
	}
	
	@Test
	public void testCalculaSalarioBruto5() throws Exception {
		EmpleadoBR empleado = new EmpleadoBR();
		float resultadoReal = empleado.calculaSalarioBruto("encargado", 1000.0f, 0.0f);
		float resultadoEsperado = 1600.0f;
		assertEquals(resultadoEsperado, resultadoReal, 0.01);
	}
	
	@Test
	public void testCalculaSalarioBruto6() throws Exception {
		EmpleadoBR empleado = new EmpleadoBR();
		float resultadoReal = empleado.calculaSalarioBruto("encargado", 999.99f, 3.0f);
		float resultadoEsperado = 1560.0f;
		assertEquals(resultadoEsperado, resultadoReal, 0.01);
	}
	
	@Test
	public void testCalculaSalarioBruto7() throws Exception {
		EmpleadoBR empleado = new EmpleadoBR();
		float resultadoReal = empleado.calculaSalarioBruto("encargado", 500.0f, 0.0f);
		float resultadoEsperado = 1500.0f;
		assertEquals(resultadoEsperado, resultadoReal, 0.01);
	}
	
	@Test
	public void testCalculaSalarioBruto8() throws Exception {
		EmpleadoBR empleado = new EmpleadoBR();
		float resultadoReal = empleado.calculaSalarioBruto("encargado", 0.0f, 8.0f);
		float resultadoEsperado = 1660.0f;
		assertEquals(resultadoEsperado, resultadoReal, 0.01);
	}
	
	@Test(expected=Exception.class)
	public void testCalculaSalarioBruto9() throws Exception {
		EmpleadoBR empleado = new EmpleadoBR();
		float resultadoReal = empleado.calculaSalarioBruto("vendedor", -1.0f, 8.0f);
		float resultadoEsperado = 1260.0f;
		assertEquals(resultadoEsperado, resultadoReal, 0.01);
	}
	
	@Test(expected=Exception.class)
	public void testCalculaSalarioBruto10() throws Exception {
		EmpleadoBR empleado = new EmpleadoBR();
		float resultadoReal = empleado.calculaSalarioBruto("vendedor", 1500.0f, -1.0f);
		float resultadoEsperado = 1260.0f;
		assertEquals(resultadoEsperado, resultadoReal, 0.01);
	}
	
	@Test(expected=Exception.class)
	public void testCalculaSalarioBruto11() throws Exception {
		EmpleadoBR empleado = new EmpleadoBR();
		float resultadoReal = empleado.calculaSalarioBruto(null, 1500.0f, 8.0f);
		float resultadoEsperado = 1260.0f;
		assertEquals(resultadoEsperado, resultadoReal, 0.01);
	}
	
	@Test
	public void testCalculaSalarioNeto1() {
		EmpleadoBR empleado = new EmpleadoBR();
		try {
			float resultadoReal = empleado.calculaSalarioNeto(2000.0f);
			float resultadoEsperado = 1640.0f;
			assertEquals(resultadoEsperado, resultadoReal, 0.01);
		}
		catch(Exception error){
			System.out.println("El sueldo bruto no puede ser menor que 0");
		}
	}
	
	@Test
	public void testCalculaSalarioNeto2() {
		EmpleadoBR empleado = new EmpleadoBR();
		try {
			float resultadoReal = empleado.calculaSalarioNeto(1500.0f);
			float resultadoEsperado = 1230.0f;
			assertEquals(resultadoEsperado, resultadoReal, 0.01);
		}
		catch(Exception error){
			System.out.println("El sueldo bruto no puede ser menor que 0");
		}
	}

	@Test
	public void testCalculaSalarioNeto3() {
		EmpleadoBR empleado = new EmpleadoBR();
		try {
			float resultadoReal = empleado.calculaSalarioNeto(1499.99f);
			float resultadoEsperado = 1259.9916f;
			assertEquals(resultadoEsperado, resultadoReal, 0.01);
		}
		catch(Exception error){
			System.out.println("El sueldo bruto no puede ser menor que 0");
		}
	}
	
	@Test
	public void testCalculaSalarioNeto4() {
		EmpleadoBR empleado = new EmpleadoBR();
		try {
			float resultadoReal = empleado.calculaSalarioNeto(1250.0f);
			float resultadoEsperado = 1050.0f;
			assertEquals(resultadoEsperado, resultadoReal, 0.01);
		}
		catch(Exception error){
			System.out.println("El sueldo bruto no puede ser menor que 0");
		}
	}
	
	@Test
	public void testCalculaSalarioNeto5() {
		EmpleadoBR empleado = new EmpleadoBR();
		try {
			float resultadoReal = empleado.calculaSalarioNeto(1000.0f);
			float resultadoEsperado = 840.0f;
			assertEquals(resultadoEsperado, resultadoReal, 0.01);
		}
		catch(Exception error){
			System.out.println("El sueldo bruto no puede ser menor que 0");
		}
	}
	
	@Test
	public void testCalculaSalarioNeto6() {
		EmpleadoBR empleado = new EmpleadoBR();
		try {
			float resultadoReal = empleado.calculaSalarioNeto(999.99f);
			float resultadoEsperado = 999.99f;
			assertEquals(resultadoEsperado, resultadoReal, 0.01);
		}
		catch(Exception error){
			System.out.println("El sueldo bruto no puede ser menor que 0");
		}
	}
	
	@Test
	public void testCalculaSalarioNeto7() {
		EmpleadoBR empleado = new EmpleadoBR();
		try {
			float resultadoReal = empleado.calculaSalarioNeto(500.0f);
			float resultadoEsperado = 500.0f;
			assertEquals(resultadoEsperado, resultadoReal, 0.01);
		}
		catch(Exception error){
			System.out.println("El sueldo bruto no puede ser menor que 0");
		}
	}
	
	@Test
	public void testCalculaSalarioNeto8() {
		EmpleadoBR empleado = new EmpleadoBR();
		try {
			float resultadoReal = empleado.calculaSalarioNeto(0.0f);
			float resultadoEsperado = 0.0f;
			assertEquals(resultadoEsperado, resultadoReal, 0.01);
		}
		catch(Exception error){
			System.out.println("El sueldo bruto no puede ser menor que 0");
		}
	}
	
	@Test(expected=Exception.class)
	public void testCalculaSalarioNeto9() throws Exception {
		EmpleadoBR empleado = new EmpleadoBR();
		float resultadoReal = empleado.calculaSalarioNeto(-1.0f);
		float resultadoEsperado = 0.0f;
		assertEquals(resultadoEsperado, resultadoReal, 0.01);
	}
}
