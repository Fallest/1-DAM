#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#define TAMCAD 30

// Estructuras
typedef struct {
	char nombre[TAMCAD];
	char depart[TAMCAD];
	int annoIncor;
	// Hubiera venido bien colocar aquí un atributo bandera para saber si estaba grabado o no el registro.
	// int flag;
} Profesor;

// Prototipos
	// Funciones para crear el array de datos
int getTam(FILE * f);
void lecturaDatos(Profesor * profesores, FILE * f);
void preguntarDepart(char * depart);
int preguntarAnnoInc();

	// Funciones para la validación de datos
void validarDatos(Profesor * profesores);
void pedirNombre(char * nom);
int comprobarNombre(char * nom, FILE * f);
int contEjec();
void mostrarDatos(char * nom, Profesor * profesores);
int preguntarModif();
void modifProfesor(char * nom, Profesor * profesores);
void modifNombre(char * nom);
void modifDepart(char * depart);
void modifAnnoInc(int * annoIncor);
void guardarRegistro(char * nom, Profesor * profesores, char * archivo);

	// Funciones para los maestros de un departamento
void maestrosDepart(Profesor * profesores, int tam);

/*----------------------------------------------------------*/// 1/1
void main () {
	// Crear el descriptor
	FILE * f;

	// Abrir el fichero
	f = fopen("nombres.txt", "r");

	// Comprobar que se ha abierto bien
	if (f == NULL)
		printf("Ha ocurrido un error. No existe el archivo indicado.\n");
	else {
		// Crear la estructura
		int numpro = getTam(f);
		Profesor profesores[5];

		// Pasar los datos a un array y dar los otros datos
		lecturaDatos(profesores, f);

		// Cerrar el archivo (ya no lo vamos a usar)
		fclose(f);

		// Validacion de datos
		validarDatos(profesores);

		// Maestros de un departamento
		maestrosDepart(profesores, numpro);
	}
	printf("Fin del programa.\n");
}

/*----------------------------------------------------------*/// 4/4
/* Funciones para crear el array de datos */

int getTam(FILE * f) {
	int cont = 0;
	char * aux;

	// Recorremos el archivo hasta el final
	while(feof(f) == 0) {
		// Vamos saltando de línea en línea
		fgets(aux, TAMCAD, f);
		cont++;
	}

	// Recolocamos el indicador de posición en el inicio del archivo
	rewind(f);

	return cont;
}

void lecturaDatos(Profesor * profesores, FILE * f) {
	/*Pasa los datos de un archivo a un array*/
	char cadNom[TAMCAD];
	int cont = 0;

	while(feof(f) == 0) {
		if (ferror(f) != 0) {
			printf("Ha ocurrido un error al operar en el fichero.\n");
			break;
		}
		else {
			// Cogemos el nombre del archivo
			fgets(cadNom, TAMCAD, f);
			fflush(stdin);
			// Introducimos los datos en el elemento del array
			printf("Introduzca los datos del profesor %s:\n", cadNom);
			strcpy(profesores[cont].nombre, cadNom);
			preguntarDepart(profesores[cont].depart);
			profesores[cont].annoIncor = preguntarAnnoInc();
		}
	}
}

void preguntarDepart(char * depart) {
	printf("Introduzca el departamento: ");
	gets(depart);
	fflush(stdin);
}

int preguntarAnnoInc() {
	int res = 0;

	printf("Introduzca el anyo de incorporacion del profesor/a: ");
	scanf("%d", &res);
	fflush(stdin);

	return res;
}

/*----------------------------------------------------------*/// 10/10
/* Funciones para la validación de datos */
void validarDatos(Profesor * profesores) {
	char nom[TAMCAD];
	int ejec = 1, comp = 0, modif = 1;

	printf("\nValidacion de datos\n");

	// Abrimos el nuevo fichero
	FILE * f;
	f = fopen("plantilla.dat", "w+");

	// Comprobar que se ha abierto bien
	if (f == NULL)
		printf("Error. Ha ocurrido un error al abrir plantilla.dat.\n");
	else {
		// Bucle para preguntar por nombres
		do {
			ejec = 0;
			// Preguntamos el nombre al usuario
			pedirNombre(nom);
			// Comprobamos que el nombre no está ya en el archivo
			comp = comprobarNombre(nom, f);

			if (comp == 1)
				printf("Ese nombre ya está grabado.\n");

			else {	
				// Muestra los datos del profesor
				mostrarDatos(nom, profesores);

				// Preguntar si se quiere modificar
				modif = preguntarModif();

				if (modif == 1) {
					// Código para modificar los datos del profesor
					modifProfesor(nom, profesores);
				}
				// Cerramos el archivo antes de entrar en la función guardarRegistro()
				fclose(f);
				// Guardar el registro en el fichero
				guardarRegistro(nom, profesores, "plantilla.dat");
				// Volvemos a abrirlo
				f = fopen("plantilla.dat", "w+");
			}

			// Preguntar si se van a seguir buscando profesores
			ejec = contEjec();
		} while(ejec != 0 && f != NULL);
	}	
}

