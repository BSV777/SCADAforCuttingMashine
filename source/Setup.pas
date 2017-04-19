unit Setup;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Grids, StdCtrls, ExtCtrls, Auto;

type
  TSetupForm = class(TForm)
    GroupBox1: TGroupBox;
    Label1: TLabel;
    Label2: TLabel;
    sgST1R: TStringGrid;
    sgST1BL: TStringGrid;
    btSend1ToPLC: TButton;
    ReadPosTimer: TTimer;
    GroupBox2: TGroupBox;
    Label3: TLabel;
    Label4: TLabel;
    sgST2R: TStringGrid;
    sgST2BL: TStringGrid;
    btSend2ToPLC: TButton;
    procedure FormShow(Sender: TObject);
    procedure ReadPosTimerTimer(Sender: TObject);
    procedure btSend1ToPLCClick(Sender: TObject);
    procedure sgST1RDrawCell(Sender: TObject; ACol, ARow: Integer; Rect: TRect; State: TGridDrawState);
    procedure sgST1BLDrawCell(Sender: TObject; ACol, ARow: Integer; Rect: TRect; State: TGridDrawState);
    procedure btSend2ToPLCClick(Sender: TObject);
    procedure sgST2RDrawCell(Sender: TObject; ACol, ARow: Integer; Rect: TRect; State: TGridDrawState);
    procedure sgST2BLDrawCell(Sender: TObject; ACol, ARow: Integer; Rect: TRect; State: TGridDrawState);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    Work : boolean;
  end;

var
  SetupForm: TSetupForm;
  RepF : TReplaceFlags;
  
implementation

uses FormMan;

{$R *.dfm}

procedure TSetupForm.FormShow(Sender: TObject);
var
  i : byte;
begin
  sgST1R.Cells[0, 0] := 'N';
  sgST1R.ColWidths[0] := 35;
  sgST1R.Cells[1, 0] := 'Поз.';
  sgST1R.ColWidths[1] := 65;
  sgST1R.Cells[2, 0] := 'Нов.';
  sgST1R.ColWidths[2] := 65;
  for i := 1 to 10 do
    begin
      CtrlMan := ST1RList.Items[10 - i];
      sgST1R.Cells[0, i] := CtrlMan.DisplayNum;
      if Work and CtrlMan.Work then sgST1R.Cells[2, i] := Format('%4.1f', [CtrlMan.AutoZad]) else sgST1R.Cells[2, i] := Format('%4.1f', [OPCClient.ST1_R_Pos[11 - i]]);
    end;
  sgST1BL.Cells[0, 0] := 'N';
  sgST1BL.ColWidths[0] := 35;
  sgST1BL.Cells[1, 0] := 'Поз.';
  sgST1BL.ColWidths[1] := 65;
  sgST1BL.Cells[2, 0] := 'Нов.';
  sgST1BL.ColWidths[2] := 65;
  for i := 1 to 6 do
    begin
      CtrlMan := ST1BLList.Items[6 - i];
      sgST1BL.Cells[0, i] := CtrlMan.DisplayNum;
      if Work and CtrlMan.Work then sgST1BL.Cells[2, i] := Format('%4.1f', [CtrlMan.AutoZad]) else sgST1BL.Cells[2, i] := Format('%4.1f', [OPCClient.ST1_BL_Pos[7 - i]]);
    end;
  sgST2R.Cells[0, 0] := 'N';
  sgST2R.ColWidths[0] := 35;
  sgST2R.Cells[1, 0] := 'Поз.';
  sgST2R.ColWidths[1] := 65;
  sgST2R.Cells[2, 0] := 'Нов.';
  sgST2R.ColWidths[2] := 65;
  for i := 1 to 10 do
    begin
      CtrlMan := ST2RList.Items[10 - i];
      sgST2R.Cells[0, i] := CtrlMan.DisplayNum;
      if Work and CtrlMan.Work then sgST2R.Cells[2, i] := Format('%4.1f', [CtrlMan.AutoZad]) else sgST2R.Cells[2, i] := Format('%4.1f', [OPCClient.ST2_R_Pos[11 - i]]);
    end;
  sgST2BL.Cells[0, 0] := 'N';
  sgST2BL.ColWidths[0] := 35;
  sgST2BL.Cells[1, 0] := 'Поз.';
  sgST2BL.ColWidths[1] := 65;
  sgST2BL.Cells[2, 0] := 'Нов.';
  sgST2BL.ColWidths[2] := 65;
  for i := 1 to 6 do
    begin
      CtrlMan := ST2BLList.Items[6 - i];
      sgST2BL.Cells[0, i] := CtrlMan.DisplayNum;
      if Work and CtrlMan.Work then sgST2BL.Cells[2, i] := Format('%4.1f', [CtrlMan.AutoZad]) else sgST2BL.Cells[2, i] := Format('%4.1f', [OPCClient.ST2_BL_Pos[7 - i]]);
    end;
