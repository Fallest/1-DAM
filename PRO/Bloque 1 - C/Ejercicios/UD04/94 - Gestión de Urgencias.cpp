// AUTOR: JOSÉ MARÍA RUIZ GARRIDO

/*
En un hospital se desea gestionar el servicio de urgencias. 
Para ello, hacer un programa que permita: 
• Dar de alta a las personas que llegan a una consulta. 
  Se pedirá el nombre, el número de la SS (10 números) 
  y el estado (que podrá ser leve, medio, grave y muy grave). 
• Seleccionar la siguiente persona para ser atendida. 
  El programa elegirá a la que tenga el estado más grave, 
  y en caso de empate a la que haya llegado antes. 
  El nombre de la persona elegida será mostrado en pantalla 
  y ésta será eliminada pues ya ha sido atendida. 
• Listar los nombres, nº de la SS y prioridades 
  de todas las personas que están esperando. 

Realizar un programa que gestione el hospital, con el siguiente menú: 
1. Alta de paciente. 
2. Seleccionar paciente a atender. 
3. Listado de pacientes. 
4. Salir. 
El número máximo de pacientes que el programa admite es de 50. 

*NOTAS:
Estado: codificar Leve/Medio/Grave/Muy Grave - 1/2/3/4
Pedir estado : 1 - Leve 2 - Medio ....
Listado: decodificar estado y mostrar texto, no el número.
Alta secuencial, por el final/derecha.
Baja/atendido: eliminar y desplazar el resto a la izquierda.
*/

#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#define NUM_SS 11

// TIPOS DE DATOS
typedef struct
{
	char ss [NUM_SS];
	char nombre [31];
	int estado;
} datospaciente;

typedef struct nodo
{
	datospaciente paciente;
	struct nodo * sig;
} nodopaciente;

// PROTOTIPOS
void mostrar_menu();
void leer_opcion (int *op);
void tratar_opcion (nodopaciente **urgencias, int opcion);
void mostrar_paciente (nodopaciente *urgencias);
void listado_pacientes (nodopaciente *urgencias);
void leer_ss (char ss[]);
void pedir_nombre (char nombre[]);
int pedir_estado ();
nodopaciente * buscar_paciente (char ss[], nodopaciente *urgencias);
void alta_paciente (nodopaciente **urgencias);
void seleccionar_paciente (nodopaciente **urgencias);
void eliminar_paciente (nodopaciente **urgencias, nodopaciente *posicion);

// FUNCIONES
void leer_ss (char ss[])
// Introduccion de datos, sin validacion.
{
	printf("\nIntroduzca el numero de la Seguridad Social del paciente: ");
	scanf("%s", ss);
	fflush(stdin);
}

void pedir_nombre (char nombre[])
// Introduccion de datos, sin validacion.
{
	printf("Introduzca el nombre del paciente: ");
	gets (nombre);
	fflush(stdin);
}

int pedir_estado ()
// Introduccion de datos, con validacion.
{
	int estado;
	do{
		printf("Estado del paciente (1: leve | 2: medio | 3: grave | 4: muy grave): ");
		scanf("%d", &estado);
		fflush(stdin);
	}while (estado < 1 || estado > 4); // Validamos el dato entre 1 y 4.
	return estado;
}

nodopaciente * buscar_paciente (char ss[], nodopaciente *urgencias)
// Devuelve el puntero al nodo indicado si se encuentra, o NULL si no se encuentra.
{
	while (urgencias != NULL)
	{
		if (strcmp(urgencias->paciente.ss, ss) == 0)
			return urgencias;
		urgencias = urgencias -> sig;
	}
	return NULL;
}

void alta_paciente (nodopaciente **urgencias)
// Funcion para añadir un nuevo paciente en la posicion 'contador' del registro
{
	char ss[NUM_SS]; // Variable cadena para el numero de SS, para buscar duplicados o añadir al registro.
	nodopaciente *entrada; // Nuevo nodo a añadir.

	leer_ss (ss); // pedir el numero de la SS.

	entrada = buscar_paciente (ss, *urgencias); // Comprobamos si el paciente indicado está ya en espera (return 1).
	if (entrada != NULL)  
	{
		printf("\nEl paciente ya se encuentra en la lista de espera.\n\n");
	}
	else // No está en la lista (return NULL).
	{
		entrada = (nodopaciente *) malloc (sizeof(nodopaciente));
		strcpy(entrada -> paciente.ss, ss); // copiamos SS en el campo SS del paciente.
		pedir_nombre (entrada->paciente.nombre); // pedimos nombre y lo copiamos en el campo nombre.
		entrada->paciente.estado = pedir_estado(); // pedimos estado y lo copiamos en el campo estado.
		entrada->sig = NULL;

		if ((*urgencias) == NULL) // Si la lista está vacía
			(*urgencias) = entrada; // insertamos al principio.
		else // si tiene nosodos
		{
			nodopaciente *aux = (*urgencias);
			while (aux->sig != NULL)
				aux = aux->sig;
			aux->sig = entrada; // insertamos al final.
		}	
		printf("\nPaciente agregado a la lista de espera.\n\n"); // informamos del éxito de la operacion.
	}

	system("PAUSE");
	system("CLS");
}

