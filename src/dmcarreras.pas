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
    Categorias: TRxMemoryData;
    CategoriasbVisible: TLongintField;
    CategoriasCarrerabVisible: TLongintField;
    CategoriasCarreracarrera_id: TStringField;
    CategoriasCarreracategoria_id: TLongintField;
    CategoriasCarreraid: TStringField;
    CategoriasCarreralxCategoria: TStringField;
    Categoriasid: TLongintField;
    Categoriasnombre: TStringField;
    DELCategorias: TZQuery;
    DELDistancias: TZQuery;
    DELCategoriasCarrera: TZQuery;
    DistanciasbVisible: TLongintField;
    Distanciascarrera_id: TStringField;
    DistanciashLargada: TDateTimeField;
    Distanciasid: TStringField;
    DistanciasNombre: TStringField;
    INSCategorias: TZQuery;
    INSDistancia: TZQuery;
    INSCategoriasCarrera: TZQuery;
    qCategorias: TZQuery;
    qDistanciasCarrera: TZQuery;
    qCarrerasBVISIBLE: TSmallintField;
    qCarrerasFECHA: TDateField;
    qCarrerasID: TStringField;
    qCarrerasNOMBRE: TStringField;
    Distancias: TRxMemoryData;
    qCategoriasCarrera: TZQuery;
    qCategoriasCarreraBVISIBLE: TSmallintField;
    qCategoriasCarreraCARRERA_ID: TStringField;
    qCategoriasCarreraCATEGORIA_ID: TLongintField;
    qCategoriasCarreraID: TStringField;
    qCategoriasCarreraLXCATEGORIA: TStringField;
    qDistanciasCarreraBVISIBLE: TSmallintField;
    qDistanciasCarreraCARRERA_ID: TStringField;
    qDistanciasCarreraHLARGADA: TTimeField;
    qDistanciasCarreraID: TStringField;
    qDistanciasCarreraNOMBRE: TStringField;
    CategoriasCarrera: TRxMemoryData;
    SELCarrera: TZQuery;
    qCarreras: TZQuery;
    SELCategorias: TZQuery;
    SELCategoriasBVISIBLE: TSmallintField;
    SELCategoriasCarreraBVISIBLE: TSmallintField;
    SELCategoriasCarreraCARRERA_ID: TStringField;
    SELCategoriasCarreraCATEGORIA_ID: TLongintField;
    SELCategoriasCarreraID: TStringField;
    SELCategoriasCarreraLXCATEGORIA: TStringField;
    SELCategoriasID: TLongintField;
    SELCategoriasNOMBRE: TStringField;
    SELDistancia: TZQuery;
    SELCarreraBVISIBLE: TSmallintField;
    SELCarreraFECHA: TDateField;
    SELCarreraID: TStringField;
    SELCarreraNOMBRE: TStringField;
    INSCarrera: TZQuery;
    SELCategoriasCarrera: TZQuery;
    SELDistanciaBVISIBLE: TSmallintField;
    SELDistanciaCARRERA_ID: TStringField;
    SELDistanciaHLARGADA: TTimeField;
    SELDistanciaID: TStringField;
    SELDistanciaNOMBRE: TStringField;
    qCategoriasBVISIBLE: TSmallintField;
    qCategoriasID: TLongintField;
    qCategoriasNOMBRE: TStringField;
    UPDCarrera: TZQuery;
    DELCarrera: TZQuery;
    UPDCategorias: TZQuery;
    UPDDistancia: TZQuery;
    UPDCategoriasCarrera: TZQuery;
    procedure CarreraAfterInsert(DataSet: TDataSet);
    procedure CategoriasAfterInsert(DataSet: TDataSet);
    procedure CategoriasCarreraAfterInsert(DataSet: TDataSet);
    procedure DataModuleCreate(Sender: TObject);
    procedure DistanciasAfterInsert(DataSet: TDataSet);
  private
    _carreraID: GUID_ID;
  public
    property IDcarrera: GUID_ID read _carreraID write _carreraID;

    procedure New;
    procedure LoadCarrera (refCarrera: GUID_ID);
    procedure Save;
    procedure LoadCarreras;
    procedure DeleteCarrera (refCarrera: GUID_ID);

    procedure LoadDistancias (refCarrera: GUID_ID);
    procedure SaveDistancias;
    procedure NewDistancia (refCarrera: GUID_ID);
    procedure LoadDistancia (refDistancia: GUID_ID);
    procedure DeleteDistancia (refDistancia: GUID_ID);

    procedure LoadCategorias (refCarrera: GUID_ID);
    procedure SaveCategorias;
    procedure NewCategoria (refCarrera: GUID_ID);
    procedure LoadCategoria (refCategoria: GUID_ID);
    procedure DeleteCategoria (refCategoria: GUID_ID);

    procedure CategoriasTUGLoad;

    procedure CategoriaNew;
    procedure CategoriaEdit (refCategoria: integer);
    procedure CategoriaDel (refCategoria: integer);
    procedure CategoriaSave;

  end;

var
  DM_Carreras: TDM_Carreras;

implementation

{$R *.lfm}

{ TDM_Carreras }

procedure TDM_Carreras.CarreraAfterInsert(DataSet: TDataSet);
begin
  _carreraID:= DM_General.CrearGUID;
  Carreraid.AsString:= _carreraID;
  CarreraFecha.AsDateTime:= Now;
  CarreraNombre.AsString:= EmptyStr;
  CarrerabVisible.AsInteger:= 1;
