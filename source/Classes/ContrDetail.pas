unit ContrDetail;

interface

uses
  SysUtils, Controls, Classes, Graphics, Forms, StdCtrls, ExtCtrls, Buttons, Mask, Windows, StrUtils, Auto, ClassZadanie, Messages, ShellAPI, Dialogs;

type
  TDetailClick = procedure(Sender : TObject; const DNum : byte; const BaseNum : string; const DeviceNum : byte; const Zad : single) of object;
  TDetailMove = procedure(Sender : TObject; const DNum : byte; const DNumStr : string) of object;
  TControlDetail = class(TCustomPanel)
  private
    FOnMoveLeft : TDetailMove;
    FOnMoveRight : TDetailMove;
    FOnCorrLeft : TDetailClick;
    FOnCorrRight : TDetailClick;
    FOnClickDetail : TDetailClick;
    FOnClickDelete : TDetailClick;
    FlashTimer : TTimer;
    IntervalTimer : TTimer;
    FZadanie : TZadanie;
    FSelect : boolean;
    FSelected : boolean;
    FAssigned : boolean;
    FScaleMax : integer;
    FZadType : string;
    FActiveBaseNum : string;
    FActiveZad : single;
    FActiveDeviceNum : byte;
    FXMin : single;
    FTrash : boolean;
    FDetailWidth : single;
    FDNum : byte;
    FRLocal : s_array;
    shLeft1 : TShape;
    shLeft2 : TShape;
    lbN : TLabel;
    lbDN : TLabel;
    RList1 : TList;
    RList2 : TList;
    RlbList1 : TList;
    RlbSList1 : TList;
    lbS : TLabel;
    btLeft : TButton;
    btRight : TButton;
    btDelete : TButton;
    X0 : integer;
    FDNumStr : string;
    FlashingShapeNum : integer;
    FlashingTrigger : boolean;
    procedure Flashing(Sender : TObject);
    procedure Interval(Sender : TObject);
    procedure SetDNum(const Value : byte);
    procedure SetDNumStr(const Value : string);
    procedure btCorrLeftClick(Sender : TObject);
    procedure btCorrRightClick(Sender : TObject);
    procedure btDeleteClick(Sender : TObject);
    procedure SetSelected(const Value : boolean);
    procedure SetXMin(const Value : single);
    function GetRLocal(Index : byte) : single;
    function GetRLocalCount : byte;
  protected
    procedure DetailMouseMove(Sender: TObject; Shift: TShiftState; X, Y: Integer);
    procedure DetailMouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure DetailClick(Sender: TObject);
    function GetDisplayNum(BaseNum : string; Num : byte) : string;
    procedure Paint; override;
  public
    constructor Create(AOwner : TComponent); override;
    procedure Init(ScaleMax : integer; XMin, DetailWidth : single; var Zadanie : TZadanie; ZadType : string);
    property OnMouseMove;
    property OnMouseDown;
    property OnClick;
    property OnMoveLeft : TDetailMove read FOnMoveLeft write FOnMoveLeft;
    property OnMoveRight : TDetailMove read FOnMoveRight write FOnMoveRight;
    property OnCorrLeft : TDetailClick read FOnCorrLeft write FOnCorrLeft;
    property OnCorrRight : TDetailClick read FOnCorrRight write FOnCorrRight;
    property OnClickDetail : TDetailClick read FOnClickDetail write FOnClickDetail;
    property OnClickDelete : TDetailClick read FOnClickDelete write FOnClickDelete;
    property DNum : byte read FDNum write SetDNum;
    property DNumStr : string read FDNumStr write SetDNumStr;
    property Selected : boolean read FSelected write SetSelected;
    property Trash : boolean read FTrash write FTrash;
    property XMin : single read FXMin write SetXMin;
    property DetailWidth : single read FDetailWidth;
    property RLocal[Index : byte] : single read GetRLocal;
    property RLocalCount : byte read GetRLocalCount;
    property ZadType : string read FZadType;
  end;

implementation

