package ClaseDentroMetodo_28;

public class Clase2
{
    public void metClase2(int x, final int y)
    {
        int i = x + y;
        final int c = x + y;
        /*--------------------------------------*/
        // Clase dentro de un método
        class Clase3
        {
            // int a = x; // error: x no es final
            int b = y;

            void metClase3()
            {
                // System.out.println(b + i); // error: i no es final
                System.out.println(b + c);
            }
        }
        /*--------------------------------------*/
        // Instanciación de un objeto de dicha clase dentro del método.
        Clase3 obj = new Clase3();
        obj.metClase3();
    }
    // Clase3 obj; No se puede crear un objeto del tipo Clase3 fuera del método.
        // Puesto que dicho método es LOCAL al método.
}