package ProyectoJavaUD06;

public class Fecha {
    // Atributos
    private int dia;
    private int mes;
    private int año;
    
    Fecha (int dia, int mes, int año) throws Errores {
        Errores error = new Errores();
        
        if (!checkFecha(dia, mes, año))
            throw error; // No hace falta hacer try catch aquí, puesto que se
                         // propaga a la función que llama a este constructor.
        else {
            this.dia = dia;
            this.mes = mes;
            this.año = año;
        }
    }
    
    // Setters:
    public void setDia(int dia) throws Errores {
        Errores error = new Errores();
        
        if (!checkFecha(dia, this.mes, this.año))
            throw error;
        else
            this.dia = dia;
    }
    
    public void setMes(int mes) throws Errores {
        Errores error = new Errores();
        
        if (!checkFecha(this.dia, mes, this.año))
            throw error;
        else
            this.mes = mes;
    }

    public void setAño(int año) throws Errores {
        Errores error = new Errores();
        
        if (!checkFecha(dia, this.mes, año))
            throw error;
        else
            this.año = año;
    }
    
    // Getters:
    public int getDia() {
        return this.dia;
    }
    
    public int getMes() {
        return this.mes;
    }

    public int getAño() {
        return this.año;
    }

    // Checkers:
    //      (sé que no los hemos dado, pero uso el concepto porque es para el control 
    //      de errores de fechas).
    private boolean checkFecha(int dia, int mes, int año) {
        // Va a devolver false si la fecha no es válida.
        boolean esValido = true;
        
        // Comprobación básica de los días, meses y años.
        if ((dia < 1 || dia > 31) || (mes < 1 || mes > 12) || (año < 1 || año > 2021))
            esValido = false;
        
        // Tratamiento de años bisiestos (solo febrero).
        switch (año % 4) {
            case 0: {
                if (mes == 2 && dia > 29)
                    esValido = false;
                break;
            }
            default: {
                if (mes == 2 && dia > 28)
                    esValido = false;
                break;
            }
        }
        
        // Tratamiento del resto de meses.
        if ((mes == 4 || mes == 6 || mes == 9 || mes == 11) && dia > 30)
            esValido = false;
        
        return esValido;
    }
}