package ProyectoJavaUD06;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;

public class main {
    
    public static void main(String[] args) {
        Catalogo catalogo = new Catalogo();
        int opcion;
        
        do {
            opcion = menu();
            ejecutarOpcion(opcion, catalogo);
        } while (opcion != 8);
    }
    /*------------------------------------------------------------------------*/
    // Funciones del menú:
    public static int menu() {
        int opcion = 0;
        
        System.out.println("-------------MENU-------------");
        System.out.println("1. \tAlta de canción");
        System.out.println("2. \tAlta de videojuego");
        System.out.println("3. \tBaja de canción");
        System.out.println("4. \tBaja de videojuego");
        System.out.println("5. \tMostrar catálogo completo");
        System.out.println("6. \tLista de canciones");
        System.out.println("7. \tLista de videojuegos");
        System.out.println("8. \tSalir");
        System.out.println("------------------------------");
        
        InputStreamReader stream = new InputStreamReader(System.in);
        BufferedReader teclado = new BufferedReader(stream);
        
        do {
            try {
                opcion = Integer.parseInt(teclado.readLine());
            }
            catch (IOException e) {
                System.out.println("\n\tError en la entrada de datos.");
                opcion = 0;
            }
            catch (NumberFormatException e) {
                System.out.println("\n\tError: Se han introducido caracteres no válidos.");
                opcion = 0;
            }
        } while (opcion < 1 || opcion > 8);
        
        return opcion;
    }
    
    public static void ejecutarOpcion(int opcion, Catalogo catalogo) {
        switch (opcion) {
            case 1: {
                try {altaCancion(catalogo);}
                catch (Errores e) {e.catLleno();}
                break;
            }
            case 2: {
                try {altaJuego(catalogo);}
                catch (Errores e) {e.catLleno();}
                break;
            }
            case 3: {
                try {bajaCancion(catalogo);}
                catch (Errores e) {e.catVacio();}
                break;
            }
            case 4: {
                try {bajaJuego(catalogo);}
                catch (Errores e) {e.catVacio();}
                break;
            }
            case 5: {
                mostrarCatalogo(catalogo);
                break;
            }
            case 6: {
                mostrarCanciones(catalogo.getCanciones());
                break;
            }
            case 7: {
                mostrarJuegos(catalogo.getVideojuegos());
                break;
            }
        }
    }
    
    /*------------------------------------------------------------------------*/
    // Funciones relacionadas con los videojuegos:
    public static void altaJuego(Catalogo catalogo) throws Errores {
        Errores error = new Errores();
        
        if (!checkLleno(catalogo)) {
            int i, j;
            Videojuego juegos[] = catalogo.getVideojuegos(); // Para poder modificar 
                                                             // el array desde esta función.
            Videojuego juego;
            
            // Inicializamos el juego que vamos a insertar:
            juego = new Videojuego();
            
            // Buscamos el lugar en el que hay que meter el juego.
            for (i = 0; i < juegos.length; i++) {
                // Si es el primer dato
                if (juegos[i] == null && i == 0) {
                    juegos[i] = juego;
                    break;
                }
                    
                // Tenemos una función de Fecha para pasarla a int, representando
                // este número la cantidad de días desde el 1/1/1 hasta esa fecha.
                // Como vamos a ordenar los videojuegos por fecha, de más nuevo a
                // más antiguo, vamos a comparar este número.
                else if (Fecha.toInt(juegos[i].getFechaLanz()) < Fecha.toInt(juego.getFechaLanz()))
                {
                    // Iteramos desde el final hasta la posición inmediatamente
                    // superior a i.
                    for (j = juegos.length - 1; j > i; j--)
                    {
                        // Si el elemento en una posición inferior a la actual está
                        // vacío, no hay que hacer ningún cambio.
                        if (juegos[j - 1] == null)
                            continue;
                        // Si estamos en el último elemento, que está vacío porque
                        // si no la función checkLleno no habría dejado entrar
                        // en este código, solo hay que desplazar el de abajo hacia a arriba.
                        else if (j == 99) {
                            juegos[j] = juegos[j-1];
                        }
                        // Si j no es 99, y el juego de la posición inferior
                        // no está vacía, significa que hay que hacer un cambio.
                        // El cambio es subir el actual una posición, y el siguiente
                        // subirlo a la posición del actual. Así no se pierde información.
                        else {
                            juegos[j+1] = juegos[j];
                            juegos[j] = juegos[j-1];
                        }
                    }
                    // Después de desplazarlo todo hacia arriba, podemos introducir
                    // el nuevo dato sin perder información.
                    juegos[i] = juego;
                }
            }
        }
        else 
            throw error;
    }
    
