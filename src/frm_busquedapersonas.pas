unit frm_busquedapersonas;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, db, FileUtil, rxdbgrid, Forms, Controls, Graphics, Dialogs,
  ExtCtrls, Buttons, StdCtrls, dmgeneral, dmbusquedapersonas;

type

  { TfrmBusquedaPersonas }

  TfrmBusquedaPersonas = class(TForm)
    btnAceptar: TBitBtn;
    btnNueva: TBitBtn;
    btnCancelar: TBitBtn;
    ds_resultados: TDataSource;
    edBusqueda: TEdit;
    GrillaColores: TRxDBGrid;
    Label1: TLabel;
    Panel1: TPanel;
    Panel2: TPanel;
    rgCriterio: TRadioGroup;
    procedure btnAceptarClick(Sender: TObject);
    procedure btnCancelarClick(Sender: TObject);
    procedure btnNuevaClick(Sender: TObject);
    procedure edBusquedaKeyPress(Sender: TObject; var Key: char);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    dmBus: TDM_BusquedaPersonas;
    _idGenerador: GUID_ID;
    function getSeleccion: GUID_ID;
    procedure Buscar;
  public
    property personaSeleccionadaID: GUID_ID read getSeleccion;
  end;

var
  frmBusquedaPersonas: TfrmBusquedaPersonas;

implementation
{$R *.lfm}
uses
  frm_personaae;


const
  IDX_Apellido = 0;
  IDX_Documento = 1;

{ TfrmBusquedaPersonas }

procedure TfrmBusquedaPersonas.btnCancelarClick(Sender: TObject);
begin
  ModalResult:= mrCancel;
end;

procedure TfrmBusquedaPersonas.edBusquedaKeyPress(Sender: TObject; var Key: char
  );
begin
  if key = #13 then
    Buscar;
end;

procedure TfrmBusquedaPersonas.FormCreate(Sender: TObject);
begin
  _idGenerador:= GUIDNULO;
  dmBus:= TDM_BusquedaPersonas.Create(self);

  ds_resultados.DataSet:= dmBus.Resultados;

end;

procedure TfrmBusquedaPersonas.FormDestroy(Sender: TObject);
begin
  dmBus.Free;
end;

function TfrmBusquedaPersonas.getSeleccion: GUID_ID;
begin
  if (_idGenerador <> GUIDNULO) then
    Result:= _idGenerador
  else
    if ((dmBus.Resultados.Active) and (dmBus.Resultados.RecordCount > 0)) then
      Result:= dmBus.Resultadosid.AsString
     else
       Result:= GUIDNULO;
end;

procedure TfrmBusquedaPersonas.Buscar;
begin
  case rgCriterio.ItemIndex of
   IDX_Apellido: dmBus.PorApellido(TRIM(edBusqueda.Text));
   IDX_Documento: dmBus.PorDocumento(TRIM(edBusqueda.Text));
  end;
end;

procedure TfrmBusquedaPersonas.btnAceptarClick(Sender: TObject);
begin
  ModalResult:= mrOK;
end;


procedure TfrmBusquedaPersonas.btnNuevaClick(Sender: TObject);
var
  scr: TfrmPersonaAE;
begin
  scr:= TfrmPersonaAE.Create(self);
  try
    Scr.personaID:= GUIDNULO;
    if scr.ShowModal = mrOK then
    begin
      _idGenerador:= scr.personaID;
      ModalResult:= mrOK;
    end;
  finally
    scr.Free;
  end;
end;

end.

