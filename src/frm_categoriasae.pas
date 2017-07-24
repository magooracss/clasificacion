unit frm_categoriasae;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, db, FileUtil, rxmemds, rxdbgrid, Forms, Controls, Graphics,
  Dialogs, ExtCtrls, Buttons, DBGrids, StdCtrls, DbCtrls, dmgeneral, dmcarreras;

type

  { TfrmCategoriasAE }

  TfrmCategoriasAE = class(TForm)
    btnAceptar: TBitBtn;
    btnNew: TButton;
    btnSave: TButton;
    dsCategorias: TDataSource;
    edCategoria: TDBEdit;
    DBGrid1: TDBGrid;
    Panel1: TPanel;
    Panel2: TPanel;
    procedure btnAceptarClick(Sender: TObject);
    procedure btnNewClick(Sender: TObject);
    procedure btnSaveClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    dmCarr: TDM_Carreras;
  public

  end;

var
  frmCategoriasAE: TfrmCategoriasAE;

implementation

{$R *.lfm}

{ TfrmCategoriasAE }

procedure TfrmCategoriasAE.FormDestroy(Sender: TObject);
begin
  dmCarr.Free;
end;

procedure TfrmCategoriasAE.FormShow(Sender: TObject);
begin
  dmCarr.CategoriasTUGLoad;
end;

procedure TfrmCategoriasAE.FormCreate(Sender: TObject);
begin
  dmCarr:= TDM_Carreras.Create(self);
  dsCategorias.DataSet:= dmCarr.Categorias;
end;

procedure TfrmCategoriasAE.btnNewClick(Sender: TObject);
begin
  dmCarr.CategoriaNew;
  edCategoria.SetFocus;
end;

procedure TfrmCategoriasAE.btnAceptarClick(Sender: TObject);
begin
  ModalResult:= mrOK;
end;

procedure TfrmCategoriasAE.btnSaveClick(Sender: TObject);
begin
  dmCarr.CategoriaSave;
  dmCarr.CategoriasTUGLoad;
  btnNew.SetFocus;
end;

end.

