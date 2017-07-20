unit dmbusquedapersonas;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, db, FileUtil, rxmemds, ZDataset
  ,dmgeneral;

type

  { TDM_BusquedaPersonas }

  TDM_BusquedaPersonas = class(TDataModule)
    qPersonaDocumento: TZQuery;
    qPersonaApellidoAPELLIDOS: TStringField;
    qPersonaApellidoAPELLIDOS1: TStringField;
    qPersonaApellidoDOCUMENTO: TStringField;
    qPersonaApellidoDOCUMENTO1: TStringField;
    qPersonaApellidoID: TStringField;
    qPersonaApellidoID1: TStringField;
    qPersonaApellidoNOMBRES: TStringField;
    qPersonaApellidoNOMBRES1: TStringField;
    Resultados: TRxMemoryData;
    ResultadosApellidos: TStringField;
    ResultadosDocumento: TStringField;
    Resultadosid: TStringField;
    ResultadosNombres: TStringField;
    qPersonaApellido: TZQuery;
  private
    procedure CargarTabla (var laConsulta: TZQuery; elParametro: string);
  public
    procedure PorDocumento (elDocumento: string);
    procedure PorApellido (elApellido: string);
  end;

var
  DM_BusquedaPersonas: TDM_BusquedaPersonas;

implementation

{$R *.lfm}

{ TDM_BusquedaPersonas }

procedure TDM_BusquedaPersonas.CargarTabla(var laConsulta: TZQuery;
  elParametro: string);
begin
  DM_General.ReiniciarTabla(Resultados);
  with laConsulta do
  begin
    if active then close;
    ParamByName('parametro').AsString:= elParametro;
    Open;
    Resultados.LoadFromDataSet(laConsulta, 0, lmAppend);
    Close;
  end;
end;

procedure TDM_BusquedaPersonas.PorDocumento(elDocumento: string);
begin
  CargarTabla(qPersonaDocumento, elDocumento);
end;

procedure TDM_BusquedaPersonas.PorApellido(elApellido: string);
begin
  CargarTabla(qPersonaApellido, elApellido);
end;

end.

