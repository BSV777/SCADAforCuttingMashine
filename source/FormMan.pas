unit FormMan;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, StdCtrls, Mask, Buttons, ContrMan, OPCClient, IniFiles, StrUtils,
  Menus, jpeg, ComCtrls;

type
  TManualControlForm = class(TForm)
    GroupBox1: TGroupBox;
    Label1: TLabel;
    Label2: TLabel;
    GroupBox2: TGroupBox;
    Label3: TLabel;
    Label4: TLabel;
    MainReadTimer: TTimer;
    edZadanie: TEdit;
    lbZadRezult: TLabel;
    GroupBox3: TGroupBox;
    btAllST1UP: TButton;
    btZadST1Down: TButton;
    GroupBox4: TGroupBox;
    btAllST2UP: TButton;
    btZadST2Down: TButton;
    btAutoZadanie1: TButton;
    btAutoZadanie2: TButton;
    btAutoStart1: TButton;
    btAutoStart2: TButton;
    MainMenu1: TMainMenu;
    mnSet: TMenuItem;
    mnNewZad: TMenuItem;
    mnAutoZad1: TMenuItem;
    mnAutoZad2: TMenuItem;
    mnSetupWork: TMenuItem;
    mnSetup: TMenuItem;
    mnNewGUI: TMenuItem;
    bt1: TButton;
    btFreeST1UP: TButton;
    bt2: TButton;
    btFreeST2UP: TButton;
    N1: TMenuItem;
    mnSaveState: TMenuItem;
    StatusBar1: TStatusBar;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure MainReadTimerTimer(Sender: TObject);
    procedure btAutoZadanie1Click(Sender: TObject);
    procedure btAllST1UPClick(Sender: TObject);
    procedure btAllST2UPClick(Sender: TObject);
    procedure btZadST1DownClick(Sender: TObject);
    procedure btZadST2DownClick(Sender: TObject);
    procedure CtrlManClick(Sender: TObject);
    procedure btAutoZadanie2Click(Sender: TObject);
    procedure btAutoStart1Click(Sender: TObject);
    procedure btAutoStart2Click(Sender: TObject);
    procedure edZadanieDblClick(Sender: TObject);
    procedure mnAutoZad1Click(Sender: TObject);
    procedure mnNewZadClick(Sender: TObject);
    procedure mnAutoZad2Click(Sender: TObject);
    procedure mnSetupWorkClick(Sender: TObject);
    procedure mnSetupClick(Sender: TObject);
    procedure mnNewGUIClick(Sender: TObject);
    procedure mnSaveStateClick(Sender: TObject);
    procedure btFreeST1UPClick(Sender: TObject);
    procedure btFreeST2UPClick(Sender: TObject);
    procedure Redist(Sender: TObject);
    procedure Button2(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  ManualControlForm: TManualControlForm;
  ST1RList : TList;
  ST1BLList : TList;
  ST2RList : TList;
  ST2BLList : TList;
  OPCClient : TOPCClient;

implementation

uses Params, PZ, Setup, FormAuto, Auto, ClassZadanie;

{$R *.dfm}

procedure TManualControlForm.FormCreate(Sender: TObject);
var
  i : integer;
begin
  StatusBar1.SimpleText := 'Rev.' + RevN;
  CurrZad := TZadanie.Create;
  NextZad := TZadanie.Create;
  if Screen.Width > 1024 then Position := poScreenCenter;
  Top := 1;
  Left := 1;
  Width := 1022;
  Height := 765;
  ST1RList := TList.Create;
  for i := 1 to 10 do
    begin
      ST1RList.Add(TControlMan.Create(Self));
      CtrlMan := ST1RList.Items[i - 1];
      with CtrlMan do
        begin
          Parent := GroupBox1;
          Num := i;
          BaseNum := 'ST1_R';
          Top := 40;
          Left := (10 - i) * 101 + 2;
          OnClick := CtrlManClick;
          TabStop := True;
        end;
    end;
  ST1BLList := TList.Create;
  for i := 1 to 6 do
    begin
      ST1BLList.Add(TControlMan.Create(Self));
      CtrlMan := ST1BLList.Items[i - 1];
      with CtrlMan do
        begin
          Parent := GroupBox1;
          Num := i;
          BaseNum := 'ST1_BL';
          Top := 199;
          Left := (6 - i) * 101 + 2;
          OnClick := CtrlManClick;
          TabStop := True;
        end;
    end;
  ST2RList := TList.Create;
  for i := 1 to 10 do
    begin
      ST2RList.Add(TControlMan.Create(Self));
      CtrlMan := ST2RList.Items[i - 1];
      with CtrlMan do
        begin
          Parent := GroupBox2;
          Num := i;
          BaseNum := 'ST2_R';
          Top := 40;
          Left := (10 - i) * 101 + 2;
          OnClick := CtrlManClick;
          TabStop := True;
        end;
    end;
  ST2BLList := TList.Create;
  for i := 1 to 6 do
    begin
      ST2BLList.Add(TControlMan.Create(Self));
      CtrlMan := ST2BLList.Items[i - 1];
      with CtrlMan do
        begin
          Parent := GroupBox2;
          Num := i;
          BaseNum := 'ST2_BL';
          Top := 199;
          Left := (6 - i) * 101 + 2;
          OnClick := CtrlManClick;
          TabStop := True;
        end;
    end;
  ReloadIni;
  OPCClient := TOPCClient.Create(Self);
  OPCClient.OnRedist := Redist;
  OPCClient.OnButton2 := Button2; 
  OPCClient.Connected := True;
  MainReadTimer.Enabled := True;
end;

procedure TManualControlForm.FormClose(Sender: TObject; var Action: TCloseAction);
var
  CommandString : array[0..200] of char;
  si : Tstartupinfo;
  p : Tprocessinformation;
begin
  OPCClient.Connected := False;
  FillChar(si, SizeOf(si), 0);
  si.cb := SizeOf(si);
  si.dwFlags := startf_UseShowWindow;
  si.wShowWindow := SW_MINIMIZE;
  StrPCopy(CommandString, 'TortoiseProc /command:update /path:".." /closeonend:1');
  if FileExists('C:\Program Files\TortoiseSVN\bin\TortoiseProc.exe') then
    if MessageDlg('Обновить версию программы?' , mtConfirmation, [mbYes, mbNo], 0) = mrYes then
      CreateProcess(nil, CommandString, nil, nil, false, Create_default_error_mode, nil, nil, si, p);
  if FileExists(RezkaTempPath + 'BL_WP.emf')    then DeleteFile(RezkaTempPath + 'BL_WP.emf');
  if FileExists(RezkaTempPath + 'R_WP.emf')     then DeleteFile(RezkaTempPath + 'R_WP.emf');
  if FileExists(RezkaTempPath + 'BL_W.emf')     then DeleteFile(RezkaTempPath + 'BL_W.emf');
  if FileExists(RezkaTempPath + 'R_W.emf')      then DeleteFile(RezkaTempPath + 'R_W.emf');
  if FileExists(RezkaTempPath + 'BL_D.emf')     then DeleteFile(RezkaTempPath + 'BL_D.emf');
  if FileExists(RezkaTempPath + 'R_D.emf')      then DeleteFile(RezkaTempPath + 'R_D.emf');
  if FileExists(RezkaTempPath + 'BL_DW.emf')     then DeleteFile(RezkaTempPath + 'BL_DW.emf');
  if FileExists(RezkaTempPath + 'R_DW.emf')      then DeleteFile(RezkaTempPath + 'R_DW.emf');
  if FileExists(RezkaTempPath + 'BL_nU.emf')    then DeleteFile(RezkaTempPath + 'BL_nU.emf');
  if FileExists(RezkaTempPath + 'R_nU.emf')     then DeleteFile(RezkaTempPath + 'R_nU.emf');
  if FileExists(RezkaTempPath + 'SubWCRev.txt') then DeleteFile(RezkaTempPath + 'SubWCRev.txt');
  if DirectoryExists(RezkaTempPath) then RemoveDir(RezkaTempPath);
end;

procedure TManualControlForm.MainReadTimerTimer(Sender: TObject);
var
  i : integer;
  d : boolean;
begin
  MainReadTimer.Enabled := False;
  if AutoControlForm.btShowPos.Down then
    begin
      AutoControlForm.lbZad_Pos1.Caption := 'Текущее положение';
      AutoControlForm.lbZad_Pos2.Caption := 'Текущее положение';
      AutoControlForm.lbZad_Pos1.Font.Color := clYellow;
      AutoControlForm.lbZad_Pos2.Font.Color := clYellow;
    end else
    begin
      AutoControlForm.lbZad_Pos1.Caption := 'Задание';
      AutoControlForm.lbZad_Pos2.Caption := 'Задание';
      AutoControlForm.lbZad_Pos1.Font.Color := clGreen;
      AutoControlForm.lbZad_Pos2.Font.Color := clGreen;
    end;
  d := False;
  for i := 1 to 10 do
    begin
      CtrlMan := ST1RList.Items[i - 1];
      CtrlMan.Pos := OPCClient.ST1_R_Pos[i];
      if CtrlMan.NewDN then OPCClient.ST1_R_DN[i] := CtrlMan.Down else CtrlMan.Down := OPCClient.ST1_R_DN[i];
      if CtrlMan.NewZad then OPCClient.ST1_R_Zad[i] := CtrlMan.Zad else CtrlMan.Zad := OPCClient.ST1_R_Zad[i];
      CtrlMan.NewDN := False;
      CtrlMan.NewZad := False;
      CtrlAuto := ST1CtrlAutoRList.Items[i - 1];
      if AutoControlForm.btShowPos.Down then
        begin
          CtrlAuto.Position := OPCClient.ST1_R_Pos[i];
          CtrlAuto.Down := OPCClient.ST1_R_DN[i];
        end else
        begin
          CtrlAuto.AutoZad := CtrlMan.AutoZad;
          CtrlAuto.Down := CtrlMan.Down;
        end;
      if CurrZad.ST1_R_Down[i] <> CtrlAuto.Down then d := True;
      CurrZad.ST1_R_Down[i] := CtrlAuto.Down;
      if CurrZad.ST1_R_Down[i] then CurrZad.ST1_R_XZad[i] := CtrlMan.AutoZad;
      NextZad.ST1_R_Down[i] := CtrlAuto.Down;
      if NextZad.ST1_R_Down[i] then NextZad.ST1_R_XZad[i] := CtrlMan.AutoZad;
      CtrlAuto.Work := CtrlMan.Work;

      CtrlMan := ST2RList.Items[i - 1];
      CtrlMan.Pos := OPCClient.ST2_R_Pos[i];
      if CtrlMan.NewDN then OPCClient.ST2_R_DN[i] := CtrlMan.Down else CtrlMan.Down := OPCClient.ST2_R_DN[i];
      if CtrlMan.NewZad then OPCClient.ST2_R_Zad[i] := CtrlMan.Zad else CtrlMan.Zad := OPCClient.ST2_R_Zad[i];
      CtrlMan.NewDN := False;
      CtrlMan.NewZad := False;
      CtrlAuto := ST2CtrlAutoRList.Items[i - 1];
      if AutoControlForm.btShowPos.Down then
        begin
          CtrlAuto.Position := OPCClient.ST2_R_Pos[i];
          CtrlAuto.Down := OPCClient.ST2_R_DN[i];
        end else
        begin
          CtrlAuto.AutoZad := CtrlMan.AutoZad;
          CtrlAuto.Down := CtrlMan.Down;
        end;
      if CurrZad.ST2_R_Down[i] <> CtrlAuto.Down then d := True;
      CurrZad.ST2_R_Down[i] := CtrlAuto.Down;
      if CurrZad.ST2_R_Down[i] then CurrZad.ST2_R_XZad[i] := CtrlMan.AutoZad;
      NextZad.ST2_R_Down[i] := CtrlAuto.Down;
      if NextZad.ST2_R_Down[i] then NextZad.ST2_R_XZad[i] := CtrlMan.AutoZad;
      CtrlAuto.Work := CtrlMan.Work;
    end;
  for i := 1 to 6 do
    begin
      CtrlMan := ST1BLList.Items[i - 1];
      CtrlMan.Pos := OPCClient.ST1_BL_Pos[i];
      if CtrlMan.NewDN then OPCClient.ST1_BL_DN[i] := CtrlMan.Down else CtrlMan.Down := OPCClient.ST1_BL_DN[i];
      if CtrlMan.NewZad then OPCClient.ST1_BL_Zad[i] := CtrlMan.Zad else CtrlMan.Zad := OPCClient.ST1_BL_Zad[i];
      CtrlMan.NewDN := False;
      CtrlMan.NewZad := False;
      CtrlAuto := ST1CtrlAutoBLList.Items[i - 1];
      if AutoControlForm.btShowPos.Down then
        begin
          CtrlAuto.Position := OPCClient.ST1_BL_Pos[i];
          CtrlAuto.Down := OPCClient.ST1_BL_DN[i];
        end else
        begin
          CtrlAuto.AutoZad := CtrlMan.AutoZad;
          CtrlAuto.Down := CtrlMan.Down;
        end;
      if CurrZad.ST1_BL_Down[i] <> CtrlAuto.Down then d := True;
      CurrZad.ST1_BL_Down[i] := CtrlAuto.Down;
      if CurrZad.ST1_BL_Down[i] then CurrZad.ST1_BL_XZad[i] := CtrlMan.AutoZad;
      NextZad.ST1_BL_Down[i] := CtrlAuto.Down;
      if NextZad.ST1_BL_Down[i] then NextZad.ST1_BL_XZad[i] := CtrlMan.AutoZad;
      CtrlAuto.Work := CtrlMan.Work;

      CtrlMan := ST2BLList.Items[i - 1];
      CtrlMan.Pos := OPCClient.ST2_BL_Pos[i];
      if CtrlMan.NewDN then OPCClient.ST2_BL_DN[i] := CtrlMan.Down else CtrlMan.Down := OPCClient.ST2_BL_DN[i];
      if CtrlMan.NewZad then OPCClient.ST2_BL_Zad[i] := CtrlMan.Zad else CtrlMan.Zad := OPCClient.ST2_BL_Zad[i];
      CtrlMan.NewDN := False;
      CtrlMan.NewZad := False;
      CtrlAuto := ST2CtrlAutoBLList.Items[i - 1];
      if AutoControlForm.btShowPos.Down then
        begin
          CtrlAuto.Position := OPCClient.ST2_BL_Pos[i];
          CtrlAuto.Down := OPCClient.ST2_BL_DN[i];
        end else
        begin
          CtrlAuto.AutoZad := CtrlMan.AutoZad;
          CtrlAuto.Down := CtrlMan.Down;
        end;
      if CurrZad.ST2_BL_Down[i] <> CtrlAuto.Down then d := True;
      CurrZad.ST2_BL_Down[i] := CtrlAuto.Down;
      if CurrZad.ST2_BL_Down[i] then CurrZad.ST2_BL_XZad[i] := CtrlMan.AutoZad;
      NextZad.ST2_BL_Down[i] := CtrlAuto.Down;
      if NextZad.ST2_BL_Down[i] then NextZad.ST2_BL_XZad[i] := CtrlMan.AutoZad;
      CtrlAuto.Work := CtrlMan.Work;
    end;
  Application.ProcessMessages;
  if d then
    begin
      CurrPlan.Renew;
      NextPlan.Renew;
    end;
  MainReadTimer.Enabled := True;
end;

procedure TManualControlForm.btAutoZadanie1Click(Sender: TObject);
begin
  SetAuto(False, CurrZad);
  CurrZad.ZadanieStr := edZadanie.Text;
  CurrZad.DistributeST1R;
  CurrZad.DistributeST1BL;
  if CurrZad.ZadanieErr then lbZadRezult.Caption := CurrZad.ZadanieStatus;
  if CurrZad.DistributeRErr then lbZadRezult.Caption := CurrZad.DistributeRStatus;
  if CurrZad.DistributeBLErr then lbZadRezult.Caption := CurrZad.DistributeBLStatus;
  if CurrZad.ZadanieErr or CurrZad.DistributeRErr or CurrZad.DistributeBLErr then
    begin
      lbZadRezult.Font.Color := clYellow;
      SetAuto(False, CurrZad);
    end else
    begin
      lbZadRezult.Font.Color := clGreen;
      lbZadRezult.Caption := CurrZad.DistributeStatus;
      SetAuto(True, CurrZad);
      CurrPlan.Renew;
    end;
end;

procedure TManualControlForm.btAutoZadanie2Click(Sender: TObject);
begin
  SetAuto(False, CurrZad);
  CurrZad.ZadanieStr := edZadanie.Text;
  CurrZad.DistributeST2R;
  CurrZad.DistributeST2BL;
  if CurrZad.ZadanieErr then lbZadRezult.Caption := CurrZad.ZadanieStatus;
  if CurrZad.DistributeRErr then lbZadRezult.Caption := CurrZad.DistributeRStatus;
  if CurrZad.DistributeBLErr then lbZadRezult.Caption := CurrZad.DistributeBLStatus;
  if CurrZad.ZadanieErr or CurrZad.DistributeRErr or CurrZad.DistributeBLErr then
    begin
      lbZadRezult.Font.Color := clYellow;
      SetAuto(False, CurrZad);
    end else
    begin
      lbZadRezult.Font.Color := clGreen;
      lbZadRezult.Caption := CurrZad.DistributeStatus;
      SetAuto(True, CurrZad);
      CurrPlan.Renew;
    end;
end;

procedure TManualControlForm.btAllST1UPClick(Sender: TObject);
var
  j : integer;
begin
  for j := 1 to 10 do OPCClient.ST1_R_DN[j] := False;
  for j := 1 to 6 do OPCClient.ST1_BL_DN[j] := False;
end;

procedure TManualControlForm.btAllST2UPClick(Sender: TObject);
var
  j : integer;
begin
  for j := 1 to 10 do OPCClient.ST2_R_DN[j] := False;
  for j := 1 to 6 do OPCClient.ST2_BL_DN[j] := False;
end;

procedure TManualControlForm.btZadST1DownClick(Sender: TObject);
var
  j : integer;
begin
  for j := 1 to 10 do
    begin
      CtrlMan := ST1RList.Items[j - 1];
      if CtrlMan.Work then OPCClient.ST1_R_DN[j] := True;
    end;
  for j := 1 to 6 do
    begin
      CtrlMan := ST1BLList.Items[j - 1];
      if CtrlMan.Work then OPCClient.ST1_BL_DN[j] := True;
    end;
end;

procedure TManualControlForm.btZadST2DownClick(Sender: TObject);
var
  j : integer;
begin
  for j := 1 to 10 do
    begin
      CtrlMan := ST2RList.Items[j - 1];
      if CtrlMan.Work then OPCClient.ST2_R_DN[j] := True;
    end;
  for j := 1 to 6 do
    begin
      CtrlMan := ST2BLList.Items[j - 1];
      if CtrlMan.Work then OPCClient.ST2_BL_DN[j] := True;
    end;
end;

procedure TManualControlForm.CtrlManClick(Sender: TObject);
begin
  ParamsForm.BaseNum := (Sender as TControlMan).BaseNum;
  ParamsForm.Num := (Sender as TControlMan).Num;
  ParamsForm.DisplayNum := (Sender as TControlMan).DisplayNum;  
  ParamsForm.Hide;
  ParamsForm.Show;
end;

procedure TManualControlForm.btAutoStart1Click(Sender: TObject);
begin
  AutoStartUP1;
end;

procedure TManualControlForm.btAutoStart2Click(Sender: TObject);
begin
  AutoStartUP2;
end;

procedure TManualControlForm.edZadanieDblClick(Sender: TObject);
var
  FPZ : TFPZ;
begin
  try
    Application.CreateForm(TFPZ, FPZ);
    FPZ.QPZ.Open;
    FPZ.ShowModal;
    if FPZ.ModalResult = mrOk then edZadanie.Text := FPZ.QPZ.FieldByName('PZ_LINE').asString;
    CurrZad.ZadanieStr := edZadanie.Text;
    FPZ.QPZ.Close;
  except
    lbZadRezult.Font.Color := clYellow;
    lbZadRezult.Caption := 'Нет связи с базой данных.';
  end;
end;

procedure TManualControlForm.mnAutoZad1Click(Sender: TObject);
begin
  btAutoZadanie1Click(Sender);
end;

procedure TManualControlForm.mnNewZadClick(Sender: TObject);
begin
  edZadanieDblClick(Sender);
end;

procedure TManualControlForm.mnAutoZad2Click(Sender: TObject);
begin
  btAutoZadanie2Click(Sender);
end;

procedure TManualControlForm.mnSetupWorkClick(Sender: TObject);
begin
  SetupForm.Work := True;
  SetupForm.ShowModal;
end;

procedure TManualControlForm.mnSetupClick(Sender: TObject);
begin
  SetupForm.Work := False;
  SetupForm.ShowModal;
end;

procedure TManualControlForm.mnNewGUIClick(Sender: TObject);
begin
  if (Screen.Width >= 1280) and (Screen.Height >= 1024) then
    begin
      CurrZad.ReloadIni;
      NextZad.ReloadIni;
      if CurrZad.ZadanieStr = '' then CurrZad.ZadanieStr := edZadanie.Text;
      SetCtrlAutoWidth(CurrZad);
      AutoControlForm.ShowModal;
    end else ShowMessage('Минимальное разрешение экрана 1280 х 1024');
end;

procedure TManualControlForm.mnSaveStateClick(Sender: TObject);
var
  Canvas : TCanvas;
  ScreenV : HDC;
  Image1: TImage;
  d, dir : string;
  jpg: TJpegImage;
  StateIni: TIniFile;
  ProgramPath : string;
begin
  Image1 := TImage.Create(Self);
  Image1.Parent := Self;
  Image1.Left := ManualControlForm.Left;
  Image1.Top := ManualControlForm.Top;
  Image1.Width := ManualControlForm.Width;
  Image1.Height := ManualControlForm.Height;
  Image1.Visible := False;  
  ScreenV := GetDC(0);
  Canvas := TCanvas.Create();
  Canvas.Handle := ScreenV;
  Image1.Canvas.Copyrect(Rect(0, 0, Image1.Width, Image1.Height), Canvas, Rect(Image1.Left, Image1.Top, Image1.Width + Image1.Left, Image1.Height + Image1.Top));
  ReleaseDC(0,ScreenV);
  Canvas.Free;
  DateTimeToString(dir, 'dd.mm.yyyy', Now);
  dir := RezkaStatusPath + dir;
  if not DirectoryExists(dir) then MkDir(dir);
  DateTimeToString(d, 'dd.mm.yyyy-hh.nn.ss', Now);
  Application.ProcessMessages;
  jpg := TJpegImage.Create;
  jpg.Assign(image1.picture.graphic);
  jpg.CompressionQuality := 100;
  jpg.Compress;
  jpg.SaveToFile(dir + '\' + d + '.jpg');
  jpg.free;
  Image1.Free;
  ProgramPath := ExtractFilePath(Application.EXEName);
  StateIni := TIniFile.Create(ProgramPath + 'Rezka.ini');
  StateIni.WriteString('Zadanie', 'CurrZad', CurrZad.ZadanieStr);
  StateIni.WriteString('Zadanie', 'NextZad', NextZad.ZadanieStr);
  StateIni.WriteString('Zadanie', 'CurrZadName', CurrZad.ZadanieName);
  StateIni.WriteString('Zadanie', 'NextZadName', NextZad.ZadanieName);
  StateIni.WriteString('Revision', 'N', RevN);
  StateIni.Free;
  CopyFile(pchar('Rezka.ini'), pchar(dir + '\' + d + '.ini'), True);
end;

procedure TManualControlForm.btFreeST1UPClick(Sender: TObject);
var
  j : integer;
begin
  for j := 1 to 10 do
    begin
      CtrlMan := ST1RList.Items[j - 1];
      if not CtrlMan.Work then OPCClient.ST1_R_DN[j] := False;
    end;
  for j := 1 to 6 do
    begin
      CtrlMan := ST1BLList.Items[j - 1];
      if not CtrlMan.Work then OPCClient.ST1_BL_DN[j] := False;
    end;
end;

procedure TManualControlForm.btFreeST2UPClick(Sender: TObject);
var
  j : integer;
begin
  for j := 1 to 10 do
    begin
      CtrlMan := ST2RList.Items[j - 1];
      if not CtrlMan.Work then OPCClient.ST2_R_DN[j] := False;
    end;
  for j := 1 to 6 do
    begin
      CtrlMan := ST2BLList.Items[j - 1];
      if not CtrlMan.Work then OPCClient.ST2_BL_DN[j] := False;
    end;
end;

procedure TManualControlForm.Redist(Sender: TObject);
begin
  AutoControlForm.Log('Нажата аппаратная кнопка Перестроить');
  AutoControlForm.btReDist.Click;
end;

procedure TManualControlForm.Button2(Sender: TObject);
begin
  AutoControlForm.Log('Нажата аппаратная кнопка Режим перестройки ручной');
  AutoControlForm.btManReDist.Down := True;
  AutoControlForm.btManReDist.Click;
end;

end.
