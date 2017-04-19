unit SplashUnit;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, jpeg, Auto, ComCtrls;

type
  TSplash = class(TForm)
    Image1: TImage;
    StatusBar1: TStatusBar;
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Splash: TSplash;

implementation

{$R *.dfm}

procedure TSplash.FormCreate(Sender: TObject);
begin
  SaveFilesFromResource;
  RevN := GetRevN;
  StatusBar1.SimpleText := 'Rev.' + RevN;  
end;

end.