    public static void bajaJuego(Catalogo catalogo) throws Errores {
        Errores error = new Errores();
        
        if (!checkVacio(catalogo)) {
            int i, j;
            String tituloElim = new String();
            boolean ejec;
            Videojuego juegos[] = catalogo.getVideojuegos(); // Para poder modificar 
                                                             // el array desde esta función.
            
            // Pedir el título del juego a eliminar.
            InputStreamReader stream = new InputStreamReader(System.in);
            BufferedReader teclado = new BufferedReader(stream);
            
            do {
                try {
                    ejec = false;
                    System.out.println("\nIntroduzca el título del juego a eliminar:");
                    tituloElim = teclado.readLine();

                    if (tituloElim.length() > 40 || tituloElim.isEmpty())
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
            
            // Buscamos la posición de la canción a eliminar.
            for (i = 0; i < juegos.length; i++)
                // Comprobamos si los títulos coinciden.
                if (juegos[i] != null && juegos[i].getTitulo().toLowerCase().equals(tituloElim.toLowerCase()))
                {
                    // Iteramos desde el final hasta la posición inmediatamente
                    // superior a i.
                    for (j = i + 1; j < juegos.length; j++)
                    {
                        // Si el elemento en una posición superior a la actual está
                        // vacío, significa que j y j-1 son el mismo objeto, y hemos
                        // terminado de bajar posiciones. Entonces vaciamos j, y 
                        // salimos del bucle.
                        if (juegos[j+1] == null) {
                            juegos[j-1] = juegos[j];
                            juegos[j] = null;
                            break;
                        }
                        // Si estamos en el último elemento, este se va a quedar
                        // vacío, puesto que estamos bajando las posiciones de todos
                        // los elementos.
                        else if (j == 99) {
                            juegos[j-1] = juegos[j];
                            juegos[j].finalize();
                        }
                        // Si j no es 99, y la canción de la posición superior
                        // no está vacía, significa que hay que hacer un cambio.
                        // El cambio es bajar el actual una posición, y el siguiente
                        // bajarlo a la posición del actual. Así se sustituye
                        // la información de la canción que queremos eliminar.
                        else {
                            juegos[j-1] = juegos[j];
                            juegos[j] = juegos[j+1];
                        }
                    }
                }
        }
        else 
            throw error;
    }
    
    public static void mostrarJuegos(Videojuego[] videojuegos) {
        int i;
        
        for (i = 0; i < videojuegos.length; i++) {
            if (videojuegos[i] != null) {
                System.out.println("\nVideojuego " + (i+1) + ":");
                videojuegos[i].mostrarDatos();
            }
        }
    }
    
    // Funciones relacionadas con las canciones:
    public static void altaCancion(Catalogo catalogo) throws Errores {
        Errores error = new Errores();
        if (!checkLleno(catalogo)) {
            int i, j;
            Cancion[] canciones = catalogo.getCanciones(); // Para poder modificar 
                                                        // el array desde esta función.
            Cancion cancion;
            
            // Inicializamos la cancion que vamos a insertar:
            cancion = new Cancion();
            
            // Buscamos el lugar en el que hay que meter la canción.
            for (i = 0; i < canciones.length; i++) {
                // Si es el primer dato
                if (canciones[i] == null && i == 0) {
                    canciones[i] = cancion;
                    break;
                }
                
                // Si la inicial del título de la canción del vector que estamos
                // comprobando está después en el abecedario que la inicial del título
                // de la canción que vamos a dar de alta, vamos a desplazar todas
                // las demás canciones del vector hacia arriba, hasta que lleguemos
                // a una que está vacía (no habría necesidad de seguir desplazando).
                else if (canciones[i].getTitulo().charAt(0) > cancion.getTitulo().charAt(0))
                {
                    // Iteramos desde el final hasta la posición inmediatamente
                    // superior a i.
                    for (j = canciones.length - 1; j > i; j--)
                    {
                        // Si el elemento en una posición inferior a la actual está
                        // vacío, no hay que hacer ningún cambio.
                        if (canciones[j - 1] == null)
                            continue;
                        // Si estamos en el último elemento, que está vacío porque
                        // si no la función checkLleno no habría dejado entrar
                        // en este código, solo hay que desplazar el de abajo hacia a arriba.
                        else if (j == 99) {
                            canciones[j] = canciones[j-1];
                        }
                        // Si j no es 99, y la canción de la posición inferior
                        // no está vacía, significa que hay que hacer un cambio.
                        // El cambio es subir el actual una posición, y el siguiente
                        // subirlo a la posición del actual. Así no se pierde información.
                        else {
                            canciones[j+1] = canciones[j];
                            canciones[j] = canciones[j-1];
                        }
                    }
                    // Después de desplazarlo todo hacia arriba, podemos introducir
                    // el nuevo dato sin perder información.
                    canciones[i] = cancion;
                }
            }
        }
        else 
            throw error;
    }
    
    public static void bajaCancion(Catalogo catalogo) throws Errores {
        Errores error = new Errores();
        
        if (!checkVacio(catalogo)) {
            int i, j;
            String tituloElim = new String();
            boolean ejec;
            Cancion[] canciones = catalogo.getCanciones(); // Para poder modificar 
                                                        // el array desde esta función.
            
            // Pedir el título de la canción a eliminar.
            InputStreamReader stream = new InputStreamReader(System.in);
            BufferedReader teclado = new BufferedReader(stream);
            
            do {
                try {
                    ejec = false;
                    System.out.println("\nIntroduzca el título de la canción a eliminar:");
                    tituloElim = teclado.readLine();

                    if (tituloElim.length() > 40 || tituloElim.isEmpty())
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
            
            // Buscamos la posición de la canción a eliminar.
            for (i = 0; i < canciones.length; i++)
                // Comprobamos si los títulos coinciden.
                if (canciones[i] != null && canciones[i].getTitulo().toLowerCase().equals(tituloElim.toLowerCase()))
                {
                    // Iteramos desde el final hasta la posición inmediatamente
                    // superior a i.
                    for (j = i + 1; j < canciones.length; j++)
                    {
                        // Si el elemento en una posición superior a la actual está
                        // vacío, hemos terminado de bajar posiciones. Entonces 
                        // vaciamos j, y salimos del bucle.
                        if (canciones[j+1] == null) {
                            canciones[j-1] = canciones[j];
                            canciones[j] = null;
                            break;
                        }
                        // Si estamos en el último elemento, este se va a quedar
                        // vacío, puesto que estamos bajando las posiciones de todos
                        // los elementos.
                        else if (j == 99) {
                            canciones[j-1] = canciones[j];
                            canciones[j].finalize();
                        }
                        // Si j no es 99, y la canción de la posición superior
                        // no está vacía, significa que hay que hacer un cambio.
                        // El cambio es bajar el actual una posición, y el siguiente
                        // bajarlo a la posición del actual. Así se sustituye
                        // la información de la canción que queremos eliminar.
                        else {
                            canciones[j-1] = canciones[j];
                            canciones[j] = canciones[j+1];
                        }
                    }
                }
        }
        else 
            throw error;
    }
    
    public static void mostrarCanciones(Cancion[] canciones) {
        int i;
        
        for (i = 0; i < canciones.length; i++) {
            if (canciones[i] != null) {
                System.out.println("\nCancion " + (i+1) + ":");
                canciones[i].mostrarDatos();
            }
        }
    }
    
    /*------------------------------------------------------------------------*/
    // Funciones del catálogo:
    public static void mostrarCatalogo(Catalogo catalogo) {
        System.out.println("\n----Canciones del catalogo----");
        mostrarCanciones(catalogo.getCanciones());
        System.out.println("\n----Videojuegos del catalogo----");
        mostrarJuegos(catalogo.getVideojuegos());
    }
    
    /*------------------------------------------------------------------------*/
    // Funciones de utilidades:
    
    // Función para comprobar que el catálogo no está lleno.
    public static boolean checkLleno(Catalogo catalogo) {
        // Devuelve true si está lleno.
        int i, contador = 0;
        boolean lleno = false; // Por defecto no está lleno.
        
        for (i = 0; i < catalogo.getTamCat(); i++)
        {
            // Si encontramos un videojuego o una canción que tiene un título:
            // Hay que separarlos porque si en un mismo índice hay tanto una canción
            // como un videojuego, hay que aumentar el contador dos veces.
            if (catalogo.getVideojuegos()[i] != null)
                contador++;
            if (catalogo.getCanciones()[i] != null)
                contador++;
        }
        
        // Comprobar si está lleno.
        if (contador == catalogo.getTamCat())
            lleno = true;
        
        return lleno;
    }
    
    // Función para comprobar si el catálogo está vacío.
    public static boolean checkVacio(Catalogo catalogo) {
        // Devuelve true si está lleno.
        int i, contador = 0;
        boolean vacio = true; // Por defecto está vacío.
        
        for (i = 0; i < catalogo.getTamCat(); i++)
        {
            // Si encontramos un videojuego o una canción que tiene un título:
            // Hay que separarlos porque si en un mismo índice hay tanto una canción
            // como un videojuego, hay que aumentar el contador dos veces.
            if (catalogo.getVideojuegos()[i] != null)
                contador++;
            if (catalogo.getCanciones()[i] != null)
                contador++;
        }
        
        // Comprobar si está vacío.
        if (contador != 0)
            vacio = false;
        
        return vacio;
    }
}