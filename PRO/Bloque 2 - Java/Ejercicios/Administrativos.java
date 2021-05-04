public class Administrativos extends Personas{
    private String estudios;
    private int num_ordenador;
    Administrativos () {
        System.out.println("\nIntroduce los estudios del administrativo: ");
        set_estudios(Leer.dato());
        System.out.println("\nIntroduce el numero de ordenador del administrativo: ");
        set_num_ordenador(Leer.datoInt());
    }
    void set_estudios(String e) {
        estudios = e;
    }
    void set_num_ordenador (int n){
        num_ordenador = n;
    }
    void visualizar_todos_datos(){
        super.visualizar_todos_datos();
        System.out.println("\nEstudios: " + estudios);
        System.out.println("\nNumero de ordenador: " + num_ordenador);
    }
}