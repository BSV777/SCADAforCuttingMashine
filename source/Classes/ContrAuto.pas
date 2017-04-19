unit ContrAuto;

interface

uses
  SysUtils, Controls, Classes, Graphics, Forms, StdCtrls, ExtCtrls, Buttons, Mask, Windows, StrUtils;

type
  // Элемент управления (контрол) - индикатор механизма на форме автоматического управления
  TControlAuto = class(TCustomPanel)
  private
    FlashTimer : TTimer;
    FFlashing : boolean;
    sh : TShape;
    img : TImage;
    FScale : single;
    FOnPosition : boolean;
    FRealWidth : single;
    FNum : byte;
    FBaseNum : string;
    FDisplayNum : string;
    FAutoZad : single;
    FDown : boolean;
    FPos : single;
    FWork : boolean;
    FReady : boolean;
    lbN : TLabel;
    lbPos : TLabel;
    FdxLInv : boolean;
    FTempPath : string;
    // Установить номер механизма (по нумерации в контроллере)
    procedure SetNum(const Value : byte);
    // Установить базовый номер, указывающий номер станка и тип механизма: ST1_R, ST2_R, ST1_BL, ST2_BL
    procedure SetBaseNum(const Value : string);
    // Задать величину отступа слева
    procedure SetRealWidth(const Value : single);
    // Установить изображение на координату, соответствующую текущей позиции
    procedure SetPos(const Value : single);
    // Показать, что механизм опущен
    procedure SetDown(const Value : boolean);
    // Показать, что механизм распределен
    procedure SetWork(const Value : boolean);
    // Установить изображение на координату, соответствующую заданной позиции
    procedure SetAutoZad(const Value : single);
    // Показать, что механизм исправен
    procedure SetReady(const Value : boolean);
    // Обработчик клика на изображении
    procedure ControlAutoClick(Sender : TObject);
    // Мигание
    procedure Flashing(Sender : TObject);
  protected
    // Отобразить номер механизма в соответствии с принятой нумерацией
    procedure SetDisplayNum;
    // Установить цвет (изображение) механизма с учетом всех флагов состояния
    procedure SetColor;
    { Protected declarations }
  public
    constructor Create(AOwner : TComponent); override;
    // Масштабный коэффициент, зависящий от разрешения экрана
    property Scale : single read FScale write FScale;
    // Величина отступа слева
    property RealWidth : single write SetRealWidth;
    // Отступ слева инверсный => отступ справа
    property dxLInv : boolean read FdxLInv write FdxLInv;
    // Номер механизма (по нумерации в контроллере)
    property Num : byte read FNum write SetNum;
    // Базовый номер, указывающий номер станка и тип механизма: ST1_R, ST2_R, ST1_BL, ST2_BL
    property BaseNum : string read FBaseNum write SetBaseNum;
    // Номер механизма в соответствии с принятой нумерацией
    property DisplayNum : string read FDisplayNum;
    // Механизм опущен
    property Down : boolean read FDown write SetDown;
    // Заданное положение
    property AutoZad : single read FAutoZad write SetAutoZad;
    // Фактическое положение
    property Position : single read FPos write SetPos;
    // Механизм распределен
    property Work : boolean read FWork write SetWork;
    // Механизм исправен
    property Ready : boolean read FReady write SetReady;
    // Обработчик клика на изображении
    property OnClick;
  end;

implementation

constructor TControlAuto.Create(AOwner : TComponent);
begin
  inherited Create(AOwner);
  Width := 50;
  Height := 85;
  BevelWidth := 1;
  BevelOuter := bvNone;
  Caption := '';
  Font.Name := 'MS Sans Serif';
  img := TImage.Create(Self);
  with img do
    begin
      Parent := Self;
      Left := 0;
      Top := 22;
      Width := 50;
      Height := 40;
      Proportional := False;
      Stretch := True;
      Visible := True;
      OnClick := ControlAutoClick;
    end;
  sh := TShape.Create(Self);
  with sh do
    begin
      Parent := Self;
      Left := 50;
      Top := 5;
      Width := 2;
      Height := 80;
      Brush.Color := clRed;
      Pen.Color := clRed;
      OnClick := ControlAutoClick;
    end;
  lbN := TLabel.Create(Self);
  with lbN do
    begin
      Parent := Self;
      Left := 0;
      Top := 0;
      AutoSize := True;
      Caption := '0';
      Font.Color := clNavy;
      Font.Size := 10;
      Font.Name := 'Times New Roman';
      Font.Style := [fsBold];
      OnClick := ControlAutoClick;
    end;
  lbPos := TLabel.Create(Self);
  with lbPos do
    begin
      Parent := Self;
      Left := 1;
      Top := 70;
      Width := 50;
      Height := 28;
      Alignment := taRightJustify;
      Caption := '';
      Font.Size := 11;
      Font.Style := [fsBold];
      OnClick := ControlAutoClick;
      Visible := True;
    end;
  FlashTimer := TTimer.Create(Self);
  FlashTimer.Interval := 1000;
  FlashTimer.Enabled := False;
  FlashTimer.OnTimer := Flashing;
  Self.OnClick := ControlAutoClick;
  FNum := 0;
  FPos := 0;
  FDown := False;
  FWork := False;
  FReady := True;
  lbPos.Visible := True;
  FScale := 1;
  FOnPosition := False;