constructor TControlDetail.Create(AOwner : TComponent);
begin
  inherited Create(AOwner);
  Width := 100;
  Height := 168;
  BevelWidth := 1;
  BevelOuter := bvNone;
  Caption := '';
  Font.Name := 'MS Sans Serif';
  shLeft1 := TShape.Create(Self);
  with shLeft1 do
    begin
      Parent := Self;
      Left := 0;
      Top := 18;
      Tag := 0;
      Width := 4;
      Height := 50;
      Pen.Color := clBlack;
      Brush.Color := clBlack;
      OnMouseDown := DetailMouseDown;
    end;
  shLeft2 := TShape.Create(Self);
  with shLeft2 do
    begin
      Parent := Self;
      Left := 0;
      Top := 70;
      Tag := 0;
      Width := 4;
      Height := 150;
      Pen.Color := clBlack;
      Brush.Color := clBlack;
      OnMouseDown := DetailMouseDown;
    end;
  lbN := TLabel.Create(Self);
  with lbN do
    begin
      Parent := Self;
      Left := 0;
      Top := 0;
      AutoSize := True;
      Caption := '';
      Font.Color := clNavy;
      Font.Size := 10;
      Font.Name := 'Times New Roman';
      Font.Style := [fsBold];
    end;
  lbDN := TLabel.Create(Self);
  with lbDN do
    begin
      Parent := Self;
      Left := 30;
      Top := 110;
      AutoSize := True;
      Caption := '';
      Font.Color := clBlack;
      Font.Size := 10;
      Font.Name := 'Times New Roman';
      Font.Style := [fsBold];
    end;
  lbS := TLabel.Create(Self);
  with lbS do
    begin
      Parent := Self;
      Left := 0;
      Top := 75;
      AutoSize := True;
      Caption := '';
      Font.Color := clBlack;
      Font.Size := 10;
      Font.Name := 'Times New Roman';
      Font.Style := [fsBold];
    end;
  btLeft := TButton.Create(Self);
    with btLeft do
      begin
        Parent := Self;
        Left := 30;
        Top := 154;
        Width := 15;
        Height := 15;
        Caption := '<';
        Font.Color := clWindowText;
        Font.Size := 8;
        Font.Name := 'MS Sans Serif';
        Font.Style := [fsBold];
        Visible := False;
        OnClick := btCorrLeftClick;
      end;
  btRight := TButton.Create(Self);
    with btRight do
      begin
        Parent := Self;
        Left := 50;
        Top := 154;
        Width := 15;
        Height := 15;
        Caption := '>';
        Font.Color := clWindowText;
        Font.Size := 8;
        Font.Name := 'MS Sans Serif';
        Font.Style := [fsBold];
        Visible := False;
        OnClick := btCorrRightClick;
      end;
  btDelete := TButton.Create(Self);
    with btDelete do
      begin
        Parent := Self;
        Left := 50;
        Top := 25;
        Width := 15;
        Height := 15;
        Caption := 'X';
        Font.Color := clWindowText;
        Font.Size := 8;
        Font.Name := 'MS Sans Serif';
        Font.Style := [fsBold];
        Visible := False;
        OnClick := btDeleteClick;
      end;
  FlashTimer := TTimer.Create(Self);
  FlashTimer.Interval := 400;
  FlashTimer.Enabled := False;
  FlashTimer.OnTimer := Flashing;
  IntervalTimer := TTimer.Create(Self);
  IntervalTimer.Interval := 10000;
  IntervalTimer.Enabled := False;
  IntervalTimer.OnTimer := Interval;
  RList1 := TList.Create;
  RList2 := TList.Create;
  RlbList1 := TList.Create;
  RlbSList1 := TList.Create;
  Self.OnMouseMove := DetailMouseMove;
  Self.OnMouseDown := DetailMouseDown;
  Self.OnClick := DetailClick;
  FSelect := True;
  X0 := 0;
  FlashingTrigger := True;
 end;

procedure TControlDetail.Flashing(Sender : TObject);
var
  shtemp1, shtemp2 : TShape;
