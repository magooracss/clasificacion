/*
	Programa para el control de carreras
*/

CREATE DOMAIN "guid"
  AS VARCHAR(38)
  CHARACTER SET ASCII
  DEFAULT '{00000000-0000-0000-0000-000000000000}' NOT NULL;

CREATE DOMAIN "money"
  AS decimal (18,4)
  DEFAULT 0 NOT NULL;
    

CREATE Table HistoDB
(
  id 		integer default -1 not null primary key
, version	integer default -1
, exe_ver	integer default -1
, exe_sub	integer default -1
, fecha		timestamp default 'NOW'
);

CREATE GENERATOR histoDBID;

SET GENERATOR histoDBID TO 0;

SET TERM ^ ;

CREATE TRIGGER HistoDBID FOR HistoDB
BEFORE INSERT POSITION 0
AS 
BEGIN 
    If (New.id = -1) then
   New.id = GEN_ID(histoDBID,1);
END^

SET TERM ; ^  

INSERT INTO HistoDB (version, exe_ver, exe_sub) VALUES (1,1,0);

CREATE TABLE Personas (
	id	"guid"	not null primary key
,	apellidos	varchar (300)
,	nombres	varchar(300)
,	tipoDocumento_id	integer default 0
,	documento	varchar(50)
,	sexo_id	integer default 0
,	fNacimiento	date
,	telefono	varchar(50)
,	direccion	varchar(300)
,	localidad_id	integer default 0
,	email	varchar(100)
,	bVisible	smallint default 1
);


CREATE TABLE TiposDocumentos
(
  id		integer not null primary key
, tipoDocumento varchar(50)
, bVisible	smallint default 1
);

CREATE GENERATOR tiposDocumentosID;

SET GENERATOR tiposDocumentosID TO 0;


SET TERM ^ ;

CREATE TRIGGER tiposDocumentosID FOR TiposDocumentos
BEFORE INSERT POSITION 0
AS 
BEGIN 
    If (New.id = -1) then
   New.id = GEN_ID(tiposDocumentosID,1);
END^

SET TERM ; ^  

INSERT INTO tiposDocumentos
(id, tipoDocumento, bVisible )
VALUES
(0,'DESCONOCIDO',0 );

INSERT INTO tiposDocumentos
(id, tipoDocumento, bVisible)
VALUES
(1, 'DNI', 1);

INSERT INTO tiposDocumentos
(id, tipoDocumento, bVisible)
VALUES
(2, 'Pasaporte', 1);

INSERT INTO tiposDocumentos
(id, tipoDocumento, bVisible)
VALUES
(3, 'Libreta civica', 1);


CREATE TABLE Localidades
(
   id	  integer not null primary key
 , Localidad	varchar(200)
 , codigoPostal varchar(20)
 , bVisible 	smallint default 1
);

CREATE GENERATOR LocalidadesID;

SET GENERATOR LocalidadesID TO 3;


SET TERM ^ ;

CREATE TRIGGER LocalidadesID FOR Localidades
BEFORE INSERT POSITION 0
AS 
BEGIN 
    If (New.id = -1) then
   New.id = GEN_ID(LocalidadesID,1);
END^

SET TERM ; ^  

INSERT INTO Localidades
(id, Localidad, codigoPostal, bVisible)
VALUES
(0, 'Desconocido', '0' , 1);

INSERT INTO Localidades
(id, Localidad, codigoPostal, bVisible)
VALUES
(1, 'La Plata', '1900' , 1);

INSERT INTO Localidades
(id, Localidad, codigoPostal, bVisible)
VALUES
(2, 'CABA', '0' , 1);

INSERT INTO Localidades
(id, Localidad, codigoPostal, bVisible)
VALUES
(3, 'Rio Grande', '9420' , 1);


CREATE TABLE Sexos
(
   id	  integer not null primary key
 , sexo	varchar(20)
 , bVisible 	smallint default 1
);

CREATE GENERATOR sexosID;

SET GENERATOR sexosID TO 2;

SET TERM ^ ;

