/* Crear las tablas */
CREATE TABLE Vendedor (
	CodVendedor INTEGER NOT NULL,
	Nombre VARCHAR ( 30 ),
	CONSTRAINT PK_Vendedor8 PRIMARY KEY (CodVendedor)
	);
CREATE TABLE Encargado (
	DNIEnc VARCHAR ( 9 ) NOT NULL,
	Nombre VARCHAR ( 30 ),
	Edad INTEGER,
	Salario DECIMAL ( 6, 2 ),
	Direccion VARCHAR ( 30 ),
	HorasMensuales INTEGER,
	CodCentroEsc INTEGER NOT NULL,
	CodCentroTra INTEGER NOT NULL,
	CONSTRAINT PK_Encargado5 PRIMARY KEY (DNIEnc)
	);
CREATE TABLE DirectorAdmin (
	DNIDir VARCHAR ( 9 ) NOT NULL,
	Nombre VARCHAR ( 30 ),
	Edad INTEGER,
	Salario DECIMAL ( 6, 2 ),
	Direccion VARCHAR ( 30 ),
	HorasMensuales INTEGER,
	CONSTRAINT PK_DirectorAdmin1 PRIMARY KEY (DNIDir)
	);
CREATE TABLE Gerente (
	DNIGer VARCHAR ( 9 ) NOT NULL,
	Nombre VARCHAR ( 30 ),
	Edad INTEGER,
	Salario DECIMAL ( 6, 2 ),
	Direccion VARCHAR ( 30 ),
	HorasMensuales INTEGER,
	CONSTRAINT PK_Gerente10 PRIMARY KEY (DNIGer)
	);
CREATE TABLE Administracion (
	CodAdmin INTEGER NOT NULL,
	Direccion VARCHAR ( 30 ),
	FechaEstablecimiento DATE,
	DNIDir VARCHAR ( 9 ) NOT NULL,
	CONSTRAINT PK_Administracion0 PRIMARY KEY (CodAdmin)
	);
CREATE TABLE CentroEscolar (
	CodCentroEsc INTEGER NOT NULL,
	Direccion VARCHAR ( 30 ),
	FechaConstruccion DATE,
	DNIDirEsc VARCHAR ( 9 ) NOT NULL,
	CodCentroTra INTEGER NOT NULL,
	CONSTRAINT PK_CentroEscolar3 PRIMARY KEY (CodCentroEsc),
	CONSTRAINT TC_CentroEscolar20 UNIQUE (DNIDirEsc)
	);
CREATE TABLE DirectorEscolar (
	DNIDirEsc VARCHAR ( 9 ) NOT NULL,
	Nombre VARCHAR ( 30 ),
	Edad INTEGER,
	CodCentroTra INTEGER NOT NULL,
	CONSTRAINT PK_DirectorEscolar6 PRIMARY KEY (DNIDirEsc)
	);
CREATE TABLE Empleado (
	DNIEmp VARCHAR ( 9 ) NOT NULL,
	Nombre VARCHAR ( 30 ),
	Edad INTEGER,
	Salario DECIMAL ( 6, 2 ),
	Direccion VARCHAR ( 30 ),
	HorasMensuales INTEGER,
	CodCentroEsc INTEGER NOT NULL,
	CodCentroTra INTEGER NOT NULL,
	DNIEnc VARCHAR ( 9 ) NOT NULL,
	CONSTRAINT PK_Empleado4 PRIMARY KEY (DNIEmp)
	);
CREATE TABLE CompraVenta (
	CodVendedor INTEGER NOT NULL,
	DNIGer VARCHAR ( 9 ) NOT NULL,
	TipoProducto VARCHAR ( 30 ),
	CONSTRAINT PK_CompraVenta9 PRIMARY KEY (CodVendedor, DNIGer)
	);
CREATE TABLE CentroTrabajo (
	CodCentroTra INTEGER NOT NULL,
	Direccion VARCHAR ( 30 ),
	FechaEstablecimiento DATE,
	DNIGer VARCHAR ( 9 ) NOT NULL,
	CodAdmin INTEGER NOT NULL,
	CONSTRAINT PK_CentroTrabajo2 PRIMARY KEY (CodCentroTra)
	);
