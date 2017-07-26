unit dmcorredores;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, db, FileUtil, rxmemds, ZDataset
  ,dmgeneral;

type

  { TDM_Corredores }

  TDM_Corredores = class(TDataModule)
    Corredores: TRxMemoryData;
    CorredoresbInvitado: TLongintField;
    CorredoresbListaEspera: TLongintField;
    CorredoresbPagado: TLongintField;
    CorredoresbVisible: TLongintField;
    Corredorescarrera_id: TStringField;
    Corredorescategoria_id: TLongintField;
    Corredoresdistancia_id: TLongintField;
    CorredoresfPago: TDateTimeField;
    CorredoreshLlegada: TDateTimeField;
    Corredoresid: TStringField;
    Corredoresimporte: TFloatField;
    Corredoresnumero: TLongintField;
    Corredorespersona_id: TStringField;
    Corredoresrecibo: TStringField;
    Corredorestalle_id: TLongintField;
    SELCorredoresHLLEGADA: TTimeField;
    tugTalles: TZQuery;
    SELCorredoresBINVITADO3: TSmallintField;
    SELCorredoresBLISTAESPERA3: TSmallintField;
    SELCorredoresBPAGADO3: TSmallintField;
    SELCorredoresBVISIBLE3: TSmallintField;
    SELCorredoresCARRERA_ID3: TStringField;
    SELCorredoresCATEGORIA_ID: TLongintField;
    SELCorredoresDISTANCIA_ID: TLongintField;
    SELCorredoresDISTANCIA_ID3: TStringField;
    SELCorredoresFPAGO3: TDateField;
    SELCorredoresID3: TStringField;
    SELCorredoresIMPORTE3: TFloatField;
    SELCorredoresNUMERO3: TLongintField;
    SELCorredoresPERSONA_ID3: TStringField;
    SELCorredoresRECIBO3: TStringField;
    SELCorredoresTALLE_ID3: TLongintField;
    tugTallesBVISIBLE: TSmallintField;
    tugTallesID: TLongintField;
    tugTallesTALLE: TStringField;
    UPDCorredores: TZQuery;
    SELCorredores: TZQuery;
    INSCorredores: TZQuery;
    SELCorredoresBINVITADO: TSmallintField;
    SELCorredoresBINVITADO1: TSmallintField;
    SELCorredoresBINVITADO2: TSmallintField;
    SELCorredoresBLISTAESPERA: TSmallintField;
    SELCorredoresBLISTAESPERA1: TSmallintField;
    SELCorredoresBLISTAESPERA2: TSmallintField;
    SELCorredoresBPAGADO: TSmallintField;
    SELCorredoresBPAGADO1: TSmallintField;
    SELCorredoresBPAGADO2: TSmallintField;
    SELCorredoresBVISIBLE: TSmallintField;
    SELCorredoresBVISIBLE1: TSmallintField;
    SELCorredoresBVISIBLE2: TSmallintField;
    SELCorredoresCARRERA_ID: TStringField;
    SELCorredoresCARRERA_ID1: TStringField;
    SELCorredoresCARRERA_ID2: TStringField;
    SELCorredoresDISTANCIA_ID1: TStringField;
    SELCorredoresDISTANCIA_ID2: TStringField;
    SELCorredoresFPAGO: TDateField;
    SELCorredoresFPAGO1: TDateField;
    SELCorredoresFPAGO2: TDateField;
    SELCorredoresID: TStringField;
    SELCorredoresID1: TStringField;
    SELCorredoresID2: TStringField;
    SELCorredoresIMPORTE: TFloatField;
    SELCorredoresIMPORTE1: TFloatField;
    SELCorredoresIMPORTE2: TFloatField;
    SELCorredoresNUMERO: TLongintField;
    SELCorredoresNUMERO1: TLongintField;
    SELCorredoresNUMERO2: TLongintField;
    SELCorredoresPERSONA_ID: TStringField;
    SELCorredoresPERSONA_ID1: TStringField;
    SELCorredoresPERSONA_ID2: TStringField;
    SELCorredoresRECIBO: TStringField;
    SELCorredoresRECIBO1: TStringField;
    SELCorredoresRECIBO2: TStringField;
    SELCorredoresTALLE_ID: TLongintField;
    SELCorredoresTALLE_ID1: TLongintField;
    SELCorredoresTALLE_ID2: TLongintField;
    DELCorredores: TZQuery;
    procedure CorredoresAfterInsert(DataSet: TDataSet);
    procedure DataModuleCreate(Sender: TObject);
  private

  public

    procedure New;
    procedure Load (refCorredor: GUID_ID);
    procedure Delete (refCorredor: GUID_ID);
    procedure Save;

    procedure AsignarPersona (persona_id: GUID_ID);
    procedure AsignarCarrera (carrera_id: GUID_ID);

  end;

var
  DM_Corredores: TDM_Corredores;

implementation

{$R *.lfm}

{ TDM_Corredores }

procedure TDM_Corredores.CorredoresAfterInsert(DataSet: TDataSet);
begin
  Corredoresid.AsString:= DM_General.CrearGUID;
  Corredorespersona_id.AsString:= GUIDNULO;
  Corredorescarrera_id.AsString:= GUIDNULO;
  Corredoresdistancia_id.AsInteger:= 0;
  Corredorescategoria_id.AsInteger:= 0;
  Corredoresnumero.AsInteger:= 0;
  Corredorestalle_id.AsInteger:= 0;
  CorredoresbInvitado.AsInteger:= 0;
  CorredoresbPagado.AsInteger:= 0;
  Corredoresimporte.AsFloat:= 0;
  Corredoresrecibo.AsString:= EmptyStr;
  CorredoresfPago.AsDateTime:= 0;
  CorredoresbListaEspera.AsInteger:= 0;
  CorredoresbVisible.AsInteger:= 1;
end;

procedure TDM_Corredores.DataModuleCreate(Sender: TObject);
begin
  tugTalles.Open;
end;

procedure TDM_Corredores.New;
begin
  DM_General.ReiniciarTabla(Corredores);
  Corredores.Insert;
end;

procedure TDM_Corredores.Load(refCorredor: GUID_ID);
begin
  DM_General.ReiniciarTabla(Corredores);
  With SELCorredores do
  begin
    if active then close;
    ParamByName('id').AsString:= refCorredor;
    Open;
    Corredores.LoadFromDataSet(SELCorredores, 0, lmAppend);
    Close;
  end;
end;

procedure TDM_Corredores.Delete(refCorredor: GUID_ID);
begin
  DELCorredores.ParamByName('id').AsString:= refCorredor;
  DELCorredores.ExecSQL;
end;

procedure TDM_Corredores.Save;
begin
  DM_General.GrabarDatos(SELCorredores, INSCorredores, UPDCorredores, Corredores, 'id');
end;

procedure TDM_Corredores.AsignarPersona(persona_id: GUID_ID);
begin
  Corredores.Edit;
  Corredorespersona_id.AsString:= persona_id;
  Corredores.Post;
end;

procedure TDM_Corredores.AsignarCarrera(carrera_id: GUID_ID);
begin
  Corredores.Edit;
  Corredorescarrera_id.AsString:= carrera_id;
  Corredores.Post;

end;


end.