void pedirNombre(char * nom) {
	printf("Introduzca el nombre a buscar: ");
	gets(nom);
	fflush(stdin);	
}

int comprobarNombre(char * nom, FILE * f) {
	// Devuelve 1 si el nombre ya está en el archivo, 0 si no existe aún.
	int res = 0;
	char cadAux[TAMCAD];

	while (feof(f) == 0) 
		if(strcmp(nom, fgets(cadAux, TAMCAD, f)) == 0) 
			res = 1;
	
	rewind(f);

	return res;
}

int contEjec() {
	int res = 1;
	char aux;
	
	printf("Quiere grabar otro profesor? (s/n)");
	scanf("%c", &aux);
	fflush(stdin);

	if(aux == 's')
		return res = 1;
	else
		return res = 0;
}

void mostrarDatos(char * nom, Profesor * profesores) {
	int ejec = 1, i = 0;

	/* Bucle "infinito", porque para entrar en esta función debe existir
	sí o sí el nombre, entonces sabemos que nos lo vamos a encontrar en algún 
	momento u otro. */
	while (ejec == 1) {
		if (strcmp(profesores[i].nombre, nom) == 0) {
			printf("Nombre: %s\n", profesores[i].nombre);
			printf("Departamento: %s\n", profesores[i].depart);
			printf("Anno de incorporacion: %d\n", profesores[i].annoIncor);
			break;
		}

		i++;
	}
}

int preguntarModif() {
	int res = 0;
	char aux;

	printf("Quiere modificar los datos del profesor? (s/n): ");
	scanf("%c", &aux);
	fflush(stdin);

	if (aux == 's')
		return res = 1;
	else
		return res;
}

void modifProfesor(char * nom, Profesor * profesores) {
	int i = 0;

	while (i >= 0) {
		if (strcmp(profesores[i].nombre, nom) == 0) {
			modifNombre(profesores[i].nombre);
			modifDepart(profesores[i].depart);
			modifAnnoInc(&profesores[i].annoIncor);
			break;
		}
		i++;
	}
}

void modifNombre(char * nom) {
	char aux;

	printf("Quiere modificar el nombre? (s/n): \n");
	scanf("%c", &aux);
	fflush(stdin);

	if (aux == 's') {
		printf("\nIntroduzca el nuevo nombre: ");
		gets(nom);
		fflush(stdin);
	}
}

void modifDepart(char * depart) {
	char aux;

	printf("Quiere modificar el departamento? (s/n): \n");
	scanf("%c", &aux);
	fflush(stdin);

	if (aux == 's') {
		printf("\nIntroduzca el nuevo departamento: ");
		gets(depart);
		fflush(stdin);
	}
}

void modifAnnoInc(int * annoIncor) {
	char aux;

	printf("Quiere modificar el anno de incorporacion? (s/n): \n");
	scanf("%c", &aux);
	fflush(stdin);

	if (aux == 's') {
		printf("\nIntroduzca el nuevo anno de incorporacion: ");
		scanf("%d", annoIncor);
		fflush(stdin);
	}
}

void guardarRegistro(char * nom, Profesor * profesores, char * archivo) {
	int i = 0;
	Profesor profAux;
	// Creamos una copia del registro
	while (i >= 0) {
		if (strcmp(profesores[i].nombre, nom) == 0)
			profAux = profesores[i];

		i++;
	}

	// Vamos a abrir el archivo en modo append
	FILE * f = fopen(archivo, "a");
	if (f != NULL) {
		// Utilizamos printf para poner una cadena con formato
		fprintf(f, "%s - %s - %d\n", profAux.nombre, profAux.depart, profAux.annoIncor);
		// Cerrarlo para evitar problemas
		fclose(f);

		printf("Dato grabado.\n");
	}
	else
		printf("Error al abrir el archivo en la funcion guardarRegistro().\n");
}

/*----------------------------------------------------------*/// 1/1
/* Funciones para los maestros de un departamento */
void maestrosDepart(Profesor * profesores, int tam) {
	/*	---- NO REALIZA TODAS LAS FUNCIONES ----*/
	char depart[TAMCAD];

	printf("\nMaestros de un departamento\n");

	// Preguntamos por el departamento
	preguntarDepart(depart);

	char nomFile[TAMCAD];
	strcat(depart, ".txt");

	// Creamos el archivo
	FILE * f = fopen(nomFile, "w");

	if (f == NULL)
		printf("Error al crear el archivo en maestrosDepart().\n");
	else {
		// Falta: Código para crear un array auxiliar con los profesores a introducir-------------------
		// en el archivo ordenados por antigüedad.
		int i = 0;

		for (i = 0; i < tam; i++) 
			if (strcmp(profesores[i].depart, depart) == 0) 
				fprintf(f, "%s - %d",strupr(profesores[i].nombre), profesores[i].annoIncor);
	}
}