public class Maquinistas extends Personas{
    private int num_maquina;
    private int anios;
    Maquinistas () {
        System.out.println("\nIntroduce el numero de la maquina del maquinista: ");
        set_num_maquina(Leer.datoInt());
        System.out.println("\nIntroduce los años que lleva trabajando en esa maquina el maquinista: ");
        set_anios(Leer.datoInt());
    }   
    void set_num_maquina (int n){
        num_maquina = n;
    }
    void set_anios (int a){
        anios = a;
    }
    void visualizar_todos_datos(){
        super.visualizar_todos_datos();
        System.out.println("\nNumero de maquina: " + num_maquina);
        System.out.println("\nAños usando la maquina: " + anios);
    }
}
