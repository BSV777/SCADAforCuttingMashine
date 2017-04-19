unit ContrPlan;

interface

uses
  SysUtils, Controls, Classes, Graphics, Forms, StdCtrls, ExtCtrls, Buttons, Mask, Windows, StrUtils, ContrMan, ContrDetail, Auto, ClassZadanie, Dialogs, FormMan, PZ, jpeg, shellapi;

type
  TPlanDistribute = procedure(Sender : TObject) of object;
  TControlPlan = class(TCustomPanel)
  private
    FOnPlanDistribute : TPlanDistribute;
    RenewTimer : TTimer;
    DetailList : TList;
    FZadanie : TZadanie;
    FZadanieStr : string;
    FScaleMax : integer;
    FDetailMove : boolean;
    FActiveBaseNum : string;
    FZadType : string;
    FActiveZad : single;
    sh : TShape;
    edZadanie : TEdit;
    mInfo : TMemo;
    btRenew : TButton;
    btST1 : TButton;
    btST2 : TButton;
    btPrint : TButton;
    lbZadRezult : TLabel;
    lbZadType : TLabel;
    lbZadName : TLabel;
    procedure edZadanieDblClick(Sender: TObject);
    procedure edZadanieChange(Sender: TObject);
    procedure edZadanieKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure RenewT(Sender : TObject);
    procedure MoveDetailLeft(Sender : TObject; const DNum : byte; const DNumStr : string);
    procedure ZadanieChange(Sender : TObject);
    procedure MoveDetailRight(Sender : TObject; const DNum : byte; const DNumStr : string);
    procedure ClickDetail(Sender : TObject; const DNum : byte; const BaseNum : string; const DeviceNum : byte; const Zad : single);
    procedure ClickDelete(Sender : TObject; const DNum : byte; const BaseNum : string; const DeviceNum : byte; const Zad : single);
    procedure CorrLeft(Sender : TObject; const DNum : byte; const BaseNum : string; const DeviceNum : byte; const Zad : single);
    procedure CorrRight(Sender : TObject; const DNum : byte; const BaseNum : string; const DeviceNum : byte; const Zad : single);
    procedure btRenewClick(Sender: TObject);
    procedure btST1Click(Sender: TObject);
    procedure btST2Click(Sender: TObject);
    procedure btPrintClick(Sender: TObject);
    procedure SetZadType(const Value : string);
    function  GetZadanieStr : string;
    procedure SetActiveDev(const Value : string);
    procedure DetailMove;
  protected
    { Protected declarations }
  public
    constructor Create(AOwner : TComponent); override;
    property  OnPlanDistribute : TPlanDistribute read FOnPlanDistribute write FOnPlanDistribute;
    procedure Renew;
    procedure GetNextZad(STNum : byte);
    procedure Init(ScaleMax : integer; var Zadanie : TZadanie);
    property  ActiveDev : string write SetActiveDev;
    property  ActiveBaseNum : string read FActiveBaseNum write FActiveBaseNum;
    property  ActiveZad : single read FActiveZad write FActiveZad;
    property  ZadType : string read FZadType write SetZadType;
    property  OnClick;
  end;

implementation

