unit FormAuto;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, ContrAuto, Auto, Menus, ContrPlan, jpeg, IniFiles,
  ComCtrls, TapeCounter_TLB, Buttons, shellapi, ColorBtn;

type
  TAutoControlForm = class(TForm)
    RightPanel: TPanel;
    GroupBox3: TGroupBox;
    btAllSTUP: TButton;
    btZadSTDown: TButton;
    btFreeSTUP: TButton;
    imgScale: TImage;
    Shape1: TShape;
    Shape2: TShape;
    Label1: TLabel;
    Label2: TLabel;
    Shape3: TShape;
    Shape4: TShape;
    MainMenu1: TMainMenu;
    N1: TMenuItem;
    mnSaveState: TMenuItem;
    BottomPanel: TPanel;
    StatusBar1: TStatusBar;
    lbZad_Pos1: TLabel;
    lbZad_Pos2: TLabel;
    mnZad_Pos: TMenuItem;
    CounterTimer: TTimer;
    btNextCurr: TButton;
    btManReDist: TSpeedButton;
    btAutoReDist: TSpeedButton;
    lbr: TLabel;
    lbrestpz: TLabel;
    btShowZad: TSpeedButton;
    btShowPos: TSpeedButton;
    btInsert: TSpeedButton;
    mnHelp: TMenuItem;
    MemoLog: TMemo;
    btReDist: TColorBtn;
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    btAutoStart: TColorBtn;
    ImgLegend: TImage;
    procedure CtrlAutoClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btAllSTUPClick(Sender: TObject);
    procedure btZadSTDownClick(Sender: TObject);
    procedure mnSaveStateClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure PlanDistribute(Sender: TObject);
    procedure mnZad_PosClick(Sender: TObject);
    procedure btFreeSTUPClick(Sender: TObject);
    procedure CounterTimerTimer(Sender: TObject);
    procedure btNextCurrClick(Sender: TObject);
    procedure btAutoReDistClick(Sender: TObject);
    procedure btManReDistClick(Sender: TObject);
    procedure btInsertClick(Sender: TObject);
    procedure mnHelpClick(Sender: TObject);
    procedure Log(Value : string);
    procedure btReDistClick(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure btAutoStartClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  AutoControlForm : TAutoControlForm;
  ScaleMin, ScaleMax : integer;
  CurrPlan, NextPlan : TControlPlan;
  TapeCounter : IComPort;
  ReDistStep : integer;
  CounterTemp : integer;
  CutDone : boolean;

implementation

uses Setup, FormMan, ClassZadanie, Params;

{$R *.dfm}

procedure TAutoControlForm.FormCreate(Sender: TObject);
var
  i : integer;
  RezkaIni: TIniFile;
  LastCurrZad, LastNextZad, ProgramPath : string;
begin
  Top := 0;
  Left := 0;
  Width := Screen.Width;
  Height := Screen.Height - 30;
  StatusBar1.SimpleText := 'Rev.' + RevN;
  ScaleMin := 40;
  ScaleMax := Screen.Width - ScaleMin - 390;
  imgScale.Width := Round(ScaleMax * 1.003);
  imgScale.Left := ScaleMin - 2;
  Shape1.Width := ScaleMax;
  Shape1.Left := ScaleMin;
  Shape2.Width := ScaleMax;
  Shape2.Left := ScaleMin;
  Shape3.Width := ScaleMax;
  Shape3.Left := ScaleMin;
  Shape4.Width := ScaleMax;
  Shape4.Left := ScaleMin;
  ST1CtrlAutoRList := TList.Create;
  for i := 1 to 10 do
    begin
      ST1CtrlAutoRList.Add(TControlAuto.Create(Self));
      CtrlAuto := ST1CtrlAutoRList.Items[i - 1];
      with CtrlAuto do
        begin
          Parent := AutoControlForm;
          Num := i;
          BaseNum := 'ST1_R';
          Top := 4;
          Left := 0;
          TabStop := True;
          Ready := True;
          Scale := ScaleMax;
          OnClick := CtrlAutoClick;
        end;
    end;
  ST1CtrlAutoBLList := TList.Create;
  for i := 1 to 6 do
    begin
      ST1CtrlAutoBLList.Add(TControlAuto.Create(Self));
      CtrlAuto := ST1CtrlAutoBLList.Items[i - 1];
      with CtrlAuto do
        begin
          Parent := AutoControlForm;
          Num := i;
          BaseNum := 'ST1_BL';
          Top := 92;
          Left := 0;
          TabStop := True;
          Ready := True;
          Scale := ScaleMax;
          OnClick := CtrlAutoClick;
        end;
    end;
  ST2CtrlAutoRList := TList.Create;
  for i := 1 to 10 do
    begin
      ST2CtrlAutoRList.Add(TControlAuto.Create(Self));
      CtrlAuto := ST2CtrlAutoRList.Items[i - 1];
      with CtrlAuto do
        begin
          Parent := AutoControlForm;
          Num := i;
          BaseNum := 'ST2_R';
          Top := 230;
          Left := 0;
          TabStop := True;
          Ready := True;
          Scale := ScaleMax;
          OnClick := CtrlAutoClick;
        end;
    end;
  ST2CtrlAutoBLList := TList.Create;
  for i := 1 to 6 do
    begin
      ST2CtrlAutoBLList.Add(TControlAuto.Create(Self));
      CtrlAuto := ST2CtrlAutoBLList.Items[i - 1];
      with CtrlAuto do
        begin
          Parent := AutoControlForm;
          Num := i;
          BaseNum := 'ST2_BL';
          Top := 318;
          Left := 0;
          TabStop := True;
          Ready := True;
          Scale := ScaleMax;
          OnClick := CtrlAutoClick;
        end;
    end;
  CurrPlan := TControlPlan.Create(Self);
    with CurrPlan do
      begin
        Parent := AutoControlForm;
        Top := 660;
        Left := ScaleMin;
        OnPlanDistribute := PlanDistribute;
      end;
  NextPlan := TControlPlan.Create(Self);
    with NextPlan do
      begin
        Parent := AutoControlForm;
        Top := 420;
        Left := ScaleMin;
        OnPlanDistribute := PlanDistribute;
      end;
  CurrPlan.ZadType := 'C';
  NextPlan.ZadType := 'N';
  CurrZad.ReloadIni;
  NextZad.ReloadIni;
  CurrPlan.Init(ScaleMax, CurrZad);
  ProgramPath := ExtractFilePath(Application.EXEName);
  RezkaIni := TIniFile.Create(ProgramPath + 'Rezka.ini');
  LastCurrZad := RezkaIni.ReadString('Zadanie', 'CurrZad', '');
  LastNextZad := RezkaIni.ReadString('Zadanie', 'NextZad', '');
  CurrZad.ZadanieName := RezkaIni.ReadString('Zadanie', 'CurrZadName', '');
  NextZad.ZadanieName := RezkaIni.ReadString('Zadanie', 'NextZadName', '');
  RezkaIni.Free;
  if LastCurrZad <> '' then CurrZad.ZadanieStr := LastCurrZad else CurrZad.OnZadanieChange(Self);
  if LastCurrZad <> '' then ManualControlForm.edZadanie.Text := LastCurrZad;
//  CurrZad.OnZadanieChange(Self);
  NextPlan.Init(ScaleMax, NextZad);
  if LastNextZad <> '' then NextZad.ZadanieStr := LastNextZad else NextZad.OnZadanieChange(Self);
//  NextZad.OnZadanieChange(Self);
  SetCtrlAutoWidth(CurrZad);
  try TapeCounter := CoComPort.CreateRemote(CounterHost); except end;
  if TapeCounter <> nil then CounterTimer.Enabled := True else StatusBar1.SimpleText := StatusBar1.SimpleText + '     Нет доступа к данным счетчика на ' + CounterHost;
  AutoReDist := False;
  ReDistNow := False;
  ReDistStep := 0;
  CutDone := False;
end;

procedure TAutoControlForm.CtrlAutoClick(Sender: TObject);
begin
  if Pos(NextPlan.ActiveBaseNum, (Sender as TControlAuto).BaseNum) <> 0 then
    begin
//      if (Sender as TControlAuto).BaseNum = 'ST1_BL' then CtrlMan := ST1BLList.Items[(Sender as TControlAuto).Num - 1];
//      if (Sender as TControlAuto).BaseNum = 'ST2_BL' then CtrlMan := ST2BLList.Items[(Sender as TControlAuto).Num - 1];
//      if (Sender as TControlAuto).BaseNum = 'ST1_R' then CtrlMan := ST1RList.Items[(Sender as TControlAuto).Num - 1];
//      if (Sender as TControlAuto).BaseNum = 'ST2_R' then CtrlMan := ST2RList.Items[(Sender as TControlAuto).Num - 1];
//      if CtrlMan <> nil then CtrlMan.AutoZad := NextPlan.ActiveZad;
//      if CtrlMan <> nil then CtrlMan.Work := True;
      NextPlan.ActiveDev := (Sender as TControlAuto).BaseNum + IntToStr((Sender as TControlAuto).Num);
    end else
    begin
      ParamsForm.BaseNum := (Sender as TControlAuto).BaseNum;
      ParamsForm.Num := (Sender as TControlAuto).Num;
      ParamsForm.DisplayNum := (Sender as TControlAuto).DisplayNum;
      ParamsForm.Hide;
      ParamsForm.Show;
    end;
end;

procedure TAutoControlForm.btAllSTUPClick(Sender: TObject);
begin
  Log('Поднять все');
  ManualControlForm.btAllST1UP.Click;
  ManualControlForm.btAllST2UP.Click;
end;

procedure TAutoControlForm.btZadSTDownClick(Sender: TObject);
begin
  Log('Опустить рабочие');
  ManualControlForm.btZadST1Down.Click;
  ManualControlForm.btZadST2Down.Click;
end;

procedure TAutoControlForm.mnSaveStateClick(Sender: TObject);
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
  Image1.Left := AutoControlForm.Left;
  Image1.Top := AutoControlForm.Top;
  Image1.Width := AutoControlForm.Width;
  Image1.Height := AutoControlForm.Height;
  Image1.Visible := False;
  ScreenV := GetDC(0);
  Canvas := TCanvas.Create();
  Canvas.Handle := ScreenV;
  Image1.Canvas.Copyrect(Rect(0, 0, Image1.Width, Image1.Height), Canvas, Rect(Image1.Left, Image1.Top, Image1.Width + Image1.Left, Image1.Height + Image1.Top));
  ReleaseDC(0,ScreenV);
  Canvas.Free;
  DateTimeToString(dir, 'dd.mm.yyyy', Now);
  if not DirectoryExists(RezkaStatusPath + dir) then MkDir(RezkaStatusPath + dir);
  DateTimeToString(d, 'dd.mm.yyyy-hh.nn.ss', Now);
  dir := RezkaStatusPath + dir;
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

procedure TAutoControlForm.FormShow(Sender: TObject);
begin
  BottomPanel.Height := AutoControlForm.Height - CurrPlan.Top - CurrPlan.Height - 50;
  MemoLog.Height := BottomPanel.Height - 70;
end;

procedure TAutoControlForm.PlanDistribute(Sender: TObject);
var
//  StartTime : TDateTime;
  StateIni: TIniFile;
  ProgramPath : string;
begin
//  StartTime := Now;
//  while (Now - StartTime) < OneSecond do Application.ProcessMessages;
//  mnSaveState.Click;
  ProgramPath := ExtractFilePath(Application.EXEName);
  StateIni := TIniFile.Create(ProgramPath + 'Rezka.ini');
  StateIni.WriteString('Zadanie', 'CurrZad', CurrZad.ZadanieStr);
  StateIni.WriteString('Zadanie', 'NextZad', NextZad.ZadanieStr);
  StateIni.WriteString('Zadanie', 'CurrZadName', CurrZad.ZadanieName);
  StateIni.WriteString('Zadanie', 'NextZadName', NextZad.ZadanieName);
  StateIni.WriteString('Revision', 'N', RevN);
  StateIni.Free;
  btShowZad.Down := True;
end;

procedure TAutoControlForm.mnZad_PosClick(Sender: TObject);
begin
  if btShowPos.Down then btShowZad.Down := True else
    if btShowZad.Down then btShowPos.Down := True;
end;

procedure TAutoControlForm.btFreeSTUPClick(Sender: TObject);
begin
  Log('Поднять свободные');
  ManualControlForm.btFreeST1UP.Click;
  ManualControlForm.btFreeST2UP.Click;
end;

// Процедура перестройки
procedure TAutoControlForm.CounterTimerTimer(Sender: TObject);
var
  r, s : string;
  i, st, j : integer;
  n : string;
  ST1BLX, ST2BLX  : array[1..6] of single;
  ST1RX, ST2RX    : array[1..10] of single;
  ST1BLW, ST2BLW  : array[1..6] of boolean;
  ST1BLM, ST2BLM  : array[1..6] of boolean;
  ST1RW, ST2RW    : array[1..10] of boolean;
  ST1RM, ST2RM    : array[1..10] of boolean;
  AnyBL1DN1, AnyBL1DN2, AnyBL2DN1, AnyBL2DN2 : boolean;
begin
  CounterTimer.Enabled := False;
// Получение значение счетчика и преобразование в строку с начальными нулями
  try r := TapeCounter.restpz; except r := ''; end;
  try Counter := StrToInt(r); except Counter := 0; end;
  if Counter <= 0 then
    begin
      Counter := 0;
      r := '';
      ReDistNow := False;
    end;
  s := '';
  if (Counter > 0) and (Length(r) < 5) then for i := 1 to 5 - Length(r) do s := s + '0';
  lbrestpz.Caption := s + r;
// Включение доступности кнопки Перестройка в автоматическом режиме при значении счетчика < 100
  if AutoReDist and (Counter < 100) then
    begin
      btReDist.Enabled := True;
      btReDist.ButtonColor := $000080FF;
    end;
// При приближении счетчика к 0 переход в начальное состояние (1)
  if AutoReDist and (Counter < 20) then ReDistStep := 1;
// При переходе счетчика через 0  - готовность к перестройке - состояние (2)
  if AutoReDist and (Counter > 100) and (ReDistStep = 1) then
    begin
      Log('Значение счетчика = ' + IntToStr(Counter) + ' Готовность к автоматической перестройке');
      CounterTemp := Counter;
      btReDist.Enabled := False;
      btReDist.ButtonColor := clBtnFace;
      ReDistStep := 2;
    end;
// Переход в состояние (2) при нажатии кнопки Перестроить
  if ReDistNow and ((ReDistStep < 2) or (ReDistStep >= 6)) then
    begin
      CounterTemp := Counter;
      ReDistStep := 2;
    end;
// Значение счетчика достигло первой константы после перехода через 0
  if (ReDistNow or (AutoReDist and (Counter < CounterTemp - CounterConst1))) and (ReDistStep = 2) then
    begin
      btShowZad.Down := True; 
      Log('Значение счетчика = ' + IntToStr(Counter));
      CutDone := False;
      // Если не выбран режим вклинить
      if not btInsert.Down then
        begin
          Log('Перестроить');
          // Скопировать из следующего задания все свойства в текущее
          CurrZad.ZadanieName := NextZad.ZadanieName;
          CurrZad.ZadanieStr := NextZad.ZadanieStr;
          for i := 1 to 6 do
            begin
              CurrZad.ST1_BL_Xzad[i] := NextZad.ST1_BL_Xzad[i];
              CurrZad.ST2_BL_Xzad[i] := NextZad.ST2_BL_Xzad[i];
              CurrZad.ST1_BL_Work[i] := NextZad.ST1_BL_Work[i];
              CurrZad.ST2_BL_Work[i] := NextZad.ST2_BL_Work[i];
              CurrZad.ST1_BL_ManSet[i] := NextZad.ST1_BL_ManSet[i];
              CurrZad.ST2_BL_ManSet[i] := NextZad.ST2_BL_ManSet[i];
            end;
          for i := 1 to 10 do
            begin
              CurrZad.ST1_R_Xzad[i] := NextZad.ST1_R_Xzad[i];
              CurrZad.ST2_R_Xzad[i] := NextZad.ST2_R_Xzad[i];
              CurrZad.ST1_R_Work[i] := NextZad.ST1_R_Work[i];
              CurrZad.ST2_R_Work[i] := NextZad.ST2_R_Work[i];
              CurrZad.ST1_R_ManSet[i] := NextZad.ST1_R_ManSet[i];
              CurrZad.ST2_R_ManSet[i] := NextZad.ST2_R_ManSet[i];
            end;
          // Обновить чертеж текущего задания
          CurrPlan.Renew;
          NextZad.ZadanieName := '';
          NextZad.ZadanieStr := '';
          // Передать текущее задание в компоненты ручного режима - готовность к командам Установить/Опустить рабочие
          SetAuto(False, CurrZad);
          SetAuto(True, CurrZad);
          // Отобразить текущее задание на форме автоматического режима
          SetCtrlAutoWidth(CurrZad);
          Log('Следующее задание скопировано в текущее');
          Log('Поднять столик');
          OPCClient.Table(True);
          // Проверить, был ли опущен один из некрайних ножей на станке 1 до перестройки
          AnyBL1DN1 := False;
          for j := 2 to 5 do if OPCClient.ST1_BL_DN[j] then AnyBL1DN1 := True;
          if AnyBL1DN1 then Log('Один из некрайних ножей на станке 1 до перестройки был опущен');
          // Проверить, был ли опущен один из некрайних ножей на станке 2 до перестройки
          AnyBL2DN1 := False;
          for j := 2 to 5 do if OPCClient.ST2_BL_DN[j] then AnyBL2DN1 := True;
          if AnyBL2DN1 then Log('Один из некрайних ножей на станке 2 до перестройки был опущен');
          Application.ProcessMessages;
          Log('Опустить рабочие');
          // Опустить рабочие (по текущему заданию)
          ManualControlForm.btZadST1Down.Click;
          ManualControlForm.btZadST2Down.Click;
          Application.ProcessMessages;
//          Log('Установить все (поднятые) механизмы по заданию');
//          // Установить все (поднятые) механизмы по текущему заданию
//          AutoStartUP1;
//          AutoStartUP2;

          Log('Установить все механизмы по заданию');
          // Установить все механизмы по текущему заданию
          AutoStartAll1;
          AutoStartAll2;

          Application.ProcessMessages;
          Log('Поднять свободные на ПР1');
          // Поднять свободные на ПР1
          ManualControlForm.btFreeST1UP.Click;
        end else
        begin
          // Если выбран режим Вклинить
          Log('Вклинить');
          // Запомнить свойства текущего задания
          s := CurrZad.ZadanieStr;
          n := CurrZad.ZadanieName;
          for i := 1 to 6 do
            begin
              ST1BLX[i] := CurrZad.ST1_BL_Xzad[i];
              ST2BLX[i] := CurrZad.ST2_BL_Xzad[i];
              ST1BLW[i] := CurrZad.ST1_BL_Work[i];
              ST2BLW[i] := CurrZad.ST2_BL_Work[i];
              ST1BLM[i] := CurrZad.ST1_BL_ManSet[i];
              ST2BLM[i] := CurrZad.ST2_BL_ManSet[i];
            end;
          for i := 1 to 10 do
            begin
              ST1RX[i] := CurrZad.ST1_R_Xzad[i];
              ST2RX[i] := CurrZad.ST2_R_Xzad[i];
              ST1RW[i] := CurrZad.ST1_R_Work[i];
              ST2RW[i] := CurrZad.ST2_R_Work[i];
              ST1RM[i] := CurrZad.ST1_R_ManSet[i];
              ST2RM[i] := CurrZad.ST2_R_ManSet[i];
            end;
          // Скопировать свойства следующего задания в текущее
          CurrZad.ZadanieName := NextZad.ZadanieName;
          CurrZad.ZadanieStr := NextZad.ZadanieStr;
          for i := 1 to 6 do
            begin
              CurrZad.ST1_BL_Xzad[i] := NextZad.ST1_BL_Xzad[i];
              CurrZad.ST2_BL_Xzad[i] := NextZad.ST2_BL_Xzad[i];
              CurrZad.ST1_BL_Work[i] := NextZad.ST1_BL_Work[i];
              CurrZad.ST2_BL_Work[i] := NextZad.ST2_BL_Work[i];
              CurrZad.ST1_BL_ManSet[i] := NextZad.ST1_BL_ManSet[i];
              CurrZad.ST2_BL_ManSet[i] := NextZad.ST2_BL_ManSet[i];
            end;
          for i := 1 to 10 do
            begin
              CurrZad.ST1_R_Xzad[i] := NextZad.ST1_R_Xzad[i];
              CurrZad.ST2_R_Xzad[i] := NextZad.ST2_R_Xzad[i];
              CurrZad.ST1_R_Work[i] := NextZad.ST1_R_Work[i];
              CurrZad.ST2_R_Work[i] := NextZad.ST2_R_Work[i];
              CurrZad.ST1_R_ManSet[i] := NextZad.ST1_R_ManSet[i];
              CurrZad.ST2_R_ManSet[i] := NextZad.ST2_R_ManSet[i];
            end;
          // Скопировать запомненные свойства в следующее задание
          NextZad.ZadanieName := n;
          NextZad.ZadanieStr := s;
          for i := 1 to 6 do
            begin
              NextZad.ST1_BL_Xzad[i] := ST1BLX[i];
              NextZad.ST2_BL_Xzad[i] := ST2BLX[i];
              NextZad.ST1_BL_Work[i] := ST1BLW[i];
              NextZad.ST2_BL_Work[i] := ST2BLW[i];
              NextZad.ST1_BL_ManSet[i] := ST1BLM[i];
              NextZad.ST2_BL_ManSet[i] := ST2BLM[i];
            end;
          for i := 1 to 10 do
            begin
              NextZad.ST1_R_Xzad[i] := ST1RX[i];
              NextZad.ST2_R_Xzad[i] := ST2RX[i];
              NextZad.ST1_R_Work[i] := ST1RW[i];
              NextZad.ST2_R_Work[i] := ST2RW[i];
              NextZad.ST1_R_ManSet[i] := ST1RM[i];
              NextZad.ST2_R_ManSet[i] := ST2RM[i];
            end;
          // Обновить чертежи
          CurrPlan.Renew;
          NextPlan.Renew;
          // Передать текущее задание в компоненты ручного режима - готовность к командам Установить/Опустить рабочие
          SetAuto(False, CurrZad);
          SetAuto(True, CurrZad);
          // Отобразить текущее задание на форме автоматического режима
          SetCtrlAutoWidth(CurrZad);
          Log('Опустить рабочие');
          ManualControlForm.btZadST1Down.Click;
          ManualControlForm.btZadST2Down.Click;
          Log('Установить все механизмы по заданию');
          AutoStartAll1;
          AutoStartAll2;
          Log('Поднять столик');
          OPCClient.Table(True);
          Log('Поднять свободные на ПР1');
          ManualControlForm.btFreeST1UP.Click;
        end;
      CounterTemp := Counter;
      ReDistStep := 3;
    end;
// Значение счетчика прошло вторую константу
  if (ReDistNow or AutoReDist and (Counter < CounterTemp - CounterConst2)) and (ReDistStep = 3) then
    begin
//  если при выполнении п. 1 ТЗ не был опущен ни один из следующих ножей:
//	12, 13 ,14, 15 на ПР1 (все за исключением двух крайних)
//  и на ПР2 был опущен хотя бы один из следующих ножей: 22, 23, 24, 25
//	происходит рез на вырубке.
//  Или был поднят хотя бы один из следующих ножей:
//	12, 13, 14, 15, 22, 23, 24, 25 (все ножи кроме крайних)
//	и все эти ножи оказались в поднятом состоянии (переход с заготовок на листы)
//  происходит рез на вырубке.
    // Проверить, был ли опущен один из некрайних ножей на станке 1 после перестройки
    AnyBL1DN2 := False;
    for j := 2 to 5 do if OPCClient.ST1_BL_DN[j] then AnyBL1DN2 := True;
    if AnyBL1DN2 then Log('Один из некрайних ножей на станке 1 после перестройки был опущен');
    // Проверить, был ли опущен один из некрайних ножей на станке 2 после перестройки
    AnyBL2DN2 := False;
    for j := 2 to 5 do if OPCClient.ST2_BL_DN[j] then AnyBL2DN2 := True;
    if AnyBL2DN2 then Log('Один из некрайних ножей на станке 2 после перестройки был опущен');
      if AnyBL1DN1 or AnyBL2DN1 or AnyBL1DN2 or AnyBL2DN2 then
        begin
          Log('Значение счетчика = ' + IntToStr(Counter) + ' Проверка опущенных ножей и рез на вырубке');
          OPCClient.Cut;
          CutDone := True;
        end;
      CounterTemp := Counter;
      ReDistStep := 4;
    end;
// Значение счетчика прошло третью константу
  if (ReDistNow or AutoReDist and (Counter < CounterTemp - CounterConst3)) and (ReDistStep = 4) then
    begin
      Log('Значение счетчика = ' + IntToStr(Counter) + ' Поднять свободные на ПР2');
      // Поднять свободные на ПР2
      ManualControlForm.btFreeST2UP.Click;
//    если при выполнении п. 1 ТЗ был опущен хотя бы один из следующих ножей
//    12, 13 ,14, 15 на ПР1 (все за исключением двух крайних) происходит рез на вырубке.
      if (not CutDone) and AnyBL1DN1 then
        begin
          Log('Значение счетчика = ' + IntToStr(Counter) + ' Проверка опущенных ножей и рез на вырубке');
          OPCClient.Cut;
          CutDone := True;
        end;
      CounterTemp := Counter;
      ReDistStep := 5;
    end;
// Значение счетчика прошло четвертую константу
  if (ReDistNow or AutoReDist and (Counter < CounterTemp - CounterConst4)) and (ReDistStep = 5) then
    begin
      Log('Значение счетчика = ' + IntToStr(Counter) + ' Опустить столик');
      OPCClient.Table(False);
      ReDistStep := 6;
      ReDistNow := False;
      // Запомнить номер станка, на который было распределено следующее задание
      st := NextZad.ActiveST;
      // Выбрать новое следующее задание из базы и распределить на другой станок
      if st = 1 then NextPlan.GetNextZad(2);
      if st = 2 then NextPlan.GetNextZad(1);
      Log('Выбрано новое Следующее задание из базы и распределено');
      btAutoStart.ButtonColor := clSkyBlue;
      btAutoReDist.Down := True;
      btAutoReDist.Click;
    end;
  CounterTimer.Enabled := True;
end;

procedure TAutoControlForm.btNextCurrClick(Sender: TObject);
var
  i : byte;
//  n : byte;
begin
  CurrZad.ZadanieName := NextZad.ZadanieName;
  CurrZad.ZadanieStr := NextZad.ZadanieStr;
  for i := 1 to 6 do
    begin
      CurrZad.ST1_BL_Xzad[i] := NextZad.ST1_BL_Xzad[i];
      CurrZad.ST2_BL_Xzad[i] := NextZad.ST2_BL_Xzad[i];
      CurrZad.ST1_BL_Work[i] := NextZad.ST1_BL_Work[i];
      CurrZad.ST2_BL_Work[i] := NextZad.ST2_BL_Work[i];
      CurrZad.ST1_BL_ManSet[i] := NextZad.ST1_BL_ManSet[i];
      CurrZad.ST2_BL_ManSet[i] := NextZad.ST2_BL_ManSet[i];
    end;
  for i := 1 to 10 do
    begin
      CurrZad.ST1_R_Xzad[i] := NextZad.ST1_R_Xzad[i];
      CurrZad.ST2_R_Xzad[i] := NextZad.ST2_R_Xzad[i];
      CurrZad.ST1_R_Work[i] := NextZad.ST1_R_Work[i];
      CurrZad.ST2_R_Work[i] := NextZad.ST2_R_Work[i];
      CurrZad.ST1_R_ManSet[i] := NextZad.ST1_R_ManSet[i];
      CurrZad.ST2_R_ManSet[i] := NextZad.ST2_R_ManSet[i];
    end;
  CurrPlan.Renew;
  NextZad.ZadanieName := '';
  NextZad.ZadanieStr := '';
  SetAuto(False, CurrZad);
  SetAuto(True, CurrZad);
  SetCtrlAutoWidth(CurrZad);
  Log('Следующее задание скопировано в текущее');
//  n := NextZad.ActiveST;
//  if n = 1 then NextPlan.GetNextZad(2);
//  if n = 2 then NextPlan.GetNextZad(1);
//  Log('Выбрано новое Следующее задание из базы');
end;

procedure TAutoControlForm.btAutoReDistClick(Sender: TObject);
begin
  ReDistNow := False;
  AutoReDist := True;
  btReDist.Enabled := False;
  btReDist.ButtonColor := clBtnFace;
end;

procedure TAutoControlForm.btManReDistClick(Sender: TObject);
begin
  ReDistNow := False;
  AutoReDist := False;
  btReDist.Enabled := True;
  btReDist.ButtonColor := $000080FF;
end;

procedure TAutoControlForm.btInsertClick(Sender: TObject);
begin
  btAutoReDist.Enabled := not btInsert.Down;
  if btInsert.Down then
    begin
      btManReDist.Down := True;
      btManReDist.Click;
    end;
end;

procedure TAutoControlForm.mnHelpClick(Sender: TObject);
var
  TempString : array[0..79] of char;
  RepF : TReplaceFlags;
  ProgramPath : string;
begin
  RepF := [rfReplaceAll, rfIgnoreCase];
  ProgramPath := ExtractFilePath(Application.EXEName);
  ProgramPath := StringReplace(ProgramPath, 'bin', 'doc', RepF);
  StrPCopy(TempString, ProgramPath + '\Технологическая_инструкция.htm');
  if FileExists(ProgramPath + '\Технологическая_инструкция.htm') then
    ShellExecute(0, Nil, TempString, Nil, Nil, SW_NORMAL);
end;

procedure TAutoControlForm.Log(Value : string);
var
  D : string;
  LogFile : TextFile;
begin
  DateTimeToString(D, 'dd.mm.yyyy  hh.nn.ss', Now);
  MemoLog.Lines.Add(D + '   -   ' + Value);
  AssignFile(LogFile, RezkaStatusPath + 'LogFile.txt');
  if FileExists(RezkaStatusPath + 'LogFile.txt') then Append(LogFile) else Rewrite(LogFile);
  WriteLn(LogFile, D + '   -   ' + Value);
  CloseFile(LogFile);
end;

procedure TAutoControlForm.btReDistClick(Sender: TObject);
begin
  ReDistNow := True;
end;

procedure TAutoControlForm.Button1Click(Sender: TObject);
begin
  OPCClient.Table(True);
end;

procedure TAutoControlForm.Button2Click(Sender: TObject);
begin
  OPCClient.Table(False);
end;

procedure TAutoControlForm.Button3Click(Sender: TObject);
begin
  OPCClient.Cut;
end;

procedure TAutoControlForm.btAutoStartClick(Sender: TObject);
begin
  Log('Установить поднятые механизмы по заданию');
  btAutoStart.ButtonColor := clBtnFace;
  btAutoStart.Enabled := False;
  btZadSTDown.Enabled := False;
  AutoStartUP1;
  AutoStartUP2;
  btAutoStart.Enabled := True;
  btZadSTDown.Enabled := True;
  btShowPos.Down := True;
end;

end.
