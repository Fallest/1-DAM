public class Principal
{
    public static void main(String args[])
    {
        int administrativos;
        int personas;
        int maquinistas;
        int b;
        System.out.println("\nIntroduce el sueldo: ");
        Personas.set_sueldo(Leer.datoInt());
        System.out.println("\nIntroduce el numero de maquinistas: ");
        maquinistas = Leer.datoInt();
        System.out.println("\nIntroduce el numero de administrativos: ");
        administrativos = Leer.datoInt();
        System.out.println("\nIntroduce el numero de otros trabajadores: ");
        personas = Leer.datoInt();


        Maquinistas m[] = new Maquinistas[maquinistas];
        for(b = 0; b < maquinistas; b++)
        {	
            m[b] = new Maquinistas();
        }
        
        Administrativos a[] = new Administrativos[administrativos];
        for(b = 0; b < administrativos; b++)
        {	
            a[b] = new Administrativos();
        }

        Personas p[] = new Personas[personas];
        for(b = 0; b < personas; b++)
        {	
            p[b] = new Personas();
        }
        visualizar_datos(m);
        visualizar_datos(a);
        visualizar_datos(p);
        calcular_media(m);
        calcular_media(a);
        calcular_media(p);
    }
    
    public static void visualizar_datos(Personas p[])
    {
        if (p[0] instanceof Maquinistas)
        {
            System.out.println("\n\n--- Maquinistas ---");
        }
        else if (p[0] instanceof Administrativos)
        {
            System.out.println("\n\n--- Administrativos ---");
        }
        else
        {
            System.out.println("\n\n--- Sin grupo ---");
        }
        for(int b = 0; b < p.length; b++)
        {
          p[b].visualizar_todos_datos();
          System.out.println("\n");
        }
    }
    
    public static void calcular_media(Personas p[])
    {
        int edad = 0;
        for(int b = 0; b < p.length; b++)
        {
          edad = p[b].get_edad() + edad;
        }
        if (p[0] instanceof Maquinistas)
        {
            System.out.println("\n\n--- Maquinistas ---");
        }
        else if (p[0] instanceof Administrativos)
        {
            System.out.println("\n\n--- Administrativos ---");
        }
        else
        {
            System.out.println("\n\n--- Sin grupo ---");
        }
        System.out.println("\nLa edad media es de: " + ((float)edad / p.length));
    }
}