unit frm_categoriascarreraae;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, db, FileUtil, rxlookup, Forms, Controls, Graphics, Dialogs,
  ExtCtrls, Buttons, dmcarreras, dmgeneral;

type

  { TfrmCategoriasCarreraAE }

  TfrmCategoriasCarreraAE = class(TForm)
    btnAgregar: TBitBtn;
    btnAceptar: TBitBtn;
    btnCancelar: TBitBtn;
    ds_categoriaCarrera: TDataSource;
    ds_categorias: TDataSource;
    Panel2: TPanel;
    RxDBLookupCombo1: TRxDBLookupCombo;
    procedure btnAceptarClick(Sender: TObject);
    procedure btnCancelarClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    _carreraID: GUID_ID;
    _categoriaID: GUID_ID;
    dmCarr: TDM_Carreras;
  public
    property categoriaID: GUID_ID read _categoriaID write _categoriaID;
    property IDcarrera: GUID_ID read _carreraID write _carreraID;
  end;

var
  frmCategoriasCarreraAE: TfrmCategoriasCarreraAE;

implementation

{$R *.lfm}

{ TfrmCategoriasCarreraAE }

procedure TfrmCategoriasCarreraAE.btnCancelarClick(Sender: TObject);
begin
  ModalResult:= mrCancel;
end;

procedure TfrmCategoriasCarreraAE.FormCreate(Sender: TObject);
begin
  _categoriaID:= GUIDNULO;
  dmCarr:= TDM_Carreras.Create(self);

  ds_categorias.DataSet:= dmCarr.Categorias;
  ds_categoriaCarrera.DataSet:= dmCarr.CategoriasCarrera;

end;

procedure TfrmCategoriasCarreraAE.FormDestroy(Sender: TObject);
begin
  dmCarr.Free;
end;

procedure TfrmCategoriasCarreraAE.FormShow(Sender: TObject);
begin
  if _categoriaID = GUIDNULO then
  begin
    dmCarr.NewCategoria(_carreraID);
  end;
end;

procedure TfrmCategoriasCarreraAE.btnAceptarClick(Sender: TObject);
begin
  ModalResult:= mrOK;
end;

end.