begin
  if FSelected then
    begin
      FlashTimer.Enabled := True;
      if FlashingTrigger then
        begin
          if FlashingShapeNum = 0 then
            begin
              shLeft1.Pen.Color := clWhite;
              shLeft1.Brush.Color := clWhite;
              shLeft2.Pen.Color := clWhite;
              shLeft2.Brush.Color := clWhite;
            end else
            begin
              shtemp1 := RList1.Items[FlashingShapeNum - 1];
              shtemp1.Pen.Color := clWhite;
              shtemp2 := RList2.Items[FlashingShapeNum - 1];
              shtemp2.Pen.Color := clWhite;
            end;
        end;
    end else
    begin
      IntervalTimer.Enabled := False;
      FlashTimer.Enabled := False;
    end;
  if (not FlashingTrigger) or (not FSelected) then
    begin
      if FlashingShapeNum = 0 then
        begin
          shLeft1.Pen.Color := clBlack;
          shLeft1.Brush.Color := clBlack;
          shLeft2.Pen.Color := clBlack;
          shLeft2.Brush.Color := clBlack;
          if (FZadType = 'N') and (FActiveDeviceNum <> 0) and (FActiveBaseNum = 'ST1_BL') then
            if FZadanie.ST1_BL_Down[FActiveDeviceNum] then
              begin
                shLeft1.Pen.Color := clBlue;
                shLeft1.Brush.Color := clBlue;
                shLeft2.Pen.Color := clRed;
                shLeft2.Brush.Color := clRed;
              end else
              begin
                shLeft1.Pen.Color := clGreen;
                shLeft1.Brush.Color := clGreen;
                shLeft2.Pen.Color := clGreen;
                shLeft2.Brush.Color := clGreen;
              end;
          if (FZadType = 'N') and (FActiveDeviceNum <> 0) and (FActiveBaseNum = 'ST2_BL') then
            if FZadanie.ST2_BL_Down[FActiveDeviceNum] then
              begin
                shLeft1.Pen.Color := clBlue;
                shLeft1.Brush.Color := clBlue;
                shLeft2.Pen.Color := clRed;
                shLeft2.Brush.Color := clRed;
              end else
              begin
                shLeft1.Pen.Color := clGreen;
                shLeft1.Brush.Color := clGreen;
                shLeft2.Pen.Color := clGreen;
                shLeft2.Brush.Color := clGreen;
              end;
        end else
        begin
          shtemp1 := RList1.Items[FlashingShapeNum - 1];
          shtemp1.Pen.Color := clBlack;
          shtemp2 := RList2.Items[FlashingShapeNum - 1];
          shtemp2.Pen.Color := clBlack;
          if (FZadType = 'N') and (FActiveBaseNum = 'ST1_R') then
            if FZadanie.ST1_R_Down[FActiveDeviceNum] then
              begin
                shtemp1 := RList1.Items[FlashingShapeNum - 1];
                shtemp1.Pen.Color := clBlue;
                shtemp2 := RList2.Items[FlashingShapeNum - 1];
                shtemp2.Pen.Color := clRed;
              end else
              begin
                shtemp1 := RList1.Items[FlashingShapeNum - 1];
                shtemp1.Pen.Color := clGreen;
                shtemp2 := RList2.Items[FlashingShapeNum - 1];
                shtemp2.Pen.Color := clGreen;
              end;
          if (FZadType = 'N') and (FActiveBaseNum = 'ST2_R') then
            if FZadanie.ST2_R_Down[FActiveDeviceNum] then
              begin
                shtemp1 := RList1.Items[FlashingShapeNum - 1];
                shtemp1.Pen.Color := clBlue;
                shtemp2 := RList2.Items[FlashingShapeNum - 1];
                shtemp2.Pen.Color := clRed;
              end else
              begin
                shtemp1 := RList1.Items[FlashingShapeNum - 1];
                shtemp1.Pen.Color := clGreen;
                shtemp2 := RList2.Items[FlashingShapeNum - 1];
                shtemp2.Pen.Color := clGreen;
              end;
        end;
    end;
  FlashingTrigger := not FlashingTrigger;
  btLeft.Visible := FSelected and FAssigned;
  btRight.Visible := FSelected and FAssigned;
  btDelete.Visible := FSelected;  