void eliminar_paciente (nodopaciente **urgencias, nodopaciente *posicion)
// funcion para eliminar el nodo paciente de la lista
{
	nodopaciente *aux;
	aux = (*urgencias);
	
	if (posicion == (*urgencias)) // Si posicion en el primer nodo
	{
		(*urgencias) = (*urgencias)->sig;
	}else
	{
		while (aux->sig != posicion) //recorro la lista hasta el anterior a posicion
			aux = aux->sig;
		aux->sig = posicion->sig;
	}
	free(posicion);
}

void seleccionar_paciente (nodopaciente **urgencias)
// Busca el primer nodo paciente con el campo 'estado' de mayor valor.
{
	nodopaciente *posicion;
	nodopaciente *paux = *urgencias;
	int mayor = 0;

	if ((*urgencias) == NULL) // Si la lista está vacía 
		printf("\nNo hay pacientes en lista de espera.\n");		
	else
	{
		while (paux != NULL)
		{
			if (paux->paciente.estado > mayor)
			{
				mayor = paux->paciente.estado;
				posicion = paux;
			}
			paux = paux->sig;
		}
		printf("\nSiguiente paciente: \n"); // Mostramos en pantalla el resultado.
		mostrar_paciente(posicion);
		eliminar_paciente(urgencias, posicion); // Eliminamos el paciente del nodo posicion de la lista.
	}
	printf("\n");
	system("PAUSE");
	system("CLS");
}

void mostrar_paciente (nodopaciente *urgencias)
// Funcion para mostrar el nodopaciente urgencias.
{
	// mostramos los campos SS y nombre.
	printf("n.SS: %s - Nombre: %s - Estado: ", strupr(urgencias->paciente.ss), strupr(urgencias->paciente.nombre));
	switch (urgencias->paciente.estado) // y descodifocamos el campo ESTADO (1/2/3/4)
	{
		case 1: 
			printf("LEVE\n");
			break;
		case 2: 
			printf("MEDIO\n");
			break;
		case 3: 
			printf("GRAVE\n");
			break;
		case 4: 
			printf("MUY GRAVE\n");
	}
}

void listado_pacientes (nodopaciente *urgencias)
// Muestra en pantalla los registros de urgencias hasta que encuentre NULL.
{
	if (urgencias == NULL) // Si la lista está vacía
	{
		printf("\nNo hay pacientes en lista de espera.\n");
	}
	else{
		printf("\nPACIENTES EN LISTA DE ESPERA\n");
		printf("--------------------------------\n");
		while (urgencias != NULL)
		{
			mostrar_paciente(urgencias); // mostramos los pacientes.
			urgencias = urgencias -> sig;		
		}
	}
	printf("\n");
	system("PAUSE");
	system("CLS");
}

void mostrar_menu()
{
	printf("\nMENU PRINCIPAL\n--------------\n");
	printf("1.- Alta de paciente.\n");
	printf("2.- Seleccionar paciente a atender.\n");
	printf("3.- Listado de pacientes.\n");
	printf("4.- Salir.\n\n");
}

void leer_opcion (int *op)
{
	do{
		printf("Introduzca opcion: ");
		scanf("%d", op);
		fflush(stdin);
	}while ((*op) < 1 || (*op) > 4);
}

void tratar_opcion (nodopaciente **urgencias, int opcion)
// Lanza las funciones. Recive opcion. No devuelve nada. Envía registro y contador
{
	switch (opcion)
	{
		case 1: alta_paciente (urgencias);
				break;
		case 2: seleccionar_paciente (urgencias);
			    break;
		case 3: listado_pacientes (*urgencias);
	}
}

void main()
// PROGRAMA PRINCIPAL
{
	nodopaciente * urgencias = NULL; // Variable lista tipo NODO,
	
	int opcion; // opcion a tratar del menu.

	do{
		mostrar_menu();
		leer_opcion (&opcion);
		tratar_opcion (&urgencias, opcion);
	}while(opcion != 4); // Validacion de opcion.
	printf("\n--------------------------------\n");
	// destruir_lista(&nodo);
}
