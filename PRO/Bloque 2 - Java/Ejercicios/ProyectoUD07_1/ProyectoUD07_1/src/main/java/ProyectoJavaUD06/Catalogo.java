package ProyectoJavaUD06;

import java.util.ArrayList;

public abstract class Catalogo<T> {
    // Atributos
    private ArrayList<T> catalogo;
    
    Catalogo(T... cat) {
        catalogo = new ArrayList<T>(cat.length);
        for (int i = 0; i < cat.length; i++)
            catalogo.add(cat[i]);
    }
    
    
}