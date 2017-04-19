unit OPCClient;

interface

uses
  SysUtils, Classes, Graphics, Forms, StdCtrls, ExtCtrls,
  OPCDA, OPCutils, ComObj, ActiveX, OPCTypes, IniFiles, ContrAuto;

type
  THardwareButton = procedure(Sender : TObject) of object;
  TOPCClient = class(TComponent)
  private
    FOnRedist   : THardwareButton;
    FOnButton2  : THardwareButton;
    FRedist     : boolean;
    FButton2    : boolean;
    TagNameList : array[1..210] of string;
    FST1_BL_Zad : array[1..6]   of single;
    FST2_BL_Zad : array[1..6]   of single;
    FST1_BL_Pos : array[1..6]   of single;
    FST2_BL_Pos : array[1..6]   of single;

    FST1_R_Zad  : array[1..10]  of single;
    FST2_R_Zad  : array[1..10]  of single;
    FST1_R_Pos  : array[1..10]  of single;
    FST2_R_Pos  : array[1..10]  of single;

    FST1_BL_DN  : array[1..6]   of boolean;
    FST2_BL_DN  : array[1..6]   of boolean;

    FST1_R_DN   : array[1..10]  of boolean;
    FST2_R_DN   : array[1..10]  of boolean;

    FST1_BL_SetPos : array[1..6]  of single;
    FST2_BL_SetPos : array[1..6]  of single;
    FST1_R_SetPos  : array[1..10] of single;
    FST2_R_SetPos  : array[1..10] of single;

    FST1_R_Corr    : array[1..10] of single;
    FST2_R_Corr    : array[1..10] of single;
    FST1_BL_Corr   : array[1..6]  of single;
    FST2_BL_Corr   : array[1..6]  of single;

    FConnected : boolean;
    ReadTimer : TTimer;
    ConnectTimer : TTimer;
    procedure ReadTimerTimer(Sender : TObject);
    procedure Read;
    procedure ConnectTimerTimer(Sender : TObject);
    procedure Connect;
    procedure Disconnect;
    function GetST1_BL_Zad(Index : byte) : single;
    procedure SetST1_BL_Zad(Index : byte; Value : single);
    function GetST2_BL_Zad(Index : byte) : single;
    procedure SetST2_BL_Zad(Index : byte; Value : single);
    function GetST1_BL_Pos(Index : byte) : single;
    function GetST2_BL_Pos(Index : byte) : single;
    function GetST1_R_Zad(Index : byte) : single;
    procedure SetST1_R_Zad(Index : byte; Value : single);
    function GetST2_R_Zad(Index : byte) : single;
    procedure SetST2_R_Zad(Index : byte; Value : single);
    function GetST1_R_Pos(Index : byte) : single;
    function GetST2_R_Pos(Index : byte) : single;
    function GetST1_BL_DN(Index : byte) : boolean;
    procedure SetST1_BL_DN(Index : byte; Value : boolean);
    function GetST2_BL_DN(Index : byte) : boolean;
    procedure SetST2_BL_DN(Index : byte; Value : boolean);
    function GetST1_R_DN(Index : byte) : boolean;
    procedure SetST1_R_DN(Index : byte; Value : boolean);
    function GetST2_R_DN(Index : byte) : boolean;
    procedure SetST2_R_DN(Index : byte; Value : boolean);

    function GetST1_BL_SetPos(Index : byte) : single;
    procedure SetST1_BL_SetPos(Index : byte; Value : single);
    function GetST2_BL_SetPos(Index : byte) : single;
    procedure SetST2_BL_SetPos(Index : byte; Value : single);
    function GetST1_R_SetPos(Index : byte) : single;
    procedure SetST1_R_SetPos(Index : byte; Value : single);
    function GetST2_R_SetPos(Index : byte) : single;
    procedure SetST2_R_SetPos(Index : byte; Value : single);

    procedure SetConnected(Value : boolean);
  protected
    function GetTagReal(Index : byte) : single;
    function GetTagBool(Index : byte) : boolean;
  public
    constructor Create(AOwner:TComponent); override;
    property OnRedist : THardwareButton read FOnRedist write FOnRedist;
    property OnButton2 : THardwareButton read FOnButton2 write FOnButton2;
    property ST1_BL_Zad[Index : byte] : single read GetST1_BL_Zad write SetST1_BL_Zad;
    property ST2_BL_Zad[Index : byte] : single read GetST2_BL_Zad write SetST2_BL_Zad;
    property ST1_BL_Pos[Index : byte] : single read GetST1_BL_Pos;
    property ST2_BL_Pos[Index : byte] : single read GetST2_BL_Pos;
    property ST1_R_Zad[Index : byte] : single read GetST1_R_Zad write SetST1_R_Zad;
    property ST2_R_Zad[Index : byte] : single read GetST2_R_Zad write SetST2_R_Zad;
    property ST1_R_Pos[Index : byte] : single read GetST1_R_Pos;
    property ST2_R_Pos[Index : byte] : single read GetST2_R_Pos;

    property ST1_BL_DN[Index : byte] : boolean read GetST1_BL_DN write SetST1_BL_DN;
    property ST2_BL_DN[Index : byte] : boolean read GetST2_BL_DN write SetST2_BL_DN;
    property ST1_R_DN[Index : byte] : boolean read GetST1_R_DN write SetST1_R_DN;
    property ST2_R_DN[Index : byte] : boolean read GetST2_R_DN write SetST2_R_DN;

    property ST1_BL_SetPos[Index : byte] : single read GetST1_BL_SetPos write SetST1_BL_SetPos;
    property ST2_BL_SetPos[Index : byte] : single read GetST2_BL_SetPos write SetST2_BL_SetPos;
    property ST1_R_SetPos[Index : byte] : single read GetST1_R_SetPos write SetST1_R_SetPos;
    property ST2_R_SetPos[Index : byte] : single read GetST2_R_SetPos write SetST2_R_SetPos;
    procedure ST1_Set;
    procedure ST2_Set;
    procedure Table(Value : boolean);
    procedure Cut;

    property Connected : boolean read FConnected write SetConnected;
  end;

