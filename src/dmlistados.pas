unit dmlistados;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, db, FileUtil, rxmemds, ZDataset, dmgeneral;

type

  { TDM_Listados }

  TDM_Listados = class(TDataModule)
    qClasificaciones: TZQuery;
    qClasificacionesAPYNOM: TStringField;
    qClasificacionesCATEGORIA: TStringField;
    qClasificacionesCATEGORIA_ID: TLongintField;
    qClasificacionesCORREDOR_ID: TStringField;
    qClasificacionesDISTANCIA: TStringField;
    qClasificacionesDISTANCIA_ID: TLongintField;
    qClasificacionesHLARGADA: TTimeField;
    qClasificacionesHLLEGADA: TTimeField;
    qClasificacionesNUMERO: TLongintField;
    qClasificacionesPERSONA_ID: TStringField;
    qClasificacionesTIEMPOSEGUNDOS: TLargeintField;
    qClasificacionesTIEMPOTOTAL: TFloatField;
    ResultadosCarrera: TRxMemoryData;
    ResultadosCarreraApyNom: TStringField;
    ResultadosCarreracategoria: TStringField;
    ResultadosCarreracategoria_id: TLongintField;
    ResultadosCarreracorredor_id: TStringField;
    ResultadosCarreradistancia: TStringField;
    ResultadosCarreradistancia_id: TLongintField;
    ResultadosCarrerahLargada: TTimeField;
    ResultadosCarrerahLlegada: TTimeField;
    ResultadosCarreranumero: TLongintField;
    ResultadosCarrerapersona_id: TStringField;
    ResultadosCarreraTiempoSegundos: TLargeintField;
    ResultadosCarreraTiempoTotal: TTimeField;
  private
    function ConvertirSegundos (eltiempo: LongInt): TTime;
    procedure CalcularTiempos;
  public
    procedure Clasificaciones (refCarrera: GUID_ID);
  end;

var
  DM_Listados: TDM_Listados;

implementation
uses
  dateutil
;
{$R *.lfm}

{ TDM_Listados }

function TDM_Listados.ConvertirSegundos(eltiempo: LongInt): TTime;
var
  h: TTime;
begin
  h:= 0;
  Result:= IncSecond(h, eltiempo);
end;

procedure TDM_Listados.CalcularTiempos;
var
  elTiempo: TTime;
begin
  with ResultadosCarrera do
  begin
    DisableControls;
    if (RecordCount > 0) then
    begin
      First;
      while (Not EOF) do
      begin
        elTiempo:= ConvertirSegundos(ResultadosCarreraTiempoSegundos.AsInteger);
        if elTiempo = 0 then
        begin
          ResultadosCarrera.Delete;
          First;
        end
        else
        begin
          Edit;
          ResultadosCarreraTiempoTotal.AsDateTime:= elTiempo;
          Post;
        end;
        Next;
      end;
    end;
    EnableControls;
  end;
end;

procedure TDM_Listados.Clasificaciones(refCarrera: GUID_ID);
begin
  DM_General.ReiniciarTabla(ResultadosCarrera);

  with qClasificaciones do
  begin
    if active then close;
    ParamByName('carrera_id').AsString:= refCarrera;
    Open;
    ResultadosCarrera.LoadFromDataSet(qClasificaciones, 0, lmAppend);
    Close;
  end;
  CalcularTiempos;
  ResultadosCarrera.SortOnFields('Distancia;Categoria;TiempoTotal',False,False);
end;

end.