ALTER TABLE Encargado ADD CONSTRAINT FK_Encargado16 FOREIGN KEY (CodCentroEsc) REFERENCES CentroEscolar (CodCentroEsc) ;
ALTER TABLE Encargado ADD CONSTRAINT FK_Encargado14 FOREIGN KEY (CodCentroTra) REFERENCES CentroTrabajo (CodCentroTra) ;
ALTER TABLE Administracion ADD CONSTRAINT FK_Administracion2 FOREIGN KEY (DNIDir) REFERENCES DirectorAdmin (DNIDir) ;
ALTER TABLE CentroEscolar ADD CONSTRAINT FK_CentroEscolar7 FOREIGN KEY (DNIDirEsc) REFERENCES DirectorEscolar (DNIDirEsc) ;
ALTER TABLE CentroEscolar ADD CONSTRAINT FK_CentroEscolar6 FOREIGN KEY (CodCentroTra) REFERENCES CentroTrabajo (CodCentroTra) ;
ALTER TABLE DirectorEscolar ADD CONSTRAINT FK_DirectorEscolar8 FOREIGN KEY (CodCentroTra) REFERENCES CentroTrabajo (CodCentroTra) ;
ALTER TABLE Empleado ADD CONSTRAINT FK_Empleado10 FOREIGN KEY (DNIEnc) REFERENCES Encargado (DNIEnc) ;
ALTER TABLE Empleado ADD CONSTRAINT FK_Empleado15 FOREIGN KEY (CodCentroTra) REFERENCES CentroTrabajo (CodCentroTra) ;
ALTER TABLE Empleado ADD CONSTRAINT FK_Empleado9 FOREIGN KEY (CodCentroEsc) REFERENCES CentroEscolar (CodCentroEsc) ;
ALTER TABLE CompraVenta ADD CONSTRAINT FK_CompraVenta12 FOREIGN KEY (CodVendedor) REFERENCES Vendedor (CodVendedor) ;
ALTER TABLE CompraVenta ADD CONSTRAINT FK_CompraVenta11 FOREIGN KEY (DNIGer) REFERENCES Gerente (DNIGer) ;
ALTER TABLE CentroTrabajo ADD CONSTRAINT FK_CentroTrabajo5 FOREIGN KEY (CodAdmin) REFERENCES Administracion (CodAdmin) ;
ALTER TABLE CentroTrabajo ADD CONSTRAINT FK_CentroTrabajo13 FOREIGN KEY (DNIGer) REFERENCES Gerente (DNIGer) ;


/*-----------------------------------------------------------*/
/* Inserci??n de datos */
insert into directoradmin values ('11992312K', 'Francisco Silgado Mac??as', 58, 2450, 'C/Intenso N 34', 176);
insert into directoradmin values ('73765142M', 'Mar??a S??nchez Garc??a', 52, 2600, 'C/Vivaldi N 23', 184);
insert into directoradmin values ('81723465P', 'Paula M??ndez Arias', 42, 1860, 'C/Catador N 41', 182);
insert into directoradmin values ('83890412S', 'Ana Mar??a Delgado de la Rosa', 36, 2100, 'Avda del Roc??o N 32 A', 166);
insert into directoradmin values ('92398132H', 'Antonio P??rez Delgado', 33, 1920, 'C/Blanco White N 16', 160);

insert into administracion values (122783, 'Avda Expo 92 N 20', '16/09/2020', '92398132H');
insert into administracion values (632521, 'Calle Los Reyes Cat??licos N 1', '12/11/2020', '81723465P');
insert into administracion values (636251, 'Paseo La Isla N 56', '29/03/2018', '11992312K');
insert into administracion values (823716, 'Avda La Antigua N 40', '12/02/2016', '83890412S');
insert into administracion values (923812, 'Calle El Torre??n N 15', '22/08/2019', '73765142M');

insert into gerente values ('33241123C', 'Francisco Cortina Lumbreras', 28, 1350, 'V??a Lorem ipsum, 106A 3??H', 202);
insert into gerente values ('66534267J', 'Isidro Pujol Sol??s', 32, 1500, 'Londa Lorem ipsum, 211 11??B', 160);
insert into gerente values ('73761928B', 'Rafael Torrijos Bola??os', 34, 1600, 'Callej??n Lorem ipsum, 170B 2??A', 184);
insert into gerente values ('83719938N', 'Lupe Pozuelo Pizarro', 44, 1550, 'Alameda Lorem, 84A', 190);

insert into centrotrabajo values(113921, 'Ctra. Hornos, 13', '19/06/2020', '73761928B', 122783);
insert into centrotrabajo values(777638, 'C/ Domingo Beltr??n, 59', '05/08/2020', '66534267J', 823716);
insert into centrotrabajo values(798002, 'C/ Eras, 24', '15/07/2016', '33241123C', 923812);
insert into centrotrabajo values(837212, 'Celso Emilio Ferreiro, 16', '09/05/2019', '83719938N', 632521);

insert into directorescolar values ('23313424F', 'Erato Corona Arreola', 67, 113921);
insert into directorescolar values ('33126645V', 'Bela Riojas Alarc??n', 45, 798002);
insert into directorescolar values ('41427686G', 'Celmira Enr??quez Esquivel', 34, 837212);

insert into centroescolar values (100231, 'Avda. de la Estaci??n, 99', '09/09/1996', '23313424F', 113921);
insert into centroescolar values (332442, 'Escuadro, 85', '20/04/2002', '41427686G', 837212);
insert into centroescolar values (736828, 'Avenda??o, 69', '11/04/2001', '33126645V', 798002);

