unit frm_corredoresae;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, db, FileUtil, rxlookup, Forms, Controls, Graphics, Dialogs,
  ExtCtrls, StdCtrls, Buttons, DbCtrls, DBGrids, DBExtCtrls, dmgeneral,
  dmPersonas, dmcorredores, dmcarreras;

type

  { TfrmCorredoresAE }

  TfrmCorredoresAE = class(TForm)
    btnBuscarPersona: TBitBtn;
    btnAceptar: TBitBtn;
    btnCancelar: TBitBtn;
    DBCheckBox1: TDBCheckBox;
    DBCheckBox2: TDBCheckBox;
    DBCheckBox3: TDBCheckBox;
    DBDateEdit1: TDBDateEdit;
    DBEdit4: TDBEdit;
    DBEdit5: TDBEdit;
    DBEdit6: TDBEdit;
    DBEdit7: TDBEdit;
    DBEdit8: TDBEdit;
    DBText1: TDBText;
    dsCarrera: TDataSource;
    dsCategoria: TDataSource;
    dsDistancia: TDataSource;
    dsTalles: TDataSource;
    dsPersona: TDataSource;
    DBEdit1: TDBEdit;
    DBEdit2: TDBEdit;
    DBEdit3: TDBEdit;
    dsCorredor: TDataSource;
    edDocumento: TEdit;
    edEdad: TEdit;
    GroupBox1: TGroupBox;
    GroupBox2: TGroupBox;
    GroupBox3: TGroupBox;
    Label1: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    Label12: TLabel;
    Label13: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    Panel2: TPanel;
    RxDBLookupCombo1: TRxDBLookupCombo;
    RxDBLookupCombo2: TRxDBLookupCombo;
    RxDBLookupCombo3: TRxDBLookupCombo;
    procedure btnAceptarClick(Sender: TObject);
    procedure btnBuscarPersonaClick(Sender: TObject);
    procedure btnCancelarClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    dmPer: TDM_Personas;
    dmCorr: TDM_Corredores;
    dmCarre: TDM_Carreras;
    _carreraID: GUID_ID;
    _corredorID: GUID_ID;

    procedure DatosPersona;
    procedure AsignarPersona;
  public
    property corredorID: GUID_ID read _corredorID write _corredorID;
    property carreraID: GUID_ID read _carreraID write _carreraID;

  end;

var
  frmCorredoresAE: TfrmCorredoresAE;

implementation
{$R *.lfm}
uses
  dateutils
, frm_busquedapersonas
;

{ TfrmCorredoresAE }

procedure TfrmCorredoresAE.btnCancelarClick(Sender: TObject);
begin
  ModalResult:= mrCancel;
end;

procedure TfrmCorredoresAE.FormCreate(Sender: TObject);
begin
  _corredorID:= GUIDNULO;
  _carreraID:= GUIDNULO;

  dmCorr:= TDM_Corredores.Create(self);
  dmPer:= TDM_Personas.Create(self);
  dmCarre:= TDM_Carreras.Create(self);

  dsPersona.DataSet:= dmPer.Personas;
  dsCorredor.DataSet:= dmCorr.Corredores;
  dsCarrera.DataSet:= dmCarre.Carrera;
  dsCategoria.DataSet:= dmCarre.CategoriasCarrera;
  dsDistancia.DataSet:= dmCarre.Distancias;

end;

procedure TfrmCorredoresAE.FormDestroy(Sender: TObject);
begin
  dmCarre.Free;
  dmPer.Free;
  dmCorr.Free;
end;

procedure TfrmCorredoresAE.FormShow(Sender: TObject);
begin
  dmCarre.LoadCarrera(_carreraID);

  if _corredorID = GUIDNULO then
  begin
    dmCorr.New;
    dmCorr.AsignarCarrera(_carreraID);
  end
  else
  begin
    dmCorr.Load(_corredorID);
    dmPer.LoadPersona(dmCorr.Corredorespersona_id.AsString);
    DatosPersona;
  end;
end;

procedure TfrmCorredoresAE.DatosPersona;
begin
  edDocumento.Text:= dmPer.Personasdocumento.AsString;
  edEdad.Text:= IntToStr(YearsBetween(Now, dmPer.PersonasfNacimiento.asDateTime));
end;

procedure TfrmCorredoresAE.AsignarPersona;
var
  scr: TfrmBusquedaPersonas;
begin
  scr:= TfrmBusquedaPersonas.Create(self);
  try
    if scr.ShowModal = mrOK then
    begin
      dmPer.LoadPersona(scr.personaSeleccionadaID);
      dmCorr.AsignarPersona(scr.personaSeleccionadaID);
      DatosPersona;
    end;
  finally
    scr.Free;
  end;
end;

procedure TfrmCorredoresAE.btnAceptarClick(Sender: TObject);
begin
  dmCorr.Save;
  ModalResult:= mrOK;
end;

procedure TfrmCorredoresAE.btnBuscarPersonaClick(Sender: TObject);
begin
  AsignarPersona;
end;

end.

