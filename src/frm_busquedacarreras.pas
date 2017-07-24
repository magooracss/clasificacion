unit frm_busquedacarreras;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, db, FileUtil, rxdbgrid, Forms, Controls, Graphics, Dialogs,
  ExtCtrls, Buttons, DBGrids, dmcarreras, dmgeneral;

type

  { TfrmBusquedaCarreras }

  TfrmBusquedaCarreras = class(TForm)
    btnAceptar: TBitBtn;
    btnCancelar: TBitBtn;
    DBGrid1: TDBGrid;
    dsCarrera: TDataSource;
    Panel2: TPanel;
    procedure btnAceptarClick(Sender: TObject);
    procedure btnCancelarClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    dmCarr: TDM_Carreras;
    _idCarreraSeleccionada: GUID_ID;

  public
    property carreraSeleccionadaID: GUID_ID read _idCarreraSeleccionada;
  end;

var
  frmBusquedaCarreras: TfrmBusquedaCarreras;

implementation

{$R *.lfm}

{ TfrmBusquedaCarreras }

procedure TfrmBusquedaCarreras.btnCancelarClick(Sender: TObject);
begin
  ModalResult:= mrCancel;
end;

procedure TfrmBusquedaCarreras.FormCreate(Sender: TObject);
begin
  dmCarr:= TDM_Carreras.Create(self);

  dsCarrera.DataSet := dmCarr.Carrera;
end;

procedure TfrmBusquedaCarreras.FormDestroy(Sender: TObject);
begin
  dmCarr.Free;
end;

procedure TfrmBusquedaCarreras.FormShow(Sender: TObject);
begin
  dmCarr.LoadCarreras;
end;

procedure TfrmBusquedaCarreras.btnAceptarClick(Sender: TObject);
begin
  if ((dmCarr.Carrera.Active)
       and (dmCarr.Carrera.RecordCount > 0 )
     ) then
    _idCarreraSeleccionada:= dmCarr.Carreraid.AsString
  else
    _idCarreraSeleccionada:= GUIDNULO;

  ModalResult:= mrOK;
end;

end.

