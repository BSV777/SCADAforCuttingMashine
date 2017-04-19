unit Params;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, IniFiles;

type
  TParamsForm = class(TForm)
    Label1: TLabel;
    edMax: TEdit;
    Label2: TLabel;
    edMin: TEdit;
    cbReady: TCheckBox;
    btSave: TBitBtn;
    BitBtn2: TBitBtn;
    Label5: TLabel;
    edDxR: TEdit;
    edAltMax: TEdit;
    Label6: TLabel;
    edAltMin: TEdit;
    rbLeft: TRadioButton;
    rbRight: TRadioButton;
    Label3: TLabel;
    edImpuls: TEdit;
    Label4: TLabel;
    Label7: TLabel;
    btUP: TButton;
    btDown: TButton;
    btFree: TButton;
    Label8: TLabel;
    edCorr: TEdit;
    procedure FormShow(Sender: TObject);
    procedure btSaveClick(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
    procedure btUPClick(Sender: TObject);
    procedure btDownClick(Sender: TObject);
    procedure btFreeClick(Sender: TObject);
  private
    { Private declarations }
  public
    BaseNum : string;
    DisplayNum : string;
    Num : byte;
    { Public declarations }
  end;

var
  ParamsForm: TParamsForm;

implementation

uses FormMan, Auto, ContrMan;

{$R *.dfm}

procedure TParamsForm.FormShow(Sender: TObject);
var
  ProgramPath : string;
  RezkaIni: TIniFile;
begin
  if BaseNum = 'ST1_R' then ParamsForm.Caption := 'Станок 1 рилевка ' + DisplayNum;
  if BaseNum = 'ST1_BL' then ParamsForm.Caption := 'Станок 1 нож ' + DisplayNum;
  if BaseNum = 'ST2_R' then ParamsForm.Caption := 'Станок 2 рилевка ' + DisplayNum;
  if BaseNum = 'ST2_BL' then ParamsForm.Caption := 'Станок 2 нож ' + DisplayNum;
  ProgramPath := ExtractFilePath(Application.EXEName);
  RezkaIni := TIniFile.Create(ProgramPath + 'Rezka.ini');
  try edMax.Text := Format('%4.1f', [StrToFloat(RezkaIni.ReadString('Max', BaseNum + IntToStr(Num), '0'))]);  except  end;
  try edAltMax.Text := Format('%4.1f', [StrToFloat(RezkaIni.ReadString('AltMax', BaseNum + IntToStr(Num), '0'))]);  except  end;
  try edAltMin.Text := Format('%4.1f', [StrToFloat(RezkaIni.ReadString('AltMin', BaseNum + IntToStr(Num), '0'))]);  except  end;
  try edMin.Text := Format('%4.1f', [StrToFloat(RezkaIni.ReadString('Min', BaseNum + IntToStr(Num), '0'))]);  except  end;
  try edDxR.Text := Format('%4.1f', [StrToFloat(RezkaIni.ReadString('DxL', BaseNum + IntToStr(Num), '0'))]);  except  end;
  try edImpuls.Text := Format('%1.1f', [StrToFloat(RezkaIni.ReadString('Impuls', BaseNum + IntToStr(Num), '0'))]);  except  end;
  try edCorr.Text := Format('%1.1f', [StrToFloat(RezkaIni.ReadString('Correction', BaseNum + IntToStr(Num), '0'))]);  except  end;
  if RezkaIni.ReadString('Ready', BaseNum + IntToStr(Num), '1') <> '0' then cbReady.Checked := True else cbReady.Checked := False;
  if RezkaIni.ReadString('DxLInv', BaseNum + IntToStr(Num), '0') <> '0' then rbRight.Checked := True else rbLeft.Checked := True;
  RezkaIni.Free;
end;

procedure TParamsForm.btSaveClick(Sender: TObject);
var
  ProgramPath : string;
  RezkaIni: TIniFile;
begin
  ProgramPath := ExtractFilePath(Application.EXEName);
  RezkaIni := TIniFile.Create(ProgramPath + 'Rezka.ini');
  RezkaIni.WriteString('Max', BaseNum + IntToStr(Num), edMax.Text);
  RezkaIni.WriteString('AltMax', BaseNum + IntToStr(Num), edAltMax.Text);
  RezkaIni.WriteString('Min', BaseNum + IntToStr(Num), edMin.Text);
  RezkaIni.WriteString('AltMin', BaseNum + IntToStr(Num), edAltMin.Text);
  RezkaIni.WriteString('DxL',  BaseNum + IntToStr(Num), edDxR.Text);
  RezkaIni.WriteString('Impuls',  BaseNum + IntToStr(Num), edImpuls.Text);
  RezkaIni.WriteString('Correction',  BaseNum + IntToStr(Num), edCorr.Text);
  if cbReady.Checked then RezkaIni.WriteString('Ready', BaseNum + IntToStr(Num), '1') else RezkaIni.WriteString('Ready', BaseNum + IntToStr(Num), '0');
  if rbRight.Checked then RezkaIni.WriteString('DxLInv', BaseNum + IntToStr(Num), '1') else RezkaIni.WriteString('DxLInv', BaseNum + IntToStr(Num), '0');
  RezkaIni.Free;
  ReloadIni;
  CurrZad.ReloadIni;
  NextZad.ReloadIni;
  Hide;
end;

procedure TParamsForm.BitBtn2Click(Sender: TObject);
begin
  Hide;
end;

procedure TParamsForm.btUPClick(Sender: TObject);
begin
  if BaseNum = 'ST1_R'  then OPCClient.ST1_R_DN[Num]  := False;
  if BaseNum = 'ST1_BL' then OPCClient.ST1_BL_DN[Num] := False;
  if BaseNum = 'ST2_R'  then OPCClient.ST2_R_DN[Num]  := False;
  if BaseNum = 'ST2_BL' then OPCClient.ST2_BL_DN[Num] := False;
end;

procedure TParamsForm.btDownClick(Sender: TObject);
begin
  if BaseNum = 'ST1_R'  then OPCClient.ST1_R_DN[Num]  := True;
  if BaseNum = 'ST1_BL' then OPCClient.ST1_BL_DN[Num] := True;
  if BaseNum = 'ST2_R'  then OPCClient.ST2_R_DN[Num]  := True;
  if BaseNum = 'ST2_BL' then OPCClient.ST2_BL_DN[Num] := True;
end;

procedure TParamsForm.btFreeClick(Sender: TObject);
var
  CtrlMan : TControlMan;
begin
  if BaseNum = 'ST1_R'  then CtrlMan := ST1RList.Items[Num - 1];
  if BaseNum = 'ST1_BL' then CtrlMan := ST1BLList.Items[Num - 1];
  if BaseNum = 'ST2_R'  then CtrlMan := ST2RList.Items[Num - 1];
  if BaseNum = 'ST2_BL' then CtrlMan := ST2BLList.Items[Num - 1];
  if CtrlMan <> nil then CtrlMan.Work := False;
end;

end.