constructor TControlPlan.Create(AOwner : TComponent);
begin
  inherited Create(AOwner);
  Width := 500;
  Height := 230;
  BevelWidth := 1;
  BevelOuter := bvNone;
  Caption := '';
  sh := TShape.Create(Self);
  sh.Parent := Self;
  sh.Left := 0;
  sh.Top := 29;
  sh.Width := Width;
  sh.Height := 170;
  sh.Pen.Color := clNavy;
  sh.Brush.Style := bsClear;
  edZadanie := TEdit.Create(Self);
  edZadanie.Parent := Self;
  edZadanie.Left := 1;
  edZadanie.Top := 210;
  edZadanie.Width := 675;
  edZadanie.Height := 21;
  edZadanie.Color := clCream;
  edZadanie.Font.Charset := DEFAULT_CHARSET;
  edZadanie.Font.Color := clGreen;
  edZadanie.Font.Height := -11;
  edZadanie.Font.Name := 'MS Sans Serif';
  edZadanie.Font.Style := [fsBold];
  edZadanie.ParentFont := False;
  edZadanie.OnDblClick := edZadanieDblClick;
  edZadanie.OnChange := edZadanieChange;
  edZadanie.OnKeyDown := edZadanieKeyDown;
  mInfo := TMemo.Create(Self);
  with mInfo do
    begin
      Parent := Self;
      Left := 800;
      Top := 25;
      Width := 180;
      Height := 190;
      BevelEdges := [];
      BevelInner := bvNone;
      BevelOuter := bvNone;
      BorderStyle := bsNone;
      Color := clBtnFace;
      ReadOnly := True;
    end;
  lbZadType := TLabel.Create(Self);
  with lbZadType do
    begin
      Parent := Self;
      Left := 1;
      Top := 5;
      AutoSize := True;
      Caption := '';
      Font.Color := clNavy;
      Font.Size := 10;
      Font.Name := 'Times New Roman';
      Font.Style := [fsBold];
    end;
  lbZadName := TLabel.Create(Self);
  with lbZadName do
    begin
      Parent := Self;
      Left := 150;
      Top := 5;
      AutoSize := True;
      Caption := '';
      Font.Color := clGreen;
      Font.Size := 11;
      Font.Name := 'Times New Roman';
      Font.Style := [fsBold];
    end;
  btRenew := TButton.Create(Self);
    with btRenew do
      begin
        Parent := Self;
        Left := 680;
        Top := 210;
        Width := 55;
        Height := 21;
        Caption := 'Ввод';
        Font.Color := clWindowText;
        Font.Size := 8;
        Font.Name := 'MS Sans Serif';
        Font.Style := [fsBold];
        OnClick := btRenewClick;
      end;
  btST1 := TButton.Create(Self);
    with btST1 do
      begin
        Parent := Self;
        Left := 760;
        Top := 210;
        Width := 55;
        Height := 21;
        Caption := 'На ПР1';
        Font.Color := clWindowText;
        Font.Size := 8;
        Font.Name := 'MS Sans Serif';
        Font.Style := [fsBold];
        Enabled := False;
        OnClick := btST1Click;
      end;
  btST2 := TButton.Create(Self);
    with btST2 do
      begin
        Parent := Self;
        Left := 800;
        Top := 210;
        Width := 55;
        Height := 21;
        Caption := 'На ПР2';
        Font.Color := clWindowText;
        Font.Size := 8;
        Font.Name := 'MS Sans Serif';
        Font.Style := [fsBold];
        Enabled := False;
        OnClick := btST2Click;
      end;
  btPrint := TButton.Create(Self);
    with btPrint do
      begin
        Parent := Self;
        Left := 850;
        Top := 210;
        Width := 55;
        Height := 21;
        Caption := 'Печать';
        Font.Color := clWindowText;
        Font.Size := 8;
        Font.Name := 'MS Sans Serif';
        Font.Style := [fsBold];
        OnClick := btPrintClick;
      end;
  lbZadRezult := TLabel.Create(Self);
  with lbZadRezult do
    begin
      Parent := Self;
      Left := 900;
      Top := 212;
      AutoSize := True;
      Caption := '';
      Font.Color := clNavy;
      Font.Size := 10;
      Font.Name := 'Times New Roman';
      Font.Style := [fsBold];
    end;
  Font.Name := 'MS Sans Serif';
  DetailList := TList.Create;
  RenewTimer := TTimer.Create(Self);
  RenewTimer.Interval := 500;
  RenewTimer.Enabled := False;
  RenewTimer.OnTimer := RenewT;
  FDetailMove := False;
end;


procedure TControlPlan.RenewT(Sender : TObject);
var
  a : integer;
begin
  a := FZadanie.ActiveST;
  FZadanie.ZadanieStr := FZadanieStr;
  if a = 1 then btST1.Click;
  if a = 2 then btST2.Click;
  RenewTimer.Enabled := False;
end;

procedure TControlPlan.Init(ScaleMax : integer; var Zadanie : TZadanie);
begin
  FScaleMax := ScaleMax;
  edZadanie.Width := Round(FScaleMax * 0.8);
  btRenew.Left := edZadanie.Width + 5;
  btST1.Left := btRenew.Left + 60;
  btST2.Left := btST1.Left + 60;
  btPrint.Left := btST2.Left + 60;
  lbZadRezult.Left := btPrint.Left + 60;
  FZadanie := Zadanie;
  FZadanie.OnZadanieChange := ZadanieChange;
end;

procedure TControlPlan.MoveDetailLeft(Sender : TObject; const DNum : byte; const DNumStr : string);
var
  XMin, DetailWidth : single;
  Detail : TControlDetail;
  a : integer;
  s : string;
begin
  if (DNum > 2) and (DNum < FZadanie.BLzadCount + 1) then
    if MessageDlg('Переместить заготовку ' + DNumStr + ' влево?' , mtConfirmation, [mbYes, mbNo], 0) = mrYes then
      begin
