unit frm_carrerasae;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, db, FileUtil, rxdbgrid, Forms, Controls, Graphics, Dialogs,
  ExtCtrls, Buttons, DbCtrls, DBExtCtrls, StdCtrls, dmgeneral, dmcarreras;

type

  { TfrmCarreraAE }

  TfrmCarreraAE = class(TForm)
    btnCategoriaDEL: TBitBtn;
    btnDistanciaNEW: TBitBtn;
    btnCategoriaNEW: TBitBtn;
    btnDistanciaUPD: TBitBtn;
    btnDistanciaDEL: TBitBtn;
    btnAceptar: TBitBtn;
    btnCancelar: TBitBtn;
    dsCarrera: TDataSource;
    DBDateEdit1: TDBDateEdit;
    DBEdit1: TDBEdit;
    ds_distancias: TDataSource;
    ds_categorias: TDataSource;
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
    procedure btnCategoriaDELClick(Sender: TObject);
    procedure btnCategoriaNEWClick(Sender: TObject);
    procedure btnDistanciaDELClick(Sender: TObject);
    procedure btnDistanciaNEWClick(Sender: TObject);
    procedure btnDistanciaUPDClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    dmCarr: TDM_Carreras;
    _carreraID: GUID_ID;

    procedure scrDistancias (refDistancia: GUID_ID);
  public
    property carreraID: GUID_ID read _carreraID write _carreraID;
  end;

var
  frmCarreraAE: TfrmCarreraAE;

implementation
{$R *.lfm}
uses
  frm_distanciasae
, frm_categoriascarreraae
;
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
  ds_categorias.DataSet:= dmCarr.CategoriasCarrera;
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

(*******************************************************************************
***  DISTANCIAS
*******************************************************************************)
procedure TfrmCarreraAE.scrDistancias(refDistancia: GUID_ID);
var
  scr: TfrmDistanciaAE;
begin
  scr:= TfrmDistanciaAE.Create(self);
  try
    scr.distanciaID:= refDistancia;
    scr.IDCarrera:= _carreraID;
    if scr.ShowModal = mrOK then
    begin
      dmCarr.LoadDistancias(_carreraID);
    end;
  finally
    scr.Free;
  end;
end;

procedure TfrmCarreraAE.btnDistanciaNEWClick(Sender: TObject);
begin
  scrDistancias(GUIDNULO);
end;

procedure TfrmCarreraAE.btnDistanciaUPDClick(Sender: TObject);
begin
  scrDistancias(ds_distancias.DataSet.FieldByName('id').AsString);
end;

procedure TfrmCarreraAE.btnDistanciaDELClick(Sender: TObject);
begin
  if (MessageDlg ('ATENCION'
                   , 'Borro la distancia seleccionada?'
                   , mtConfirmation, [mbYes, mbNo],0 ) = mrYes) then
  begin
    dmCarr.DeleteDistancia(dmCarr.Distanciasid.asString);
    dmCarr.LoadDistancias(_carreraID);
  end;
end;


(*******************************************************************************
***  CATEGORIAS
*******************************************************************************)
procedure TfrmCarreraAE.btnCategoriaDELClick(Sender: TObject);
begin
  if (MessageDlg ('ATENCION'
                   , 'Borro la categoria seleccionada?'
                   , mtConfirmation, [mbYes, mbNo],0 ) = mrYes) then
  begin
    dmCarr.DeleteCategoria(dmCarr.CategoriasCarreraid.asString);
    dmCarr.LoadCategorias(_carreraID);
  end;
end;

procedure TfrmCarreraAE.btnCategoriaNEWClick(Sender: TObject);
var
  scr: TfrmCategoriasCarreraAE;
begin
  scr:= TfrmCategoriasCarreraAE.Create(self);
  try
    scr.IDcarrera:= _carreraID;
    if scr.ShowModal = mrOK then
       dmCarr.LoadCategorias(_carreraID);
  finally
    scr.Free;
  end;

end;

end.