const
  ServerProgID = 'S7200.OPCServer';
  OneSecond = 1 / (24 * 60 * 60);

var
  ServerIf : IOPCServer;
  GroupIf : IOPCItemMgt;
  GroupHandle : OPCHANDLE;
  ItemHandle : array[1..210] of OPCHANDLE;
  StartTime : TDateTime;
  ProgramPath : string;

implementation

constructor TOPCClient.Create(AOwner : TComponent);
begin
  ReadTimer := TTimer.Create(AOwner);
  ReadTimer.Interval := 1000;
  ReadTimer.Enabled := False;
  ReadTimer.OnTimer := ReadTimerTimer;

  ConnectTimer := TTimer.Create(AOwner);
  ConnectTimer.Interval := 5000;
  ConnectTimer.Enabled := False;
  ConnectTimer.OnTimer := ConnectTimerTimer;
  TagNameList[1] := 'MicroWin.Lpak2.USER1.zadan_bl1';
  TagNameList[2] := 'MicroWin.Lpak2.USER1.zadan_bl2';
  TagNameList[3] := 'MicroWin.Lpak2.USER1.zadan_bl3';
  TagNameList[4] := 'MicroWin.Lpak2.USER1.zadan_bl4';
  TagNameList[5] := 'MicroWin.Lpak3.USER1.zadan_bl1';
  TagNameList[6] := 'MicroWin.Lpak3.USER1.zadan_bl2';
  TagNameList[7] := 'MicroWin.Lpak3.USER1.zadan_bl3';
  TagNameList[8] := 'MicroWin.Lpak3.USER1.zadan_bl4';
  TagNameList[9] := 'MicroWin.Lpak4.USER1.zadan_bl1';
  TagNameList[10] := 'MicroWin.Lpak4.USER1.zadan_bl2';
  TagNameList[11] := 'MicroWin.Lpak4.USER1.zadan_bl3';
  TagNameList[12] := 'MicroWin.Lpak4.USER1.zadan_bl4';
  TagNameList[13] := 'MicroWin.Lpak5.USER1.zadan_bl1';
  TagNameList[14] := 'MicroWin.Lpak5.USER1.zadan_bl2';
  TagNameList[15] := 'MicroWin.Lpak5.USER1.zadan_bl3';
  TagNameList[16] := 'MicroWin.Lpak5.USER1.zadan_bl4';

  TagNameList[22] := 'MicroWin.Lpak6.USER1.zadan_bl1';
  TagNameList[21] := 'MicroWin.Lpak6.USER1.zadan_bl2';
  TagNameList[20] := 'MicroWin.Lpak6.USER1.zadan_bl3';
  TagNameList[19] := 'MicroWin.Lpak6.USER1.zadan_bl4';
  TagNameList[18] := 'MicroWin.Lpak7.USER1.zadan_bl1';
  TagNameList[17] := 'MicroWin.Lpak7.USER1.zadan_bl2';

  TagNameList[32] := 'MicroWin.Lpak7.USER1.zadan_bl3';
  TagNameList[31] := 'MicroWin.Lpak7.USER1.zadan_bl4';
  TagNameList[30] := 'MicroWin.Lpak8.USER1.zadan_bl1';
  TagNameList[29] := 'MicroWin.Lpak8.USER1.zadan_bl2';
  TagNameList[28] := 'MicroWin.Lpak8.USER1.zadan_bl3';
  TagNameList[27] := 'MicroWin.Lpak8.USER1.zadan_bl4';
  TagNameList[26] := 'MicroWin.Lpak9.USER1.zadan_bl1';
  TagNameList[25] := 'MicroWin.Lpak9.USER1.zadan_bl2';
  TagNameList[24] := 'MicroWin.Lpak9.USER1.zadan_bl3';
  TagNameList[23] := 'MicroWin.Lpak9.USER1.zadan_bl4';

  TagNameList[33] := 'MicroWin.Lpak2.USER1.real_bl1';
  TagNameList[34] := 'MicroWin.Lpak2.USER1.real_bl2';
  TagNameList[35] := 'MicroWin.Lpak2.USER1.real_bl3';
  TagNameList[36] := 'MicroWin.Lpak2.USER1.real_bl4';
  TagNameList[37] := 'MicroWin.Lpak3.USER1.real_bl1';
  TagNameList[38] := 'MicroWin.Lpak3.USER1.real_bl2';
  TagNameList[39] := 'MicroWin.Lpak3.USER1.real_bl3';
  TagNameList[40] := 'MicroWin.Lpak3.USER1.real_bl4';
  TagNameList[41] := 'MicroWin.Lpak4.USER1.real_bl1';
  TagNameList[42] := 'MicroWin.Lpak4.USER1.real_bl2';
  TagNameList[43] := 'MicroWin.Lpak4.USER1.real_bl3';
  TagNameList[44] := 'MicroWin.Lpak4.USER1.real_bl4';
  TagNameList[45] := 'MicroWin.Lpak5.USER1.real_bl1';
  TagNameList[46] := 'MicroWin.Lpak5.USER1.real_bl2';
  TagNameList[47] := 'MicroWin.Lpak5.USER1.real_bl3';
  TagNameList[48] := 'MicroWin.Lpak5.USER1.real_bl4';

  TagNameList[54] := 'MicroWin.Lpak6.USER1.real_bl1';
  TagNameList[53] := 'MicroWin.Lpak6.USER1.real_bl2';
  TagNameList[52] := 'MicroWin.Lpak6.USER1.real_bl3';
  TagNameList[51] := 'MicroWin.Lpak6.USER1.real_bl4';
  TagNameList[50] := 'MicroWin.Lpak7.USER1.real_bl1';
  TagNameList[49] := 'MicroWin.Lpak7.USER1.real_bl2';

  TagNameList[64] := 'MicroWin.Lpak7.USER1.real_bl3';
  TagNameList[63] := 'MicroWin.Lpak7.USER1.real_bl4';
  TagNameList[62] := 'MicroWin.Lpak8.USER1.real_bl1';
  TagNameList[61] := 'MicroWin.Lpak8.USER1.real_bl2';
  TagNameList[60] := 'MicroWin.Lpak8.USER1.real_bl3';
  TagNameList[59] := 'MicroWin.Lpak8.USER1.real_bl4';
  TagNameList[58] := 'MicroWin.Lpak9.USER1.real_bl1';
  TagNameList[57] := 'MicroWin.Lpak9.USER1.real_bl2';
  TagNameList[56] := 'MicroWin.Lpak9.USER1.real_bl3';
  TagNameList[55] := 'MicroWin.Lpak9.USER1.real_bl4';

  TagNameList[101] := 'MicroWin.Lpak2.USER1.blade1_up';
  TagNameList[102] := 'MicroWin.Lpak2.USER1.blade2_up';
  TagNameList[103] := 'MicroWin.Lpak2.USER1.blade3_up';
  TagNameList[104] := 'MicroWin.Lpak2.USER1.blade4_up';
  TagNameList[105] := 'MicroWin.Lpak3.USER1.blade1_up';
  TagNameList[106] := 'MicroWin.Lpak3.USER1.blade2_up';
  TagNameList[107] := 'MicroWin.Lpak3.USER1.blade3_up';
  TagNameList[108] := 'MicroWin.Lpak3.USER1.blade4_up';
  TagNameList[109] := 'MicroWin.Lpak4.USER1.blade1_up';
  TagNameList[110] := 'MicroWin.Lpak4.USER1.blade2_up';
  TagNameList[111] := 'MicroWin.Lpak4.USER1.blade3_up';
  TagNameList[112] := 'MicroWin.Lpak4.USER1.blade4_up';
  TagNameList[113] := 'MicroWin.Lpak5.USER1.blade1_up';
  TagNameList[114] := 'MicroWin.Lpak5.USER1.blade2_up';
  TagNameList[115] := 'MicroWin.Lpak5.USER1.blade3_up';
  TagNameList[116] := 'MicroWin.Lpak5.USER1.blade4_up';
  TagNameList[117] := 'MicroWin.Lpak6.USER1.blade1_up';
  TagNameList[118] := 'MicroWin.Lpak6.USER1.blade2_up';
  TagNameList[119] := 'MicroWin.Lpak6.USER1.blade3_up';
  TagNameList[120] := 'MicroWin.Lpak6.USER1.blade4_up';
  TagNameList[121] := 'MicroWin.Lpak7.USER1.blade1_up';
  TagNameList[122] := 'MicroWin.Lpak7.USER1.blade2_up';
  TagNameList[123] := 'MicroWin.Lpak7.USER1.blade3_up';
  TagNameList[124] := 'MicroWin.Lpak7.USER1.blade4_up';
  TagNameList[125] := 'MicroWin.Lpak8.USER1.blade1_up';
  TagNameList[126] := 'MicroWin.Lpak8.USER1.blade2_up';
  TagNameList[127] := 'MicroWin.Lpak8.USER1.blade3_up';
  TagNameList[128] := 'MicroWin.Lpak8.USER1.blade4_up';
  TagNameList[129] := 'MicroWin.Lpak9.USER1.blade1_up';
  TagNameList[130] := 'MicroWin.Lpak9.USER1.blade2_up';
  TagNameList[131] := 'MicroWin.Lpak9.USER1.blade3_up';
  TagNameList[132] := 'MicroWin.Lpak9.USER1.blade4_up';

  TagNameList[151] := 'MicroWin.Lpak2.USER1.zadan1';
  TagNameList[152] := 'MicroWin.Lpak2.USER1.zadan2';
  TagNameList[153] := 'MicroWin.Lpak2.USER1.zadan3';
  TagNameList[154] := 'MicroWin.Lpak2.USER1.zadan4';
  TagNameList[155] := 'MicroWin.Lpak3.USER1.zadan1';
  TagNameList[156] := 'MicroWin.Lpak3.USER1.zadan2';
  TagNameList[157] := 'MicroWin.Lpak3.USER1.zadan3';
  TagNameList[158] := 'MicroWin.Lpak3.USER1.zadan4';
  TagNameList[159] := 'MicroWin.Lpak4.USER1.zadan1';
  TagNameList[160] := 'MicroWin.Lpak4.USER1.zadan2';
  TagNameList[161] := 'MicroWin.Lpak4.USER1.zadan3';
  TagNameList[162] := 'MicroWin.Lpak4.USER1.zadan4';
  TagNameList[163] := 'MicroWin.Lpak5.USER1.zadan1';
  TagNameList[164] := 'MicroWin.Lpak5.USER1.zadan2';
  TagNameList[165] := 'MicroWin.Lpak5.USER1.zadan3';
  TagNameList[166] := 'MicroWin.Lpak5.USER1.zadan4';

  TagNameList[172] := 'MicroWin.Lpak6.USER1.zadan1';
  TagNameList[171] := 'MicroWin.Lpak6.USER1.zadan2';
  TagNameList[170] := 'MicroWin.Lpak6.USER1.zadan3';
  TagNameList[169] := 'MicroWin.Lpak6.USER1.zadan4';
  TagNameList[168] := 'MicroWin.Lpak7.USER1.zadan1';
  TagNameList[167] := 'MicroWin.Lpak7.USER1.zadan2';

  TagNameList[182] := 'MicroWin.Lpak7.USER1.zadan3';
  TagNameList[181] := 'MicroWin.Lpak7.USER1.zadan4';
  TagNameList[180] := 'MicroWin.Lpak8.USER1.zadan1';
  TagNameList[179] := 'MicroWin.Lpak8.USER1.zadan2';
  TagNameList[178] := 'MicroWin.Lpak8.USER1.zadan3';
  TagNameList[177] := 'MicroWin.Lpak8.USER1.zadan4';
  TagNameList[176] := 'MicroWin.Lpak9.USER1.zadan1';
  TagNameList[175] := 'MicroWin.Lpak9.USER1.zadan2';
  TagNameList[174] := 'MicroWin.Lpak9.USER1.zadan3';
  TagNameList[173] := 'MicroWin.Lpak9.USER1.zadan4';

  TagNameList[191] := 'MicroWin.Lpak2.USER1.new_zadan';
  TagNameList[192] := 'MicroWin.Lpak3.USER1.new_zadan';
  TagNameList[193] := 'MicroWin.Lpak4.USER1.new_zadan';
  TagNameList[194] := 'MicroWin.Lpak5.USER1.new_zadan';
  TagNameList[195] := 'MicroWin.Lpak6.USER1.new_zadan';
  TagNameList[196] := 'MicroWin.Lpak7.USER1.new_zadan';
  TagNameList[197] := 'MicroWin.Lpak8.USER1.new_zadan';
  TagNameList[198] := 'MicroWin.Lpak9.USER1.new_zadan';

  TagNameList[199] := 'MicroWin.Lpak7.USER1.board_on'; //Поднятие стола
  TagNameList[200] := 'MicroWin.Lpak8.USER1.board_on'; //Опускание стола

  TagNameList[201] := 'MicroWin.Lpak2.USER1.pusk1';   //Изменить режим перестройки на ручной
  TagNameList[202] := 'MicroWin.Lpak2.USER1.pusk2';   //не используется
  TagNameList[203] := 'MicroWin.Lpak2.USER1.pusk3';   //не используется
  TagNameList[204] := 'MicroWin.Lpak2.USER1.pusk4';   //не используется
  TagNameList[205] := 'MicroWin.Lpak6.USER1.pusk1';   //Перестроить
  TagNameList[206] := 'MicroWin.Lpak6.USER1.pusk2';   //не используется
  TagNameList[207] := 'MicroWin.Lpak6.USER1.pusk3';   //не используется
  TagNameList[208] := 'MicroWin.Lpak6.USER1.pusk4';   //не используется

  TagNameList[209] := 'MicroWin.Lpak6.USER1.board_on'; //Обруб
  FConnected := False;
  FRedist    := False;
  FButton2   := False;
