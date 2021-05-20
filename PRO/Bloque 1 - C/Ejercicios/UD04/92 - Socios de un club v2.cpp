/*

El programa va a mantener una lista de socios de un club.

  De cada socio se guardara su numero de socio, su nombre y si es vip.

  El usuario dara de alta todos los socios que quiera.

  Finalmente el programa mostrara un listado.

  Versión modular.
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


// TIPOS DE DATOS




// PROTOTIPOS
// FUNCIONES
void pedir_codigo (int *c)
{
	printf("Introduzca el codigo de socio: ");
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

int preguntar_seguir()
{
	int seguir;

	printf("Desea grabar otro socio (1 = si, 0 = no)?: ");
	scanf("%d", &seguir);
	fflush(stdin);

	return seguir;
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
		printf("Vamos a eliminar a %s\n", paux -> datossocio.nombre);
		free (paux);
		paux = lista;
	}
	
	printf("\nHemos destruido la lista.\n\n");
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
	int seguir;

	do{
		// Reservamos espacio para el nuevo nodo:
		paux = (nodoSocio *) malloc (sizeof(nodoSocio));

		// Asignamos valores a los campos de datos del nodo:
		pedir_codigo (&(paux -> datossocio.numero));
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

		// Preguntar al usuario si desea seguir grabando datos:
		seguir = preguntar_seguir();
	}while(seguir == 1);
}


/* ******************************************************************************
*********************************************************************************
                             PROGRAMA PRINCIPAL
*********************************************************************************
****************************************************************************** */

void main()
{
	nodoSocio *lista = NULL;
	nodoSocio *paux;

	// Alta de socios: Inserción por el final
	alta_socio (&lista, &paux);

	// Listado de socios:
	listado_socios (lista);

	// Destruccion de la estructura:
	destruir_estructura (lista);
}