//        FZadanie.ZadanieStr := edZadanie.Text;
        Detail := DetailList.Items[DNum - 1];
        DetailWidth := Detail.DetailWidth;
        Detail := DetailList.Items[DNum - 2];
        XMin := Detail.XMin;
        Detail := DetailList.Items[DNum - 1];
        Detail.XMin := XMin;
        Detail := DetailList.Items[DNum - 2];
        Detail.XMin := XMin + DetailWidth;
        s := FZadanie.Details[DNum - 1];
        FZadanie.Details[DNum - 1] := FZadanie.Details[DNum - 2];
        FZadanie.Details[DNum - 2] := s;
        FDetailMove := True;
        a := FZadanie.ActiveST;
        FZadanie.ZadanieStr := GetZadanieStr;
        Application.ProcessMessages;
        if a = 1 then btST1.Click;
        if a = 2 then btST2.Click;
      end;
end;

procedure TControlPlan.MoveDetailRight(Sender : TObject; const DNum : byte; const DNumStr : string);
var
  XMin, DetailWidth : single;
  Detail : TControlDetail;
  a : integer;
  s : string;
begin
  if (DNum > 1) and (DNum < FZadanie.BLzadCount) then
    if MessageDlg('Переместить заготовку ' + DNumStr + ' вправо?' , mtConfirmation, [mbYes, mbNo], 0) = mrYes then
      begin
//        FZadanie.ZadanieStr := edZadanie.Text;
        Detail := DetailList.Items[DNum - 1];
        XMin := Detail.XMin;
        Detail := DetailList.Items[DNum];
        DetailWidth := Detail.DetailWidth;
        Detail.XMin := XMin;
        Detail := DetailList.Items[DNum - 1];
        Detail.XMin := XMin + DetailWidth;
        s := FZadanie.Details[DNum - 1];
        FZadanie.Details[DNum - 1] := FZadanie.Details[DNum];
        FZadanie.Details[DNum] := s;
        FDetailMove := True;
        a := FZadanie.ActiveST;
        FZadanie.ZadanieStr := GetZadanieStr;
        Application.ProcessMessages;
        if a = 1 then btST1.Click;
        if a = 2 then btST2.Click;
      end;
end;

procedure TControlPlan.ClickDetail(Sender : TObject; const DNum : byte; const BaseNum : string; const DeviceNum : byte; const Zad : single);
var
  i : byte;
  Detail : TControlDetail;
begin
  for i := 1 to FZadanie.BLzadCount + 1 do
    begin
      Detail := DetailList.Items[i - 1];
      if Detail.DNum <> DNum then Detail.Selected := False;
    end;
//  if DeviceNum = 0 then
//    begin
      FActiveBaseNum := BaseNum;
      FActiveZad := Zad;
//    end;
end;

procedure TControlPlan.ClickDelete(Sender : TObject; const DNum : byte; const BaseNum : string; const DeviceNum : byte; const Zad : single);
var
  s, z : string;
  t : integer;
begin
  if Pos('BL', BaseNum) <> 0 then z := 'H' + Format('%3.1f', [Zad]);
  if Pos('R', BaseNum) <> 0 then z := 'P' + Format('%3.1f', [Zad]);
  s := GetZadanieStr;
  t := Pos(z, s);
  Delete(s, t, Length(z));
  FZadanieStr := s;
  RenewTimer.Enabled := True;
end;

procedure TControlPlan.CorrLeft(Sender : TObject; const DNum : byte; const BaseNum : string; const DeviceNum : byte; const Zad : single);
var
  CtrlMan : TControlMan;
begin
  if BaseNum = 'ST1_BL' then CtrlMan := ST1BLList.Items[DeviceNum - 1] else
    if BaseNum = 'ST2_BL' then CtrlMan := ST2BLList.Items[DeviceNum - 1] else
      if BaseNum = 'ST1_R' then CtrlMan := ST1RList.Items[DeviceNum - 1] else
        if BaseNum = 'ST2_R' then CtrlMan := ST2RList.Items[DeviceNum - 1] else CtrlMan := nil;
  if CtrlMan <> nil then CtrlMan.Zad := CtrlMan.Pos - CtrlMan.Impuls;
  if CtrlMan <> nil then CtrlMan.NewZad := True;
end;

procedure TControlPlan.CorrRight(Sender : TObject; const DNum : byte; const BaseNum : string; const DeviceNum : byte; const Zad : single);
var
  CtrlMan : TControlMan;