end;

procedure TControlDetail.Interval(Sender : TObject);
begin
  FSelected := False;
  IntervalTimer.Enabled := False;
end;

procedure TControlDetail.Init(ScaleMax : integer; XMin, DetailWidth : single; var Zadanie : TZadanie; ZadType : string);
var
  L, i, j, k, Count : integer;
  R : TShape;
  Rlb : TLabel;
begin
  FZadType := ZadType;
  FZadanie := Zadanie;
  FXMin := XMin;
  FDetailWidth := DetailWidth;
  FScaleMax := ScaleMax;
  Left := Round(XMin * ScaleMax / 2605) + 1;
  Width := Round(DetailWidth * ScaleMax / 2605) - 2;
  if (Left + Width > ScaleMax) then Width := ScaleMax - Left - 2;
  lbS.Left := Width div 2 - 10;
  lbS.Caption := Format('%4.1f', [DetailWidth]);
  lbDN.Left := Width div 2 - 10;
  SetLength(FRLocal, 1);
  if XMin < 2 then
    begin
      lbN.Visible := False;
      shLeft1.Visible := False;
      shLeft2.Visible := False;
    end else
    begin
      lbN.Visible := True;
      shLeft1.Visible := True;
      shLeft2.Visible := True;
    end;
//  if not Zadanie.DistributeBLErr then for i := 1 to 6 do
  for i := 1 to 6 do
    begin
      if Zadanie.ST1_BL_Work[i] and (Zadanie.ST1_BL_Xzad[i] = XMin) then
        begin
          lbN.Caption := GetDisplayNum('ST1_BL', i);
          if FZadType = 'N' then
          if Zadanie.ST1_BL_Down[i] then
            begin
              shLeft1.Pen.Color := clBlue;
              shLeft1.Brush.Color := clBlue;
              shLeft2.Pen.Color := clRed;
              shLeft2.Brush.Color := clRed;
            end else
            begin
              shLeft1.Pen.Color := clGreen;
              shLeft1.Brush.Color := clGreen;
              shLeft2.Pen.Color := clGreen;
              shLeft2.Brush.Color := clGreen;
            end;
        end;
      if Zadanie.ST2_BL_Work[i] and (Zadanie.ST2_BL_Xzad[i] = XMin) then
        begin
          lbN.Caption := GetDisplayNum('ST2_BL', i);
          if FZadType = 'N' then
          if Zadanie.ST2_BL_Down[i] then
            begin
              shLeft1.Pen.Color := clBlue;
              shLeft1.Brush.Color := clBlue;
              shLeft2.Pen.Color := clRed;
              shLeft2.Brush.Color := clRed;
            end else
            begin
              shLeft1.Pen.Color := clGreen;
              shLeft1.Brush.Color := clGreen;
              shLeft2.Pen.Color := clGreen;
              shLeft2.Brush.Color := clGreen;
            end;
        end;
    end;
  Count := RList1.Count - 1;
  for i := Count downto 0 do
    begin
      R := RList1.Items[i];
      RList1.Delete(i);
      R.Free;
    end;
  Count := RList2.Count - 1;
  for i := Count downto 0 do
    begin
      R := RList2.Items[i];
      RList2.Delete(i);
      R.Free;
    end;
  Count := RlbList1.Count - 1;
  for i := Count downto 0 do
    begin
      Rlb := RlbList1.Items[i];
      RlbList1.Delete(i);
      Rlb.Free;
    end;
  Count := RlbSList1.Count - 1;
  for i := Count downto 0 do
    begin
      Rlb := RlbSList1.Items[i];
      RlbSList1.Delete(i);
      Rlb.Free;
    end;

