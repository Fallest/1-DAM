// LIBRERIAS
#include <stdio.h>
#include <string.h>
#include <stdlib.h>



// CONSTANTES
#define CADENA_LARGA 40
#define TARIFA_MINUTO 0.10


// TIPOS DE DATOS
typedef struct
{
  int numero;
  char descripcion[CADENA_LARGA];
}DatosLinea;


typedef struct
{
  int dia, mes, anio;
  int hh, mm;
  int duracion;
}DatosLlamada;


typedef struct nodolla
{
  DatosLlamada llamada;
  struct nodolla * sig;
}NodoLlamada;


typedef struct nodoli
{
  DatosLinea linea;
  struct nodoli *sig;
  NodoLlamada *lista_llamadas;
} NodoLinea;


void pedir_fecha (DatosLlamada *reg)
{
	printf("\nIntroduzca la fecha de la llamada (dd-mm-aa): ");
	scanf("%d-%d-%d", &((*reg).dia), &((*reg).mes), &((*reg).anio));
	fflush(stdin);
}


void pedir_hora (DatosLlamada *reg)
{
	printf("\nIntroduzca hora y minutos de inicio de la llamada (hh:mm): ");
	scanf("%d:%d", &((*reg).hh), &((*reg).mm));
	fflush(stdin);
}


void pedir_duracion (DatosLlamada *reg)
{
	printf("\nIntroduzca la duracion en minutos de la llamada: ");
	scanf("%d-%d-%d", &((*reg).duracion));
	fflush(stdin);
}


void inserta_llamada (NodoLinea *tel)
{
	// Creamos el nodo de la nueva llamada y pedimos los datos de la misma
	// para almacenarlos dentro de su zona de datos:
	NodoLlamada *ll = (NodoLlamada *) malloc (sizeof(NodoLlamada));
	pedir_fecha (&(ll -> llamada));
	pedir_hora (&(ll -> llamada));
	pedir_duracion (&(ll -> llamada));

	// Colocamos el nodo de la nueva llamada como el primero de la lista
	// de llamadas de esa linea:
	ll -> sig = tel -> lista_llamadas;
	tel -> lista_llamadas = ll;
}


int preguntar_si_alta()
{
	int respuesta;

	printf("La linea indicada no existe. Desea darla de alta (1 SI, 0 NO)?: ");
	scanf("%d", &respuesta);
	fflush(stdin);

	return respuesta;
}


void inserta_linea_en_lista (NodoLinea *nuevaLinea, NodoLinea **lineas)
{
	// Casos posibles:
	// 1) La lista esta vacia. El nuevo nodo sera el primero de la lista.
	// 2) La lista no esta vacia. El nuevo nodo se colocara en el lugar
	//    que le corresponda segun el orden establecido.
	// 2.1) Le corresponde ser el primero.
	// 2.2) Le corresponde no ser el primero. Debemos encontrar el nodo
	//      que le precedera.

	// Caso 1:
	if ((*lineas) == NULL)
		(*lineas) = nuevaLinea;
	else
	{
		// Caso 2.1:
		if ((*lineas) ->linea.numero > nuevaLinea ->linea.numero)
		{
			nuevaLinea ->sig = (*lineas);
			(*lineas) = nuevaLinea;
		}
		// Caso 2.2:
		else
		{
			NodoLinea *aux = (*lineas);

			// Recorremos la lista mientras el nodo siguiente al que usamos para
			// recorrerla no es NULL y ademas su numero de linea es menor que
			// el que tenemos en el nuevo nodo.
			
			// Si llegamos al final de la lista o bien si encontramos un nodo
			// cuyo nodo siguiente contenga un numero mayor que el que tenemos
			// en el nuevo nodo, en esos casos ya sabemos detras de que nodo
			// vamos a insertar el nuevo.
			while (aux -> sig != NULL && 
				   aux ->sig ->linea.numero < nuevaLinea ->linea.numero)
				aux = aux -> sig;

			nuevaLinea ->sig = aux ->sig;
			aux ->sig = nuevaLinea;
		}
	}
}


