/*
VERSION 3
  El programa va a mantener una lista de socios de un club.

  De cada socio se guardara su numero de socio, su nombre y si es vip.

  El usuario dispondra de un menu de opciones:
  1) Alta de socio. El numero de socio no puede repetirse.
  2) Baja de socio. El usuario indicara el numero y el programa borrara el registro.
  3) Modificacion de socio. El usuario indicara el numero y pedira de nuevo el nombre
  y si es vip.
  4) Listado de socios.
*/


// LIBRERIAS
#include <stdio.h>
#include <string.h>
#include <stdlib.h>


// CONSTANTES


// TIPOS DE DATOS
typedef struct
{
	int numero;
	char nombre[30];
	char vip;
}socio;


typedef struct nodo
{
	socio datossocio;
	struct nodo *sig;
}nodoSocio;


// FUNCIONES
void pedir_codigo (int *c)
{
	printf("Introduzca el codigo de socio (no puede estar repetido): ");
	scanf("%d", c);
	fflush(stdin);
}

void pedir_nombre (char nombre[])
{
	printf("Introduzca el nombre de socio: ");
	gets (nombre);
	fflush(stdin);
}

void pedir_vip (char *vip)
{
	printf("Es socio vip (s/n)?: ");
	scanf("%c", vip);
	fflush(stdin);
}


void listado_socios (nodoSocio *lista)
{
	nodoSocio *paux;

	printf("\n\nLISTADO DE SOCIOS\n--------------------\n");
	paux = lista;
	while (paux != NULL)
	{
		printf("Socio: %d - %s ", paux -> datossocio.numero, paux -> datossocio.nombre);
		
		if (paux -> datossocio.vip == 's')
			printf("(VIP)\n");
		else
			printf("\n");
		
		paux = paux -> sig;
	}
}



void destruir_estructura (nodoSocio *lista)
{
	nodoSocio *paux;

	paux = lista;
	
	while (paux != NULL)
	{
		lista = lista -> sig;
		free (paux);
		paux = lista;
	}
	
	printf("\nHemos destruido la lista.\n\n");
}


int codigo_repetido (int numero, nodoSocio *lista)
{
	while (lista != NULL)
		if (lista -> datossocio.numero == numero)
			return 1;
		else
			lista = lista -> sig;

	return 0;
}


/*
El puntero al inicio de la lista se pasa a esta funcion por referencia (puntero a
puntero) porque cabe la posibilidad de que su contenido se vea alterado (concretamente
cuando la lista esta vacia). Si no se hace asi los cambios en ese puntero no son
permanentes y, por tanto, las inserciones no seran visibles en el main.
*/
void alta_socio (nodoSocio **lista)
{
	nodoSocio *paux;
	nodoSocio *buscanodo;
	int numero;

	// Reservamos espacio para el nuevo nodo:
	paux = (nodoSocio *) malloc (sizeof(nodoSocio));

	// Asignamos valores a los campos de datos del nodo:
	do{
		// El codigo de socio no puede repetirse, por eso se valida.
		pedir_codigo (&numero);
	}while(codigo_repetido (numero, *lista));
		
	paux -> datossocio.numero = numero;
		
	pedir_nombre (paux -> datossocio.nombre);
	pedir_vip (&(paux -> datossocio.vip));

	// Asignamos NULL al campo que apunta al nodo siguiente:
	paux -> sig = NULL;

	// Colocamos el nodo al final de la lista.
	// Dos casos posibles:
	// 1) Inserción al principio.
	// 2) Inserción detrás de un nodo.
		
	//Caso 1:
	if (*lista == NULL)
		*lista = paux;
	else // Caso 2:
	{
		// Buscamos el nodo que esté al final de la lista:
		buscanodo = *lista;
		while (buscanodo -> sig != NULL)
			buscanodo = buscanodo -> sig;
		buscanodo -> sig = paux;
	}

	printf("\n\nInsercion efectuada.\n\n");
}