//  if (Zadanie.RzadCount <> 0) and Zadanie.DistributeRErr then
  if (Zadanie.RzadCount <> 0) then
    begin
      j := 0;
      for i := 1 to Zadanie.RzadCount do if (Zadanie.Rzad[i] <= XMin + DetailWidth) and (Zadanie.Rzad[i] > XMin) then
        begin
          L := High(FRLocal) + 1;
          SetLength(FRLocal, L + 1);
          FRLocal[L] := Zadanie.Rzad[i] - XMin;
          RList1.Add(TShape.Create(Self));
          R := RList1.Items[j];
          with R do
            begin
              Parent := Self;
              Left := Round((Zadanie.Rzad[i] - XMin) * ScaleMax / 2605) - 3;
              Top := 19;
              Width := 5;
              Height := 50;
              Tag := Round(Zadanie.Rzad[i] * 10);
              Pen.Color := clBlack;
              if FZadType = 'N' then
              for k := 1 to 10 do
                begin
                  if Zadanie.ST1_R_Work[k] and (Zadanie.ST1_R_Xzad[k] = Zadanie.Rzad[i]) then
                    if Zadanie.ST1_R_Down[k] then Pen.Color := clBlue else Pen.Color := clGreen;
                  if Zadanie.ST2_R_Work[k] and (Zadanie.ST2_R_Xzad[k] = Zadanie.Rzad[i]) then
                    if Zadanie.ST2_R_Down[k] then Pen.Color := clBlue else Pen.Color := clGreen;
                end;
              Brush.Style := bsClear;
              OnMouseDown := DetailMouseDown;
            end;
          RList2.Add(TShape.Create(Self));
          R := RList2.Items[j];
          with R do
            begin
              Parent := Self;
              Left := Round((Zadanie.Rzad[i] - XMin) * ScaleMax / 2605) - 3;
              Top := 70;
              Width := 5;
              Height := 150;
              Tag := Round(Zadanie.Rzad[i] * 10);
              Pen.Color := clBlack;
              if FZadType = 'N' then
              for k := 1 to 10 do
                begin
                  if Zadanie.ST1_R_Work[k] and (Zadanie.ST1_R_Xzad[k] = Zadanie.Rzad[i]) then
                    if Zadanie.ST1_R_Down[k] then Pen.Color := clRed else Pen.Color := clGreen;
                  if Zadanie.ST2_R_Work[k] and (Zadanie.ST2_R_Xzad[k] = Zadanie.Rzad[i]) then
                    if Zadanie.ST2_R_Down[k] then Pen.Color := clRed else Pen.Color := clGreen;
                end;
              Brush.Style := bsClear;
              OnMouseDown := DetailMouseDown;
            end;
          RlbList1.Add(TLabel.Create(Self));
          Rlb := RlbList1.Items[j];
          with Rlb do
            begin
              Parent := Self;
              Left := Round((Zadanie.Rzad[i] - XMin) * ScaleMax / 2605) - 3;
              Top := 10;
              AutoSize := True;
              Caption := '   ';
              for k := 1 to 10 do if Zadanie.ST1_R_Work[k] and (Zadanie.ST1_R_Xzad[k] = Zadanie.Rzad[i]) then Caption := GetDisplayNum('ST1_R', k);
              for k := 1 to 10 do if Zadanie.ST2_R_Work[k] and (Zadanie.ST2_R_Xzad[k] = Zadanie.Rzad[i]) then Caption := GetDisplayNum('ST2_R', k);
              Font.Color := clNavy;
              Font.Size := 10;
              Font.Name := 'Times New Roman';
              Font.Style := [fsBold];
            end;
          RlbSList1.Add(TLabel.Create(Self));
          Rlb := RlbSList1.Items[j];
          with Rlb do
            begin
              Parent := Self;
              Left := Round((Zadanie.Rzad[i] - XMin) * ScaleMax / 2605) - 10;
              Top := 55;
              AutoSize := True;
              Caption := Format('%3.1f', [Zadanie.Rzad[i] - XMin]);
              Font.Color := clBlack;
              Font.Size := 10;
              Font.Name := 'Times New Roman';
              Font.Style := [fsBold];
            end;
          j := j + 1;
        end;
    end;
end;

procedure TControlDetail.DetailClick(Sender: TObject);
begin
  FSelected := False;
end;

