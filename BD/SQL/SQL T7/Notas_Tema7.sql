/*SENTENCIAS DE DEFINICIÓN DE DATOS*/

CREATE /*Para crear*/
	/*TIPOS DE DATOS*/
	NUMBER
	VARCHAR2
	CHAR
	DATE
	
ALTER
DROP /*Para eliminar*/

/*Se acostumbra a poner cada campo en una línea para identificar el error.*/
CREATE TABLE CURSO
	(Cod NUMBER(2),
	nombre VARCHAR2(15));

DROP TABLE CURSO;

/*Restricción PRIMARY KEY*/
CREATE TABLE CURSO
	(Cod NUMBER(2) PRIMARY KEY,
	nombre VARCHAR2(15));

/*Restricción CLAVE ALTERNATIVA*/
CREATE TABLE CURSO
	(Cod NUMBER(2) PRIMARY KEY, /*La restricción en linea es restricción de columna*/
	nombre VARCHAR2(15) UNIQUE);

CREATE TABLE ALUMNO
	(Codigo NUMBER(2), 
	nombre VARCHAR2(15) NOT NULL, /*Restricción de obligatoriedad*/
	edad NUMBER(2) CHECK(edad > 18), /*Restrición de condición*/
	ciudad VARCHAR2(15) DEFAULT 'GINES', /*Valor por defecto*/
	PRIMARY KEY (Codigo)); /*Las restricciones al final son restricciones de tabla*/

INSERT INTO ALUMNO VALUES (14, 'Rocio', 20, NULL); /*Si se pone NULL machaca el valor DEFAULT*/

/*Nombrar las restricciones*/
CREATE TABLE ALUMNO
	(Codigo NUMBER(2), 
	nombre VARCHAR2(15) NOT NULL,
	edad NUMBER(2) CONSTRAINT CK_ALU CHECK(edad > 18),
	ciudad VARCHAR2(15) DEFAULT 'GINES', 
	CONSTRAINT PK_ALU PRIMARY KEY (Codigo)); 

/*Enlazar tablas*/
CREATE TABLE ALUMNO
	(Codigo NUMBER(2), 
	nombre VARCHAR2(15) NOT NULL,
	edad NUMBER(2) CONSTRAINT CK_ALU CHECK(edad > 18),
	ciudad VARCHAR2(15) DEFAULT 'GINES', 
	codcurso NUMBER(2) REFERENCES CURSO);

CREATE TABLE ALUMNO
	(Codigo NUMBER(2), 
	nombre VARCHAR2(15) NOT NULL,
	edad NUMBER(2) CONSTRAINT CK_ALU CHECK(edad > 18),
	ciudad VARCHAR2(15) DEFAULT 'GINES', 
	codcurso NUMBER(2),
	CONSTRAINT PK_ALU PRIMARY KEY (Codigo),
	CONSTRAINT FK_ALU FOREIGN KEY (codcurso) REFERENCES CURSO); 
	
CREATE TABLE ALUMNO
	(Codigo NUMBER(2), 
	nombre VARCHAR2(15) NOT NULL,
	edad NUMBER(2) CONSTRAINT CK_ALU CHECK(edad > 18),
	ciudad VARCHAR2(15) DEFAULT 'GINES', 
	codcurso NUMBER(2),
	CONSTRAINT PK_ALU PRIMARY KEY (Codigo),
	CONSTRAINT FK_ALU FOREIGN KEY (codcurso) REFERENCES CURSO ON DELETE CASCADE);  /*Permite borrar en cascada todos los alumnos del curso eliminado.*/