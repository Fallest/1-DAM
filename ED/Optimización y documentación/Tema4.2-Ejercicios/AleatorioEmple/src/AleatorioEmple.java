import java.io.File;
import java.io.IOException;
import java.io.RandomAccessFile;


public class AleatorioEmple {

public static RandomAccessFile file;

public static void consultar(int num, double importe) throws IOException {      
	File fichero = new File("AleatorioEmple.dat");
    RandomAccessFile file = new RandomAccessFile(fichero, "rw");
    double salario,nuevosalario;
	int pos,dep;
	char aux;
	String nom="";
	// 36 es la longitud del registro
	if (file.length() <=0)
		 System.out.println(" EL FICHERO ESTÁ VACÍO.");   
	else
	if (file.length()<(num*36))
	 System.out.println(" EL NUMERO DE EMPLEADO NO EXISTE.");   
	 else
      { 
	    pos=(num-1)*36;   file.seek(pos);  
	    num=file.readInt();   // obtengo el dep	  	  
	    for (int i = 0; i < 10; i++) {
	         aux = file.readChar(); 
	         nom=nom+aux;    
	    }      
	    dep = file.readInt();
	    salario = file.readDouble();
		System.out.println("Empleado: "+  nom + ", numero:" + num +
		    		    ", dep: " + dep + ", salario: "+ salario); 
	    nuevosalario=salario+importe;
		pos=((num-1)*36)+28;  file.seek(pos);   
		// nos colocamos en salario
		file.writeDouble(nuevosalario);		
      }	
	file.close();
	
}//fin consultar	
	
public static void leer() throws IOException {      
	   File fichero = new File("AleatorioEmple.dat");
	   file = new RandomAccessFile(fichero, "r");
	   char cad[] = new char[10], aux; 
	   String nom;
	   double salario;
	   int pos,num,dep;
       if (file.length()>0 ){
	   pos=0;  
	   System.out.println(" ------------------------------------------");  
	   System.out.println(" - - - VISUALIZO POR CONSOLAAAAA ");      
	   for(;;){  //recorro el fichero, visualiza también las posiciones vacías
		   file.seek(pos); 
		   num=file.readInt();   // obtengo el dep	  	  
	       for (int i = 0; i < cad.length; i++) {
	         aux = file.readChar(); 
	         cad[i] = aux;    
	        }     
	        nom= new String(cad);//convierto a String el array
	        dep = file.readInt();
	        salario = file.readDouble();
		    System.out.println("Empleado: "+  nom + ", numero:" + num +
		    		    ", dep: " + dep + ", salario: "+ salario);        
		    pos= pos + 36;                
		    //Si he recorrido todos los bytes salgo del for	 	  
	        if (file.getFilePointer()==file.length())break;
	   
	}//fin bucle for 
	file.close();  //cerrar fichero 
	System.out.println(" ------------------------------------------");  
	}
  else  //esto sólo sale la primera vez
		System.out.println(" ---------FICHERO VACIÍIOOOO --------------------");
}// fin verporconsola

 public static void crear() throws IOException {      
   File fichero = new File("AleatorioEmple.dat");
   RandomAccessFile file = new RandomAccessFile(fichero, "rw");
   String apellido[] = {"FERNANDEZ","GIL","LOPEZ","RAMOS",
			                        "SEVILLA","CASILLA", "REY"};//apellidos 
	int dep[] = {10, 20, 10, 10, 30, 30, 20};       //departamentos
	Double salario[]={1000.45, 2400.60, 3000.0, 1500.56, 
			                     2200.0, 1435.87, 2000.0};//salarios
			   
	StringBuffer buffer = null;//buffer para almacenar apellido
	int n=apellido.length;//numero de elementos del array
			   
	for (int i=0;i<n; i++){ //recorro los arrays          	  
	  file.writeInt(i+1); //uso i+1 para identificar empleado
	  buffer = new StringBuffer( apellido[i] );      
	  buffer.setLength(10); //10 caracteres para el apellido
	  file.writeChars(buffer.toString());//insertar apellido
	  file.writeInt(dep[i]);       //insertar departamento
	  file.writeDouble(salario[i]);//insertar salario
	  }     
	file.close();  //cerrar fichero 
	}//fin crear

 public static void main(String[] args) throws IOException       
	 {
		crear();
		leer();
		 	
	 }
}//fin class
