

import java.awt.*;
import java.awt.event.*;
import java.io.BufferedReader;
import java.io.File;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.RandomAccessFile;

import javax.swing.*;

/**
 * <h2> Clase para mostrar una ventana al usuario. </h2> 
 * 
 * @version 1.0
 * @author Juan Antonio
 * */



public class VentanaDepart extends SuperclaseDepart implements ActionListener  {
		

	private static final long serialVersionUID = 1L;
	JTextField num=new JTextField(10);
	JTextField nombre=new JTextField(25);
	JTextField loc=new JTextField(25);
	
	
	JLabel mensaje=new JLabel(" ----------------------------- ");
	JLabel titulo=new JLabel ("GESTIï¿½N DE DEPARTAMENTOS.");
	
	JLabel lnum = new JLabel ("NUMERO DEPARTAMENTO:");
	JLabel lnom = new JLabel ("NOMBRE:");
	JLabel lloc = new JLabel ("LOCALIDAD:");
	
	JButton balta= new JButton("Insertar Depar.t");
	JButton consu= new JButton("Consultar Depart.");
	JButton borra= new JButton("Borrar Depart.");
	JButton breset=new JButton("Limpiar datos.");
	JButton modif=new JButton("Modificar Departamento.");
	JButton ver=new JButton("Ver por consola.");
	JButton fin=new JButton("CERRAR");
	Color c; //para poner colores
	 // WHITE,LIGHTGRAY,GRAY,DARKGRAY,BLUE,BLACK,RED,MAGENTA,PINK,ORANGE,CYAN,GREEN,YELLOW
	private String nOEXISTEDEPART;
	private String depar_error;
	
	/**
	 * Función para crear una ventana
	 * @param f
	 * */

	public VentanaDepart(JFrame f )
	{ 	
	    setTitle("GESTIï¿½N DE DEPARTAMENTOS.");
	    
	    JPanel p0 = new JPanel();
		c = Color.CYAN;
		p0.add(titulo);
		p0.setBackground(c);
				
		JPanel p1 = new JPanel();
		p1.setLayout (new FlowLayout());
		p1.add(lnum);
		p1.add(num);p1.add(consu);
		
		JPanel p2 = new JPanel();
		p2.setLayout (new FlowLayout());
		p2.add(lnom);
		p2.add(nombre);
		
		JPanel p3 = new JPanel();
		p3.setLayout (new FlowLayout());
		p3.add(lloc);
		p3.add(loc);
		
		JPanel p4 = new JPanel();
		p4.setLayout (new FlowLayout());
		c = Color.YELLOW;
		p4.add(balta);	 p4.add(borra);p4.add(modif);
		p4.setBackground(c);
		
		JPanel p5 = new JPanel();
		p4.setLayout (new FlowLayout());
		c = Color.PINK;
		p5.add(breset);p5.add(ver);
		p5.add(fin);p5.setBackground(c);
	
		JPanel p7 = new JPanel();
		p7.setLayout (new FlowLayout());
		p7.add(mensaje);
		
		// para ver la ventana y colocar los controles verticalmente
		setLayout(new BoxLayout(getContentPane(), BoxLayout.Y_AXIS)); 
		// aï¿½adir los panel al frame
		add(p0);add(p1);add(p2);add(p3);add(p4);add(p5);add(p7);
		pack(); //hace que se coloquen alineados los elementos de cada JPanel
		
	    setDefaultCloseOperation(WindowConstants.EXIT_ON_CLOSE);
		
		balta.addActionListener(this);
		breset.addActionListener(this);
		fin.addActionListener(this);
		consu.addActionListener(this);
		borra.addActionListener(this);
		modif.addActionListener(this);
		ver.addActionListener(this);
	}
	