procedure TControlDetail.DetailMouseMove(Sender: TObject; Shift: TShiftState; X, Y: Integer);
begin
  if (ssLeft in Shift) and (X0 <> 0) and (X0 - X > Width / 2)  then
    begin
      FSelected := False;
      IntervalTimer.Enabled := False;
      if FSelect and Assigned(FOnMoveLeft)  then FOnMoveLeft(Self,  FDNum, FDNumStr);
      FSelect := False;
    end;
  if (ssLeft in Shift) and (X0 <> 0) and (X0 - X < -Width / 2) then
    begin
      FSelected := False;
      IntervalTimer.Enabled := False;
      if FSelect and Assigned(FOnMoveRight) then FOnMoveRight(Self, FDNum, FDNumStr);
      FSelect := False;
    end;
end;

procedure TControlDetail.DetailMouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var
  i, c : integer;
  sh, shtemp : TShape;
begin
  X0 := X;
  if FSelect and (Sender is TShape) then
    begin
      sh := (Sender as TShape);
      if sh.Left < Width - 30 then btLeft.Left := sh.Left else btLeft.Left := Width - 30;
      if sh.Left < Width - 30 then btDelete.Left := sh.Left else btDelete.Left := Width - 30;
      btRight.Left := btLeft.Left + 16;
      FSelected := True;
      FAssigned := False;
      if sh.Tag = 0 then FlashingShapeNum := 0 else
        begin
          c := RList1.Count - 1;
          for i := 0 to c do
            begin
              shtemp := RList1.Items[i];
              if sh.Tag = shtemp.Tag then FlashingShapeNum := i + 1;
            end;
        end;
      FActiveDeviceNum := 0;
      if (sh.Tag = 0) and (not FZadanie.DistributeBLErr) then for i := 1 to 6 do
        begin
          if FZadanie.ST1_BL_Work[i] and (FZadanie.ST1_BL_Xzad[i] = FXMin) then
            begin
              FActiveBaseNum := 'ST1_BL';
              FActiveDeviceNum := i;
              FAssigned := True;
            end;
          if FZadanie.ST2_BL_Work[i] and (FZadanie.ST2_BL_Xzad[i] = FXMin) then
            begin
              FActiveBaseNum := 'ST2_BL';
              FActiveDeviceNum := i;
              FAssigned := True;
            end;
        end;
      if (sh.Tag <> 0) and (FZadanie.RzadCount <> 0) and not FZadanie.DistributeRErr then for i := 1 to 10 do
        begin
          if FZadanie.ST1_R_Work[i] and (Round(FZadanie.ST1_R_Xzad[i] * 10) = sh.Tag) then
            begin
              FActiveBaseNum := 'ST1_R';
              FActiveDeviceNum := i;
              FAssigned := True;
            end;
          if FZadanie.ST2_R_Work[i] and (Round(FZadanie.ST2_R_Xzad[i] * 10) = sh.Tag) then
            begin
              FActiveBaseNum := 'ST2_R';
              FActiveDeviceNum := i;
              FAssigned := True;
            end;
        end;
//      if (not FAssigned) and (sh.Tag = 0) and Assigned(FOnClickDetail) then FOnClickDetail(Self, FDNum, 'BL', 0, FXMin);
//      if (not FAssigned) and (sh.Tag <> 0) and Assigned(FOnClickDetail) then FOnClickDetail(Self, FDNum, 'R', 0, sh.Tag / 10);
      if (sh.Tag = 0) and Assigned(FOnClickDetail) then FOnClickDetail(Self, FDNum, 'BL', 0, FXMin);
      if (sh.Tag <> 0) and Assigned(FOnClickDetail) then FOnClickDetail(Self, FDNum, 'R', 0, sh.Tag / 10);
      if (sh.Tag = 0) then
        begin
          if not FAssigned then FActiveBaseNum := 'BL';
          FActiveZad := FXMin;
        end else
        begin
          if not FAssigned then FActiveBaseNum := 'R';
          FActiveZad := sh.Tag / 10;
        end;
      btLeft.Visible := FSelected and FAssigned;
      btRight.Visible := FSelected and FAssigned;
      btDelete.Visible := FSelected;
      FlashTimer.Enabled := True;
      IntervalTimer.Enabled := True;
    end else FSelect := True;