end;

procedure TSetupForm.ReadPosTimerTimer(Sender: TObject);
var
  i : byte;
begin
  for i := 1 to 10 do sgST1R.Cells[1, i] := Format('%4.1f', [OPCClient.ST1_R_Pos[11 - i]]);
  for i := 1 to 6 do sgST1BL.Cells[1, i] := Format('%4.1f', [OPCClient.ST1_BL_Pos[7 - i]]);
  for i := 1 to 10 do sgST2R.Cells[1, i] := Format('%4.1f', [OPCClient.ST2_R_Pos[11 - i]]);
  for i := 1 to 6 do sgST2BL.Cells[1, i] := Format('%4.1f', [OPCClient.ST2_BL_Pos[7 - i]]);
end;

procedure TSetupForm.btSend1ToPLCClick(Sender: TObject);
const
  OneSecond = 1 / (24 * 60 * 60);
var
  i : byte;
  StartTime : TDateTime;
begin
  for i := 1 to 10 do OPCClient.ST1_R_SetPos[11 - i] := StrToFloat(sgST1R.Cells[2, i]);
  for i := 1 to 6 do OPCClient.ST1_BL_SetPos[7 - i] := StrToFloat(sgST1BL.Cells[2, i]);
  btSend1ToPLC.Caption := 'Ждите';
  StartTime := Now;
  while (Now - StartTime) < OneSecond * 3 do Application.ProcessMessages;
  OPCClient.ST1_Set;
  btSend1ToPLC.Caption := 'Записать';
end;

procedure TSetupForm.sgST1RDrawCell(Sender: TObject; ACol, ARow: Integer; Rect: TRect; State: TGridDrawState);
   procedure WriteText(StringGrid: TStringGrid; ACanvas: TCanvas; const ARect: TRect; const Text: string; Format: Word);
   const
     DX = 2;
     DY = 2;
   var
     S: array[0..255] of Char;
   begin
     with Stringgrid, ACanvas, ARect do
     begin
       case Format of
         DT_LEFT: ExtTextOut(Handle, Left + DX, Top + DY, ETO_OPAQUE or ETO_CLIPPED, @ARect, StrPCopy(S, Text), Length(Text), nil);
         DT_RIGHT: ExtTextOut(Handle, Right - TextWidth(Text) - 3, Top + DY, ETO_OPAQUE or ETO_CLIPPED, @ARect, StrPCopy(S, Text), Length(Text), nil);
         DT_CENTER: ExtTextOut(Handle, Left + (Right - Left - TextWidth(Text)) div 2, Top + DY, ETO_OPAQUE or ETO_CLIPPED, @ARect, StrPCopy(S, Text), Length(Text), nil);
       end;
     end;
   end;

   procedure Display(StringGrid: TStringGrid; const S: string; Alignment: TAlignment);
   const
     Formats: array[TAlignment] of Word = (DT_LEFT, DT_RIGHT, DT_CENTER);
   begin
     WriteText(StringGrid, StringGrid.Canvas, Rect, S, Formats[Alignment]);
   end;
var
  t : single;