void pedir_linea (int *linea)
{
	printf("\nIntroduzca el numero de la linea: ");
	scanf("%d", linea);
	fflush(stdin);
}


NodoLinea *buscar_linea (int l, NodoLinea *lineas)
{
	// Recorremos la lista mientras queden nodos y
	// el numero de cada nodo sea menor que el que me han pasado
	// como parametro.
	while (lineas != NULL && lineas ->linea.numero < l)
		lineas = lineas -> sig;

	// Si hemos terminado la lista o el nodo en el que el recorrido
	// se ha detenido no contiene el numero buscado, en esos casos
	// devolvemos NULL (que quiere decir que el numero introducido
	// por el usuario no esta en la lista).
	if (lineas == NULL || lineas ->linea.numero != l)
		return NULL;

	// Si el recorrido anterior se ha detenido en un nodo cuyo numero
	// de linea coincida con el que nos han pasado como parametro
	// en ese caso devolvemos el puntero a dicho nodo.
	if (lineas -> linea.numero == l)
		return lineas;
}


void pedir_descripcion (char descripcion[])
{
	printf("\nIntroduzca la descripcion de la linea: ");
	gets (descripcion);
	fflush(stdin);
}


void alta_llamada (NodoLinea **lineas)
{
	// En el enunciado se indica que si la linea no existe se debe dar
	// al usuario la posibilidad de darla de alta.
	
	int l; // Almacenara el numero de linea introducido por el usuario.
	
	// Solicitamos el numero de la linea en la que deseamos dar de alta
	// los datos de la llamada.
	pedir_linea (&l);
	
	// Buscamos el nodo correspondiente a ese numero de linea.
	NodoLinea *tel = buscar_linea(l, *lineas);

	if (tel == NULL) // La linea no existe.
	{
		if (!preguntar_si_alta())
			return;

		// Creamos un nuevo nodo para la linea y le escribimos el numero de telefono.
		tel = (NodoLinea *) malloc (sizeof(NodoLinea));
		tel -> linea.numero = l;
		pedir_descripcion (tel ->linea.descripcion);
		tel -> sig = NULL;
		tel -> lista_llamadas = NULL;

		// Insertamos el nodo que acabamos de crear en la lista de lineas.
		inserta_linea_en_lista (tel, lineas);
	}
	
	// Procedemos a la grabacion de los datos de la llamada.
	inserta_llamada (tel);
	
	printf("\n\nLlamada registrada.\n\n");
}


/*
void imprime_lista (NodoLinea *lineas)
{
	while (lineas != NULL)
	{
		printf("%d - %s\n", lineas ->linea.numero, lineas ->linea.descripcion);
		lineas = lineas -> sig;
	}
}
*/

void alta_linea (NodoLinea **lineas)
{
	// En el enunciado se indica que las lineas deben estar ordenadas
	// en la lista (por el numero de la linea), de forma ascendente.

	NodoLinea *nuevaLinea; // Nodo que contendra la nueva linea.
	
	int l; // Almacenara el numero de linea introducido por el usuario.
	
	// Solo admitiremos un numero de linea que no exista.
	do{
		pedir_linea (&l);
	}while(buscar_linea(l, *lineas) != NULL);

	// Creamos el nodo y rellenamos los campos de datos.
	// Los punteros al siguiente nodo de linea y a la lista
	// de llamadas de esa linea los ponemos a NULL.
	nuevaLinea = (NodoLinea *) malloc (sizeof(NodoLinea));
	nuevaLinea ->linea.numero = l;
	pedir_descripcion (nuevaLinea ->linea.descripcion);
	nuevaLinea ->sig = NULL;
	nuevaLinea ->lista_llamadas = NULL;

	// Colocamos el nodo que acabamos de crear dentro de la lista
	// de forma que ésta siga ordenada.
	inserta_linea_en_lista (nuevaLinea, lineas);

	printf("\n\nLinea dada de alta en la base de datos.\n\n");
}


void calcula_e_imprime_facturacion_linea (NodoLinea *l)
{
	int total_minutos = 0;

	NodoLlamada *aux = l -> lista_llamadas;

	while (aux != NULL)
	{
		total_minutos += aux -> llamada.duracion;
		aux = aux -> sig;
	}

	printf("%d (%s): %d minutos (%.2f euros)\n", l -> linea.numero, l -> linea.descripcion,
		total_minutos, total_minutos * TARIFA_MINUTO);
}


