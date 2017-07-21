unit frm_distanciasae;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, db, Forms, Controls, Graphics, Dialogs, ExtCtrls, Buttons,
  DbCtrls, StdCtrls, DBDateTimePicker, dmgeneral, dmcarreras;

type

  { TfrmDistanciaAE }

  TfrmDistanciaAE = class(TForm)
    btnAceptar: TBitBtn;
    btnCancelar: TBitBtn;
    DBDateTimePicker1: TDBDateTimePicker;
    DBEdit1: TDBEdit;
    dsDistancia: TDataSource;
    Label1: TLabel;
    Label2: TLabel;
    Panel2: TPanel;
    procedure btnAceptarClick(Sender: TObject);
    procedure btnCancelarClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    dmCarre: TDM_Carreras;
    _carreraID: GUID_ID;
    _distanciaID: GUID_ID;
  public
    property distanciaID: GUID_ID read _distanciaID write _distanciaID;
    property IDCarrera: GUID_ID  read _carreraID write _carreraID;
  end;

var
  frmDistanciaAE: TfrmDistanciaAE;

implementation

{$R *.lfm}

{ TfrmDistanciaAE }

procedure TfrmDistanciaAE.btnCancelarClick(Sender: TObject);
begin
  ModalResult:= mrCancel;
end;

procedure TfrmDistanciaAE.FormCreate(Sender: TObject);
begin
  _distanciaID:= GUIDNULO;

  dmCarre:= TDM_Carreras.Create(self);
  dsDistancia.DataSet:= dmCarre.Distancias;

end;

procedure TfrmDistanciaAE.FormDestroy(Sender: TObject);
begin
  dmCarre.Free;
end;

procedure TfrmDistanciaAE.FormShow(Sender: TObject);
begin
  if _distanciaID = GUIDNULO then
  begin
    dmCarre.NewDistancia (_carreraID);
    _distanciaID:= dmCarre.Distanciasid.AsString;
  end
  else
   dmCarre.LoadDistancia(_distanciaID);
end;

procedure TfrmDistanciaAE.btnAceptarClick(Sender: TObject);
begin
  dmCarre.SaveDistancias;
  ModalResult:= mrOK;
end;

end.

