public class Personas {
    private String nombre;
    private static int sueldo;
    private int edad;
    Personas () {
        System.out.println("\nIntroduce el nombre de la persona: ");
        set_nombre(Leer.dato());
        System.out.println("\nIntroduce la edad de la persona: ");
        set_edad(Leer.datoInt());
    }
    void set_nombre(String n) {
        nombre = n;
    }
    static void set_sueldo(int s) {
        sueldo = s;
    }
    void set_edad (int e){
        edad = e;
    }
    int get_edad (){
        return edad;
    }
    void visualizar_todos_datos(){
        System.out.println("\nNombre: " + nombre);
        System.out.println("\nSueldo: " + sueldo);
        System.out.println("\nEdad: " + edad);
    }
    
}