begin
  if BaseNum = 'ST1_BL' then CtrlMan := ST1BLList.Items[DeviceNum - 1] else
    if BaseNum = 'ST2_BL' then CtrlMan := ST2BLList.Items[DeviceNum - 1] else
      if BaseNum = 'ST1_R' then CtrlMan := ST1RList.Items[DeviceNum - 1] else
        if BaseNum = 'ST2_R' then CtrlMan := ST2RList.Items[DeviceNum - 1] else CtrlMan := nil;
  if CtrlMan <> nil then CtrlMan.Zad := CtrlMan.Pos + CtrlMan.Impuls;
  if CtrlMan <> nil then CtrlMan.NewZad := True;
end;

procedure TControlPlan.btRenewClick(Sender: TObject);
begin
  btST1.Enabled := True;
  btST2.Enabled := True;
  FZadanie.ZadanieStr := edZadanie.Text;
end;

procedure TControlPlan.btST1Click(Sender: TObject);
begin
  SetAuto(False, FZadanie);
//  FZadanie.ZadanieStr := edZadanie.Text;
  FZadanie.DistributeST1R;
  FZadanie.DistributeST1BL;
  if FZadanie.ZadanieErr then lbZadRezult.Caption := FZadanie.ZadanieStatus;
  if FZadanie.DistributeRErr then lbZadRezult.Caption := FZadanie.DistributeRStatus;
  if FZadanie.DistributeBLErr then lbZadRezult.Caption := FZadanie.DistributeBLStatus;
  if FZadanie.ZadanieErr or FZadanie.DistributeRErr or FZadanie.DistributeBLErr then
    begin
      lbZadRezult.Font.Color := clYellow;
      SetAuto(False, FZadanie);
    end else
    begin
      lbZadRezult.Font.Color := clGreen;
      lbZadRezult.Caption := FZadanie.DistributeStatus;
      SetAuto(True, FZadanie);
    end;
  SetCtrlAutoWidth(FZadanie);
  Renew;
  btST1.Enabled := False;
  btST2.Enabled := False;
  if Assigned(FOnPlanDistribute) then FOnPlanDistribute(Self);
end;

procedure TControlPlan.btST2Click(Sender: TObject);
begin
  SetAuto(False, FZadanie);
//  FZadanie.ZadanieStr := edZadanie.Text;
  FZadanie.DistributeST2R;
  FZadanie.DistributeST2BL;
  if FZadanie.ZadanieErr then lbZadRezult.Caption := FZadanie.ZadanieStatus;
  if FZadanie.DistributeRErr then lbZadRezult.Caption := FZadanie.DistributeRStatus;
  if FZadanie.DistributeBLErr then lbZadRezult.Caption := FZadanie.DistributeBLStatus;
  if FZadanie.ZadanieErr or FZadanie.DistributeRErr or FZadanie.DistributeBLErr then
    begin
      lbZadRezult.Font.Color := clYellow;
      SetAuto(False, FZadanie);
    end else
    begin
      lbZadRezult.Font.Color := clGreen;
      lbZadRezult.Caption := FZadanie.DistributeStatus;
      SetAuto(True, FZadanie);
    end;
  SetCtrlAutoWidth(FZadanie);
  Renew;
  btST1.Enabled := False;
  btST2.Enabled := False;
  if Assigned(FOnPlanDistribute) then FOnPlanDistribute(Self);
end;

function TControlPlan.GetZadanieStr : string;
var
  s : string;
  i, j, Count : integer;
  Detail : TControlDetail;
begin
  s := '';
  Count := DetailList.Count - 1;
  for i := 0 to Count do
    begin
      Detail := DetailList.Items[i];
      if Detail.XMin > 0 then s := s + 'H' + Format('%3.1f', [Detail.XMin]) + ' ';
      for j := 1 to Detail.RLocalCount do s := s + 'P' + Format('%3.1f', [Detail.XMin + Detail.RLocal[j]]) + ' ';
    end;
  Result := s;
end;

procedure TControlPlan.ZadanieChange(Sender : TObject);
begin
  lbZadRezult.Caption := '';
  edZadanie.Text := FZadanie.ZadanieStr;
  lbZadName.Caption := FZadanie.ZadanieName;
  if FZadanie.ZadanieErr then
    begin
      lbZadRezult.Font.Color := clYellow;
      lbZadRezult.Caption := FZadanie.ZadanieStatus;
    end else lbZadRezult.Font.Color := clGreen;
  if FDetailMove then DetailMove else Renew;
end;

procedure TControlPlan.Renew;
var
  Detail : TControlDetail;
  i, j, k, Count : integer;
  r : string;
