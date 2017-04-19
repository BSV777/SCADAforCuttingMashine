unit PZ;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Grids, DBGrids, DB, DBTables, ExtCtrls, StdCtrls, Buttons;

type
  TFPZ = class(TForm)
    Database1: TDatabase;
    QPZ: TQuery;
    QPZNUM: TStringField;
    QPZPZ_LINE: TMemoField;
    DataSource1: TDataSource;
    DBGrid1: TDBGrid;
    Panel1: TPanel;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    QPZL: TStringField;
    QPZKNIFES: TStringField;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FPZ: TFPZ;

implementation

{$R *.dfm}

end.
