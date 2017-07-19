unit frm_personaae;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, db, FileUtil, rxlookup, DBDateTimePicker, Forms, Controls,
  Graphics, Dialogs, ExtCtrls, DbCtrls, StdCtrls, ComCtrls, Buttons, DBExtCtrls,
  dmPersonas, dmgeneral;

type

  { TfrmPersonaAE }

  TfrmPersonaAE = class(TForm)
    btnAceptar: TBitBtn;
    btnCancelar: TBitBtn;
    DBDateEdit1: TDBDateEdit;
    DBEdit1: TDBEdit;
    DBEdit2: TDBEdit;
    DBEdit3: TDBEdit;
    DBEdit4: TDBEdit;
    DBEdit5: TDBEdit;
    DBEdit6: TDBEdit;
    ds_personas: TDataSource;
    GroupBox1: TGroupBox;
    GroupBox2: TGroupBox;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    PageControl1: TPageControl;
    Panel1: TPanel;
    Panel2: TPanel;
    RxDBLookupCombo1: TRxDBLookupCombo;
    RxDBLookupCombo2: TRxDBLookupCombo;
    RxDBLookupCombo3: TRxDBLookupCombo;
    TabSheet1: TTabSheet;
    procedure btnAceptarClick(Sender: TObject);
    procedure btnCancelarClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    dmPer: TDM_Personas;
    _personaID: GUID_ID;
    procedure initialise;
  public
    property personaID: GUID_ID read _personaID write _personaID;
  end;

var
  frmPersonaAE: TfrmPersonaAE;

implementation

{$R *.lfm}

{ TfrmPersonaAE }

procedure TfrmPersonaAE.FormCreate(Sender: TObject);
begin
  dmPer:= TDM_Personas.Create(self);

  ds_personas.DataSet:= dmPer.Personas;
end;

procedure TfrmPersonaAE.btnCancelarClick(Sender: TObject);
begin
  ModalResult:= mrCancel;
end;

procedure TfrmPersonaAE.btnAceptarClick(Sender: TObject);
begin
  dmPer.Save;
  ModalResult:= mrOK;
end;

procedure TfrmPersonaAE.FormDestroy(Sender: TObject);
begin
  dmPer.Free;
end;

procedure TfrmPersonaAE.FormShow(Sender: TObject);
begin
  initialise;
end;

procedure TfrmPersonaAE.initialise;
begin
   if _personaID = GUIDNULO then
   begin
      dmPer.New;
      _personaID:= dmPer.Personasid.AsString;
   end
   else
     dmPer.LoadPersona(_personaID);
end;

end.

