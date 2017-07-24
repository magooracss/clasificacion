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
    Corredorescategoria_id: TStringField;
    Corredoresdistancia_id: TStringField;
    CorredoresfPago: TDateTimeField;
    Corredoresid: TStringField;
    Corredoresimporte: TFloatField;
    Corredoresnumero: TLongintField;
    Corredorespersona_id: TStringField;
    Corredoresrecibo: TStringField;
    Corredorestalle_id: TLongintField;
    SELCorredoresBINVITADO3: TSmallintField;
    SELCorredoresBLISTAESPERA3: TSmallintField;
    SELCorredoresBPAGADO3: TSmallintField;
    SELCorredoresBVISIBLE3: TSmallintField;
    SELCorredoresCARRERA_ID3: TStringField;
    SELCorredoresDISTANCIA_ID3: TStringField;
    SELCorredoresFPAGO3: TDateField;
    SELCorredoresID3: TStringField;
    SELCorredoresIMPORTE3: TFloatField;
    SELCorredoresNUMERO3: TLongintField;
    SELCorredoresPERSONA_ID3: TStringField;
    SELCorredoresRECIBO3: TStringField;
    SELCorredoresTALLE_ID3: TLongintField;
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
    SELCorredoresDISTANCIA_ID: TStringField;
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
  private

  public

    procedure New;
    procedure Load (refCorredor: GUID_ID);
    procedure Delete (refCorredor: GUID_ID);
    procedure Save;

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
  Corredoresdistancia_id.AsString:= GUIDNULO;
  Corredorescategoria_id.AsString:= GUIDNULO;
  Corredoresnumero.AsInteger:= 0;
  Corredorestalle_id.AsInteger:= 0;
  CorredoresbInvitado.AsInteger:= 0;
  CorredoresbPagado.AsInteger:= 0;
  Corredoresimporte.AsFloat:= 0;
  Corredoresrecibo.AsString:= EmptyStr;
  CorredoresfPago.AsDateTime:= 0;
  CorredoresbListaEspera.AsInteger:= 0;
  CorredoresbVisible.AsInteger:= 0;
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
    Corredores.LoadFromDataSet(Corredores, 0, lmAppend);
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

end.

