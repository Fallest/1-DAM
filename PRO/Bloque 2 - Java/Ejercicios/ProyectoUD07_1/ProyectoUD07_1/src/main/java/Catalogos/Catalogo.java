package Catalogos;

import Objetos.*;
import java.util.*;

public class Catalogo {
    // Atributos
    private Collection canciones = new ArrayList<Cancion>();
    private Collection videojuegos = new ArrayList<Videojuego>();
    
    // Constructor
    public Catalogo() {} // Dejamos un constructor vacío, no hace falta inicializar
                         // ningún valor.
    
    public Catalogo(Collection catCanc, Collection catJuegos) {
        setCatCanciones(catCanc);
        setCatVideojuegos(catJuegos);
    }
    
    // Setters
    public void setCatCanciones(Collection catCanc) {
        // Se asume que el catálogo dado por parámetros ya está ordenado.
        // Esta función no se va a usar, de todas maneras.
        Iterator iter = catCanc.iterator();
        
        while (iter.hasNext()) {
            this.canciones.add(iter.next());
            iter.next();
        }
    }
    
    public void setCatVideojuegos(Collection catJuegos) {
        // Se asume que el catálogo dado por parámetros ya está ordenado.
        // Esta función no se va a usar, de todas maneras.
        Iterator iter = catJuegos.iterator();
        
        while (iter.hasNext()) {
            this.canciones.add(iter.next());
            iter.next();
        }
    }
    
    // Getters
    public Collection getCanciones() {
        return this.canciones;
    }
    
    public Collection getVideojuegos() {
        return this.videojuegos;
    }
    
    // Utilidades    
    public void mostrarDatos() {
        // Solo hay que llamar a los otros dos métodos juntos
        mostrarCanciones();
        mostrarVideojuegos();
    }
    
    public void mostrarCanciones() {
        System.out.println("-----Canciones-----");
        
        Iterator iter = this.canciones.iterator();
        Cancion cancAux;
        
        while (iter.hasNext()) {
            cancAux = (Cancion) iter.next();
            cancAux.mostrarDatos();
            iter.next();
            System.out.println("-----");
        }
    }
    
    public void mostrarVideojuegos() {
        System.out.println("-----Videojuegos-----");
        
        Iterator iter = this.videojuegos.iterator();
        Videojuego juegoAux;
        
        while (iter.hasNext()) {
            juegoAux = (Videojuego) iter.next();
            juegoAux.mostrarDatos();
            iter.next();
            System.out.println("-----");
        }
    }
}