unit dmlevantarxls;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil;

type

  { TDataModule1 }

  TDataModule1 = class(TDataModule)
  private
    procedure LevantarArchivo (elArchivo: string);
  public
    { public declarations }
  end;

var
  DataModule1: TDataModule1;

implementation
{$R *.lfm}
uses
  laz_fpspreadsheet, fpspreadsheet;

{ TDataModule1 }

procedure TDataModule1.LevantarArchivo(elArchivo: string);
var
  elXLS: TsWorkbook;
  laHoja: TsWorksheet;
  laCelda: PCell;
  laFila, laCol, fGrilla: integer;
begin
  elXLS:= TsWorkbook.Create;
  try
//    Grilla.RowCount:= (udFin.Position - udIni.Position)+ 2;
    elXLS.ReadFromFile(elArchivo, sfExcel8);
    laHoja:= (elXLS.GetFirstWorksheet);
    fGrilla:= 1; //fila de la grilla
//    for laFila:= udIni.Position - 1 to udFin.Position -1  do
    begin
//      for laCol:=  0 to MAX_COL-1  do
      begin
        laCelda:= laHoja.GetCell(laFila, laCol);

  //      grilla.Cells[laCol, fGrilla]:= LaHoja.ReadAsUTF8Text(laCelda^.Row, laCelda^.Col);
      end;
      Inc (fGrilla);
    end;
  finally
    elXLS.Free;
  end;
end;


end.