end;

procedure TOPCClient.ReadTimerTimer(Sender: TObject);
begin
  Read;
end;

function TOPCClient.GetTagReal(Index : byte) : single;
var
  HR : HResult;
  ItemValue : string;
  ItemQuality : Word;
begin
  HR := ReadOPCGroupItemValue(GroupIf, ItemHandle[Index], ItemValue, ItemQuality);
  Result := 0;
  if Succeeded(HR) then
    begin
      try
        Result := StrToInt(ItemValue) / 10;
      except
      end;
    end else
    begin
      FConnected := False;
    end;
end;

function TOPCClient.GetTagBool(Index : byte) : boolean;
var
  HR : HResult;
  ItemValue : string;
  ItemQuality : Word;
begin
  HR := ReadOPCGroupItemValue(GroupIf, ItemHandle[Index], ItemValue, ItemQuality);
  Result := False;
  if Succeeded(HR) then
    begin
      if ItemValue = 'True' then Result := True else Result := False;
    end else
    begin
      FConnected := False;
    end;
end;

procedure TOPCClient.Read;
var
  i : byte;
begin
  ReadTimer.Enabled := False;
  for i := 1 to 6 do FST1_BL_Zad[i] := GetTagReal(i);
  for i := 1 to 6 do FST2_BL_Zad[i] := GetTagReal(i + 16);
  for i := 1 to 6 do FST1_BL_Pos[i] := GetTagReal(i + 32);
  for i := 1 to 6 do FST2_BL_Pos[i] := GetTagReal(i + 48);
  for i := 1 to 10 do FST1_R_Zad[i] := GetTagReal(i + 6);
  for i := 1 to 10 do FST2_R_Zad[i] := GetTagReal(i + 22);
  for i := 1 to 10 do FST1_R_Pos[i] := GetTagReal(i + 38);
  for i := 1 to 10 do FST2_R_Pos[i] := GetTagReal(i + 54);
  for i := 1 to 6 do FST1_BL_DN[i] := GetTagBool(100 + i);
  for i := 1 to 6 do FST2_BL_DN[i] := GetTagBool(100 + i + 16);
  for i := 1 to 10 do FST1_R_DN[i] := GetTagBool(100 + i + 6);
  for i := 1 to 10 do FST2_R_DN[i] := GetTagBool(100 + i + 22);

  for i := 1 to 6 do FST1_BL_SetPos[i] := GetTagReal(i + 150);
  for i := 1 to 6 do FST2_BL_SetPos[i] := GetTagReal(i + 150 + 16);
  for i := 1 to 10 do FST1_R_SetPos[i] := GetTagReal(i + 150 + 6);
  for i := 1 to 10 do FST2_R_SetPos[i] := GetTagReal(i + 150 + 22);
  if GetTagBool(205) then
    begin
      if not FRedist then
        begin
          if Assigned(FOnRedist) then FOnRedist(Self);
          FRedist := True;
        end;
    end else FRedist := False;
  if GetTagBool(201) then
    begin
      if not FButton2 then
        begin
          if Assigned(FOnButton2) then FOnButton2(Self);
          FButton2 := True;
        end;
    end else FButton2 := False;

  ReadTimer.Enabled := True;