begin
  if (ARow = 0) or (ACol = 0) then Display(sgST1R, sgST1R.Cells[ACol, ARow], taCenter);
  if (ARow > 0) and (ACol = 1) then Display(sgST1R, sgST1R.Cells[ACol, ARow], taRightJustify);
  if (ARow > 0) and (ACol = 2) then
    begin
      try
        t := StrToFloat(StringReplace(sgST1R.Cells[2, ARow], '.', ',', RepF));
      except
        sgST1R.Cells[2, ARow] := Format('%4.1f', [OPCClient.ST1_R_Pos[11 - ARow]]);
        t := StrToFloat(sgST1R.Cells[2, ARow]);
      end;
      Display(sgST1R, Format('%4.1f', [t]), taRightJustify);
    end;
end;

procedure TSetupForm.sgST1BLDrawCell(Sender: TObject; ACol, ARow: Integer;  Rect: TRect; State: TGridDrawState);
   procedure WriteText(StringGrid: TStringGrid; ACanvas: TCanvas; const ARect: TRect; const Text: string; Format: Word);
   const
     DX = 2;
     DY = 2;
   var
     S: array[0..255] of Char;
   begin
     with Stringgrid, ACanvas, ARect do
     begin
       case Format of
         DT_LEFT: ExtTextOut(Handle, Left + DX, Top + DY, ETO_OPAQUE or ETO_CLIPPED, @ARect, StrPCopy(S, Text), Length(Text), nil);
         DT_RIGHT: ExtTextOut(Handle, Right - TextWidth(Text) - 3, Top + DY, ETO_OPAQUE or ETO_CLIPPED, @ARect, StrPCopy(S, Text), Length(Text), nil);
         DT_CENTER: ExtTextOut(Handle, Left + (Right - Left - TextWidth(Text)) div 2, Top + DY, ETO_OPAQUE or ETO_CLIPPED, @ARect, StrPCopy(S, Text), Length(Text), nil);
       end;
     end;
   end;

   procedure Display(StringGrid: TStringGrid; const S: string; Alignment: TAlignment);
   const
     Formats: array[TAlignment] of Word = (DT_LEFT, DT_RIGHT, DT_CENTER);
   begin
     WriteText(StringGrid, StringGrid.Canvas, Rect, S, Formats[Alignment]);
   end;
var
  t : single;
begin
  if (ARow = 0) or (ACol = 0) then Display(sgST1BL, sgST1BL.Cells[ACol, ARow], taCenter);
  if (ARow > 0) and (ACol = 1) then Display(sgST1BL, sgST1BL.Cells[ACol, ARow], taRightJustify);
  if (ARow > 0) and (ACol = 2) then
    begin
      try
        t := StrToFloat(StringReplace(sgST1BL.Cells[2, ARow], '.', ',', RepF));
      except
        sgST1BL.Cells[2, ARow] := Format('%4.1f', [OPCClient.ST1_BL_Pos[7 - ARow]]);
        t := StrToFloat(sgST1BL.Cells[2, ARow]);
      end;
      Display(sgST1BL, Format('%4.1f', [t]), taRightJustify);
    end;
end;

procedure TSetupForm.btSend2ToPLCClick(Sender: TObject);
const
  OneSecond = 1 / (24 * 60 * 60);
var
  i : byte;
  StartTime : TDateTime;
begin
  for i := 1 to 10 do OPCClient.ST2_R_SetPos[11 - i] := StrToFloat(sgST2R.Cells[2, i]);
  for i := 1 to 6 do OPCClient.ST2_BL_SetPos[7 - i] := StrToFloat(sgST2BL.Cells[2, i]);
  btSend2ToPLC.Caption := 'Ждите';
  StartTime := Now;
  while (Now - StartTime) < OneSecond * 3 do Application.ProcessMessages;
  OPCClient.ST2_Set;
  btSend2ToPLC.Caption := 'Записать';
end;

