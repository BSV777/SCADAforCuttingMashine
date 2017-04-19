unit ContrMan;

interface

uses
  SysUtils, Classes, Graphics, Forms, StdCtrls, ExtCtrls, Buttons, Mask, Windows, StrUtils;

type
  TControlMan = class(TCustomPanel)
  private
    FNum : byte;
    FBaseNum : string;
    FDisplayNum : string;
    FZad : single;
    FAutoZad : single;
    FImpuls : single;
    FNewZad : boolean;
    FDown : boolean;
    FPos : single;
    FNewDN : boolean;
    FWork : boolean;
    FReady : boolean;
    lbN : TLabel;
    lbDN : TLabel;
    lbPos : TLabel;
    lbAutoZad : TLabel;
    lbAs : TLabel;
    lbP : TLabel;
    lbRemont : TLabel;
    edZadanie: TMaskEdit;
    btWork : TSpeedButton;
    btUp : TButton;
    btDn : TButton;
    ZadEdit : boolean;
    procedure SetNum(const Value : byte);
    procedure SetBaseNum(const Value : string);
    procedure SetPos(const Value : single);
    procedure SetDown(const Value : boolean);
    procedure SetWork(const Value : boolean);
    procedure SetZad(const Value : single);
    procedure SetAutoZad(const Value : single);
    procedure SetReady(const Value : boolean);
    procedure ControlManClick(Sender : TObject);
  protected
    procedure SetDisplayNum;
    procedure btDnClick(Sender: TObject);
    procedure btUpClick(Sender: TObject);
    procedure btWorkClick(Sender: TObject);
    procedure meKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure meEnter(Sender: TObject);
    procedure meExit(Sender: TObject);
    { Protected declarations }
  public
    constructor Create(AOwner:TComponent); override;
    property Num : byte read FNum write SetNum;
    property BaseNum : string read FBaseNum write SetBaseNum;
    property DisplayNum : string read FDisplayNum;
    property Down : boolean read FDown write SetDown;
    property Zad : single read FZad write SetZad;
    property AutoZad : single read FAutoZad write SetAutoZad;
    property Impuls : single read FImpuls write FImpuls;    
    property Pos : single read FPos write SetPos;
    property Work : boolean read FWork write SetWork;
    property NewZad : boolean read FNewZad write FNewZad;
    property NewDN : boolean read FNewDN write FNewDN;
    property Ready : boolean read FReady write SetReady;
    property OnClick;
  end;

implementation

constructor TControlMan.Create(AOwner:TComponent);
begin
  inherited Create(AOwner);
  Width := 100;
  Height := 138;
  BevelWidth := 1;
  Caption := '';
  Font.Name := 'MS Sans Serif';
  lbN := TLabel.Create(Self);
  with lbN do
    begin
      Parent := Self;
      Left := 5;
      Top := 4;
      AutoSize := True;
      Caption := '0';
      Font.Color := clNavy;
      Font.Size := 10;
      Font.Name := 'Times New Roman';
      Font.Style := [fsBold];
      OnClick := ControlManClick;
    end;
  lbDN := TLabel.Create(Self);
  with lbDN do
    begin
      Parent := Self;
      Left := 35;
      Top := 4;
      AutoSize := True;
      Caption := 'Верх/Низ';
      Font.Color := clGreen;
      Font.Size := 10;
      Font.Name := 'Times New Roman';
      Font.Style := [fsBold];
      OnClick := ControlManClick;
    end;
  edZadanie := TMaskEdit.Create(Self);
  with edZadanie do
    begin
      Parent := Self;
      Left := 42;
      Top := 25;
      Width := 55;
      Height := 23;
      Text := '';
      AutoSize := False;
      Font.Size := 11;
      Font.Style := [fsBold];
//      EditMask := '!999;1;_';
      OnKeyDown := meKeyDown;
      OnEnter := meEnter;
      OnExit := meExit;
    end;
  lbPos := TLabel.Create(Self);
  with lbPos do
    begin
      Parent := Self;
      Left := 46;
      Top := 63;
      Width := 85;
      Height := 28;
      Alignment := taLeftJustify;
      Caption := '';
      Font.Size := 11;
      Font.Style := [fsBold];
      OnClick := ControlManClick;
    end;
  lbAutoZad := TLabel.Create(Self);
  with lbAutoZad do
    begin
      Parent := Self;
      Left := 5;
      Top := 47;
      Width := 70;
      Height := 20;
      Alignment := taLeftJustify;
      Caption := '';
      Font.Size := 5;
