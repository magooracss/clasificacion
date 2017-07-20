unit frm_main;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, Menus,
  ActnList, ComCtrls, dmgeneral;

type

  { TfrmMain }

  TfrmMain = class(TForm)
    perDEL: TAction;
    perUPD: TAction;
    perNEW: TAction;
    prg_configurar: TAction;
    prg_autor: TAction;
    MenuItem5: TMenuItem;
    MenuItem6: TMenuItem;
    MenuItem7: TMenuItem;
    MenuItem8: TMenuItem;
    prg_salir: TAction;
    ActionList1: TActionList;
    MainMenu1: TMainMenu;
    MenuItem1: TMenuItem;
    MenuItem2: TMenuItem;
    MenuItem3: TMenuItem;
    MenuItem4: TMenuItem;
    st: TStatusBar;
    ToolBar1: TToolBar;
    ToolButton1: TToolButton;
    ToolButton2: TToolButton;
    ToolButton8: TToolButton;
    procedure FormShow(Sender: TObject);
    procedure perDELExecute(Sender: TObject);
    procedure perNEWExecute(Sender: TObject);
    procedure perUPDExecute(Sender: TObject);
    procedure prg_autorExecute(Sender: TObject);
    procedure prg_salirExecute(Sender: TObject);
  private
    procedure initialise;
    procedure scrPersonas (refPersona: GUID_ID);
  public
    { public declarations }
  end;

var
  frmMain: TfrmMain;

implementation
{$R *.lfm}
uses
  versioninfo
, frm_about
, frm_personaae
, frm_busquedapersonas
, dmPersonas
;


{ TfrmMain }

procedure TfrmMain.FormShow(Sender: TObject);
begin
  initialise;
end;

procedure TfrmMain.prg_autorExecute(Sender: TObject);
var
  scr: TfrmAbout;
begin
  scr:= TfrmAbout.Create(self);
  try
    scr.ShowModal;
  finally
    scr.Free;
  end;
end;

procedure TfrmMain.prg_salirExecute(Sender: TObject);
begin
  Application.Terminate;
end;

procedure TfrmMain.initialise;
Var
  NroVersion: String;
  Info: TVersionInfo;
begin
  Info := TVersionInfo.Create;
  Info.Load(HINSTANCE);
  NroVersion := IntToStr(Info.FixedInfo.FileVersion[0])+'.'
                +IntToStr(Info.FixedInfo.FileVersion[1])+'.'
                +IntToStr(Info.FixedInfo.FileVersion[2])+'.'
                +IntToStr(Info.FixedInfo.FileVersion[3]);
  Info.Free;

  st.Panels[0].Text:= '  v:' + NroVersion;
  st.Panels[1].Text:= FormatDateTime('dd/mm/yyyy', now)+ '        ';
end;


(*******************************************************************************
***  PERSONAS
*******************************************************************************)
procedure TfrmMain.scrPersonas(refPersona: GUID_ID);
var
  scrPer: TfrmPersonaAE;
begin
  scrPer:= TfrmPersonaAE.Create(self);
  try
    scrPer.personaID:= refPersona;
    scrPer.ShowModal;
  finally
    scrPer.Free;
  end;
end;

procedure TfrmMain.perNEWExecute(Sender: TObject);
begin
  scrPersonas(GUIDNULO);
end;

procedure TfrmMain.perUPDExecute(Sender: TObject);
var
  scrBus: TfrmBusquedaPersonas;
begin
  scrBus:= TfrmBusquedaPersonas.Create(self);
  try
    if scrBus.ShowModal = mrOK then
     scrPersonas(scrBus.personaSeleccionadaID);
  finally
    scrBus.Free;
  end;
end;

procedure TfrmMain.perDELExecute(Sender: TObject);
var
  dmP: TDM_Personas;
  scrBus: TfrmBusquedaPersonas;
begin
  dmP:= TDM_Personas.Create(self);
  scrBus:= TfrmBusquedaPersonas.Create(self);
  try
    if  (scrBus.ShowModal = mrOK)
        and (MessageDlg ('ATENCION'
                      , 'Borro a la persona seleccionada?'
                      , mtConfirmation, [mbYes, mbNo],0 ) = mrYes) then
    begin
      dmP.Delete(scrBus.personaSeleccionadaID);
    end;
  finally
    scrBus.Free;
    dmP.Free;
  end;
end;


end.