end;

procedure TControlAuto.SetDown(const Value : boolean);
begin
  FDown := Value;
  SetColor;
end;

procedure TControlAuto.SetWork(const Value : boolean);
begin
  FWork := Value;
  SetColor;
end;

procedure TControlAuto.SetNum(const Value : byte);
begin
  FNum := Value;
  SetDisplayNum;
end;

procedure TControlAuto.SetBaseNum(const Value : string);
begin
  FBaseNum := Value;
  SetDisplayNum;
  SetColor;
end;

procedure TControlAuto.SetPos(const Value : single);
begin
  if (Abs(FPos - Value) > 1) and (Value <> FAutoZad) then
    begin
       FFlashing := True;
       FlashTimer.Enabled := True;
    end else FFlashing := False;
  FPos := Value;
  lbPos.Caption := Format('%4.1f', [FPos]);

  if FdxLInv then
    begin
      if FScale > 1000 then
        begin
          if Width <= 40 then Left := Width + Round(FPos * FScale / 2590) else
//            if Pos('R', FBaseNum) <> 0 then Left := Width + Round((FPos - FRealWidth / 2) * FScale / 2590) + 30 else Left := Width + Round((FPos - FRealWidth / 1.6) * FScale / 2590) + 27;
            if Pos('R', FBaseNum) <> 0 then Left := Width + Round((FPos - FRealWidth / 2) * FScale / 2590) + 3 else Left := Width + Round((FPos - FRealWidth / 1.6) * FScale / 2590) + 3;
        end else
        begin
          if Width <= 40 then if Pos('R', FBaseNum) <> 0 then Left := Width + Round(FPos * FScale / 2590 + 30) else Left := Width + Round(FPos * FScale / 2590 + 28) else
            if Pos('R', FBaseNum) <> 0 then Left := Width + Round((FPos - FRealWidth / 2) * FScale / 2590) + 42 else Left := Width + Round((FPos - FRealWidth / 1.8) * FScale / 2590) + 35;
        end;
    end else
    begin
      if FScale > 1000 then
        begin
          if Width <= 40 then Left := Round(FPos * FScale / 2590) else
//            if Pos('R', FBaseNum) <> 0 then Left := Round((FPos - FRealWidth / 2) * FScale / 2590) + 27 else Left := Round((FPos - FRealWidth / 1.6) * FScale / 2590) + 27;
            if Pos('R', FBaseNum) <> 0 then Left := Round((FPos - FRealWidth / 2) * FScale / 2590) + 3 else Left := Round((FPos - FRealWidth / 1.6) * FScale / 2590) + 3;
        end else
        begin
          if Width <= 40 then if Pos('R', FBaseNum) <> 0 then Left := Round(FPos * FScale / 2590 + 30) else Left := Round(FPos * FScale / 2590 + 30) else
            if Pos('R', FBaseNum) <> 0 then Left := Round((FPos - FRealWidth / 2) * FScale / 2590) + 42 else Left := Round((FPos - FRealWidth / 1.8) * FScale / 2590) + 35;
        end;
    end;
  if (Abs(FAutoZad - FPos) < 0.5) and (FPos <> 0) and FReady then
    begin
      lbPos.Font.Color := clGreen;
      if not FOnPosition then
        begin
          FOnPosition := True;
          SetColor;
        end;
    end else
    begin
      lbPos.Font.Color := clBlue;
      if FOnPosition then
        begin
          FOnPosition := False;
          SetColor;
        end;
    end;
  if not FWork then lbPos.Font.Color := clBlack;
  if FPos < 250 then Visible := False else Visible := True;
end;

procedure TControlAuto.SetAutoZad(const Value : single);
begin
  FAutoZad := Value;
  SetPos(FAutoZad);
end;

procedure TControlAuto.SetReady(const Value : boolean);
begin
  FReady := Value;
  lbPos.Visible := Value;
end;

procedure TControlAuto.ControlAutoClick(Sender:TObject);
begin
  inherited Click;
end;

