#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#define ISBN 16
#define NREGISTROS 4
#define TITULO 40

typedef struct
{
	char isbn [ISBN];
	char titulo [TITULO];
	int nejemplares;
}Libro;


typedef struct nodo
{
	Libro DatosLibro;
	struct nodo *sig;
}NodoLibro;


void mostrar_menu()
{
	printf("\nMENU PRINCIPAL\n--------------\n");
	printf("a.- Nuevo ejemplar.\n");
	printf("b.- Baja de ejemplar.\n");
	printf("c.- Listado de libros.\n");
	printf("d.- Salir.\n\n");
}


void leer_opcion (char *op)
{
	do{
		printf("Introduzca opcion: ");
		scanf("%c", op);
		fflush(stdin);
	}while ((*op) != 'a' && (*op) != 'A' && (*op) != 'b' && (*op) != 'B' && 
		(*op) != 'c' && (*op) != 'C' && (*op) != 'd' && (*op) != 'D');
}


void leer_isbn (char isbn[])
{
	printf("\nIntroduzca el isbn: ");
	scanf("%s", isbn);
	fflush(stdin);
}


void pedir_titulo (char titulo[])
{
	printf("\nIntroduzca el titulo: ");
	gets (titulo);
	fflush(stdin);
}


NodoLibro * buscar_libro (char isbn[], NodoLibro *biblioteca)
{
	// Devolver el puntero al nodo del libro indicado dentro de la lista
	// o bien NULL si no se encuentra.

	while (biblioteca != NULL)
	{
		if (strcmp(biblioteca -> DatosLibro.isbn, isbn) == 0)
			return biblioteca;

		biblioteca = biblioteca -> sig;
	}

	return NULL;
}


void alta_ejemplar (NodoLibro **biblioteca)
{
	char isbn[ISBN];
	NodoLibro *posicion;

	leer_isbn (isbn);
	posicion = buscar_libro (isbn, *biblioteca);

	if (posicion == NULL) // El libro indicado no esta.
	{
		// Creamos un nodo para el libro nuevo y lo insertamos al final de la lista.
		posicion = (NodoLibro *) malloc (sizeof(NodoLibro));
		strcpy(posicion -> DatosLibro.isbn, isbn);
		pedir_titulo (posicion ->DatosLibro.titulo);
		posicion ->DatosLibro.nejemplares = 1;
		posicion -> sig = NULL;
		
		// Casos posibles:
		// 1) Lista vacia: insercion por el principio.
		// 2) Lista no vacia: insercion por el final.

		// Caso 1:
		if ((*biblioteca) == NULL)
			(*biblioteca) = posicion;
		
		else // Caso 2:
		{
			NodoLibro *aux = (*biblioteca);
			while (aux -> sig != NULL)
				aux = aux -> sig;
			aux -> sig = posicion;
		}
		
		printf("Nuevo libro registrado en la biblioteca.\n");
	}		
	else // Se ha encontrado el libro: incrementamos su numero de ejemplares
	{
		posicion -> DatosLibro.nejemplares++;
		printf("Se ha anadido un ejemplar del libro indicado.\n");
	}
}


void baja_ejemplar (NodoLibro *biblioteca)
{
	char isbn[ISBN];
	NodoLibro* posicion;
	
	if (biblioteca == NULL)
	{
		printf("\nNo hay libros registrados en este momento.\n\n");
		return;
	}

	leer_isbn (isbn);
	posicion = buscar_libro (isbn, biblioteca);

	if (posicion == NULL)
		printf("El libro indicado no existe en nuestra biblioteca.\n");
	else
		if (posicion ->DatosLibro.nejemplares == 0)
			printf("No disponemos de ejemplares de ese libro.\n");
		else
		{
			posicion -> DatosLibro.nejemplares--;
			printf("Hemos eliminado un ejemplar del libro indicado.\n");
		}
}


void listado_biblioteca (NodoLibro *biblioteca)
{
	printf("\nLISTADO DE LIBROS DE LA BIBLIOTECA\n");
	printf("-------------------------------------------\n");
	
	while (biblioteca != NULL)
	{
		if (biblioteca -> DatosLibro.nejemplares != 0)
			printf("%s - \"%s\" (%d ejemplares)\n",
			    biblioteca->DatosLibro.isbn,
			    strupr(biblioteca->DatosLibro.titulo),
				biblioteca->DatosLibro.nejemplares);
		biblioteca = biblioteca -> sig;
	}
	
	printf("\n\n");
}


void tratar_opcion (NodoLibro **biblioteca, char opcion)
{
	switch (opcion)
	{
		case 'a':
		case 'A': alta_ejemplar (biblioteca);
		          break;
		case 'b':
		case 'B': baja_ejemplar (*biblioteca);
			      break;
		case 'c':
		case 'C': listado_biblioteca (*biblioteca);
	}
}

void main()
{
	NodoLibro *biblioteca = NULL;

	char opcion;

	do{
		mostrar_menu();
		leer_opcion (&opcion);
		tratar_opcion (&biblioteca, opcion);
	}while(opcion != 'd' && opcion != 'D');

	//destruir_lista (biblioteca);
}
