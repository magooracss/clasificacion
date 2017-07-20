unit frm_carrerasae;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, db, FileUtil, rxdbgrid, Forms, Controls, Graphics, Dialogs,
  ExtCtrls, Buttons, DbCtrls, DBExtCtrls, StdCtrls, dmgeneral, dmcarreras;

type

  { TfrmCarreraAE }

  TfrmCarreraAE = class(TForm)
    btnDistanciaDEL1: TBitBtn;
    btnDistanciaNEW: TBitBtn;
    btnDistanciaNEW1: TBitBtn;
    btnDistanciaUPD: TBitBtn;
    btnDistanciaDEL: TBitBtn;
    btnAceptar: TBitBtn;
    btnCancelar: TBitBtn;
    btnDistanciaUPD1: TBitBtn;
    dsCarrera: TDataSource;
    DBDateEdit1: TDBDateEdit;
    DBEdit1: TDBEdit;
    ds_distancias: TDataSource;
    GrillaDistancias: TRxDBGrid;
    GrillaDistancias1: TRxDBGrid;
    Label1: TLabel;
    Label2: TLabel;
    Panel1: TPanel;
    Panel2: TPanel;
    Panel3: TPanel;
    Panel4: TPanel;
    Panel5: TPanel;
    Panel6: TPanel;
    StaticText1: TStaticText;
    StaticText2: TStaticText;
    procedure btnAceptarClick(Sender: TObject);
    procedure btnCancelarClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    dmCarr: TDM_Carreras;
    _carreraID: GUID_ID;
  public
    property carreraID: GUID_ID read _carreraID write _carreraID;
  end;

var
  frmCarreraAE: TfrmCarreraAE;

implementation

{$R *.lfm}

{ TfrmCarreraAE }

procedure TfrmCarreraAE.btnCancelarClick(Sender: TObject);
begin
  ModalResult:= mrCancel;
end;

procedure TfrmCarreraAE.FormCreate(Sender: TObject);
begin
  _carreraID:= GUIDNULO;

  dmCarr:= TDM_Carreras.Create(self);

  dsCarrera.DataSet:= dmCarr.Carrera;
  ds_distancias.DataSet:= dmCarr.Distancias;
end;

procedure TfrmCarreraAE.FormDestroy(Sender: TObject);
begin
  dmCarr.Free;
end;

procedure TfrmCarreraAE.FormShow(Sender: TObject);
begin
  if _carreraID = GUIDNULO then
  begin
    dmCarr.New;
    _carreraID:= dmCarr.Carreraid.AsString;
  end
  else
    dmCarr.LoadCarrera(_carreraID);
end;

procedure TfrmCarreraAE.btnAceptarClick(Sender: TObject);
begin
  dmCarr.Save;
  ModalResult:= mrOK;
end;

end.

