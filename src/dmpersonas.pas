unit dmPersonas;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, db, FileUtil, rxmemds, ZDataset
  ,dmgeneral;

type

  { TDM_Personas }

  TDM_Personas = class(TDataModule)
    Personas: TRxMemoryData;
    PersonasApellidos: TStringField;
    PersonasbVisible: TLongintField;
    Personasdireccion: TStringField;
    Personasdocumento: TStringField;
    Personasemail: TStringField;
    PersonasfNacimiento: TDateTimeField;
    Personasid: TStringField;
    Personaslocalidad_id: TLongintField;
    PersonasNombres: TStringField;
    Personassexo_id: TLongintField;
    Personastelefono: TStringField;
    PersonastipoDocumento_id: TLongintField;
    SELPersonas: TZQuery;
    INSPersonas: TZQuery;
    SELPersonasAPELLIDOS: TStringField;
    SELPersonasBVISIBLE: TSmallintField;
    SELPersonasDIRECCION: TStringField;
    SELPersonasDOCUMENTO: TStringField;
    SELPersonasEMAIL: TStringField;
    SELPersonasFNACIMIENTO: TDateField;
    SELPersonasID: TStringField;
    SELPersonasLOCALIDAD_ID: TLongintField;
    SELPersonasNOMBRES: TStringField;
    SELPersonasSEXO_ID: TLongintField;
    SELPersonasTELEFONO: TStringField;
    SELPersonasTIPODOCUMENTO_ID: TLongintField;
    UPDPersonas: TZQuery;
    DELPersonas: TZQuery;
    procedure PersonasAfterInsert(DataSet: TDataSet);
  private
    { private declarations }
  public
    procedure New;
    procedure LoadPersona (refPersona: GUID_ID);
    procedure Save;
  end;

var
  DM_Personas: TDM_Personas;

implementation

{$R *.lfm}

{ TDM_Personas }

procedure TDM_Personas.PersonasAfterInsert(DataSet: TDataSet);
begin
  Personasid.AsString:= DM_General.CrearGUID;
  PersonasApellidos.AsString:= EmptyStr;
  PersonasNombres.AsString:= EmptyStr;
  PersonastipoDocumento_id.AsInteger:= 0;
  Personasdocumento.AsString:= EmptyStr;
  Personassexo_id.AsInteger:= 0;
  PersonasfNacimiento.AsDateTime:= 0;
  Personastelefono.AsString:= EmptyStr;
  Personasdireccion.AsString:= EmptyStr;
  Personaslocalidad_id.AsInteger:= 0;
  Personasemail.AsString:= EmptyStr;
  PersonasbVisible.AsInteger:= 1;
end;

procedure TDM_Personas.New;
begin
  DM_General.ReiniciarTabla(Personas);
  Personas.Insert;
end;

procedure TDM_Personas.LoadPersona(refPersona: GUID_ID);
begin
  DM_General.ReiniciarTabla(Personas);
  with SELPersonas do
  begin
    if active then close;
    ParamByName('id').AsString:= refPersona;
    Open;
    Personas.LoadFromDataSet(SELPersonas, 0, lmAppend);
    Close;
  end;
end;

procedure TDM_Personas.Save;
begin
  DM_General.GrabarDatos(SELPersonas, INSPersonas, UPDPersonas, Personas, 'id');
end;

end.