procedure TControlAuto.SetRealWidth(const Value : single);
begin
  if FdxLInv then
    begin
      FRealWidth := Value;
      Width := Round(FRealWidth * FScale / 2590);
      if Width < 40 then Width := 40;
      if Pos('R', FBaseNum) <> 0 then img.Width := Round(FRealWidth * FScale / 2590 * 1.1) else img.Width := Round(FRealWidth * FScale / 2590 * 1.25);
      if img.Width < 30 then img.Width := 30;
      sh.Left := 2;
      lbN.Left := 0;
      img.Left := 2;
      lbPos.Left := 0;
      lbPos.Alignment := taLeftJustify;
    end else
    begin
      FRealWidth := Value;
      Width := Round(FRealWidth * FScale / 2590);
      if Width < 40 then Width := 40;
      if Pos('R', FBaseNum) <> 0 then img.Width := Round(FRealWidth * FScale / 2590 * 1.1) else img.Width := Round(FRealWidth * FScale / 2590 * 1.25);
      if img.Width < 30 then img.Width := 30;
      sh.Left := Width - 3;
      lbN.Left := Width - 30;
      if Pos('R', FBaseNum) <> 0 then img.Left := Width - img.Width + 2 else img.Left := Width - img.Width + 7;
      lbPos.Left := Width - lbPos.Width;
      lbPos.Alignment := taRightJustify;
    end;
end;

procedure TControlAuto.SetColor;
begin
  FTempPath := '.\rezkatemp\';
  if (FDown and FOnPosition) or (FDown and not FWork) then if Pos('R', FBaseNum) <> 0 then img.Picture.LoadFromFile(FTempPath + 'R_D.emf') else img.Picture.LoadFromFile(FTempPath + 'BL_D.emf') else
  if FDown then if Pos('R', FBaseNum) <> 0 then img.Picture.LoadFromFile(FTempPath + 'R_DW.emf') else img.Picture.LoadFromFile(FTempPath + 'BL_DW.emf') else
  if FWork and FOnPosition then if Pos('R', FBaseNum) <> 0 then img.Picture.LoadFromFile(FTempPath + 'R_WP.emf') else img.Picture.LoadFromFile(FTempPath + 'BL_WP.emf') else
  if FWork and not FOnPosition then if Pos('R', FBaseNum) <> 0 then img.Picture.LoadFromFile(FTempPath + 'R_W.emf') else img.Picture.LoadFromFile(FTempPath + 'BL_W.emf') else
  if Pos('R', FBaseNum) <> 0 then img.Picture.LoadFromFile(FTempPath + 'R_nU.emf') else img.Picture.LoadFromFile(FTempPath + 'BL_nU.emf');
end;

procedure TControlAuto.SetDisplayNum;
begin
  if FBaseNum = 'ST1_R' then
  case FNum of
    1:  FDisplayNum := '1.10';
    2:  FDisplayNum := '1.9';
    3:  FDisplayNum := '1.8';
    4:  FDisplayNum := '1.7';
    5:  FDisplayNum := '1.6';
    6:  FDisplayNum := '1.5';
    7:  FDisplayNum := '1.4';
    8:  FDisplayNum := '1.3';
    9:  FDisplayNum := '1.2';
    10: FDisplayNum := '1.1';
  end;
  if FBaseNum = 'ST2_R' then
  case FNum of
    1:  FDisplayNum := '2.10';
    2:  FDisplayNum := '2.9';
    3:  FDisplayNum := '2.8';
    4:  FDisplayNum := '2.7';
    5:  FDisplayNum := '2.6';
    6:  FDisplayNum := '2.5';
    7:  FDisplayNum := '2.4';
    8:  FDisplayNum := '2.3';
    9:  FDisplayNum := '2.2';
    10: FDisplayNum := '2.1';
  end;
  if FBaseNum = 'ST1_BL' then
  case FNum of
    1:  FDisplayNum := '1.6';
    2:  FDisplayNum := '1.5';
    3:  FDisplayNum := '1.4';
    4:  FDisplayNum := '1.3';
    5:  FDisplayNum := '1.2';
    6:  FDisplayNum := '1.1';
  end;
  if FBaseNum = 'ST2_BL' then
  case FNum of
    1:  FDisplayNum := '2.6';
    2:  FDisplayNum := '2.5';
    3:  FDisplayNum := '2.4';
    4:  FDisplayNum := '2.3';
    5:  FDisplayNum := '2.2';
    6:  FDisplayNum := '2.1';
  end;
  lbN.Caption := FDisplayNum;
end;

procedure TControlAuto.Flashing(Sender : TObject);
begin
  if FFlashing then
    begin
      FlashTimer.Enabled := True;
      img.Visible := not img.Visible;
    end else
    begin
      FlashTimer.Enabled := False;
      img.Visible := True;
    end;
end;

end.
