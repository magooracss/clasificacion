program clasificador;

{$mode objfpc}{$H+}

uses
  {$IFDEF UNIX}{$IFDEF UseCThreads}
  cthreads,
  {$ENDIF}{$ENDIF}
  Interfaces, // this includes the LCL widgetset
  Forms, rxnew, datetimectrls, zcomponent, frm_main, dmgeneral, frm_personaae,
  dmPersonas
  { you can add units after this };

{$R *.res}

begin
  Application.Title:='Clasificador';
  RequireDerivedFormResource:=True;
  Application.Initialize;
  Application.CreateForm(TDM_General, DM_General);
  Application.CreateForm(TfrmMain, frmMain);
  Application.CreateForm(TfrmPersonaAE, frmPersonaAE);
  Application.CreateForm(TDM_Personas, DM_Personas);
  Application.Run;
end.