end;

procedure TOPCClient.ConnectTimerTimer(Sender: TObject);
begin
  Connect;
end;

procedure TOPCClient.Connect;
var
  i : byte;
  ItemType : TVarType;
  HR : HResult;
begin
  ConnectTimer.Enabled := False;
  try
    ServerIf := CreateComObject(ProgIDToClassID(ServerProgID)) as IOPCServer;
  except
    ServerIf := nil;
  end;
  if ServerIf = nil then
    begin
      Disconnect;
    end else
    begin
      HR := ServerAddGroup(ServerIf, 'Grp', True, 1000, 0, GroupIf, GroupHandle);
      if not Succeeded(HR) then
        begin
          Disconnect;
        end else
        begin
          for i := 1 to 64 do
            begin
              try
                GroupAddItem(GroupIf, TagNameList[i], 0, VT_UI2, ItemHandle[i], ItemType);
              except
              end;
              Application.ProcessMessages;
            end;
          for i := 101 to 140 do
            begin
              try
                GroupAddItem(GroupIf, TagNameList[i], 0, VT_BOOL, ItemHandle[i], ItemType);
              except
              end;
              Application.ProcessMessages;
            end;
          for i := 151 to 182 do
            begin
              try
                GroupAddItem(GroupIf, TagNameList[i], 0, VT_UI2, ItemHandle[i], ItemType);
              except
              end;
              Application.ProcessMessages;
            end;
          for i := 191 to 209 do
            begin
              try
                GroupAddItem(GroupIf, TagNameList[i], 0, VT_BOOL, ItemHandle[i], ItemType);
              except
              end;
              Application.ProcessMessages;
            end;
          StartTime := Now;
          while (Now - StartTime) < OneSecond do Application.ProcessMessages;
          ReadTimer.Enabled := True;
          FConnected := True;
        end;
    end;
