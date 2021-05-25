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