CREATE TRIGGER sexosID FOR Sexos
BEFORE INSERT POSITION 0
AS 
BEGIN 
    If (New.id = -1) then
   New.id = GEN_ID(sexosID,1);
END^

SET TERM ; ^  

INSERT INTO Sexos
(id, sexo, bVisible)
VALUES
(0, 'Desconocido', 1);

INSERT INTO Sexos
(id, sexo, bVisible)
VALUES
(1, 'Masculino', 1);

INSERT INTO Sexos
(id, sexo, bVisible)
VALUES
(2, 'Femenino', 1);

CREATE TABLE Carreras (
	id	"guid"	not null primary key
,	nombre	varchar(500)
,	fecha	date
,	bVisible smallint default 1
);

CREATE TABLE Distancias(
	id	integer not null primary key
,	carrera_id	"guid"
,	nombre	varchar(500)
,	hLargada	time
,	bVisible smallint default 1
);

CREATE GENERATOR DistanciasID;

SET GENERATOR DistanciasID TO 0;

SET TERM ^ ;

CREATE TRIGGER DistanciasID FOR Distancias
BEFORE INSERT POSITION 0
AS 
BEGIN 
    If (New.id = -1) then
   New.id = GEN_ID(DistanciasID,1);
END^

SET TERM ; ^  

CREATE TABLE CategoriasCarrera(
	id	integer not null primary key
,	carrera_id	"guid"
, 	categoria_id integer default 0
, 	bVisible smallint default 1
);



CREATE GENERATOR CategoriasCarreraID;

SET GENERATOR CategoriasCarreraID TO 0;

SET TERM ^ ;

CREATE TRIGGER CategoriasCarreraID FOR CategoriasCarrera
BEFORE INSERT POSITION 0
AS 
BEGIN 
    If (New.id = -1) then
   New.id = GEN_ID(CategoriasCarreraID,1);
END^

SET TERM ; ^  


CREATE TABLE Categorias (
	id	  integer not null primary key
,	nombre	varchar(500)
,	bVisible  smallint default 1	
);

CREATE GENERATOR CategoriasID;

SET GENERATOR CategoriasID TO 0;

SET TERM ^ ;

CREATE TRIGGER CategoriasID FOR Categorias
BEFORE INSERT POSITION 0
AS 
BEGIN 
    If (New.id = -1) then
   New.id = GEN_ID(CategoriasID,1);
END^

SET TERM ; ^  

CREATE TABLE Corredores (
	id	"guid"	not null primary key
,	persona_id	"guid"
,	carrera_id	"guid"
,	distancia_id	integer default 0
,	categoria_id	integer default 0
,	numero		integer default 0
, 	talle_id	integer default 0
,	bInvitado	smallint default 0
,	bPagado		smallint default 0
,	importe		"money"
,	recibo		varchar(20)
,	fPago		date
,	bListaEspera smallint default 0
,	hLlegada		time
,	bVisible	smallint default 1
);

CREATE TABLE Talles (
	id	integer not null primary key
,	talle	varchar(20)
,	bVisible	smallint default 1
);

CREATE GENERATOR TallesID;

SET GENERATOR TallesID TO 0;

SET TERM ^ ;

CREATE TRIGGER TallesID FOR Talles
BEFORE INSERT POSITION 0
AS 
BEGIN 
    If (New.id = -1) then
   New.id = GEN_ID(TallesID,1);
END^

SET TERM ; ^  

INSERT INTO TALLES
(id, talle, bVisible)
VALUES
(0, 'Desconocido', 1);

INSERT INTO TALLES
(id, talle, bVisible)
VALUES
(-1, 'XS', 1);

INSERT INTO TALLES
(id, talle, bVisible)
VALUES
(-1, 'S', 1);

INSERT INTO TALLES
(id, talle, bVisible)
VALUES
(-1, 'M', 1);

INSERT INTO TALLES
(id, talle, bVisible)
VALUES
(-1, 'L', 1);

INSERT INTO TALLES
(id, talle, bVisible)
VALUES
(-1, 'XL', 1);

INSERT INTO TALLES
(id, talle, bVisible)
VALUES
(-1, 'XXL', 1);
