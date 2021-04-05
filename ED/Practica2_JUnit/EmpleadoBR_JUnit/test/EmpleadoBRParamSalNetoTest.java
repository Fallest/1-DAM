import static org.junit.Assert.*;
import java.util.*;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.junit.runners.Parameterized;
import org.junit.runners.Parameterized.Parameters;
import org.junit.Test;

@RunWith(Parameterized.class)

public class EmpleadoBRParamSalNetoTest {
	private float salarioBruto, expected;
	
	public EmpleadoBRParamSalNetoTest (float salarioBruto, float expected) {
		this.salarioBruto = salarioBruto;
		this.expected = expected;
	}

	@Parameters
	public static Collection<Object[]> numeros() {
		return Arrays.asList(new Object[][] {{2000.0f, 1640.0f},
											{1500.0f,  1230.0f},
											{1499.99f,  1259.9916f},
											{1250.0f,  1050.0f},
											{1000.0f,  840.0f},
											{999.99f,  999.99f},
											{500.0f,  500.0f},
											{0.0f,  0.0f},
											});
	}
	
	@Test
	public void testCalculaSalarioNeto() throws Exception{
		EmpleadoBR empleado = new EmpleadoBR("vendedor", 0.0f, 0.0f);
		float resultado = empleado.calculaSalarioNeto(salarioBruto);
		assertEquals(expected, resultado, 0.01);
	}

}