//      Font.Style := [fsBold];
      Font.Color := clRed;
      OnClick := ControlManClick;
    end;
  lbAs := TLabel.Create(Self);
  with lbAs do
    begin
      Parent := Self;
      Left := 3;
      Top := 30;
      AutoSize := True;
      Caption := 'Задан.:';
      Font.Color := clWhite;
      Font.Size := 8;
      OnClick := ControlManClick;
    end;
  lbP := TLabel.Create(Self);
  with lbP do
    begin
      Parent := Self;
      Left := 3;
      Top := 65;
      AutoSize := True;
      Caption := 'Полож.:';
      Font.Color := clWhite;
      Font.Size := 8;
      OnClick := ControlManClick;
    end;
  lbRemont := TLabel.Create(Self);
  with lbRemont do
    begin
      Parent := Self;
      Left := 7;
      Top := 30;
      AutoSize := True;
      Caption := 'В ремонте';
      Font.Color := clYellow;
      Font.Size := 10;
      Font.Style := [fsBold];
    end;
  btUp := TButton.Create(Self);
    with btUp do
      begin
        Parent := Self;
        Left := 6;
        Top := 88;
        Width := 42;
        Height := 22;
        Caption := 'Вверх';
        Font.Color := clWindowText;
        Font.Size := 8;
        Font.Name := 'MS Sans Serif';
        Font.Style := [fsBold];
        OnClick := btUpClick;
      end;
  btDn := TButton.Create(Self);
    with btDn do
      begin
        Parent := Self;
        Left := 50;
        Top := 88;
        Width := 42;
        Height := 22;
        Caption := 'Вниз';
        Font.Color := clWindowText;
        Font.Size := 8;
        Font.Name := 'MS Sans Serif';
        Font.Style := [fsBold];
        OnClick := btDnClick;
      end;
  btWork := TSpeedButton.Create(Self);
    with btWork do
      begin
        Parent := Self;
        Left := 5;
        Top := 115;
        Width := 87;
        Height := 18;
        Caption := 'В работе';
        GroupIndex := 1;
        Font.Color := clWindowText;
        Font.Size := 8;
        Font.Name := 'MS Sans Serif';
        Font.Style := [fsBold];
        AllowAllUp := True;
        OnClick := btWorkClick;
      end;
  Self.OnClick := ControlManClick;
  FNum := 0;
  FPos := 0;
  FDown := False;
  FReady := True;
  FNewDN := False;
  FNewZad := False;
  ZadEdit := False;
  FAutoZad := 0;
end;

procedure TControlMan.btDnClick(Sender: TObject);
begin
  FDown := True;
  FNewDN := True;
end;

procedure TControlMan.btUpClick(Sender: TObject);
begin
  FDown := False;
  FNewDN := True;
end;

procedure TControlMan.btWorkClick(Sender: TObject);
begin
  FWork := btWork.Down;
  if FWork then Color := clMoneyGreen else Color := clBtnFace;
end;

procedure TControlMan.meKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if Key=VK_RETURN then
    begin
      FNewZad := True;
      edZadanie.Color := clWhite;
      try
        if StrToFloat(edZadanie.Text) < 3000 then FZad := StrToFloat(edZadanie.Text);
      except
        edZadanie.Text := Format('%4.1f', [FZad]);
      end;
      ZadEdit := False;
      Self.SetFocus;
    end;
  if Key=VK_ESCAPE then
    begin
      edZadanie.Color := clWhite;
      edZadanie.Text := Format('%4.1f', [FZad]);
      ZadEdit := False;
      Self.SetFocus;
    end;
end;

procedure TControlMan.meEnter(Sender: TObject);
begin
  edZadanie.Text := '';
  edZadanie.Color := clYellow;
    ZadEdit := True;
end;

procedure TControlMan.meExit(Sender: TObject);
begin
   edZadanie.Text := Format('%4.1f', [FZad]);
   edZadanie.Color := clWhite;
   ZadEdit := False;
end;

procedure TControlMan.SetDown(const Value : boolean);
begin
  FDown := Value;
  if FDown then
    begin
      lbDN.Caption := 'Низ';
      lbDN.Font.Color := clYellow;
    end else
    begin
      lbDN.Caption := 'Верх';
      lbDN.Font.Color := clGreen;
    end;
end;

procedure TControlMan.SetWork(const Value : boolean);
begin
  FWork := Value;
  btWork.Down := Value;
  if FWork then Color := clMoneyGreen else Color := clBtnFace;
end;

procedure TControlMan.SetNum(const Value : byte);
begin
  FNum := Value;
  SetDisplayNum;
end;

procedure TControlMan.SetBaseNum(const Value : string);
begin
  FBaseNum := Value;
  SetDisplayNum;
end;

procedure TControlMan.SetDisplayNum;
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

procedure TControlMan.SetPos(const Value : single);
begin
  FPos := Value;
  lbPos.Caption := Format('%4.1f', [FPos]);
//  if (FAutoZad <> FPos) and (FAutoZad <> 0) and (FPos <> 0) and (FZad <> 0) and FReady then lbAutoZad.Visible := True else lbAutoZad.Visible := False;
  if (FZad = FPos) and (FPos <> 0) and FReady then lbPos.Font.Color := clGreen else lbPos.Font.Color := clBlack;
end;

procedure TControlMan.SetZad(const Value : single);
begin
  if not ZadEdit then
    begin
      FZad := Value;
      edZadanie.Text := Format('%4.1f', [FZad]);
      if (FAutoZad <> FZad) and (FAutoZad <> 0) and FReady then lbAutoZad.Visible := True else lbAutoZad.Visible := False;
      if (FZad = FPos) and (FPos <> 0) and FReady then lbPos.Font.Color := clGreen else lbPos.Font.Color := clBlack;
    end;
end;

procedure TControlMan.SetAutoZad(const Value : single);
begin
  FAutoZad := Value;
  lbAutoZad.Caption := Format('%4.1f', [FAutoZad]);
//  if (FAutoZad <> FPos) and (FAutoZad <> 0) and (FPos <> 0) and (FZad <> 0) and FReady then lbAutoZad.Visible := True else lbAutoZad.Visible := False;
  if (FAutoZad <> FZad) and (FAutoZad <> 0) and FReady then lbAutoZad.Visible := True else lbAutoZad.Visible := False;
end;

procedure TControlMan.SetReady(const Value : boolean);
begin
  FReady := Value;
  lbRemont.Visible := not Value;
  lbPos.Visible := Value;
  lbAs.Visible := Value;
  lbP.Visible := Value;
  edZadanie.Visible := Value;
  btWork.Visible := Value;
  btUp.Visible := Value;
  btDn.Visible := Value;
  lbDN.Visible := Value;
  lbAutoZad.Visible := Value;
end;

procedure TControlMan.ControlManClick(Sender:TObject);
begin
  inherited Click;
end;

end.