end;

procedure TDM_Carreras.CategoriasAfterInsert(DataSet: TDataSet);
begin
  Categoriasid.AsInteger:= -1;
  Categoriasnombre.AsString:= EmptyStr;
  CategoriasbVisible.AsInteger:= 1;
end;

procedure TDM_Carreras.CategoriasCarreraAfterInsert(DataSet: TDataSet);
begin
  CategoriasCarreraid.AsString:= DM_General.CrearGUID;
  CategoriasCarreracarrera_id.AsString:= _carreraID;
  CategoriasCarreracategoria_id.AsInteger:= 0;
  CategoriasCarrerabVisible.AsInteger:= 1;
end;

procedure TDM_Carreras.DataModuleCreate(Sender: TObject);
begin
  CategoriasTUGLoad;
end;

procedure TDM_Carreras.DistanciasAfterInsert(DataSet: TDataSet);
begin
  Distanciasid.AsString:= DM_General.CrearGUID;
  Distanciascarrera_id.AsString:= _carreraID;
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
   _carreraID:= refCarrera;
  with SELCarrera do
  begin
    if active then close;
    ParamByName('id').AsString:= refCarrera;
    Open;
    Carrera.LoadFromDataSet(SELCarrera, 0, lmAppend);
    Close;
  end;

  LoadDistancias(refCarrera);
  LoadCategorias(refCarrera);
end;

procedure TDM_Carreras.Save;
begin
  DM_General.cnxBase.StartTransaction;
  try
    DM_General.GrabarDatos(SELCarrera, INSCarrera, UPDCarrera, Carrera, 'id');
    SaveDistancias;
    SaveCategorias;
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

procedure TDM_Carreras.NewDistancia(refCarrera: GUID_ID);
begin
  DM_General.ReiniciarTabla(Distancias);
  _carreraID:= refCarrera;
  Distancias.Insert;
end;

procedure TDM_Carreras.LoadDistancia(refDistancia: GUID_ID);
begin
  DM_General.ReiniciarTabla(Distancias);
  with SELDistancia do
  begin
    if active then close;
    ParamByName('id').AsString:= refDistancia;
    Open;
    Distancias.LoadFromDataSet(SELDistancia, 0, lmAppend);
    Close;
  end;
end;

procedure TDM_Carreras.DeleteDistancia(refDistancia: GUID_ID);
begin
  DELDistancias.ParamByName('id').AsString:= refDistancia;
  DELDistancias.ExecSQL;
end;

procedure TDM_Carreras.LoadCategorias(refCarrera: GUID_ID);
begin
  DM_General.ReiniciarTabla(CategoriasCarrera);
  with qCategoriasCarrera do
  begin
    if active then close;
    ParamByName('carrera_id').AsString:= refCarrera;
    Open;
    CategoriasCarrera.LoadFromDataSet(qCategoriasCarrera, 0, lmAppend);
    Close;
  end;
end;

procedure TDM_Carreras.SaveCategorias;
begin
  DM_General.GrabarDatos(SELCategoriasCarrera, INSCategoriasCarrera, UPDCategoriasCarrera, CategoriasCarrera, 'id');
end;

procedure TDM_Carreras.NewCategoria(refCarrera: GUID_ID);
begin
  DM_General.ReiniciarTabla(CategoriasCarrera);
  _carreraID:= refCarrera;
  CategoriasCarrera.Insert;
end;

procedure TDM_Carreras.LoadCategoria(refCategoria: GUID_ID);
begin
  DM_General.ReiniciarTabla(CategoriasCarrera);
  with SELCategoriasCarrera do
  begin
    if active then close;
    ParamByName('id').AsString:= refCategoria;
    Open;
    CategoriasCarrera.LoadFromDataSet(SELCategoriasCarrera, 0, lmAppend);
    Close;
  end;
end;

procedure TDM_Carreras.DeleteCategoria(refCategoria: GUID_ID);
begin
  DELCategoriasCarrera.ParamByName('id').AsString:= refCategoria;
  DELCategoriasCarrera.ExecSQL;
end;

procedure TDM_Carreras.CategoriasTUGLoad;
begin
  DM_General.ReiniciarTabla(Categorias);
  with qCategorias do
  begin
    if active then close;
    Open;
    Categorias.LoadFromDataSet(qCategorias, 0, lmAppend);
    Close;
  end;
end;

procedure TDM_Carreras.CategoriaNew;
begin
  DM_General.ReiniciarTabla(Categorias);
  Categorias.Insert;

end;

procedure TDM_Carreras.CategoriaEdit(refCategoria: integer);
begin
  DM_General.ReiniciarTabla(Categorias);
  with SELCategorias do
  begin
    if Active then Close;
    ParamByName('id').AsInteger:= refCategoria;
    Open;
    Categorias.LoadFromDataSet(SELCategorias, 0, lmAppend);
    Close;
    if Categorias.RecordCount > 0 then
       Categorias.Edit;
  end;
end;

procedure TDM_Carreras.CategoriaDel(refCategoria: integer);
begin
  DELCategorias.ParamByName('id').asInteger:= refCategoria;
  DELCategorias.ExecSQL;
end;

procedure TDM_Carreras.CategoriaSave;
begin
  DM_General.GrabarDatos(SELCategorias, INSCategorias, UPDCategorias, Categorias, 'id');
end;

end.

