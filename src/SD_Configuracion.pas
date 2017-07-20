unit SD_Configuracion;

interface
uses
  IniFiles;

const
  ARCHIVO_CFG= 'programa.cfg';
  ERROR_APERTURA_CFG= 'ErrorAperturaCFG';
  ERROR_CFG= 'ErrorLecturaCFG';

  SECCION_APP = 'APLICACION';
  RUTA_LISTADOS = 'RUTA_LISTADOS';

  SERVIDOR_FB = 'RUTA_FB';  //Ruta al archivo de BD
  BASE_HOST='HOST';         //Dirección IP del HOST

  DIR_SERVIDOR = 'SERVIDOR';        //Ruta al archivo ejecutable

  CARRERA_ACTIVA = 'CARRERA';

  //Factura Impresa
  SECCION_FI = 'FACTURA_IMPRESA';
  FI_LOGO = 'FI_LOGO';
  FI_RAZON_SOCIAL = 'FI_RAZON_SOCIAL';
  FI_DOMICILIO = 'FI_DOMICILIO';
  FI_CONDICION_IVA = 'FI_CONDICION_IVA';
  FI_CUIT = 'FI_CUIT';
  FI_IB = 'FI_IB';
  FI_INIACT = 'FI_INIACT';
  FI_FACTURA = 'FI_FACTURA';


  function AbrirArchivo: TIniFile;
  function LeerDato (Clave, Etiqueta: string): string;
  procedure EscribirDato (Clave, Etiqueta, Dato: string);


implementation

uses
  SysUtils
  ,forms, Dialogs
  ;

function AbrirArchivo: TIniFile;
begin
  Result:= TiniFile.Create(ExtractFilePath(Application.ExeName) + ARCHIVO_CFG);
end;

function LeerDato (Clave, Etiqueta: string): string;
var
 elArchivo: TIniFile;
begin
   elArchivo:=  AbrirArchivo;
   try
    if (elArchivo <> nil) and (FileExists(elArchivo.FileName))  then
      Result:= elArchivo.ReadString(Clave,Etiqueta, ERROR_CFG)
    else
    begin
     Result:= ERROR_APERTURA_CFG;
    end;
  finally
    elArchivo.Free;
  end;
end;


procedure EscribirDato (Clave, Etiqueta, Dato: string);
var
 elArchivo: TIniFile;
begin
   elArchivo:=  AbrirArchivo;
   try
    if (elArchivo <> nil) and (FileExists(elArchivo.FileName))  then
      elArchivo.WriteString(Clave,Etiqueta, Dato)
  finally
    elArchivo.Free;
  end;
end;


end.
