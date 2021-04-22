package ProyectoJavaUD06;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;

public final class Videojuego {
    // Atributos
    private String desarrolladora;
    private String titulo;
    private Fecha fecha_lanz;
    private float precio;
    private String plataforma; // Como no hemos dado enum, se usará una función 
                               // para controlar su valor.
    
    // Constructor: 
    Videojuego() throws Errores {
        setTitulo();
        setDesarrolladora();
        setFechaLanz();
        setPrecio();
        setPlataforma();
    }
    
    // Setters:
    public void setTitulo() {
        // Prácticamente el mismo que de Cancion.
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

                System.out.println("\n\tIntroduzca el título del videojuego (40 car. max.):");
                this.titulo = teclado.readLine();

                // Comprobar que el dato introducido es válido.
                if ((this.titulo.length() > 40) || (this.titulo.equals("")))
                    throw error;
            }
            catch (IOException e) {
                System.out.println("\nError en la entrada de datos.");
                ejec = true;
            }
            catch (Errores e) {
                e.invalidStr();
                ejec = true;
            }
        } while (ejec);
    }
    
    public void setDesarrolladora() {
        boolean ejec;
        Errores error = new Errores();
        
        do {
            try {
                ejec = false;
                
                InputStreamReader stream = new InputStreamReader(System.in);
                BufferedReader teclado = new BufferedReader(stream);

                System.out.println("\n\tIntroduzca el nombre de la empresa desarrolladora (40 car. max.):");
                this.desarrolladora = teclado.readLine();

                // Comprobar que el dato introducido es válido.
                if ((this.desarrolladora.length() > 40) || (this.desarrolladora.equals("")))
                    throw error;
            }
            catch (IOException e) {
                System.out.println("\nError en la entrada de datos.");
                ejec = true;
            }
            catch (Errores e) {
                e.invalidStr();
                ejec = true;
            }
        } while (ejec);
    }
    
    public void setFechaLanz() {
        boolean ejec;
        
        do {
            try {
                ejec = false;
                InputStreamReader stream = new InputStreamReader(System.in);
                BufferedReader teclado = new BufferedReader(stream);
                
                System.out.println("\n\tIntroduzca la fecha de lanzamiento (DD/MM/YYYY): ");
                this.fecha_lanz = new Fecha(Integer.parseInt(teclado.readLine().substring(0, 1)),
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
    
    public void setPrecio() {
        boolean ejec;
        Errores error = new Errores();
        
        do {
            try {
                ejec = false;
                InputStreamReader stream = new InputStreamReader(System.in);
                BufferedReader teclado = new BufferedReader(stream);
                
                System.out.println("\n\tIntroduzca el precio del videojuego (separador decimal \".\"):");
                this.precio = Float.parseFloat(teclado.readLine());

                // Comprobar que el dato introducido es válido.
                if (this.precio < 0f)
                    throw error;
            }
            catch (IOException e) {
                System.out.println("\n\tError en la entrada de datos.");
                ejec = true;
            }
            catch (NumberFormatException e) {
                System.out.println("\n\tError: formato de número incorrecto.");
                ejec = true;
            }
            catch (Errores e) {
                e.invalidPrice();
                ejec = true;
            }
        } while (ejec);
    }
    
    public void setPlataforma() {
        boolean ejec;
        Errores error = new Errores();
        
        do {
            try {
                ejec = false;
                InputStreamReader stream = new InputStreamReader(System.in);
                BufferedReader teclado = new BufferedReader(stream);
                
                System.out.println("\n\tIntroduzca la plataforma (Windows, Mac, Linux"
                        + "PlayStation o Xbox): ");
                this.plataforma = teclado.readLine();
                
                if (!checkPlataforma(this.plataforma))
                    throw error;
            }
            catch (IOException e) {
                System.out.println("\n\tError en la entrada de datos.");
                ejec = true;
            }
            catch (Errores e)
            {
                e.invalidPlatform();
                ejec = true;
            }
        } while (ejec);
    }
    
    // Getters:
    public String getTitulo() {
        return this.titulo;
    }
    
    public String getDesarrolladora() {
        return this.desarrolladora;
    }
    
    public Fecha getFechaLanz() {
        return this.fecha_lanz;
    }
    
    public float getPrecio() {
        return this.precio;
    }
    
    public String getPlataforma() {
        return this.plataforma;
    }
    
    // Checkers:
    private boolean checkPlataforma(String plataforma) {
        boolean esValida = false;
        
        if (plataforma.toLowerCase().equals("windows") ||
                plataforma.toLowerCase().equals("mac") ||
                plataforma.toLowerCase().equals("linux") ||
                plataforma.toLowerCase().equals("playstation") ||
                plataforma.toLowerCase().equals("xbox"))
            esValida = true;
        
        return esValida;
    }
    
}