insert into encargado values ('09003241L', 'Zaba Mac??as Aranda', 34, 790, 'Comandante Izarduy, 84', 80, 332442, 837212);
insert into encargado values ('77639912X', 'Macedonio Guevara Romero', 42, 770, 'Rio Segura, 61', 80, '736828', '798002');
insert into encargado values ('83874321C', 'Florida Guerra Garc??a', 52, 800, 'Herrer??a, 52', 80, '100231', '113921');

insert into empleado values ('00930821H', 'Oberto Espinoza Osorio', 38, 630, 'Cercas Bajas, 42', 80, 100231, 113921, '83874321C');
insert into empleado values ('12346789U', 'Filem??n Hidalgo Granado', 34, 660, 'Constituci??n, 56', 80, 332442, 837212, '09003241L');
insert into empleado values ('19283794F', 'Normando Moreno Cortez', 40, 640, 'C/ Fern??ndez de Leceta, 26', 80, 100231, 113921, '83874321C');
insert into empleado values ('67812378E', 'Janice Pizarro Montalvo', 21, 660, 'Herrer??a, 35', 80, 332442, 837212, '09003241L');
insert into empleado values ('67832456P', 'Laia Jaime Santacruz', 42, 650, 'C/ Manuel Iradier, 37', 80, 736828, 798002, '77639912X');
insert into empleado values ('77365498C', 'Arqu??medes Arana Coronado', 24, 665, 'Rua da Rapina, 77', 80, 100231, 113921, '83874321C');
insert into empleado values ('81376289N', 'Servio Guerrero Porras', 29, 640, 'Avda. Los llanos, 91', 80, 100231, 113921, '83874321C');
insert into empleado values ('88376253O', 'Pirra Corona Maestas', 30, 640, 'Avda. Los llanos, 13', 80, 100231, 113921, '83874321C');
insert into empleado values ('89785634R', 'Dalmazio Gaona Serrano', 47, 650, 'Prolongacion San Sebastian, 21', 80, 736828, 798002, '77639912X');

insert into vendedor values (121231, 'Velasco Madrigal Lemus');
insert into vendedor values (665362, 'Dimpna G??mez Sotelo');
insert into vendedor values (783721, 'Teolinda Est??vez Rosas');

insert into compraventa values (121231, '33241123C', 'Esponjas');
insert into compraventa values (121231, '83719938N', 'Bayetas');
insert into compraventa values (665362, '73761928B', 'Fregonas');
insert into compraventa values (665362, '83719938N', 'Friega suelos');
insert into compraventa values (783721, '66534267J', 'Limpia cristales');
insert into compraventa values (783721, '73761928B', 'Limpia cristales');

/*-----------------------------------------------------------*/
/* Consultas */
/* 1. Eliminar los empleados de los centros de trabajo donde haya dos o menos trabajadores, sin contar a los encargados. */

delete empleado where exists (
	select codcentrotra from empleado
	group by codcentrotra
	having count(dniemp) <= 2;
);

/*---------------------------------------------*/
/* 2. Mostrar los encargados de los centros de trabajo que tengan alg??n empleado.*/

select * from encargado
where dnienc in (select dnienc from empleado);

/*---------------------------------------------*/
/* 3. Mostrar los empleados de los centros de trabajo que est??n bajo la administraci??n con c??digo 632521 y que cobren igual o m??s de 630 euros. */

select dniemp, E.nombre
from empleado E
where codcentrotra in (
	select codcentrotra from centrotrabajo
	where codadmin = 632521
)
intersect
select dniemp, nombre
from empleado
where salario >= 630;

/*---------------------------------------------*/
/* 4. 	 */

select Dir.dnidir, Dir.nombre 
from directoradmin Dir
where Dir.dnidir = (
	select Ad.dnidir from administracion Ad
	where Ad.codadmin = (
		select Ct.codadmin from centrotrabajo Ct
		where Ct.codcentrotra = (
			select Em.codcentrotra	
			from empleado Em
			group by Em.codcentrotra
			having count(*) = (
				select max(count(*)) from empleado
				group by codcentrotra
			)
		)
	)
);

/*---------------------------------------------*/
/* 5. Cambiar el salario al gerente de los centros de trabajo que no tengan ning??n empleado. A??adir 200???. */

update gerente set salario = salario + 200
where dniger in (
	select centrotrabajo.dniger from empleado, centrotrabajo
	where empleado.codcentrotra (+) = centrotrabajo.codcentrotra
	group by centrotrabajo.dniger
	having count(empleado.dniemp) = 0;
);


/*-----------------------------------------------------------*/
/* Informe de las tablas en SQL 
Salario para cada empleado, agrupado por centro de trabajo.
*/
ttitle "SALARIO PARA CADA EMPLEADO POR CENTRO DE TRABAJO"

column centro heading 'Centro de Trabajo' format 999999
column nombre heading 'Nombre de Empleado'
column salario heading 'Salario' format 9G999D99

set linesize 80
set pagesize 50
set newpage 1

break on centro skip 2
compute sum label "-Suma" count label "-N?? Empleados" max label "-Sal Max" of 

salario on centro

select codcentrotra "centro", nombre, salario 
from empleado
order by codcentrotra;

ttitle off;