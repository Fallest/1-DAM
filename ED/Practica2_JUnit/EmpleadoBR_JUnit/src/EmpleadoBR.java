
public class EmpleadoBR {
	String tipo;
	float ventasMes;
	float horasExtra;

	public EmpleadoBR() {super();}
	
	public EmpleadoBR(String tipo, float ventasMes, float horasExtra)
	{
		this.tipo = tipo;
		this.ventasMes = ventasMes;
		this.horasExtra = horasExtra;
	}
	
	public void setTipo(String tipo) throws Exception {
		if(tipo == null)
		throw new Exception("El tipo no puede ser null");
		this.tipo = tipo;
	}
	
	public String getTip() {
		return tipo;
	}
	
	public void SetVentasMes(float ventas) throws Exception {
		if(ventas < 0)
		throw new Exception("Las ventas no pueden tener un valor negativo");
		this.ventasMes = ventas;
	}
	
	public float getVentasMes() {
		return ventasMes;
	}
	
	public void SetHorasExtras(float horasExtra) throws Exception {
		if(horasExtra < 0)
		throw new Exception("Las horas extras no pueden tener un valor negativo");
		this.horasExtra = horasExtra;
	}
	
	public float getHorasExtras() {
		return horasExtra;
	}
	
	public float calculaSalarioBruto(String tipo, float ventasMes, float horasExtra) throws Exception {
		float base = 0;
		float salarioBruto;
		float extra;
		
		// Exception handling
		if (tipo == null)
		{
			throw new Exception("El tipo de empleado no puede ser null.");
		}
		if (ventasMes < 0)
		{
			throw new Exception("Las ventas del mes no pueden ser negativas.");
		}
		if (horasExtra < 0)
		{
			throw new Exception("Las horas extra no pueden ser negativas.");
		}
		
		if (tipo == "vendedor")
		{
			base = 1000;
		}
		if (tipo == "encargado")
		{
			base = 1500;
		}
		if (ventasMes >= 1000 & ventasMes < 1500) {
			base = base + 100;
		}
		if (ventasMes >= 1500) {
			base = base + 200;
		}
		
		extra = horasExtra*20;
		salarioBruto = base + extra;
		return salarioBruto;
	}
	
	public float calculaSalarioNeto(float salarioBruto) throws Exception {
		float salarioNeto = salarioBruto;
		
		if (salarioBruto < 0)
			throw new Exception("El salario no puede ser un valor negativo");
		if (salarioBruto >= 1000 & salarioBruto < 1500) {
			salarioNeto = (float) (salarioBruto * (1 - 0.16));
		}
		if (salarioBruto >= 1500) {
			salarioNeto = (float) (salarioBruto * (1 - 0.18));
		}
		return salarioNeto;
	}

}
