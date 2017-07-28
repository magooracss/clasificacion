unit frm_listados;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, ExtCtrls,
  Buttons, StdCtrls, ComCtrls, dmgeneral, contnrs;

type

  TReportOption = class
    position: integer; //For sort
    name: string; //Visible name
    parameterIdx: integer; //Index of Visual Tab parameters need;
    processIdx: integer; //Simplest, faster and unthought way to make report functions
  end;


  { TfrmListados }

  TfrmListados = class(TForm)
    btnExit: TBitBtn;
    btnPrint: TBitBtn;
    btnSaveFile: TBitBtn;
    cbFileFormats: TComboBox;
    Label7: TLabel;
    lbReports: TListBox;
    PCParametros: TPageControl;
    Panel2: TPanel;
    tabNula: TTabSheet;
    procedure btnExitClick(Sender: TObject);
    procedure btnPrintClick(Sender: TObject);
    procedure btnSaveFileClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure lbReportsSelectionChange(Sender: TObject; User: boolean);
  private
    reportOptions:TObjectList;
    _carreraID: GUID_ID;

    procedure CreateOptions;
    procedure Initialise;

    procedure ExecuteReport (reportIdx: integer; rptAction: TReportAction);
  public
    property carreraID: GUID_ID read _carreraID write _carreraID;
  end;

var
  frmListados: TfrmListados;

implementation
{$R *.lfm}
uses
  rpt_clasificaciones
;

const
  PARAM_NULO = 0;

  RPT_CLASIFIC = 1;
  RPT_PODIOS = 2;
  RPT_INSCRIPTOS = 3;



{ TfrmListados }

procedure TfrmListados.btnExitClick(Sender: TObject);
begin
  ModalResult:= mrOK;
end;

procedure TfrmListados.btnPrintClick(Sender: TObject);
begin
  if (lbReports.ItemIndex >= 0) then
    ExecuteReport((reportOptions[lbReports.ItemIndex] as TReportOption).processIdx , raPrint);
end;

procedure TfrmListados.btnSaveFileClick(Sender: TObject);
begin
 if (lbReports.ItemIndex >= 0) then
 begin
   ExecuteReport((reportOptions[lbReports.ItemIndex] as TReportOption).processIdx
                 ,TReportAction (cbFileFormats.Items.Objects[cbFileFormats.ItemIndex])
                 );
 end;
end;

procedure TfrmListados.FormCreate(Sender: TObject);
begin
 _carreraID:= GUIDNULO;
 reportOptions:= TObjectList.Create(true);
 with cbFileFormats do
 begin
   Items.Clear;
   items.AddObject('Archivo PDF', TObject(raPDF));
   items.AddObject('Archivo Excel 97-2003', TObject(raXLS));
   items.AddObject('Archivo Excel', TObject(raXLSX));
   ItemIndex:= 0;
 end;
end;

procedure TfrmListados.FormShow(Sender: TObject);
begin
  Initialise;
end;

procedure TfrmListados.lbReportsSelectionChange(Sender: TObject; User: boolean);
begin
 if ((lbReports.ItemIndex < lbReports.Items.Count)
     and
      (lbReports.ItemIndex >= 0)
     )then
  PCParametros.ActivePageIndex:= (reportOptions[lbReports.ItemIndex] as TReportOption).parameterIdx;
end;

procedure TfrmListados.CreateOptions;

  procedure createObj( Objpos: integer; Objname: string; ObjtabIdx, ObjProcIdx: integer);
  var
    obj: TReportOption;
  begin
    obj:= TReportOption.Create;
    obj.position:= Objpos;
    obj.name:= Objname;
    obj.parameterIdx:= ObjtabIdx;
    obj.processIdx:= ObjProcIdx;
    reportOptions.Add(obj);
  end;
begin
  createObj(1,'Clasificaciones carrera', PARAM_NULO, RPT_CLASIFIC);
//  createObj(2,'Podios por distancias y categorías', PARAM_NULO, RPT_PODIOS);
//  createObj(3,'Corredores inscriptos', PARAM_NULO, RPT_INSCRIPTOS);
end;

procedure TfrmListados.Initialise;
var
  iter: integer;
begin
  CreateOptions;
  for iter:= 0 to reportOptions.Count - 1 do
  begin
    lbReports.Items.Add((reportOptions[iter] as TReportOption).name);
  end;
  PCParametros.ActivePageIndex:= 0;
end;

procedure TfrmListados.ExecuteReport(reportIdx: integer;
  rptAction: TReportAction);
var
  frm: TForm;
begin
   try
     case reportIdx of
       RPT_CLASIFIC: begin
                      frm:= TrptClasificaciones.Create(self);
                     (frm as TrptClasificaciones ).runReport ( _carreraID
                                                          , rptAction
                                                          );
               end;

     end;
   finally
     if (frm <> nil) then
 	     frm.Free;
   end;
end;

end.