end;

procedure TOPCClient.Disconnect;
begin
  if ServerIf <> nil then ServerIf.RemoveGroup(GroupHandle, False);
  GroupIf := nil;
  ServerIf := nil;
  FConnected := False;
  ConnectTimer.Enabled := True;
end;

function TOPCClient.GetST1_BL_Zad(Index : byte) : single;
begin
  Result := FST1_BL_Zad[Index];
end;

function TOPCClient.GetST1_BL_Pos(Index : byte) : single;
begin
  Result := FST1_BL_Pos[Index];
end;

function TOPCClient.GetST2_BL_Zad(Index : byte) : single;
begin
  Result := FST2_BL_Zad[Index];
end;

function TOPCClient.GetST2_BL_Pos(Index : byte) : single;
begin
  Result := FST2_BL_Pos[Index];
end;

function TOPCClient.GetST1_R_Zad(Index : byte) : single;
begin
  Result := FST1_R_Zad[Index];
end;

function TOPCClient.GetST1_R_Pos(Index : byte) : single;
begin
  Result := FST1_R_Pos[Index];
end;

function TOPCClient.GetST2_R_Zad(Index : byte) : single;
begin
  Result := FST2_R_Zad[Index];
end;

function TOPCClient.GetST2_R_Pos(Index : byte) : single;
begin
  Result := FST2_R_Pos[Index];
