package Principal;

import Catalogos.*;
import Objetos.*;
import Errores.Errores;
import java.io.*;
import java.util.*;

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
                darAlta((ArrayList) catalogo.getCanciones());
                break;
            }
            case 2: {
                darAlta((ArrayList) catalogo.getVideojuegos());
                break;
            }
            case 3: {
                try {darBaja((ArrayList) catalogo.getVideojuegos());}
                catch (Errores e) {e.catVacio();}
                break;
            }
            case 4: {
                try {darBaja((ArrayList) catalogo.getCanciones());}
                catch (Errores e) {e.catVacio();}
                break;
            }
            case 5: {
                mostrarCatalogo(catalogo);
                break;
            }
            case 6: {
                mostrarDatos((ArrayList) catalogo.getCanciones());
                break;
            }
            case 7: {
                mostrarDatos((ArrayList) catalogo.getVideojuegos());
                break;
            }
        }
    }
    
    public static void darAlta(ArrayList lista) {
        if (lista.get(0) instanceof Videojuego) {
            // Código para insertar un videojuego
            insertarVideojuego(lista);
        }
        else if (lista.get(0) instanceof Cancion) {
            // Código para insertar una canción
            insertarCancion(lista);
        }
    }
    
    public static void darBaja(ArrayList lista) throws Errores {
        Errores error = new Errores();
        
        // No se puede eliminar un objeto si la lista está vacía
        if (lista.get(0) == null)
            throw error;
        
        else if (lista.get(0) instanceof Videojuego) {
            // Código para eliminar un videojuego
            eliminarVideojuego(lista);
        }
        else if (lista.get(0) instanceof Cancion) {
            // Código para eliminar una canción
            eliminarCancion(lista);
        }
    }
    
    /*------------------------------------------------------------------------*/
    public static void insertarVideojuego(ArrayList<Videojuego> lista) {    
        // Inicializamos el juego que vamos a insertar:
        juego = new Videojuego();

        // Si es el primer dato
        if (juegos[0] == null) {
            juegos[0] = juego;
        }

        /*
        Vamos a buscar la posición en la que vamos a meter el juego.
        Para ello vamos a hacer una iteracíon inversa a la lista, para
        ir moviendo hacia arriba todos los juegos que estuvieran dentro
        que tienen una fecha anterior al que vamos a insertar.
        */
        else 
        {
            // Iteramos desde el final hasta la posición inmediatamente
            // superior a 0.
            for (j = juegos.length - 1; j >= 0; j--)
            {
                if (j == 0) {
                    juegos[j] = juego;
                    break;
                }
                // Si el elemento en una posición inferior a la actual está
                // vacío, no hay que hacer ningún cambio.
                else if (juegos[j-1] == null)
                    continue;

                // Si nos encontramos que la posición inferior no está vacía,
                // tenemos que comprobar si vamos a meter ahí el juego o no.
                else if (juegos[j-1] != null) {
                    // Tenemos que comprobar si estamos en el último elemento,
                    // para no salirnos de los límites de la lista.
                    if (j == juegos.length - 1) {
                        if (Fecha.toInt(juegos[j-1].getFechaLanz()) <= Fecha.toInt(juego.getFechaLanz())) {
                            juegos[j] = juego;
                            break;
                        }
                        else
                            juegos[j] = juegos[j-1];
                    }  
                    // Si la fecha del juego de la lista es anterior
                    // a la del juego, es el lugar en el que hay
                    // que insertarlo.
                    else if (Fecha.toInt(juegos[j-1].getFechaLanz()) <= Fecha.toInt(juego.getFechaLanz())) {
                        juegos[j] = juego;
                        break;
                    }

                    // Si hay que seguir avanzando para encontrar otra juego,
                    // hay que dejar desplazadas los otros juegos para
                    // no perder datos.
                    else {
                        juegos[j+1] = juegos[j];
                        juegos[j] = juegos[j-1];
                    }                            
                }
            }
        }
    }
    
    public static void eliminarVideojuego(ArrayList<Videojuego> lista) {
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

                    if (tituloElim.length() > 40 || tituloElim.isEmpty()) {
                        throw error;
                    }
                } catch (IOException e) {
                    System.out.println("\n\tError en la entrada de datos.");
                    ejec = true;
                } catch (Errores e) {
                    e.invalidStr();
                    ejec = true;
                }
            } while (ejec);

            // Buscamos la posición de la canción a eliminar.
            for (i = 0; i < juegos.length; i++) // Comprobamos si los títulos coinciden.
            {
                if (juegos[i] != null && juegos[i].getTitulo().toLowerCase().equals(tituloElim.toLowerCase())) {
                    // Iteramos desde el final hasta la posición inmediatamente
                    // superior a i.
                    for (j = i + 1; j < juegos.length; j++) {
                        // Si el elemento en una posición superior a la actual está
                        // vacío, significa que j y j-1 son el mismo objeto, y hemos
                        // terminado de bajar posiciones. Entonces vaciamos j, y 
                        // salimos del bucle.
                        if (juegos[j + 1] == null) {
                            juegos[j - 1] = juegos[j];
                            juegos[j] = null;
                            break;
                        } // Si estamos en el último elemento, este se va a quedar
                        // vacío, puesto que estamos bajando las posiciones de todos
                        // los elementos.
                        else if (j == juegos.length) {
                            juegos[j - 1] = juegos[j];
                            juegos[j].finalize();
                        } //
                        else {
                            juegos[j - 1] = juegos[j];
                            juegos[j] = juegos[j + 1];
                        }
                    }
                }
            }
        } else {
            throw error;
        }
    }

    // Funciones relacionadas con las canciones:
    public static void insertarCancion(ArrayList<Cancion> lista) {
        Errores error = new Errores();
        int j;
        Collection canciones = catalogo.getCanciones(); // Para poder modificar 
        // el array desde esta función.
        Cancion cancion;

        // Inicializamos la cancion que vamos a insertar:
        cancion = new Cancion();

        // Si es el primer dato
        if (canciones[0] == null) {
            canciones[0] = cancion;
        } /*
        Vamos a buscar la posición en la que vamos a meter la canción.
        Para ello vamos a hacer una iteracíon inversa a la lista, para
        ir moviendo hacia arriba todas las canciones que estuvieran dentro
        que están por detrás en el abecedario que la canción que vamos a 
        insertar.
         */ else {
            // Iteramos desde el final hasta la posición inmediatamente
            // superior a 0.
            for (j = canciones.length - 1; j >= 0; j--) {
                if (j == 0) {
                    canciones[j] = cancion;
                    break;
                } // Si el elemento en una posición inferior a la actual está
                // vacío, no hay que hacer ningún cambio.
                else if (canciones[j - 1] == null) {
                    continue;
                } // Si nos encontramos que la canción inferior no está vacía,
                // tenemos que comprobar si vamos a meter ahí la canción o no.
                else if (canciones[j - 1] != null) {

                    // Tenemos que comprobar si estamos en el último elemento,
                    // para no salirnos de los límites de la lista.
                    if (j == canciones.length - 1) {
                        if (canciones[j - 1].getTitulo().toLowerCase().charAt(0) <= cancion.getTitulo().toLowerCase().charAt(0)) {
                            canciones[j] = cancion;
                            break;
                        } else {
                            canciones[j] = canciones[j - 1];
                        }
                    } // Si la inicial de la canción de la lista es anterior
                    // a la de la canción, es el lugar en el que hay
                    // que meter la canción.
                    else if (canciones[j - 1].getTitulo().toLowerCase().charAt(0) <= cancion.getTitulo().toLowerCase().charAt(0)) {
                        canciones[j] = cancion;
                        break;
                    } // Si hay que seguir avanzando para encontrar otra canción,
                    // hay que dejar desplazadas las otras canciones para
                    // no perder datos.
                    else {
                        canciones[j + 1] = canciones[j];
                        canciones[j] = canciones[j - 1];
                    }
                }
            }
        }

    }

    public static void eliminarCancion(ArrayList<Cancion> lista) {
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

                    if (tituloElim.length() > 40 || tituloElim.isEmpty()) {
                        throw error;
                    }
                } catch (IOException e) {
                    System.out.println("\n\tError en la entrada de datos.");
                    ejec = true;
                } catch (Errores e) {
                    e.invalidStr();
                    ejec = true;
                }
            } while (ejec);

            // Buscamos la posición de la canción a eliminar.
            for (i = 0; i < canciones.length; i++) // Comprobamos si los títulos coinciden.
            {
                if (canciones[i] != null && canciones[i].getTitulo().toLowerCase().equals(tituloElim.toLowerCase())) {
                    // Iteramos desde el final hasta la posición inmediatamente
                    // superior a i.
                    for (j = i + 1; j < canciones.length; j++) {
                        // Si el elemento en una posición superior a la actual está
                        // vacío, hemos terminado de bajar posiciones. Entonces 
                        // vaciamos j, y salimos del bucle.
                        if (canciones[j + 1] == null) {
                            canciones[j - 1] = canciones[j];
                            canciones[j] = null;
                            break;
                        } // Si estamos en el último elemento, este se va a quedar
                        // vacío, puesto que estamos bajando las posiciones de todos
                        // los elementos.
                        else if (j == canciones.length) {
                            canciones[j - 1] = canciones[j];
                            canciones[j].finalize();
                            break;
                        } // Si j no es 99, y la canción de la posición superior
                        // no está vacía, significa que hay que hacer un cambio.
                        // El cambio es bajar el actual una posición, y el siguiente
                        // bajarlo a la posición del actual. Así se sustituye
                        // la información de la canción que queremos eliminar.
                        else {
                            canciones[j - 1] = canciones[j];
                            canciones[j] = canciones[j + 1];
                        }
                    }
                }
            }
        } else {
            throw error;
        }
    }

    
    // Funciones para mostrar datos del catálogo:
    public static void mostrarDatos(ArrayList lista) {
        if (lista.get(0) instanceof Videojuego) {
            Catalogo catAux = new Catalogo();
            catAux.setCatVideojuegos(lista);
            catAux.mostrarVideojuegos();
        }
        else if (lista.get(0) instanceof Cancion) {
            Catalogo catAux = new Catalogo();
            catAux.setCatCanciones(lista);
            catAux.mostrarCanciones();
        }
    }

    public static void mostrarCatalogo(Catalogo catalogo) {
        catalogo.mostrarDatos();
    }
}