void mostrar_menu()
{
	printf("\nMENU PRINCIPAL\n--------------\n");
	printf("1.- Alta de socio.\n");
	printf("2.- Baja de socio.\n");
	printf("3.- Modificacion de socio.\n");
	printf("4.- Listado de socios.\n");
	printf("5.- Salir.\n\n");
}


void leer_opcion (int *op)
{
	do{
		printf("Introduzca opcion: ");
		scanf ("%d", op);
		fflush(stdin);
	}while((*op) < 1 || (*op) > 5);
}

void preguntar_codigo_a_buscar (int *numero)
{
	printf("Introduzca el codigo de socio en el que desea realizar la operacion: ");
	scanf("%d", numero);
	fflush(stdin);
}


nodoSocio *buscar_numero (nodoSocio *lista, int numero)
{
	/*
	Podemos utilizar "lista" para recorrer la estructura ya que en realidad se trata
	de una copia del original y no hay peligro de perder la primera referencia.
	*/
	while (lista != NULL)
		if (lista -> datossocio.numero == numero)
			return lista;
		else
			lista = lista -> sig;
	
	return NULL;
}


void baja_socio (nodoSocio **lista)
{
	int numero;

	if ((*lista) == NULL)
	{
		printf("\n\nActualmente no hay datos de socios en la aplicacion.\n\n");
		return;
	}

	preguntar_codigo_a_buscar (&numero);

	nodoSocio *nodo_a_borrar = buscar_numero (*lista, numero);

	if (nodo_a_borrar == NULL)
		printf("\nEl codigo indicado no se encuentra en la base de datos.\n\n");
	else
	{
		// Si el nodo a borrar esta el primero de la lista:
		if ((*lista) == nodo_a_borrar)
			(*lista) = (*lista) -> sig;
		else
		{
			// Localizamos el nodo anterior al que se desea borrar:
			nodoSocio *anterior = (*lista);
			
			while (anterior -> sig != nodo_a_borrar)
				anterior = anterior -> sig;

			anterior -> sig = nodo_a_borrar -> sig;
		}
		free (nodo_a_borrar);
		printf("\n\nBorrado efectuado.\n\n");
	}

}


void modificacion_socio (nodoSocio *lista)
{
	int numero;

	if (lista == NULL)
	{
		printf("\n\nActualmente no hay datos de socios en la aplicacion.\n\n");
		return;
	}

	preguntar_codigo_a_buscar (&numero);

	nodoSocio *nodo_a_modificar = buscar_numero (lista, numero);

	if (nodo_a_modificar == NULL)
		printf("\nEl codigo indicado no se encuentra en la base de datos.\n\n");
	else
	{
		printf("Nombre actual: %s\n", nodo_a_modificar -> datossocio.nombre);
		pedir_nombre (nodo_a_modificar -> datossocio.nombre);
		printf("VIP (actualmente): %c\n", toupper(nodo_a_modificar -> datossocio.vip));
		pedir_vip (&(nodo_a_modificar -> datossocio.vip));

		printf("\n\nModificacion efectuada.\n\n");
	}
}



void tratar_opcion (int opcion, nodoSocio **lista)
{
	switch (opcion)
	{
		case 1: alta_socio (lista);
			    break;
		case 2: baja_socio (lista);
			    break;
		case 3: modificacion_socio (*lista);
			    break;
		case 4: listado_socios (*lista);
	}
}





/* ******************************************************************************
*********************************************************************************
                             PROGRAMA PRINCIPAL
*********************************************************************************
****************************************************************************** */

void main()
{
	nodoSocio *lista = NULL;
	int opcion;
	
	do{
		mostrar_menu();
		leer_opcion (&opcion);
		tratar_opcion (opcion, &lista);
	}while(opcion != 5);
	
	// Destruccion de la estructura:
	destruir_estructura (lista);
}