end;

function TOPCClient.GetST1_BL_DN(Index : byte) : boolean;
begin
  Result := FST1_BL_DN[Index];
end;

function TOPCClient.GetST2_BL_DN(Index : byte) : boolean;
begin
  Result := FST2_BL_DN[Index];
end;

function TOPCClient.GetST1_R_DN(Index : byte) : boolean;
begin
  Result := FST1_R_DN[Index];
end;

function TOPCClient.GetST2_R_DN(Index : byte) : boolean;
begin
  Result := FST2_R_DN[Index];
end;

function TOPCClient.GetST1_BL_SetPos(Index : byte) : single;
begin
  Result := FST1_BL_SetPos[Index];
end;

function TOPCClient.GetST2_BL_SetPos(Index : byte) : single;
begin
  Result := FST2_BL_SetPos[Index];
end;

function TOPCClient.GetST1_R_SetPos(Index : byte) : single;
begin
  Result := FST1_R_SetPos[Index];
end;

function TOPCClient.GetST2_R_SetPos(Index : byte) : single;
begin
  Result := FST2_R_SetPos[Index];
end;

procedure TOPCClient.SetConnected(Value : boolean);
begin
  if Value <> FConnected then
    begin
      if Value then Connect else
        begin
          Disconnect;
          ConnectTimer.Enabled := False;
        end;
    end;
end;

procedure TOPCClient.SetST1_BL_DN(Index : byte; Value : boolean);
var
  HR : HResult;
begin
  FST1_BL_DN[Index] := Value;
  if ItemHandle[100 + Index] <> 0 then
    begin
      if FST1_BL_DN[Index] then
        HR :=  WriteOPCGroupItemValue(GroupIf, ItemHandle[100 + Index], '1') else
        HR :=  WriteOPCGroupItemValue(GroupIf, ItemHandle[100 + Index], '0');
      if not Succeeded(HR) then FConnected := False;
    end;
end;