	/**
	 * Función para manejar alguna acción
	 * @param e
	 * */
	public void actionPerformed(ActionEvent e) 
	{   int dep, confirm;
		String existedepart = "DEPARTAMENTO EXISTE.";
		
		insertarDepartamento(e, existedepart, "PRUEBA");
			   
		consultar(e, existedepart);
			  
		borrar(e, existedepart);
		
		modificar(e, existedepart);
		
		if (e.getSource() == fin) { //SE PULSA EL BOTON salir 	
			 System.exit(0);	
			 //dispose();   	
		}
		if (e.getSource() == ver) { //SE PULSA EL BOTON  ver por consola  	
			try {
				mensaje.setText("Visualizando el fichero por la consolaa.....");    
				verporconsola();
			} catch (IOException e1) {
				System.out.println("ERRROR AL LEEERRRRRR AleatorioDep.dat");    
				//e1.printStackTrace();
			}	
		}
		if (e.getSource() == breset) { //SE PULSA EL BOTON  limpiar  	
			mensaje.setText(" has pulsado el boton limpiar..");    
	        num.setText(" ");nombre.setText(" ");
	        loc.setText(" ");
		}
	}

	
	
	/**
	 * Función que mostrará por consola algo
	 * @throws IOException
	 * */

	public  void verporconsola() throws IOException {     
	  String  nom="",loc=""; int dep=0; long pos;
	  File fichero = new File("AleatorioDep.dat");
	  RandomAccessFile file = new RandomAccessFile(fichero, "r");
	  char cad[] = new char[10], aux; 
	  
	  FicheroAleatorioVentana fa=new FicheroAleatorioVentana();
	  claseAnidada ej = new claseAnidada();
	  ej.entrada();
	  System.out.println("Llamo a Salida: "+ej.salida(10));
	  
	  if (file.length()>0 ){
		pos=0;  //para situarnos al principio
		System.out.println(" ------------------------------------------");  
		System.out.println(" - - - VISUALIZO POR CONSOLAAAAA ");      
		for(;;){  //recorro el fichero, visualiza tambiï¿½n las posiciones vacï¿½as
			   file.seek(pos); 
			   dep=file.readInt();   // obtengo el dep	  	  
		       for (int i = 0; i < cad.length; i++) {
		         aux = file.readChar();//recorro uno a uno los caracteres del apellido 
		         cad[i] = aux;    //los voy guardando en el array
		        }     
		        nom= new String(cad);//convierto a String el array
		        for (int i = 0; i < cad.length; i++) {
			         aux = file.readChar();
			         cad[i] = aux;  
			    }     
			    loc= new String(cad);//convierto a String el array
			    System.out.println("DEP: " + dep + ", Nombre: "+  nom + ", Localidad: "+ loc);        
			    pos= pos + 44;                
			    //Si he recorrido todos los bytes salgo del for	 	  
		        if (file.getFilePointer()==file.length())break;
		   
		}//fin bucle for 
		file.close();  //cerrar fichero 
		System.out.println(" ------------------------------------------");  
		}
	  else  //esto sï¿½lo sale la primera vez
			System.out.println(" ---------FICHERO VACIï¿½IOOOO --------------------");
	}// fin verporconsola
	
	/**
	 * Realiza alguna consulta de algún tipo
	 * @param dep
	 * @throws IOException
	 * */
	boolean consultar(int dep) throws IOException 
	{	 
		long pos; int depa;
		File fichero = new File("AleatorioDep.dat");
		RandomAccessFile file = new RandomAccessFile(fichero, "r");
	    // Calculo del reg a leer
		try { pos=44 * (dep-1);
	          if (file.length()==0) return false; // si estï¿½ vacï¿½o
		      file.seek(pos); 
		      depa=file.readInt();   
		      file.close(); 
		      System.out.println("Depart leido:" + depa);   
		      if (depa>0) return true;
		             else return false;
		  }catch (IOException ex2) {
		    System.out.println(" ERRORRR al leerrrrr..");
		    return false;
		  } 
	} // fin consultar
	