procedure TSetupForm.sgST2RDrawCell(Sender: TObject; ACol, ARow: Integer; Rect: TRect; State: TGridDrawState);
   procedure WriteText(StringGrid: TStringGrid; ACanvas: TCanvas; const ARect: TRect; const Text: string; Format: Word);
   const
     DX = 2;
     DY = 2;
   var
     S: array[0..255] of Char;
   begin
     with Stringgrid, ACanvas, ARect do
     begin
       case Format of
         DT_LEFT: ExtTextOut(Handle, Left + DX, Top + DY, ETO_OPAQUE or ETO_CLIPPED, @ARect, StrPCopy(S, Text), Length(Text), nil);
         DT_RIGHT: ExtTextOut(Handle, Right - TextWidth(Text) - 3, Top + DY, ETO_OPAQUE or ETO_CLIPPED, @ARect, StrPCopy(S, Text), Length(Text), nil);
         DT_CENTER: ExtTextOut(Handle, Left + (Right - Left - TextWidth(Text)) div 2, Top + DY, ETO_OPAQUE or ETO_CLIPPED, @ARect, StrPCopy(S, Text), Length(Text), nil);
       end;
     end;
   end;

   procedure Display(StringGrid: TStringGrid; const S: string; Alignment: TAlignment);
   const
     Formats: array[TAlignment] of Word = (DT_LEFT, DT_RIGHT, DT_CENTER);
   begin
     WriteText(StringGrid, StringGrid.Canvas, Rect, S, Formats[Alignment]);
   end;
var
  t : single;
begin
  if (ARow = 0) or (ACol = 0) then Display(sgST2R, sgST2R.Cells[ACol, ARow], taCenter);
  if (ARow > 0) and (ACol = 1) then Display(sgST2R, sgST2R.Cells[ACol, ARow], taRightJustify);
  if (ARow > 0) and (ACol = 2) then
    begin
      try
        t := StrToFloat(StringReplace(sgST2R.Cells[2, ARow], '.', ',', RepF));
      except
        sgST2R.Cells[2, ARow] := Format('%4.1f', [OPCClient.ST2_R_Pos[11 - ARow]]);
        t := StrToFloat(sgST2R.Cells[2, ARow]);
      end;
      Display(sgST2R, Format('%4.1f', [t]), taRightJustify);
    end;
end;

procedure TSetupForm.sgST2BLDrawCell(Sender: TObject; ACol, ARow: Integer; Rect: TRect; State: TGridDrawState);
   procedure WriteText(StringGrid: TStringGrid; ACanvas: TCanvas; const ARect: TRect; const Text: string; Format: Word);
   const
     DX = 2;
     DY = 2;
   var
     S: array[0..255] of Char;
   begin
     with Stringgrid, ACanvas, ARect do
     begin
       case Format of
         DT_LEFT: ExtTextOut(Handle, Left + DX, Top + DY, ETO_OPAQUE or ETO_CLIPPED, @ARect, StrPCopy(S, Text), Length(Text), nil);
         DT_RIGHT: ExtTextOut(Handle, Right - TextWidth(Text) - 3, Top + DY, ETO_OPAQUE or ETO_CLIPPED, @ARect, StrPCopy(S, Text), Length(Text), nil);
         DT_CENTER: ExtTextOut(Handle, Left + (Right - Left - TextWidth(Text)) div 2, Top + DY, ETO_OPAQUE or ETO_CLIPPED, @ARect, StrPCopy(S, Text), Length(Text), nil);
       end;
     end;
   end;

   procedure Display(StringGrid: TStringGrid; const S: string; Alignment: TAlignment);
   const
     Formats: array[TAlignment] of Word = (DT_LEFT, DT_RIGHT, DT_CENTER);
   begin
     WriteText(StringGrid, StringGrid.Canvas, Rect, S, Formats[Alignment]);
   end;
var
  t : single;
begin
  if (ARow = 0) or (ACol = 0) then Display(sgST2BL, sgST2BL.Cells[ACol, ARow], taCenter);
  if (ARow > 0) and (ACol = 1) then Display(sgST2BL, sgST2BL.Cells[ACol, ARow], taRightJustify);
  if (ARow > 0) and (ACol = 2) then
    begin
      try
        t := StrToFloat(StringReplace(sgST2BL.Cells[2, ARow], '.', ',', RepF));
      except
        sgST2BL.Cells[2, ARow] := Format('%4.1f', [OPCClient.ST2_BL_Pos[7 - ARow]]);
        t := StrToFloat(sgST2BL.Cells[2, ARow]);
      end;
      Display(sgST2BL, Format('%4.1f', [t]), taRightJustify);
    end;
end;

procedure TSetupForm.FormCreate(Sender: TObject);
begin
  RepF := [rfReplaceAll, rfIgnoreCase];
end;

end.
