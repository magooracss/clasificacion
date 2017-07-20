unit dmcarreras;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, db, FileUtil, rxmemds, ZDataset, dmgeneral;

type

  { TDM_Carreras }

  TDM_Carreras = class(TDataModule)
    Carrera: TRxMemoryData;
    CarrerabVisible: TLongintField;
    CarreraFecha: TDateTimeField;
    Carreraid: TStringField;
    CarreraNombre: TStringField;
    DELDistancias: TZQuery;
    DistanciasbVisible: TLongintField;
    Distanciascarrera_id: TStringField;
    DistanciashLargada: TDateTimeField;
    Distanciasid: TStringField;
    DistanciasNombre: TStringField;
    INSDistancia: TZQuery;
    qDistanciasCarrera: TZQuery;
    qCarrerasBVISIBLE: TSmallintField;
    qCarrerasFECHA: TDateField;
    qCarrerasID: TStringField;
    qCarrerasNOMBRE: TStringField;
    Distancias: TRxMemoryData;
    qDistanciasCarreraBVISIBLE: TSmallintField;
    qDistanciasCarreraCARRERA_ID: TStringField;
    qDistanciasCarreraHLARGADA: TTimeField;
    qDistanciasCarreraID: TStringField;
    qDistanciasCarreraNOMBRE: TStringField;
    SELCarrera: TZQuery;
    qCarreras: TZQuery;
    SELDistancia: TZQuery;
    SELCarreraBVISIBLE: TSmallintField;
    SELCarreraFECHA: TDateField;
    SELCarreraID: TStringField;
    SELCarreraNOMBRE: TStringField;
    INSCarrera: TZQuery;
    SELDistanciaBVISIBLE: TSmallintField;
    SELDistanciaCARRERA_ID: TStringField;
    SELDistanciaHLARGADA: TTimeField;
    SELDistanciaID: TStringField;
    SELDistanciaNOMBRE: TStringField;
    UPDCarrera: TZQuery;
    DELCarrera: TZQuery;
    UPDDistancia: TZQuery;
    procedure CarreraAfterInsert(DataSet: TDataSet);
    procedure DistanciasAfterInsert(DataSet: TDataSet);
  private
    { private declarations }
  public
    procedure New;
    procedure LoadCarrera (refCarrera: GUID_ID);
    procedure Save;
    procedure LoadCarreras;
    procedure DeleteCarrera (refCarrera: GUID_ID);

    procedure LoadDistancias (refCarrera: GUID_ID);
    procedure SaveDistancias;
  end;

var
  DM_Carreras: TDM_Carreras;

implementation

{$R *.lfm}

{ TDM_Carreras }

procedure TDM_Carreras.CarreraAfterInsert(DataSet: TDataSet);
begin
  Carreraid.AsString:= DM_General.CrearGUID;
  CarreraFecha.AsDateTime:= Now;
  CarreraNombre.AsString:= EmptyStr;
  CarrerabVisible.AsInteger:= 1;
end;

procedure TDM_Carreras.DistanciasAfterInsert(DataSet: TDataSet);
begin
  Distanciasid.AsString:= DM_General.CrearGUID;
  Distanciascarrera_id.AsString:= Carreraid.AsString;
  DistanciashLargada.AsDateTime:= Now;
  DistanciasNombre.AsString:= EmptyStr;
  DistanciasbVisible.AsInteger:= 1;
end;

procedure TDM_Carreras.New;
begin
  DM_General.ReiniciarTabla(Carrera);
  Carrera.Insert;
end;

procedure TDM_Carreras.LoadCarrera(refCarrera: GUID_ID);
begin
  DM_General.ReiniciarTabla(Carrera);

  with SELCarrera do
  begin
    if active then close;
    ParamByName('id').AsString:= refCarrera;
    Open;
    Carrera.LoadFromDataSet(SELCarrera, 0, lmAppend);
    Close;
  end;

  LoadDistancias(refCarrera);
end;

procedure TDM_Carreras.Save;
begin
  DM_General.cnxBase.StartTransaction;
  try
    DM_General.GrabarDatos(SELCarrera, INSCarrera, UPDCarrera, Carrera, 'id');
    SaveDistancias;
    DM_General.cnxBase.Commit;
  except
    DM_General.cnxBase.Rollback;
  end;

end;

procedure TDM_Carreras.LoadCarreras;
begin
  DM_General.ReiniciarTabla(Carrera);

  with qCarreras do
  begin
    if active then close;
    Open;
    Carrera.LoadFromDataSet(qCarreras, 0, lmAppend);
    Close;
  end;

end;

procedure TDM_Carreras.DeleteCarrera(refCarrera: GUID_ID);
begin
  DELCarrera.ParamByName('id').AsString:= refCarrera;
  DELCarrera.ExecSQL;
end;

procedure TDM_Carreras.LoadDistancias(refCarrera: GUID_ID);
begin
  DM_General.ReiniciarTabla(Distancias);
  with qDistanciasCarrera do
  begin
    if active then close;
    ParamByName('carrera_id').AsString:= refCarrera;
    Open;
    Distancias.LoadFromDataSet(qDistanciasCarrera, 0, lmAppend);
    Close;
  end;
end;

procedure TDM_Carreras.SaveDistancias;
begin
  DM_General.GrabarDatos(SELDistancia, INSDistancia, UPDDistancia, Distancias, 'id');
end;

end.

