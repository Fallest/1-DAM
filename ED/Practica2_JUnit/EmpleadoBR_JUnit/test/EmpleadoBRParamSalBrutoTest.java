import static org.junit.Assert.*;
import java.util.*;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.junit.runners.Parameterized;
import org.junit.runners.Parameterized.Parameters;
import org.junit.Test;

@RunWith(Parameterized.class)

public class EmpleadoBRParamSalBrutoTest {
	private float ventasMes, horasExtra, expected;
	private String tipo;
	
	public EmpleadoBRParamSalBrutoTest (String tipo, float ventasMes, float horasExtra, float expected) {
		this.tipo = tipo;
		this.ventasMes = ventasMes;
		this.horasExtra = horasExtra;
		this.expected = expected;
	}

	@Parameters
	public static Collection<Object[]> numeros() {
		return Arrays.asList(new Object[][] {{"vendedor", 2000.0f, 8.0f, 1360.0f},
											{"vendedor", 1500.0f, 3.0f, 1260.0f},
											{"vendedor", 1499.99f, 0.0f, 1100.0f},
											{"encargado", 1250.0f, 8.0f, 1760.0f},
											{"encargado", 1000.0f, 0.0f, 1600.0f},
											{"encargado", 999.99f, 3.0f, 1560.0f},
											{"encargado", 500.99f, 0.0f, 1500.0f},
											{"encargado", 0.99f, 8.0f, 1660.0f}
											});
	}
	
	@Test
	public void testCalculaSalarioBruto() throws Exception{
		EmpleadoBR empleado = new EmpleadoBR(tipo, ventasMes, horasExtra);
		float resultado = empleado.calculaSalarioBruto(tipo, ventasMes, horasExtra);
		assertEquals(expected, resultado, 0.01);
	}

}