begin
  mInfo.Lines.Clear;
  Count := DetailList.Count - 1;
  for i := Count downto 0 do
    begin
      Detail := DetailList.Items[i];
      DetailList.Delete(i);
      Detail.Free;
    end;
  Width := FScaleMax + 220;
  mInfo.Left := Left + FScaleMax - 30;
  sh.Width := FScaleMax;
  k := 1;
  if FZadanie.BLzadCount = 0 then
    begin
      DetailList.Add(TControlDetail.Create(Self));
      Detail := DetailList.Items[0];
      Detail.Parent := Self;
      Detail.Top := 30;
      Detail.OnMoveLeft := MoveDetailLeft;
      Detail.OnMoveRight := MoveDetailRight;
      Detail.OnClickDetail := ClickDetail;
      Detail.OnClickDelete := ClickDelete;
      Detail.Init(FScaleMax, 0, 2600, FZadanie, FZadType);
      Detail.OnCorrLeft := CorrLeft;
      Detail.OnCorrRight := CorrRight;
      Detail.DNum := 0;
      Detail.DNumStr := '';
    end;
  for i := 1 to FZadanie.BLzadCount do
    begin
      if i = 1 then
        begin
          mInfo.Lines.Add('Ширина обрези ' + Format('%4.1f', [FZadanie.BLzad[i]]));
          mInfo.Lines.Add('');
          r := '';
          for j := 1 to FZadanie.RzadCount do if (FZadanie.Rzad[j] <= FZadanie.BLzad[i]) then r := r + Format('%4.1f', [FZadanie.Rzad[j]]) + '  ';
          if r <> '' then mInfo.Lines.Add('    Рилевки: ' + r);
          DetailList.Add(TControlDetail.Create(Self));
          Detail := DetailList.Items[0];
          Detail.Parent := Self;
          Detail.Top := 30;
          Detail.OnMoveLeft := MoveDetailLeft;
          Detail.OnMoveRight := MoveDetailRight;
          Detail.OnClickDetail := ClickDetail;
          Detail.OnClickDelete := ClickDelete;
          Detail.Init(FScaleMax, 0, FZadanie.BLzad[1], FZadanie, FZadType);
          Detail.Trash := True;
          Detail.DNum := i;
          Detail.OnCorrLeft := CorrLeft;
          Detail.OnCorrRight := CorrRight;
          Detail.DNumStr := '';
        end else
        begin
          if k in [1..8] then mInfo.Lines.Add(FZadanie.Details[k] + ') Ширина заготовки ' + Format('%4.1f', [FZadanie.BLzad[i] - FZadanie.BLzad[i - 1]]));
          r := '';
          for j := 1 to FZadanie.RzadCount do if (FZadanie.Rzad[j] <= FZadanie.BLzad[i]) and (FZadanie.Rzad[j] > FZadanie.BLzad[i - 1]) then r := r + Format('%4.1f', [FZadanie.Rzad[j] - FZadanie.BLzad[i - 1]]) + '  ';
          if r <> '' then mInfo.Lines.Add('    Рилевки: ' + r);
          DetailList.Add(TControlDetail.Create(Self));
          Detail := DetailList.Items[i - 1];
          Detail.Parent := Self;
          Detail.Top := 30;
          Detail.OnMoveLeft := MoveDetailLeft;
          Detail.OnMoveRight := MoveDetailRight;
          Detail.OnClickDetail := ClickDetail;
          Detail.OnClickDelete := ClickDelete;
          Detail.Init(FScaleMax, FZadanie.BLzad[i - 1], FZadanie.BLzad[i] - FZadanie.BLzad[i - 1], FZadanie, FZadType);
          Detail.Trash := False;
          Detail.DNum := i;
          Detail.OnCorrLeft := CorrLeft;
          Detail.OnCorrRight := CorrRight;
          Detail.DNumStr := FZadanie.Details[k];
          k := k + 1;
        end;
      if i = FZadanie.BLzadCount then
        begin
          mInfo.Lines.Add('');
          mInfo.Lines.Add('Ширина обрези ' + Format('%4.1f', [2600 - FZadanie.BLzad[i]]));
          r := '';
          for j := 1 to FZadanie.RzadCount do if (FZadanie.Rzad[j] > FZadanie.BLzad[i]) then r := r + Format('%4.1f', [FZadanie.Rzad[j] - FZadanie.BLzad[i]]) + '  ';
          if r <> '' then mInfo.Lines.Add('    Рилевки: ' + r);
          DetailList.Add(TControlDetail.Create(Self));
          Detail := DetailList.Items[i];
          Detail.Parent := Self;
          Detail.Top := 30;
          Detail.OnMoveLeft := MoveDetailLeft;
          Detail.OnMoveRight := MoveDetailRight;
          Detail.OnClickDetail := ClickDetail;
          Detail.OnClickDelete := ClickDelete;
          Detail.Init(FScaleMax, FZadanie.BLzad[i], 2600 - FZadanie.BLzad[i], FZadanie, FZadType);
          Detail.Trash := True;
          Detail.DNum := i + 1;
          Detail.OnCorrLeft := CorrLeft;
          Detail.OnCorrRight := CorrRight;
          Detail.DNumStr := '';
        end;
    end;
  btST1.Enabled := True;
  btST2.Enabled := True;