end;

function TControlDetail.GetDisplayNum(BaseNum : string; Num : byte) : string;
begin
  Result := '-';
  if BaseNum = 'ST1_R' then
  case Num of
    1:  Result := '1.10';
    2:  Result := '1.9';
    3:  Result := '1.8';
    4:  Result := '1.7';
    5:  Result := '1.6';
    6:  Result := '1.5';
    7:  Result := '1.4';
    8:  Result := '1.3';
    9:  Result := '1.2';
    10: Result := '1.1';
  end;
  if BaseNum = 'ST2_R' then
  case Num of
    1:  Result := '2.10';
    2:  Result := '2.9';
    3:  Result := '2.8';
    4:  Result := '2.7';
    5:  Result := '2.6';
    6:  Result := '2.5';
    7:  Result := '2.4';
    8:  Result := '2.3';
    9:  Result := '2.2';
    10: Result := '2.1';
  end;
  if BaseNum = 'ST1_BL' then
  case Num of
    1:  Result := '1.6';
    2:  Result := '1.5';
    3:  Result := '1.4';
    4:  Result := '1.3';
    5:  Result := '1.2';
    6:  Result := '1.1';
  end;
  if BaseNum = 'ST2_BL' then
  case Num of
    1:  Result := '2.6';
    2:  Result := '2.5';
    3:  Result := '2.4';
    4:  Result := '2.3';
    5:  Result := '2.2';
    6:  Result := '2.1';
  end;
end;

procedure TControlDetail.Paint;
var
  Rect1 : TRect;
begin
  Rect1 := Rect(0,0,Width,Height);
  Canvas.Brush.Style := bsClear;
  Canvas.Pen.Color := clNavy;
  Canvas.MoveTo(3, 70);
  Canvas.LineTo(Width, 70);
  Canvas.MoveTo(3, 70);
  Canvas.LineTo(9, 73);
  Canvas.MoveTo(3, 70);
  Canvas.LineTo(9, 67);
  Canvas.MoveTo(Width - 1, 70);
  Canvas.LineTo(Width - 6, 73);
  Canvas.MoveTo(Width - 1, 70);
  Canvas.LineTo(Width - 6, 67);
end;

procedure TControlDetail.SetDNum(const Value : byte);
begin
  FDNum := Value;
  lbDN.Visible := not FTrash;
end;

procedure TControlDetail.SetDNumStr(const Value : string);
begin
  FDNumStr := Value;
  if FDNumStr <> '0' then lbDN.Caption := '( ' + FDNumStr + ' )';
end;

procedure TControlDetail.btCorrLeftClick(Sender : TObject);
begin
  if Assigned(FOnCorrLeft) then FOnCorrLeft(Self, FDNum, FActiveBaseNum, FActiveDeviceNum, 0);
end;

procedure TControlDetail.btCorrRightClick(Sender : TObject);
begin
  if Assigned(FOnCorrRight) then FOnCorrRight(Self, FDNum, FActiveBaseNum, FActiveDeviceNum, 0);
end;

procedure TControlDetail.SetSelected(const Value : boolean);
begin
  FSelected := False;
  btLeft.Visible := False;
  btRight.Visible := False;
  btDelete.Visible := False;
end;

procedure TControlDetail.SetXMin(const Value : single);
begin
  FXmin := Value;
  Left := Round(FXMin * FScaleMax / 2605) + 1;
end;

function TControlDetail.GetRLocal(Index : byte) : single;
begin
  Result := FRLocal[Index];
end;

function TControlDetail.GetRLocalCount : byte;
begin
  Result := High(FRLocal);
end;

procedure TControlDetail.btDeleteClick(Sender : TObject);
begin
  FSelected := False;
  IntervalTimer.Enabled := False;
  if Assigned(FOnClickDelete) then FOnClickDelete(Self, FDNum, FActiveBaseNum, 0, FActiveZad);
end;

end.
