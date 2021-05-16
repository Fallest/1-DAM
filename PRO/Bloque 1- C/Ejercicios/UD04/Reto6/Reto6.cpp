#include <stdlib.h>
#include <string.h>

/*
Estructuras:
	-L�nea: N�mero de tel�fono, descripci�n y registro de llamadas.
	-Llamada: Fecha (d�a, mes, a�o), hora de inicio (hora y minutos),
	duraci�n de la llamada en minutos.
*/

typedef struct {
	int dia;
	int mes;
	int anyo;
} Fecha;

typedef struct {
	int hora;
	int min;
} Hora;

typedef struct {
	Fecha fecha;
	Hora horaIni;
	int duracion;
} Llamada;

typedef struct {
	int numTlf;
	char descrip[40];
	Llamada registroLlamadas[];
} Linea;

// Prototipos:
void mostrarMenu();
void leerOpcion();
void ejecOpcion();

void altaLinea(Linea lineas[]);

void altaLlamada(Linea lineas[]);
char preguntar();
void pedirFecha();
void pedirHoraIni();
void pedirDuracion();

void listadoFact(Linea Lineas[]);
float calcularFactura(Llamada registroLlamadas[]);

void cancelarLinea(Linea lineas[]);

int pedirNumero();
char comprobarNumero();

/*---------------------------------------------------------*/// 0/1
// Main
void main() {
	
}

/*---------------------------------------------------------*/// 0/3
// Funciones de men�
void mostrarMenu() {}
void leerOpcion() {}
void ejecopcion() {}

/*---------------------------------------------------------*/// 0/1
// Alta de l�nea
void altaLinea() {}

/*---------------------------------------------------------*/// 0/5
// Alta de llamada
void altaLlamada() {}
char preguntar() {}
void pedirFecha() {}
void pedirHoraIni() {}
void pedirDuracion() {}

/*---------------------------------------------------------*/// 0/2
// Listado de facturaci�n
void listadoFact() {}
float calcularFactura() {}

/*---------------------------------------------------------*/// 0/2
// Cancelar l�nea
void cancelarLinea() {}

// Funciones de utilidades
int pedirNumero() {}
char comprobarNumero() {}