end;

procedure TControlPlan.DetailMove;
var
  Detail : TControlDetail;
  i, j, k : integer;
  r : string;
begin
  mInfo.Lines.Clear;
  k := 1;
  for i := 1 to FZadanie.BLzadCount do
    begin
      if i = 1 then
        begin
          mInfo.Lines.Add('Ширина обрези ' + Format('%4.1f', [FZadanie.BLzad[i]]));
          mInfo.Lines.Add('');
          r := '';
          for j := 1 to FZadanie.RzadCount do if (FZadanie.Rzad[j] <= FZadanie.BLzad[i]) then r := r + Format('%4.1f', [FZadanie.Rzad[j]]) + '  ';
          if r <> '' then mInfo.Lines.Add('    Рилевки: ' + r);
          Detail := DetailList.Items[0];
          Detail.Init(FScaleMax, 0, FZadanie.BLzad[1], FZadanie, FZadType);
          Detail.Trash := True;
          Detail.DNum := i;
          Detail.DNumStr := '';
        end else
        begin
          if k in [1..8] then mInfo.Lines.Add(FZadanie.Details[k] + ') Ширина заготовки ' + Format('%4.1f', [FZadanie.BLzad[i] - FZadanie.BLzad[i - 1]]));
          r := '';
          for j := 1 to FZadanie.RzadCount do if (FZadanie.Rzad[j] <= FZadanie.BLzad[i]) and (FZadanie.Rzad[j] > FZadanie.BLzad[i - 1]) then r := r + Format('%4.1f', [FZadanie.Rzad[j] - FZadanie.BLzad[i - 1]]) + '  ';
          if r <> '' then mInfo.Lines.Add('    Рилевки: ' + r);

          Detail := DetailList.Items[i - 1];
          Detail.Init(FScaleMax, FZadanie.BLzad[i - 1], FZadanie.BLzad[i] - FZadanie.BLzad[i - 1], FZadanie, FZadType);
          Detail.Trash := False;
          Detail.DNum := i;
          Detail.DNumStr := FZadanie.Details[k];
          k := k + 1;
        end;
      if i = FZadanie.BLzadCount then
        begin
          mInfo.Lines.Add('');
          mInfo.Lines.Add('Ширина обрези ' + Format('%4.1f', [2600 - FZadanie.BLzad[i]]));
          r := '';
          for j := 1 to FZadanie.RzadCount do if (FZadanie.Rzad[j] > FZadanie.BLzad[i]) then r := r + Format('%4.1f', [FZadanie.Rzad[j] - FZadanie.BLzad[i]]) + '  ';
          if r <> '' then mInfo.Lines.Add('    Рилевки: ' + r);
          Detail := DetailList.Items[i];
          Detail.Init(FScaleMax, FZadanie.BLzad[i], 2600 - FZadanie.BLzad[i], FZadanie, FZadType);
          Detail.Trash := True;
          Detail.DNum := i + 1;
          Detail.DNumStr := '';
        end;
    end;
  FDetailMove := False;
  btST1.Enabled := True;
  btST2.Enabled := True;
end;


procedure TControlPlan.SetActiveDev(const Value : string);
var
  s : string;
  i : byte;
