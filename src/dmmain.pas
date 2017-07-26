unit dmMain;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, db, FileUtil, ZDataset
  ,dmgeneral;

type

  { TDM_Main }

  TDM_Main = class(TDataModule)
    qCorredores: TZQuery;
    qCorredoresAPYNOM: TStringField;
    qCorredoresCATEGORIA: TStringField;
    qCorredoresDISTANCIA: TStringField;
    qCorredoresDOCUMENTO: TStringField;
    qCorredoresIDCORREDOR: TStringField;
    qCorredoresNUMERO: TLongintField;
  private
    { private declarations }
  public
    procedure LevantarCarrera (refCarrera: GUID_ID);
  end;

var
  DM_Main: TDM_Main;

implementation

{$R *.lfm}

{ TDM_Main }

procedure TDM_Main.LevantarCarrera(refCarrera: GUID_ID);
begin
  with qCorredores do
  begin
    if active then close;
    ParamByName('carrera_id').AsString:= refCarrera;
    Open;
  end;
end;

end.

