package ProyectoJavaUD06;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;

public class Catalogo {
    private Cancion canciones[];
    private Videojuego videojuegos[];
    private int tamCatalogo;
    
    // Constructor:
    Catalogo () throws Errores {
        // Pedir el tamaño del catálogo.
        setTamCat();
        
        // Inicializar los vectores de cada tipo.
        this.canciones = new Cancion[tamCatalogo];
        this.videojuegos = new Videojuego[tamCatalogo];
    }
    
    // Setters:
    private void setTamCat() {
        boolean ejec;
        Errores error = new Errores();
        
        do {
            try {
                ejec = false;

                InputStreamReader stream = new InputStreamReader(System.in);
                BufferedReader teclado = new BufferedReader(stream);

                System.out.println("Introduzca el tamaño del catálogo (1-80):");
                this.tamCatalogo = Integer.parseInt(teclado.readLine());

                if ((this.tamCatalogo < 1) || (this.tamCatalogo > 80))
                    throw error;
            } 
            catch (IOException e) {
                System.out.println("\n\tError en la entrada de datos.");
                ejec = true;
            }
            catch (NumberFormatException e) {
                System.out.println("\n\tError: Se han introducido caracteres no válidos.");
                ejec = true;
            }
            catch (Errores e) {
                e.invalidCatTam();
                ejec = true;
            }
        } while (ejec);
    }
    
    // Getters:
    public Cancion[] getCaciones() {
        return this.canciones;
    }
    
    public Videojuego[] getVideojuegos() {
        return this.videojuegos;
    }
    
    // Checkers:
    // Este método checkers va a ser público porque lo vamos a llamar desde main()
    // cada vez que vayamos a introducir un dato.
    public boolean checkCapacidad() {
        int i, contador = 0;
        boolean lleno = false;
        
        for (i = 0; i < this.tamCatalogo; i++)
        {
            // Si encontramos un videojuego o una canción que tiene un título:
            // Hay que separarlos porque si en un mismo índice hay tanto una canción
            // como un videojuego, hay que aumentar el contador dos veces.
            if (!this.videojuegos[i].getTitulo().isEmpty())
                contador++;
            if (!this.canciones[i].getTitulo().isEmpty())
                contador++;
        }
        
        // Comprobar si está lleno.
        if (contador == this.tamCatalogo)
            lleno = true;
        
        return lleno;
    }
}