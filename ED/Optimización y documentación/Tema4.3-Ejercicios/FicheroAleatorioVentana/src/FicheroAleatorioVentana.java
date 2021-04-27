import java.io.File;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.io.RandomAccessFile;

import javax.swing.JFrame;

/**
 * <h2>Clase FicheroAleatorioVentana</h2>
 * Clase principal para el programa.
 * @see VentanaDepart
 * @author David
 * @version v1.0
 */

public class FicheroAleatorioVentana {

	/**
	 * <h3>Función main de la clase FicheroAleatorioVentana</h3>
	 * @param args
	 * @throws IOException
	 */
	public static void main(String[] args) throws IOException {
		
		JFrame f = new JFrame("DEPARTAMENTOS.");
		// Nos aseguramos que el fichero exista para evitar posibles errores
		File fichero = new File("AleatorioDep.dat");
		RandomAccessFile file;
		file = new RandomAccessFile(fichero, "rw");	
		file.close();
		
		VentanaDepart v = new VentanaDepart(f);
		v.setVisible(true);
	   
	}//fin main

	
}//fin class