begin
  s := Value;
  if Pos(FActiveBaseNum, s) <> 0 then
    begin
      if Pos('ST1_BL', Value) <> 0 then try
        s := Value;
        Delete(s, 1, 6);
        i := StrToInt(s);
        if (FActiveZad > FZadanie.ST1_BL_Xmax[i]) or (FActiveZad < FZadanie.ST1_BL_Xmin[i]) then
          MessageDlg('Невозможно установить выбранный нож на размер ' + Format('%3.1f', [FActiveZad]) + #13#10 + 'Максимальный диапазон составляет: ' + Format('%3.1f', [FZadanie.ST1_BL_Xmin[i]]) + ' ... ' + Format('%3.1f', [FZadanie.ST1_BL_Xmax[i]]), mtInformation, [mbOk], 0) else
          begin
            FZadanie.ST1_BL_Xzad[i] := FActiveZad;
            FZadanie.ST1_BL_Work[i] := True;
            FZadanie.ST1_BL_ManSet[i] := True;
          end;
      except  end;
      if Pos('ST2_BL', Value) <> 0 then try
        s := Value;
        Delete(s, 1, 6);
        i := StrToInt(s);
        if (FActiveZad > FZadanie.ST2_BL_Xmax[i]) or (FActiveZad < FZadanie.ST2_BL_Xmin[i]) then
          MessageDlg('Невозможно установить выбранный нож на размер ' + Format('%3.1f', [FActiveZad]) + #13#10 + 'Максимальный диапазон составляет: ' + Format('%3.1f', [FZadanie.ST2_BL_Xmin[i]]) + ' ... ' + Format('%3.1f', [FZadanie.ST2_BL_Xmax[i]]), mtInformation, [mbOk], 0) else
          begin
            FZadanie.ST2_BL_Xzad[i] := FActiveZad;
            FZadanie.ST2_BL_Work[i] := True;
            FZadanie.ST2_BL_ManSet[i] := True;
          end;
      except  end;
      if Pos('ST1_R', Value) <> 0 then try
        s := Value;
        Delete(s, 1, 5);
        i := StrToInt(s);
        if (FActiveZad > FZadanie.ST1_R_Xmax[i]) or (FActiveZad < FZadanie.ST1_R_Xmin[i]) then
          MessageDlg('Невозможно установить выбранную рилевку на размер ' + Format('%3.1f', [FActiveZad]) + #13#10 + 'Максимальный диапазон составляет: ' + Format('%3.1f', [FZadanie.ST1_R_Xmin[i]]) + ' ... ' + Format('%3.1f', [FZadanie.ST1_R_Xmax[i]]), mtInformation, [mbOk], 0) else
          begin
            FZadanie.ST1_R_Xzad[i] := FActiveZad;
            FZadanie.ST1_R_Work[i] := True;
            FZadanie.ST1_R_ManSet[i] := True;
          end;
      except  end;
      if Pos('ST2_R', Value) <> 0 then try
        s := Value;
        Delete(s, 1, 5);
        i := StrToInt(s);
        if (FActiveZad > FZadanie.ST2_R_Xmax[i]) or (FActiveZad < FZadanie.ST2_R_Xmin[i]) then
          MessageDlg('Невозможно установить выбранную рилевку на размер ' + Format('%3.1f', [FActiveZad]) + #13#10 + 'Максимальный диапазон составляет: ' + Format('%3.1f', [FZadanie.ST2_R_Xmin[i]]) + ' ... ' + Format('%3.1f', [FZadanie.ST2_R_Xmax[i]]), mtInformation, [mbOk], 0) else
          begin
            FZadanie.ST2_R_Xzad[i] := FActiveZad;
            FZadanie.ST2_R_Work[i] := True;
            FZadanie.ST2_R_ManSet[i] := True;
          end;
      except  end;
      Renew;
    end;
  if FZadanie.ActiveST = 1 then btST1.Click;
  if FZadanie.ActiveST = 2 then btST2.Click;
  FActiveBaseNum := '';
  FActiveZad := 0;
end;

procedure TControlPlan.edZadanieDblClick(Sender: TObject);
var
  FPZ: TFPZ;
begin
  try
    Application.CreateForm(TFPZ, FPZ);
    FPZ.QPZ.Open;
    FPZ.ShowModal;
    if FPZ.ModalResult = mrOk then
      begin
        edZadanie.Text := FPZ.QPZ.FieldByName('PZ_LINE').asString;
        FZadanie.DetailsStr := FPZ.QPZ.FieldByName('KNIFES').asString;
        lbZadName.Caption := FPZ.QPZ.FieldByName('NUM').asString;
      end;
    FZadanie.ZadanieName := lbZadName.Caption;
    FZadanie.ZadanieStr := edZadanie.Text;
    FPZ.QPZ.Close;
  except
    lbZadRezult.Font.Color := clYellow;
    lbZadRezult.Caption := 'Нет связи с базой данных.';
  end;
end;

procedure TControlPlan.SetZadType(const Value : string);
begin
  FZadType := Value;
  if FZadType = 'C' then lbZadType.Caption := 'Текущее задание:';
  if FZadType = 'N' then lbZadType.Caption := 'Следующее задание:';
end;

procedure TControlPlan.btPrintClick(Sender: TObject);
var
  Canvas : TCanvas;
  ScreenV : HDC;
  Image1 : TImage;
  d, dir : string;
  jpg : TJpegImage;
  F : TextFile;
  i, j, r, g, b : integer;
  TempString : array[0..79] of char;
begin
  Image1 := TImage.Create(Self);
  Image1.Parent := Self;
  Image1.Left := Self.Left;
  Image1.Top := Self.Top + 70;
  Image1.Width := Self.Width - 45;
  Image1.Height := Self.Height - 50;
  ScreenV := GetDC(0);
  Canvas := TCanvas.Create();
  Canvas.Handle := ScreenV;
  Image1.Canvas.Copyrect(Rect(0, 0, Image1.Width, Image1.Height), Canvas, Rect(Image1.Left, Image1.Top, Image1.Width + Image1.Left, Image1.Height + Image1.Top));
  ReleaseDC(0, ScreenV);
  Canvas.Free;
  Application.ProcessMessages;
  DateTimeToString(dir, 'dd.mm.yyyy', Now);
  if not DirectoryExists(RezkaStatusPath + dir) then MkDir(RezkaStatusPath + dir);
  DateTimeToString(d, 'dd.mm.yyyy-hh.nn.ss', Now);
  dir := RezkaStatusPath + dir;
  r := getRValue(Image1.canvas.pixels[0, 0]);
  g := getGValue(Image1.canvas.pixels[0, 0]);
  b := getBValue(Image1.canvas.pixels[0, 0]);
  for i := 0 to Image1.Height do
    for j := 0 to Image1.Width do
      if Image1.Canvas.Pixels[j, i] = Round(rgb(r, g, b)) then Image1.Canvas.Pixels[j, i] := clWhite;
  jpg := TJpegImage.Create;
  jpg.Assign(Image1.picture.graphic);
  jpg.CompressionQuality := 100;
  jpg.Compress;
  jpg.SaveToFile(dir + '\' + FZadType + '_' + d + '.jpg');
  jpg.free;
  Image1.Free;
  AssignFile(F, dir + '\' + FZadType + '_' + d + '.htm');
  Rewrite(F);
  Writeln(F, '<HTML>');
  Writeln(F, '<HEAD>');
  Writeln(F, '<TITLE>Л-ПАК. Агрегат резки</TITLE>');
  Writeln(F, '<META HTTP-EQUIV="Content-Type" CONTENT="text/html; charset=windows-1251">');
  Writeln(F, '</HEAD>');
  Writeln(F, '<BODY BGCOLOR=#ffffff>');
  Writeln(F, '<IMG src="' + FZadType + '_' + d + '.jpg" width="1200" height="220">');
  Writeln(F, '<P style="font-family:Arial;font-size:14px;text-align:left;"><B>' + FZadanie.ZadanieStr + '</B></P>');
  Writeln(F, '</BODY>');
  Writeln(F, '</HTML>');
  CloseFile(F);
  StrPCopy(TempString, dir + '\' + FZadType + '_' + d + '.htm');
  ShellExecute(0, Nil, TempString, Nil, Nil, SW_NORMAL);
end;

procedure TControlPlan.edZadanieChange(Sender: TObject);
begin
  btST1.Enabled := False;
  btST2.Enabled := False;
end;

procedure TControlPlan.edZadanieKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if Key = VK_RETURN then btRenew.Click;
end;

procedure TControlPlan.GetNextZad(STNum : byte);
var
  FPZ : TFPZ;
begin
  try
    Application.CreateForm(TFPZ, FPZ);
    FPZ.QPZ.Open;
    FPZ.QPZ.Next;
//    // Если задание не закончилось, то оно может висеть в базе
//    if FZadanie.ZadanieName = FPZ.QPZ.FieldByName('NUM').asString then FPZ.QPZ.Next;
    FZadanie.ZadanieName := FPZ.QPZ.FieldByName('NUM').asString;
    FZadanie.DetailsStr := FPZ.QPZ.FieldByName('KNIFES').asString;
    FZadanie.ZadanieStr := FPZ.QPZ.FieldByName('PZ_LINE').asString;
    edZadanie.Text := FZadanie.ZadanieStr;
    lbZadName.Caption := FZadanie.ZadanieName;
    FPZ.QPZ.Close;
  except
    lbZadRezult.Font.Color := clYellow;
    lbZadRezult.Caption := 'Нет связи с базой данных.';
  end;
  if STNum = 1 then btST1.Click;
  if STNum = 2 then btST2.Click;
end;


end.
