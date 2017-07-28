unit frm_llegadas;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, db, FileUtil, DateTimePicker, Forms, Controls, Graphics,
  Dialogs, ExtCtrls, Buttons, StdCtrls, ComCtrls, DbCtrls,
  dmgeneral, dmcorredores, dmPersonas;

type

  { TfrmLlegadas }

  TfrmLlegadas = class(TForm)
    btnNuevo: TBitBtn;
    btnSalir: TBitBtn;
    ckReloj: TCheckBox;
    dsPersona: TDataSource;
    DBText1: TDBText;
    DBText2: TDBText;
    DBText3: TDBText;
    edLlegada: TDateTimePicker;
    edNro: TEdit;
    PCBusquedas: TPageControl;
    Panel1: TPanel;
    Panel2: TPanel;
    tabNro: TTabSheet;
    aTimer: TTimer;
    procedure btnNuevoClick(Sender: TObject);
    procedure btnSalirClick(Sender: TObject);
    procedure ckRelojChange(Sender: TObject);
    procedure edNroKeyPress(Sender: TObject; var Key: char);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure aTimerTimer(Sender: TObject);
  private
    dmCorr: TDM_Corredores;
    dmPer: TDM_Personas;
    _carreraID: GUID_ID;
    procedure Buscar;
  public
    property carreraID: GUID_ID read _carreraID write _carreraID;
  end;

var
  frmLlegadas: TfrmLlegadas;

implementation
{$R *.lfm}

const
  idx_nro = 0;

{ TfrmLlegadas }

procedure TfrmLlegadas.edNroKeyPress(Sender: TObject; var Key: char);
begin
  if key = #13 then
     Buscar;
end;

procedure TfrmLlegadas.btnNuevoClick(Sender: TObject);
begin
  aTimer.Enabled:= true;
  edNro.SetFocus;
  edNro.Clear;
  DM_General.ReiniciarTabla(dmCorr.Corredores);
  DM_General.ReiniciarTabla(dmPer.Personas);
end;

procedure TfrmLlegadas.btnSalirClick(Sender: TObject);
begin
  ModalResult:= mrOK;
end;

procedure TfrmLlegadas.ckRelojChange(Sender: TObject);
begin
  aTimer.Enabled:= not ckReloj.Checked;
end;


procedure TfrmLlegadas.FormCreate(Sender: TObject);
begin
  dmCorr:= TDM_Corredores.Create(self);
  dmPer:= TDM_Personas.Create(self);

  dsPersona.DataSet:= dmPer.Personas;

end;

procedure TfrmLlegadas.FormDestroy(Sender: TObject);
begin
  dmCorr.Free;
  dmPer.Free;
end;

procedure TfrmLlegadas.FormShow(Sender: TObject);
begin
  edLlegada.Time:= Time;
  edLlegada.SetFocus;
end;

procedure TfrmLlegadas.aTimerTimer(Sender: TObject);
begin
  edLlegada.Time:= Time;
end;

procedure TfrmLlegadas.Buscar;
begin
  case PCBusquedas.ActivePageIndex of
   idx_nro:
   begin
     if dmCorr.findCorredorNro(_carreraID, strToIntDef (edNro.Text, -1)) then
     begin
        dmCorr.AsignarLlegada(edLlegada.Time);
        dmPer.LoadPersona(dmCorr.Corredorespersona_id.AsString);
        btnNuevo.SetFocus;
     end;
   end;
  end;
end;

end.

