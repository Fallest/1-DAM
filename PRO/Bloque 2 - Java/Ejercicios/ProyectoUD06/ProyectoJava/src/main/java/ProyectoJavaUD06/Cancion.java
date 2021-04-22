package ProyectoJavaUD06;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;

public final class Cancion {
    // Atributos
    private String titulo;
    private String artistas[];
    private Fecha fechaEstreno;
    private int cantArtistas;
    
    // Constructor:
    //      Usamos solo uno porque no le daremos uso a otros.
    //      Con crear una clase con funciones completas es suficiente.
    Cancion () throws Errores {        
        setTitulo();
        setArtistas();
        setFechaEstr();
    }
    
    // Setters:
    public void setTitulo() throws Errores {
        // Usaremos una flag para seguir preguntando al usuario si no ha introducido
        // bien los datos. Además, creamos un objeto Errores para lanzarlo si es
        // necesario. Esto se va a repetir en todos los setters.
        boolean ejec;
        Errores error = new Errores();
        
        do {
            try {
                ejec = false;
                
                InputStreamReader stream = new InputStreamReader(System.in);
                BufferedReader teclado = new BufferedReader(stream);

                System.out.println("\n\tIntroduzca el título de la canción (40 car. max.):");
                this.titulo = teclado.readLine();

                // Comprobar que el dato introducido es válido.
                if ((this.titulo.length() > 40) || (this.titulo.equals("")))
                    throw error;
            }
            catch (IOException e) {
                System.out.println("\n\tError en la entrada de datos.");
                ejec = true;
            }
            catch (Errores e) {
                e.invalidStr();
                ejec = true;
            }
        } while (ejec);
    }
    
    private void setCantArtistas() throws Errores {
        boolean ejec;
        Errores error = new Errores();
        
        do {
            try {
                ejec = false;

                InputStreamReader stream = new InputStreamReader(System.in);
                BufferedReader teclado = new BufferedReader(stream);

                System.out.println("Introduzca la cantidad de artistas (1-6):");
                this.cantArtistas = Integer.parseInt(teclado.readLine());

                if ((this.cantArtistas < 1) || (this.cantArtistas > 6))
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
                e.invalidCantArtistas();
                ejec = true;
            }
        } while (ejec);
    }
    
    public void setArtistas() throws Errores {
        int i;
        boolean ejec;
        Errores error = new Errores();
        
        setCantArtistas(); // Pedimos la cantidad de artistas.
        
        this.artistas = new String[this.cantArtistas]; // Inicializamos el array.
        
        do {
            try {
                ejec = false;
                InputStreamReader stream = new InputStreamReader(System.in);
                BufferedReader teclado = new BufferedReader(stream);
                
                // Asignar todos los artistas
                for (i = 0; i < this.artistas.length; i++)
                {
                    System.out.println("\n\tIntroduzca el nombre del artista " + (i+1) + " (40 car. max.):");
                    this.artistas[i] = teclado.readLine();
                    
                    // Comprobar que el dato introducido es válido, cada vez.
                    if ((this.artistas[i].length() > 40) || (this.artistas[i].equals("")))
                        throw error;
                }
            }
            catch (IOException e) {
                System.out.println("\n\tError en la entrada de datos.");
                ejec = true;
            }
            catch (Errores e) {
                e.invalidStr();
                ejec = true;
            }
        } while (ejec);
    }
    
    public void setFechaEstr() throws Errores {
        boolean ejec;
        
        do {
            try {
                ejec = false;
                InputStreamReader stream = new InputStreamReader(System.in);
                BufferedReader teclado = new BufferedReader(stream);
                
                System.out.println("\n\tIntroduzca la fecha de estreno (DD/MM/YYYY): ");
                this.fechaEstreno = new Fecha(Integer.parseInt(teclado.readLine().substring(0, 1)),
                    Integer.parseInt(teclado.readLine().substring(3, 4)), 
                    Integer.parseInt(teclado.readLine().substring(6, 9)));
            }
            catch (IOException e) {
                System.out.println("\n\tError en la entrada de datos.");
                ejec = true;
            }
            catch (NumberFormatException e) {
                System.out.println("\n\tError: Se han introducido caracteres no válidos o de forma incorrecta.");
                ejec = true;
            } 
            catch (Errores e)
            {
                e.invalidDate(); // Control de la excepción propagada desde Fecha.
                ejec = true;
            }
        } while (ejec);
    }
    
    // Getters:
    public String getTitulo() {
        return this.titulo;
    }
    
    public String[] getArtistas() {
        return this.artistas;
    }
    
    public Fecha getFecha() {
        return this.fechaEstreno;
    }
}