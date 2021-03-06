program clasificador;

{$mode objfpc}{$H+}

uses
  {$IFDEF UNIX}{$IFDEF UseCThreads}
  cthreads,
  {$ENDIF}{$ENDIF}
  Interfaces, // this includes the LCL widgetset
  Forms, rxnew, datetimectrls, zcomponent, frm_main, dmgeneral, frm_personaae,
  dmPersonas, dmcarreras, frm_carrerasae, frm_busquedacarreras,
  frm_distanciasae, frm_categoriascarreraae, frm_categoriasae, dmcorredores,
  frm_corredoresae, dmMain, frm_llegadas, frm_listados, dmlistados
  { you can add units after this };

{$R *.res}

begin
  Application.Title:='Clasificador';
  RequireDerivedFormResource:=True;
  Application.Initialize;
  Application.CreateForm(TDM_General, DM_General);
  Application.CreateForm(TDM_Main, DM_Main);
  Application.CreateForm(TfrmMain, frmMain);
  Application.CreateForm(TfrmLlegadas, frmLlegadas);
  Application.CreateForm(TfrmListados, frmListados);
  Application.CreateForm(TDM_Listados, DM_Listados);
  Application.Run;
end.