procedure TOPCClient.SetST2_BL_DN(Index : byte; Value : boolean);
var
  HR : HResult;
begin
  FST2_BL_DN[Index] := Value;
  if ItemHandle[116 + Index] <> 0 then
    begin
      if FST2_BL_DN[Index] then
        HR :=  WriteOPCGroupItemValue(GroupIf, ItemHandle[116 + Index], '1') else
        HR :=  WriteOPCGroupItemValue(GroupIf, ItemHandle[116 + Index], '0');
      if not Succeeded(HR) then FConnected := False;
    end;
end;

procedure TOPCClient.SetST1_R_DN(Index : byte; Value : boolean);
var
  HR : HResult;
begin
  FST1_R_DN[Index] := Value;
  if ItemHandle[106 + Index] <> 0 then
    begin
      if FST1_R_DN[Index] then
        HR :=  WriteOPCGroupItemValue(GroupIf, ItemHandle[106 + Index], '1') else
        HR :=  WriteOPCGroupItemValue(GroupIf, ItemHandle[106 + Index], '0');
      if not Succeeded(HR) then FConnected := False;
    end;
end;

procedure TOPCClient.SetST2_R_DN(Index : byte; Value : boolean);
var
  HR : HResult;
begin
  FST2_R_DN[Index] := Value;
  if ItemHandle[122 + Index] <> 0 then
    begin
      if FST2_R_DN[Index] then
        HR :=  WriteOPCGroupItemValue(GroupIf, ItemHandle[122 + Index], '1') else
        HR :=  WriteOPCGroupItemValue(GroupIf, ItemHandle[122 + Index], '0');
      if not Succeeded(HR) then FConnected := False;
    end;
end;

procedure TOPCClient.SetST1_BL_Zad(Index : byte; Value : single);
var
  HR : HResult;
  Zad : single;
  RezkaIni: TIniFile;
begin
  // Считываем величину коррекции
  RezkaIni := TIniFile.Create(ProgramPath + 'Rezka.ini');
  FST1_BL_Corr[Index] := 0;
  try FST1_BL_Corr[Index] := StrToFloat(RezkaIni.ReadString('Correction', 'ST1_BL' + IntToStr(Index), '0')); except end;
  RezkaIni.Free;
  // В какую сторону корректировать
  if (Value - FST1_BL_Pos[Index] < 0) then FST1_BL_Corr[Index] := FST1_BL_Corr[Index] * (-1);
  Zad := Value + FST1_BL_Corr[Index];
  if Zad < 0 then Zad := 0;
  // Запись OPC-тега
  if ItemHandle[Index] <> 0 then
    begin
      HR :=  WriteOPCGroupItemValue(GroupIf, ItemHandle[Index], IntToStr(Round(Zad * 10)));
      if not Succeeded(HR) then FConnected := False;
    end;
end;

procedure TOPCClient.SetST2_BL_Zad(Index : byte; Value : single);
var
  HR : HResult;
  Zad : single;
  RezkaIni: TIniFile;
begin
  // Считываем величину коррекции
  RezkaIni := TIniFile.Create(ProgramPath + 'Rezka.ini');
  FST2_BL_Corr[Index] := 0;
  try FST2_BL_Corr[Index] := StrToFloat(RezkaIni.ReadString('Correction', 'ST2_BL' + IntToStr(Index), '0')); except end;
  RezkaIni.Free;
  // В какую сторону корректировать
  if (Value - FST2_BL_Pos[Index] < 0) then FST2_BL_Corr[Index] := FST2_BL_Corr[Index] * (-1);
  Zad := Value + FST2_BL_Corr[Index];
  if Zad < 0 then Zad := 0;
  // Запись OPC-тега
  if ItemHandle[Index + 16] <> 0 then
    begin
      HR :=  WriteOPCGroupItemValue(GroupIf, ItemHandle[Index + 16], IntToStr(Round(Zad * 10)));
      if not Succeeded(HR) then FConnected := False;
    end;
end;

procedure TOPCClient.SetST1_R_Zad(Index : byte; Value : single);
var
  HR : HResult;
  Zad : single;
  RezkaIni: TIniFile;
begin
  // Считываем величину коррекции
  RezkaIni := TIniFile.Create(ProgramPath + 'Rezka.ini');
  FST1_R_Corr[Index] := 0;
  try FST1_R_Corr[Index] := StrToFloat(RezkaIni.ReadString('Correction', 'ST1_R' + IntToStr(Index), '0')); except end;
  RezkaIni.Free;
  // В какую сторону корректировать
  if (Value - FST1_R_Pos[Index] < 0) then FST1_R_Corr[Index] := FST1_R_Corr[Index] * (-1);
  Zad := Value + FST1_R_Corr[Index];
  if Zad < 0 then Zad := 0;
  // Запись OPC-тега
  if ItemHandle[Index + 6] <> 0 then
    begin
      HR :=  WriteOPCGroupItemValue(GroupIf, ItemHandle[Index + 6], IntToStr(Round(Zad * 10)));
      if not Succeeded(HR) then FConnected := False;
    end;