	/**
	 * Para visualizar algo
	 * @param dep
	 * */
	void visualiza(int dep) 
	{	    String nom="",loca=""; 
			long pos; int depa;
			File fichero = new File("AleatorioDep.dat");
			try {
			RandomAccessFile file = new RandomAccessFile(fichero, "r");
	        // Calculo del reg a leer
			pos=44 * (dep-1);
		    file.seek(pos); 
		    depa=file.readInt();   
		    System.out.println("Depart leido:" + depa);   
		    char nom1[]= new char[10], aux,  loc1[]= new char[10];
			for (int i=0;i<10;i++) 
			{   aux=file.readChar();
				nom1[i]=aux;
			}
			for (int i=0;i<10;i++) 
			{   aux=file.readChar();
				loc1[i]=aux;
			}
			nom=new String (nom1);
			loca=new String (loc1);
		    System.out.println("DEP: " + dep + ", Nombre: "+  nom + ", Localidad: "+ loca);  
		    nombre.setText(nom);
	        loc.setText(loca);
		    file.close(); 
			}catch (IOException e1) {
				  System.out.println("ERRROR AL LEEERRRRRR AleatorioDep.dat");    
				e1.printStackTrace();
			}	
	} // fin visualiza
	
	/**
	 * Para borrar algo
	 * @param dep
	 * */
	void borrar(int dep) 
	{	    // con borrar ponemos a 0 el dep que se quiere borrar
		    // y a blancos el nombre y la localidad
		    String nom="",loca="";  StringBuffer buffer = null;
			long pos; 
			File fichero = new File("AleatorioDep.dat");
			try {
			RandomAccessFile file = new RandomAccessFile(fichero, "rw");
	        // Calculo del reg a leer
			pos=44 * (dep-1);
		    file.seek(pos); 
		    int depp=0;
		    file.writeInt(depp);       
		    buffer = new StringBuffer( nom );      
		    buffer.setLength(10); 
		    file.writeChars(buffer.toString());
		      
		    buffer = new StringBuffer(loca);      
		    buffer.setLength(10); 
		    file.writeChars(buffer.toString());
		    System.out.println("----REGISTRO BORRADO--------");
		    
		    file.close(); 
			}catch (IOException e1) {
				  System.out.println("ERRROR AL BORRARRR AleatorioDep.dat");    
				e1.printStackTrace();
			}	
	} // fin borrar
	
	/**
	 * Para modificar algo
	 * @param dep
	 * */
	void modificar(int dep) 
	{	    // con modificar asignamos los datos tecleados
		    String nom="",loca="";  StringBuffer buffer = null;
			long pos; 
			File fichero = new File("AleatorioDep.dat");
			try {
			RandomAccessFile file = new RandomAccessFile(fichero, "rw");
	        // Calculo del reg a leer
			pos=44 * (dep-1);
		    file.seek(pos); 
		    file.writeInt(dep);      
		    nom=nombre.getText();
		    loca=loc.getText();
		    buffer = new StringBuffer(nom);      
		    buffer.setLength(10); 
		    file.writeChars(buffer.toString());
		    buffer = new StringBuffer(loca);      
		    buffer.setLength(10); 
		    file.writeChars(buffer.toString());
		    System.out.println("----REGISTRO MODIFICADOOO--------");
		    
		    file.close(); 
			}catch (IOException e1) {
				  System.out.println("ERRROR AL MODIFICARRR AleatorioDep.dat");    
				e1.printStackTrace();
			}	
	} // fin modificar
	
	/**
	 * Para grabar algo
	 * @param dep
	 * @param nom
	 * @param loc
	 * */
	void grabar(int dep, String nom, String loc) 
	{	 
			long pos; StringBuffer buffer = null;
			File fichero = new File("AleatorioDep.dat");
			try {
			RandomAccessFile file = new RandomAccessFile(fichero, "rw");
	        // Calculo del reg a leer
	        pos=44 * (dep-1);
	        //if (file.length()==0) return false; // si estï¿½ vacï¿½o
	        
		    file.seek(pos); 
		    file.writeInt(dep);       
		    buffer = new StringBuffer( nom );      
		    buffer.setLength(10); 
		    file.writeChars(buffer.toString());//insertar nombre
		    buffer = new StringBuffer( loc );      
		    buffer.setLength(10); 
		    file.writeChars(buffer.toString());//insertar loc
		    file.close(); 
		    System.out.println(" GRABADOOO el "+dep);  
			}catch (IOException e1) {
			   System.out.println("ERRROR AL grabarr AleatorioDep.dat");    
				e1.printStackTrace();
			}	
	} // fin grabar
}//fin clase