void calculo_facturacion (NodoLinea *lineas)
{
	// El calculo se realiza para una unica linea de la lista.
	
	printf("\n\nLISTADO DE FACTURACION\n-------------------------------------\n");

	while (lineas != NULL)
	{
		calcula_e_imprime_facturacion_linea (lineas);
		lineas = lineas -> sig;
	}

	printf("\n\n");
}


void destruye_llamadas (NodoLinea *tel)
{
	NodoLlamada *nodo_a_borrar;
	NodoLlamada *nodo_recorrido;

	nodo_recorrido = nodo_a_borrar = tel -> lista_llamadas;

	while (nodo_recorrido != NULL)
	{
		nodo_recorrido = nodo_recorrido -> sig;
		free (nodo_a_borrar);
		nodo_a_borrar = nodo_recorrido;
	}

	tel -> lista_llamadas = NULL;
}


void borra_nodo_linea (NodoLinea *tel, NodoLinea **lineas)
{
	// Caso 1: El nodo a borrar es el primero de la lista. El primero de la lista
	//         debe ser el que figure detrás de el.
	// Caso 2: El nodo a borrar está detrás de otro nodo. Hay que encontrar el nodo
	//         que le precede.

	// Caso 1:
	if (tel == (*lineas))
		
		(*lineas) = (*lineas) -> sig;
	
	else // Caso 2:
	{
		NodoLinea *aux = (*lineas);
		
		while (aux -> sig != tel)
			aux = aux -> sig;
		
		aux -> sig = tel -> sig; // Nos "saltamos" el nodo "tel".
	}

	free (tel);
}


void destruye_linea (NodoLinea *tel, NodoLinea **lineas)
{
	destruye_llamadas (tel);
	borra_nodo_linea (tel, lineas);
}


void cancelacion_linea (NodoLinea **lineas)
{
	// Se debe destruir previamente la lista de llamadas de la linea y
	// posteriormente se debe borrar y destruir el nodo correspondiente
	// a la linea dentro de la lista.

	int l; // Almacenara el numero de linea introducido por el usuario.
	
	// Solicitamos el numero de la linea en la que deseamos dar de alta
	// los datos de la llamada.
	pedir_linea (&l);
	
	// Buscamos el nodo correspondiente a ese numero de linea.
	NodoLinea *tel = buscar_linea(l, *lineas);

	if (tel == NULL) // La linea no existe.
	{
		printf("\nLa linea indicada no existe.\n\n");
		return;
	}

	destruye_linea (tel, lineas);

	printf("\n\nLinea eliminada de la base de datos.\n\n");
}


void tratar_opcion (int opcion, NodoLinea **lineas)
{
  switch (opcion)
  {
    case 1: alta_linea (lineas);
            break;
    case 2: alta_llamada (lineas);
            break;
    case 3: calculo_facturacion (*lineas);
            break;
    case 4: cancelacion_linea (lineas);
            break;
  }
}


void destruir_estructura (NodoLinea *lineas)
{
}


void mostrar_menu()
{
	printf("MENU PRINCIPAL\n");
	printf("--------------\n");
	printf("1) Alta de linea.\n");
	printf("2) Alta de llamada.\n");
	printf("3) Listado de facturacion.\n");
	printf("4) Cancelacion de linea.\n");
	printf("5) Salir.\n\n");
}


void leer_opcion (int *opcion)
{
	do{
		printf("\nIntroduzca opcion: ");
		scanf("%d", opcion);
		fflush(stdin);
	}while (((*opcion) < 1) || ((*opcion) > 5));
}


/* *********************************************************
********************** PROGRAMA PRINCIPAL ******************
********************************************************* */
void main()
{
  NodoLinea *lineas = NULL;
  int opcion;

  do{
    mostrar_menu();
    leer_opcion (&opcion);
    tratar_opcion (opcion, &lineas);
  }while(opcion != 5);

  destruir_estructura (lineas);
}