end;

procedure TOPCClient.SetST2_R_Zad(Index : byte; Value : single);
var
  HR : HResult;
  Zad : single;
  RezkaIni: TIniFile;
begin
  // Считываем величину коррекции
  RezkaIni := TIniFile.Create(ProgramPath + 'Rezka.ini');
  FST2_R_Corr[Index] := 0;
  try FST2_R_Corr[Index] := StrToFloat(RezkaIni.ReadString('Correction', 'ST2_R' + IntToStr(Index), '0')); except end;
  RezkaIni.Free;
  // В какую сторону корректировать
  if (Value - FST2_R_Pos[Index] < 0) then FST2_R_Corr[Index] := FST2_R_Corr[Index] * (-1);
  Zad := Value + FST2_R_Corr[Index];
  if Zad < 0 then Zad := 0;
  // Запись OPC-тега
  if ItemHandle[Index + 22] <> 0 then
    begin
      HR := WriteOPCGroupItemValue(GroupIf, ItemHandle[Index + 22], IntToStr(Round(Zad * 10)));
      if not Succeeded(HR) then FConnected := False;
    end;
end;

procedure TOPCClient.SetST1_BL_SetPos(Index : byte; Value : single);
var
  HR : HResult;
begin
  if ItemHandle[Index + 150] <> 0 then
    begin
      HR :=  WriteOPCGroupItemValue(GroupIf, ItemHandle[Index + 150], IntToStr(Round(Value * 10)));
      if not Succeeded(HR) then FConnected := False;
    end;
end;

procedure TOPCClient.SetST2_BL_SetPos(Index : byte; Value : single);
var
  HR : HResult;
begin
  if ItemHandle[Index + 150 + 16] <> 0 then
    begin
      HR :=  WriteOPCGroupItemValue(GroupIf, ItemHandle[Index + 150 + 16], IntToStr(Round(Value * 10)));
      if not Succeeded(HR) then FConnected := False;
    end;
end;

procedure TOPCClient.SetST1_R_SetPos(Index : byte; Value : single);
var
  HR : HResult;
begin
  if ItemHandle[Index + 150 + 6] <> 0 then
    begin
      HR :=  WriteOPCGroupItemValue(GroupIf, ItemHandle[Index + 150 + 6], IntToStr(Round(Value * 10)));
      if not Succeeded(HR) then FConnected := False;
    end;
end;

procedure TOPCClient.SetST2_R_SetPos(Index : byte; Value : single);
var
  HR : HResult;
begin
  if ItemHandle[Index + 150 + 22] <> 0 then
    begin
      HR :=  WriteOPCGroupItemValue(GroupIf, ItemHandle[Index + 150 + 22], IntToStr(Round(Value * 10)));
      if not Succeeded(HR) then FConnected := False;
    end;
end;

procedure TOPCClient.ST1_Set;
begin
  if ItemHandle[191] <> 0 then WriteOPCGroupItemValue(GroupIf, ItemHandle[191], '1');
  if ItemHandle[192] <> 0 then WriteOPCGroupItemValue(GroupIf, ItemHandle[192], '1');
  if ItemHandle[193] <> 0 then WriteOPCGroupItemValue(GroupIf, ItemHandle[193], '1');
  if ItemHandle[194] <> 0 then WriteOPCGroupItemValue(GroupIf, ItemHandle[194], '1');
end;

procedure TOPCClient.ST2_Set;
begin
  if ItemHandle[195] <> 0 then WriteOPCGroupItemValue(GroupIf, ItemHandle[195], '1');
  if ItemHandle[196] <> 0 then WriteOPCGroupItemValue(GroupIf, ItemHandle[196], '1');
  if ItemHandle[197] <> 0 then WriteOPCGroupItemValue(GroupIf, ItemHandle[197], '1');
  if ItemHandle[198] <> 0 then WriteOPCGroupItemValue(GroupIf, ItemHandle[198], '1');
end;

procedure TOPCClient.Table(Value : boolean);
begin
  if Value and (ItemHandle[199] <> 0) then WriteOPCGroupItemValue(GroupIf, ItemHandle[199], '1');
  if not Value and (ItemHandle[200] <> 0) then WriteOPCGroupItemValue(GroupIf, ItemHandle[200], '1');
end;

procedure TOPCClient.Cut;
begin
  if ItemHandle[209] <> 0 then WriteOPCGroupItemValue(GroupIf, ItemHandle[209], '1');
end;

end.
