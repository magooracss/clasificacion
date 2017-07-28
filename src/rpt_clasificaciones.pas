unit rpt_clasificaciones;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, db, FileUtil, RLXLSXFilter, RLXLSFilter, RLPDFFilter,
  RLReport, Forms, Controls, Graphics, Dialogs, dmgeneral, dmlistados;

type

  { TrptClasificaciones }

  TrptClasificaciones = class(TForm)
    ds: TDataSource;
    rep_Clasificaciones: TRLReport;
    RLBand1: TRLBand;
    RLBand2: TRLBand;
    RLBand3: TRLBand;
    RLBand4: TRLBand;
    RLDBText1: TRLDBText;
    RLDBText2: TRLDBText;
    RLDBText3: TRLDBText;
    RLDBText4: TRLDBText;
    RLDBText5: TRLDBText;
    RLDBText6: TRLDBText;
    RLDBText7: TRLDBText;
    RLGroup1: TRLGroup;
    RLGroup2: TRLGroup;
    RLLabel1: TRLLabel;
    RLLabel2: TRLLabel;
    RLLabel3: TRLLabel;
    RLLabel4: TRLLabel;
    RLLabel5: TRLLabel;
    RLLabel6: TRLLabel;
    RLLabel7: TRLLabel;
    RLLabel8: TRLLabel;
    RLPDFFilter1: TRLPDFFilter;
    RLSystemInfo1: TRLSystemInfo;
    RLXLSFilter1: TRLXLSFilter;
    RLXLSXFilter1: TRLXLSXFilter;
    procedure FormCreate(Sender: TObject);
  private
    dmQ: TDM_Listados;
  public
    procedure runReport ( carreraID: GUID_ID; rptAction: TReportAction);
  end;

var
  rptClasificaciones: TrptClasificaciones;

implementation

{$R *.lfm}

{ TrptClasificaciones }

procedure TrptClasificaciones.FormCreate(Sender: TObject);
begin
  dmQ:= TDM_Listados.Create(self);
  ds.DataSet:= dmQ.ResultadosCarrera;
end;

procedure TrptClasificaciones.runReport(carreraID: GUID_ID;
  rptAction: TReportAction);
begin

  dmQ.Clasificaciones (carreraID);
  DM_General.runReport(rep_Clasificaciones, rptAction, 'clasificaciones');
end;

end.

