unit frm_main;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, Menus,
  ActnList, ComCtrls, StdCtrls, dmgeneral, dmcarreras;

type

  { TfrmMain }

  TfrmMain = class(TForm)
    corrUPD: TAction;
    corrDel: TAction;
    corrNEW: TAction;
    carr_SEL: TAction;
    carr_UPD: TAction;
    carr_DEL: TAction;
    carr_NEW: TAction;
    edCarrera: TEdit;
    MenuItem10: TMenuItem;
    MenuItem11: TMenuItem;
    MenuItem12: TMenuItem;
    MenuItem13: TMenuItem;
    MenuItem14: TMenuItem;
    MenuItem15: TMenuItem;
    MenuItem16: TMenuItem;
    MenuItem17: TMenuItem;
    MenuItem18: TMenuItem;
    MenuItem2: TMenuItem;
    MenuItem5: TMenuItem;
    MenuItem9: TMenuItem;
    perDEL: TAction;
    perUPD: TAction;
    perNEW: TAction;
    prg_configurar: TAction;
    prg_autor: TAction;
    MenuItem6: TMenuItem;
    MenuItem7: TMenuItem;
    MenuItem8: TMenuItem;
    prg_salir: TAction;
    ActionList1: TActionList;
    MainMenu1: TMainMenu;
    MenuItem1: TMenuItem;
    MenuItem3: TMenuItem;
    MenuItem4: TMenuItem;
    st: TStatusBar;
    ToolBar1: TToolBar;
    ToolButton1: TToolButton;
    ToolButton2: TToolButton;
    ToolButton3: TToolButton;
    ToolButton4: TToolButton;
    ToolButton5: TToolButton;
    ToolButton6: TToolButton;
    ToolButton8: TToolButton;
    procedure carr_DELExecute(Sender: TObject);
    procedure carr_NEWExecute(Sender: TObject);
    procedure carr_SELExecute(Sender: TObject);
    procedure carr_UPDExecute(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure perDELExecute(Sender: TObject);
    procedure perNEWExecute(Sender: TObject);
    procedure perUPDExecute(Sender: TObject);
    procedure prg_autorExecute(Sender: TObject);
    procedure prg_salirExecute(Sender: TObject);
  private
    _carreraActiva: GUID_ID;
    dmCarrera: TDM_Carreras;
    procedure initialise;
    procedure scrPersonas (refPersona: GUID_ID);
    procedure SeleccionarCarrera (refCarrera: GUID_ID);
    procedure scrCarrera (refCarrera: GUID_ID);
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
, SD_Configuracion
, frm_busquedacarreras
, frm_carrerasae
;


{ TfrmMain }

procedure TfrmMain.FormShow(Sender: TObject);
begin
  initialise;
end;

procedure TfrmMain.FormCreate(Sender: TObject);
begin
  dmCarrera:= TDM_Carreras.Create(self);
end;

procedure TfrmMain.FormDestroy(Sender: TObject);
begin
  if (_carreraActiva <> EmptyStr) then
  begin
    EscribirDato(SECCION_APP, CARRERA_ACTIVA,_carreraActiva);
  end;

  dmCarrera.Free;
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
  tmpID: String;
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

  tmpID:=  LeerDato(SECCION_APP, CARRERA_ACTIVA);
  if (tmpID = EmptyStr) then
  begin
    edCarrera.Text:= EmptyStr;
    _carreraActiva:= GUIDNULO;
  end
  else
  begin
    SeleccionarCarrera(tmpID);
  end;

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

(*******************************************************************************
***  CARRERAS
*******************************************************************************)

procedure TfrmMain.SeleccionarCarrera(refCarrera: GUID_ID);
begin
  _carreraActiva:= refCarrera;
  dmCarrera.LoadCarrera(_carreraActiva);
  edCarrera.Text:= dmCarrera.CarreraNombre.AsString;
  EscribirDato(SECCION_APP, CARRERA_ACTIVA,_carreraActiva);
end;

procedure TfrmMain.scrCarrera(refCarrera: GUID_ID);
var
  scr: TfrmCarreraAE;
begin
  scr:= TfrmCarreraAE.Create(self);
  try
    scr.carreraID:= refCarrera;
    if (scr.ShowModal = mrOK) then
    begin
      SeleccionarCarrera(scr.carreraID);
    end;
  finally
    scr.Free;
  end;
end;

procedure TfrmMain.carr_NEWExecute(Sender: TObject);
begin
  scrCarrera (GUIDNULO);
end;

procedure TfrmMain.carr_DELExecute(Sender: TObject);
var
  scrBus: TfrmBusquedaCarreras;
begin
  scrBus:=  TfrmBusquedaCarreras.Create(self);
  try
    if ((scrBus.ShowModal = mrOK)
              and (MessageDlg ('ATENCION'
                     , 'Borro la carrera seleccionada?'
                     , mtConfirmation, [mbYes, mbNo],0 ) = mrYes)) then
    begin
      dmCarrera.DeleteCarrera (scrBus.carreraSeleccionadaID);
    end;
  finally
    scrBus.Free;
  end;
end;

procedure TfrmMain.carr_UPDExecute(Sender: TObject);
var
  scrBus: TfrmBusquedaCarreras;
begin
  scrBus:=  TfrmBusquedaCarreras.Create(self);
  try
    if scrBus.ShowModal = mrOK then
    begin
      scrCarrera (scrBus.carreraSeleccionadaID);
    end;
  finally
    scrBus.Free;
  end;
end;

procedure TfrmMain.carr_SELExecute(Sender: TObject);
var
  scrBus: TfrmBusquedaCarreras;
begin
  scrBus:=  TfrmBusquedaCarreras.Create(self);
  try
    if scrBus.ShowModal = mrOK then
    begin
      SeleccionarCarrera (scrBus.carreraSeleccionadaID);
    end;
  finally
    scrBus.Free;
  end;
end;
end.

