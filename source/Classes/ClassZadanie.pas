unit ClassZadanie;

interface

uses
  SysUtils, Forms, StrUtils, IniFiles, Classes;

type
  s_array = array of single;
  b_array = array of boolean;

type
  // ������� ��� ��������� ������ �������
  TZadanieChange = procedure(Sender : TObject) of object;
  // ����� ��������� �������� ������� - ��� ������ ����������, ����������� ��������� ������� ��� ������ ������� �������
  // � ������ ������ ���������� ����� ����� ������������� ������� � ��������� ��������������� ������
  TZadanie = class(TObject)
  private
    FOnZadanieChange : TZadanieChange;
    FST1_BL_Xmin    : s_array;
    FST1_BL_Xmax    : s_array;
    FST1_BL_Xzad    : s_array;
    FST1_BL_dxL     : s_array;
    FST1_BL_dxLInv  : b_array;
    FST1_BL_Ready   : b_array;
    FST1_BL_Work    : b_array;
    FST1_BL_AltXmax : s_array;
    FST1_BL_AltXmin : s_array;
    FST1_BL_Down    : b_array;
    FST1_BL_ManSet  : b_array;
    FST1_BL_Impuls  : s_array;

    FST2_BL_Xmin    : s_array;
    FST2_BL_Xmax    : s_array;
    FST2_BL_Xzad    : s_array;
    FST2_BL_dxL     : s_array;
    FST2_BL_dxLInv  : b_array;
    FST2_BL_Ready   : b_array;
    FST2_BL_Work    : b_array;
    FST2_BL_AltXmax : s_array;
    FST2_BL_AltXmin : s_array;
    FST2_BL_Down    : b_array;
    FST2_BL_ManSet  : b_array;
    FST2_BL_Impuls  : s_array;

    FST1_R_Xmin    : s_array;
    FST1_R_Xmax    : s_array;
    FST1_R_Xzad    : s_array;
    FST1_R_dxL     : s_array;
    FST1_R_dxLInv  : b_array;
    FST1_R_Ready   : b_array;
    FST1_R_Work    : b_array;
    FST1_R_AltXmax : s_array;
    FST1_R_AltXmin : s_array;
    FST1_R_Down    : b_array;
    FST1_R_ManSet  : b_array;
    FST1_R_Impuls  : s_array;

    FST2_R_Xmin    : s_array;
    FST2_R_Xmax    : s_array;
    FST2_R_Xzad    : s_array;
    FST2_R_dxL     : s_array;
    FST2_R_dxLInv  : b_array;
    FST2_R_Ready   : b_array;
    FST2_R_Work    : b_array;
    FST2_R_AltXmax : s_array;
    FST2_R_AltXmin : s_array;
    FST2_R_Down    : b_array;
    FST2_R_ManSet  : b_array;
    FST2_R_Impuls  : s_array;

    FDetails : array[1..8] of string;

    FZadanieStr         : string;
    FZadanieName        : string;
    FZadanieErr         : boolean;
    FZadanieStatus      : string;
    FRzad               : s_array;
    FBLzad              : s_array;
    FDistributeRErr     : boolean;
    FDistributeRStatus  : string;
    FSTCountR           : byte;
    FDistributeBLErr    : boolean;
    FDistributeBLStatus : string;
    FSTCountBL          : byte;
    FActiveST           : byte;
    FDetailsStr         : string;

    // "������" � "������" ��� ������� - ��������� ��������
    function GetST1_BL_Xmin(Index : byte) : single;
    procedure SetST1_BL_Xmin(Index : byte; Value : single);
    function GetST1_BL_Xmax(Index : byte) : single;
    procedure SetST1_BL_Xmax(Index : byte; Value : single);
    function GetST1_BL_Xzad(Index : byte) : single;
    procedure SetST1_BL_Xzad(Index : byte; Value : single);
    function GetST1_BL_dxL(Index : byte) : single;
    procedure SetST1_BL_dxL(Index : byte; Value : single);
    function GetST1_BL_dxLInv(Index : byte) : boolean;
    procedure SetST1_BL_dxLInv(Index : byte; Value : boolean);
    function GetST1_BL_Ready(Index : byte) : boolean;
    procedure SetST1_BL_Ready(Index : byte; Value : boolean);
    function GetST1_BL_Work(Index : byte) : boolean;
    procedure SetST1_BL_Work(Index : byte; Value : boolean);
    function GetST1_BL_AltXmax(Index : byte) : single;
    procedure SetST1_BL_AltXmax(Index : byte; Value : single);
    function GetST1_BL_AltXmin(Index : byte) : single;
    procedure SetST1_BL_AltXmin(Index : byte; Value : single);
    function GetST1_BL_Down(Index : byte) : boolean;
    procedure SetST1_BL_Down(Index : byte; Value : boolean);
    function GetST1_BL_ManSet(Index : byte) : boolean;
    procedure SetST1_BL_ManSet(Index : byte; Value : boolean);
    function GetST1_BL_Impuls(Index : byte) : single;
    procedure SetST1_BL_Impuls(Index : byte; Value : single);

    function GetST2_BL_Xmin(Index : byte) : single;
    procedure SetST2_BL_Xmin(Index : byte; Value : single);
    function GetST2_BL_Xmax(Index : byte) : single;
    procedure SetST2_BL_Xmax(Index : byte; Value : single);
    function GetST2_BL_Xzad(Index : byte) : single;
    procedure SetST2_BL_Xzad(Index : byte; Value : single);
    function GetST2_BL_dxL(Index : byte) : single;
    procedure SetST2_BL_dxL(Index : byte; Value : single);
    function GetST2_BL_dxLInv(Index : byte) : boolean;
    procedure SetST2_BL_dxLInv(Index : byte; Value : boolean);
    function GetST2_BL_Ready(Index : byte) : boolean;
    procedure SetST2_BL_Ready(Index : byte; Value : boolean);
    function GetST2_BL_Work(Index : byte) : boolean;
    procedure SetST2_BL_Work(Index : byte; Value : boolean);
    function GetST2_BL_AltXmax(Index : byte) : single;
    procedure SetST2_BL_AltXmax(Index : byte; Value : single);
    function GetST2_BL_AltXmin(Index : byte) : single;
    procedure SetST2_BL_AltXmin(Index : byte; Value : single);
    function GetST2_BL_Down(Index : byte) : boolean;
    procedure SetST2_BL_Down(Index : byte; Value : boolean);
    function GetST2_BL_ManSet(Index : byte) : boolean;
    procedure SetST2_BL_ManSet(Index : byte; Value : boolean);
    function GetST2_BL_Impuls(Index : byte) : single;
    procedure SetST2_BL_Impuls(Index : byte; Value : single);

    function GetST1_R_Xmin(Index : byte) : single;
    procedure SetST1_R_Xmin(Index : byte; Value : single);
    function GetST1_R_Xmax(Index : byte) : single;
    procedure SetST1_R_Xmax(Index : byte; Value : single);
    function GetST1_R_Xzad(Index : byte) : single;
    procedure SetST1_R_Xzad(Index : byte; Value : single);
    function GetST1_R_dxL(Index : byte) : single;
    procedure SetST1_R_dxL(Index : byte; Value : single);
    function GetST1_R_dxLInv(Index : byte) : boolean;
    procedure SetST1_R_dxLInv(Index : byte; Value : boolean);
    function GetST1_R_Ready(Index : byte) : boolean;
    procedure SetST1_R_Ready(Index : byte; Value : boolean);
    function GetST1_R_Work(Index : byte) : boolean;
    procedure SetST1_R_Work(Index : byte; Value : boolean);
    function GetST1_R_AltXmax(Index : byte) : single;
    procedure SetST1_R_AltXmax(Index : byte; Value : single);
    function GetST1_R_AltXmin(Index : byte) : single;
    procedure SetST1_R_AltXmin(Index : byte; Value : single);
    function GetST1_R_Down(Index : byte) : boolean;
    procedure SetST1_R_Down(Index : byte; Value : boolean);
    function GetST1_R_ManSet(Index : byte) : boolean;
    procedure SetST1_R_ManSet(Index : byte; Value : boolean);
    function GetST1_R_Impuls(Index : byte) : single;
    procedure SetST1_R_Impuls(Index : byte; Value : single);

    function GetST2_R_Xmin(Index : byte) : single;
    procedure SetST2_R_Xmin(Index : byte; Value : single);
    function GetST2_R_Xmax(Index : byte) : single;
    procedure SetST2_R_Xmax(Index : byte; Value : single);
    function GetST2_R_Xzad(Index : byte) : single;
    procedure SetST2_R_Xzad(Index : byte; Value : single);
    function GetST2_R_dxL(Index : byte) : single;
    procedure SetST2_R_dxL(Index : byte; Value : single);
    function GetST2_R_dxLInv(Index : byte) : boolean;
    procedure SetST2_R_dxLInv(Index : byte; Value : boolean);
    function GetST2_R_Ready(Index : byte) : boolean;
    procedure SetST2_R_Ready(Index : byte; Value : boolean);
    function GetST2_R_Work(Index : byte) : boolean;
    procedure SetST2_R_Work(Index : byte; Value : boolean);
    function GetST2_R_AltXmax(Index : byte) : single;
    procedure SetST2_R_AltXmax(Index : byte; Value : single);
    function GetST2_R_AltXmin(Index : byte) : single;
    procedure SetST2_R_AltXmin(Index : byte; Value : single);
    function GetST2_R_Down(Index : byte) : boolean;
    procedure SetST2_R_Down(Index : byte; Value : boolean);
    function GetST2_R_ManSet(Index : byte) : boolean;
    procedure SetST2_R_ManSet(Index : byte; Value : boolean);
    function GetST2_R_Impuls(Index : byte) : single;
    procedure SetST2_R_Impuls(Index : byte; Value : single);

    function GetDetails(Index : byte) : string;
    procedure SetDetails(Index : byte; Value : string);

    function GetRzad(Index : byte) : single;
    function GetBLzad(Index : byte) : single;
    // ����� ������� �� �������� ������� ������ - ����������� ����� ���������� �������������
    procedure ResetPosR1(Max : boolean);
    // ����� ������� �� ����� ������� ������ - ����������� ����� ���������� �������������
    procedure ResetPosBL1(Max : boolean);
    // ����� ������� �� �������� ������� ������ - ����������� ����� ���������� �������������
    procedure ResetPosR2(Max : boolean);
    // ����� ������� �� ����� ������� ������ - ����������� ����� ���������� �������������
    procedure ResetPosBL2(Max : boolean);
    // ������ ������ �������
    procedure SetZadanieStr(Value : string);
    // ������ ������ ���������
    procedure SetDetailsStr(Value : string);
    function GetDistributeStatus : string;
    function Distribute(var ZAD : s_array; var ST1Xmin, ST1Xmax, ST1AltXmax, ST1AltXmin, ST1Xzad, ST1dxL : s_array; var ST1Ready, ST1Work, ST1dxLInv, ST1ManSet, ST1Down : b_array;
                                           var ST2Xmin, ST2Xmax, ST2AltXmax, ST2AltXmin, ST2Xzad, ST2dxL : s_array; var ST2Ready, ST2Work, ST2dxLInv, ST2ManSet, ST2Down : b_array; var STCount : byte; AltSize : boolean) : boolean;
    function GetRzadCount : byte;
    function GetBLzadCount : byte;
  protected
  public
    constructor Create;
    // �������� ��������� �� ini-�����
    procedure ReloadIni;
    // ������������ ������� �� ������ ������
    procedure DistributeST1R;
    // ������������ ���� �� ������ ������
    procedure DistributeST1BL;
    // ������������ ������� �� ������ ������
    procedure DistributeST2R;
    // ������������ ���� �� ������ ������
    procedure DistributeST2BL;
    // ������� ��� ��������� ������ �������
    property OnZadanieChange : TZadanieChange read FOnZadanieChange write FOnZadanieChange;
    // ������ 1, ����, ����������� ��������
    property ST1_BL_Xmin[Index : byte] : single read GetST1_BL_Xmin write SetST1_BL_Xmin;
    // ������ 1, ����, ������������ ��������
    property ST1_BL_Xmax[Index : byte] : single read GetST1_BL_Xmax write SetST1_BL_Xmax;
    // ������ 1, ����, �������� ��������
    property ST1_BL_Xzad[Index : byte] : single read GetST1_BL_Xzad write SetST1_BL_Xzad;
    // ������ 1, ����, ������ �����
    property ST1_BL_dxL[Index : byte] : single read GetST1_BL_dxL write SetST1_BL_dxL;
    // ������ 1, ����, ������ ����� ��������� => ������ ������
    property ST1_BL_dxLInv[Index : byte] : boolean read GetST1_BL_dxLInv write SetST1_BL_dxLInv;
    // ������ 1, ����, ����� � ������ = ��������
    property ST1_BL_Ready[Index : byte] : boolean read GetST1_BL_Ready write SetST1_BL_Ready;
    // ������ 1, ����, � ������ = �����������
    property ST1_BL_Work[Index : byte] : boolean read GetST1_BL_Work write SetST1_BL_Work;
    // ������ 1, ����, �������������� ����������� �����������
    property ST1_BL_AltXmax[Index : byte] : single read GetST1_BL_AltXmax write SetST1_BL_AltXmax;
    // ������ 1, ����, �������������� ������������ �����������
    property ST1_BL_AltXmin[Index : byte] : single read GetST1_BL_AltXmin write SetST1_BL_AltXmin;
    // ������ 1, ����, ������
    property ST1_BL_Down[Index : byte] : boolean read GetST1_BL_Down write SetST1_BL_Down;
    // ������ 1, ����, ����������� ������� - ������ �� ����� �� �������
    property ST1_BL_ManSet[Index : byte] : boolean read GetST1_BL_ManSet write SetST1_BL_ManSet;
    // ������ 1, ����, �������� ����������� �����������
    property ST1_BL_Impuls[Index : byte] : single read GetST1_BL_Impuls write SetST1_BL_Impuls;

    // ������ 2, ����, �������� ����������
    property ST2_BL_Xmin[Index : byte] : single read GetST2_BL_Xmin write SetST2_BL_Xmin;
    property ST2_BL_Xmax[Index : byte] : single read GetST2_BL_Xmax write SetST2_BL_Xmax;
    property ST2_BL_Xzad[Index : byte] : single read GetST2_BL_Xzad write SetST2_BL_Xzad;
    property ST2_BL_dxL[Index : byte] : single read GetST2_BL_dxL write SetST2_BL_dxL;
    property ST2_BL_dxLInv[Index : byte] : boolean read GetST2_BL_dxLInv write SetST2_BL_dxLInv;
    property ST2_BL_Ready[Index : byte] : boolean read GetST2_BL_Ready write SetST2_BL_Ready;
    property ST2_BL_Work[Index : byte] : boolean read GetST2_BL_Work write SetST2_BL_Work;
    property ST2_BL_AltXmax[Index : byte] : single read GetST2_BL_AltXmax write SetST2_BL_AltXmax;
    property ST2_BL_AltXmin[Index : byte] : single read GetST2_BL_AltXmin write SetST2_BL_AltXmin;
    property ST2_BL_Down[Index : byte] : boolean read GetST2_BL_Down write SetST2_BL_Down;
    property ST2_BL_ManSet[Index : byte] : boolean read GetST2_BL_ManSet write SetST2_BL_ManSet;
    property ST2_BL_Impuls[Index : byte] : single read GetST2_BL_Impuls write SetST2_BL_Impuls;
    // ������ 1, �������, �������� ����������
    property ST1_R_Xmin[Index : byte] : single read GetST1_R_Xmin write SetST1_R_Xmin;
    property ST1_R_Xmax[Index : byte] : single read GetST1_R_Xmax write SetST1_R_Xmax;
    property ST1_R_Xzad[Index : byte] : single read GetST1_R_Xzad write SetST1_R_Xzad;
    property ST1_R_dxL[Index : byte] : single read GetST1_R_dxL write SetST1_R_dxL;
    property ST1_R_dxLInv[Index : byte] : boolean read GetST1_R_dxLInv write SetST1_R_dxLInv;
    property ST1_R_Ready[Index : byte] : boolean read GetST1_R_Ready write SetST1_R_Ready;
    property ST1_R_Work[Index : byte] : boolean read GetST1_R_Work write SetST1_R_Work;
    property ST1_R_AltXmax[Index : byte] : single read GetST1_R_AltXmax write SetST1_R_AltXmax;
    property ST1_R_AltXmin[Index : byte] : single read GetST1_R_AltXmin write SetST1_R_AltXmin;
    property ST1_R_Down[Index : byte] : boolean read GetST1_R_Down write SetST1_R_Down;
    property ST1_R_ManSet[Index : byte] : boolean read GetST1_R_ManSet write SetST1_R_ManSet;
    property ST1_R_Impuls[Index : byte] : single read GetST1_R_Impuls write SetST1_R_Impuls;
    // ������ 2, �������, �������� ����������
    property ST2_R_Xmin[Index : byte] : single read GetST2_R_Xmin write SetST2_R_Xmin;
    property ST2_R_Xmax[Index : byte] : single read GetST2_R_Xmax write SetST2_R_Xmax;
    property ST2_R_Xzad[Index : byte] : single read GetST2_R_Xzad write SetST2_R_Xzad;
    property ST2_R_dxL[Index : byte] : single read GetST2_R_dxL write SetST2_R_dxL;
    property ST2_R_dxLInv[Index : byte] : boolean read GetST2_R_dxLInv write SetST2_R_dxLInv;
    property ST2_R_Ready[Index : byte] : boolean read GetST2_R_Ready write SetST2_R_Ready;
    property ST2_R_Work[Index : byte] : boolean read GetST2_R_Work write SetST2_R_Work;
    property ST2_R_AltXmax[Index : byte] : single read GetST2_R_AltXmax write SetST2_R_AltXmax;
    property ST2_R_AltXmin[Index : byte] : single read GetST2_R_AltXmin write SetST2_R_AltXmin;
    property ST2_R_Down[Index : byte] : boolean read GetST2_R_Down write SetST2_R_Down;
    property ST2_R_ManSet[Index : byte] : boolean read GetST2_R_ManSet write SetST2_R_ManSet;
    property ST2_R_Impuls[Index : byte] : single read GetST2_R_Impuls write SetST2_R_Impuls;
    // ������ ������� � ������ �������
    property Rzad[Index : byte] : single read GetRzad;
    // ������ ����� � ������ �������
    property BLzad[Index : byte] : single read GetBLzad;
    // ������ �������
    property ZadanieStr         : string read FZadanieStr write SetZadanieStr;
    // �������� ������� (�����)
    property ZadanieName        : string read FZadanieName write FZadanieName;
    // ��������� ������� ������ �������
    property ZadanieErr         : boolean read FZadanieErr;
    // ��������� �������� ���������� ������� ������ �������
    property ZadanieStatus      : string read FZadanieStatus;
    // ��������� ������������� ������� ������� �� ������ �������
    property DistributeRErr     : boolean read FDistributeRErr;
    // ��������� �������� ���������� ������������� ������� �� ������� ������ �������
    property DistributeRStatus  : string read FDistributeRStatus;
    // ���������� �������, �� ������� ������������ �������
    property STCountR           : byte read FSTCountR;
    // ��������� ������������� ������� ����� �� ������ �������
    property DistributeBLErr    : boolean read FDistributeBLErr;
    // ��������� �������� ���������� ������������� ������� ����� �� ������ �������
    property DistributeBLStatus : string read FDistributeBLStatus;
    // ���������� �������, �� ������� ������������ ����
    property STCountBL          : byte read FSTCountBL;
    // ��������� �������� ���������� ������������� ����� � ������� �� ������ �������
    property DistributeStatus   : string read GetDistributeStatus;
    // ��������� ����� � �������
    property BLzadCount         : byte read GetBLzadCount;
    // ��������� ������� � �������
    property RzadCount          : byte read GetRzadCount;
    // �� ����� ������ ������������ �������
    property ActiveST           : byte read FActiveST;
    // ������, ���������� ������ ���������, ��������������� �������
    property DetailsStr         : string read FDetailsStr write SetDetailsStr;
    // ������ ������� ���������, ��������������� �������
    property Details[Index : byte] : string read GetDetails write SetDetails;
  end;

implementation

constructor TZadanie.Create;
var
  i : byte;
begin
  // ������������� ��������
  SetLength(FST1_BL_Xmin,    7);
  SetLength(FST1_BL_Xmax,    7);
  SetLength(FST1_BL_Xzad,    7);
  SetLength(FST1_BL_dxL,     7);
  SetLength(FST1_BL_dxLInv,  7);
  SetLength(FST1_BL_Ready,   7);
  SetLength(FST1_BL_Work,    7);
  SetLength(FST1_BL_AltXmax, 7);
  SetLength(FST1_BL_AltXmin, 7);
  SetLength(FST1_BL_Down,    7);
  SetLength(FST1_BL_ManSet,  7);
  SetLength(FST1_BL_Impuls,  7);

  SetLength(FST2_BL_Xmin,    7);
  SetLength(FST2_BL_Xmax,    7);
  SetLength(FST2_BL_Xzad,    7);
  SetLength(FST2_BL_dxL,     7);
  SetLength(FST2_BL_dxLInv,  7);
  SetLength(FST2_BL_Ready,   7);
  SetLength(FST2_BL_Work,    7);
  SetLength(FST2_BL_AltXmax, 7);
  SetLength(FST2_BL_AltXmin, 7);
  SetLength(FST2_BL_Down,    7);
  SetLength(FST2_BL_ManSet,  7);
  SetLength(FST2_BL_Impuls,  7);

  SetLength(FST1_R_Xmin,    11);
  SetLength(FST1_R_Xmax,    11);
  SetLength(FST1_R_Xzad,    11);
  SetLength(FST1_R_dxL,     11);
  SetLength(FST1_R_dxLInv,  11);
  SetLength(FST1_R_Ready,   11);
  SetLength(FST1_R_Work,    11);
  SetLength(FST1_R_AltXmax, 11);
  SetLength(FST1_R_AltXmin, 11);
  SetLength(FST1_R_Down,    11);
  SetLength(FST1_R_ManSet,  11);
  SetLength(FST1_R_Impuls,  11);

  SetLength(FST2_R_Xmin,    11);
  SetLength(FST2_R_Xmax,    11);
  SetLength(FST2_R_Xzad,    11);
  SetLength(FST2_R_dxL,     11);
  SetLength(FST2_R_dxLInv,  11);
  SetLength(FST2_R_Ready,   11);
  SetLength(FST2_R_Work,    11);
  SetLength(FST2_R_AltXmax, 11);
  SetLength(FST2_R_AltXmin, 11);
  SetLength(FST2_R_Down,    11);
  SetLength(FST2_R_ManSet,  11);
  SetLength(FST2_R_Impuls,  11);
  FZadanieErr := True;
  FDistributeRErr := True;
  FDistributeBLErr := True;
  for i := 1 to 10 do
    begin
      FST1_R_Work[i]     := False;
      FST1_R_Down[i]     := False;
      FST1_R_ManSet[i]   := False;
      FST2_R_Work[i]     := False;
      FST2_R_Down[i]     := False;
      FST2_R_ManSet[i]   := False;
    end;
  for i := 1 to 6 do
    begin
      FST1_BL_Work[i]    := False;
      FST1_BL_Down[i]    := False;
      FST1_BL_ManSet[i]  := False;
      FST2_BL_Work[i]    := False;
      FST2_BL_Down[i]    := False;
      FST2_BL_ManSet[i]  := False;
    end;
  // ������ ��������
  ReloadIni;
  // ������������� �������� ��������
  ResetPosR1(False);
  ResetPosBL1(False);
  ResetPosR2(False);
  ResetPosBL2(False);
  FActiveST := 0;
end;

// ������ ������ �������
procedure TZadanie.SetZadanieStr(Value : string);
var
  Z, TempString : string;
  n, L, p, k : integer;
  t : single;
  RepF : TReplaceFlags;
begin
  FZadanieStr := Value;
  // ������� ������� �������
  while Pos('  ', FZadanieStr) <> 0 do FZadanieStr := StringReplace(FZadanieStr, '  ', ' ', RepF);
  FZadanieErr := Length(FZadanieStr) < 2;
  if FZadanieErr then FZadanieStatus := '��� ������ �������.' else
    begin
      SetLength(FRzad, 1);
      SetLength(FBLzad, 1);
      // ��������� � ������� ������� � �������� ������� ����� �� ���������, ����� �� �������
      FZadanieStr := AnsiUpperCase(FZadanieStr);
      RepF := [rfReplaceAll, rfIgnoreCase];
      FZadanieStr := StringReplace(FZadanieStr, '.', ',', RepF);
      FZadanieStr := StringReplace(FZadanieStr, '�', 'H', RepF);
      FZadanieStr := StringReplace(FZadanieStr, '�', 'P', RepF);
      FZadanieStr := Trim(FZadanieStr);
      Z := FZadanieStr + ' ';
      // �������� ���� �������
      while (Length(Z) > 0) and (Pos(' ', Z) > 0) do
        begin
          n := Pos(' ', Z);
          TempString := LeftStr(Z, n - 1);
          Delete(Z, 1, n);
          // ����� ������� - ������� � ������
          if TempString[1] = 'P' then
            begin
              TempString := RightStr(TempString, Length(TempString) - 1);
              try
                L := High(FRzad) + 1;
                SetLength(FRzad, L + 1);
                FRzad[L] := StrToFloat(TempString);
              except
                FZadanieErr := True;
              end;
            end else
          // ����� ��� - ������� � ������
          if TempString[1] = 'H' then
            begin
              TempString := RightStr(TempString, Length(TempString) - 1);
              try
                L := High(FBLzad) + 1;
                SetLength(FBLzad, L + 1);
                FBLzad[L] := StrToFloat(TempString);
              except
                FZadanieErr := True;
              end;
            end else FZadanieErr := True;
        end;
      // ���� ��������� ������ �������
      if not FZadanieErr then
        begin
          repeat //���������� ������� �������
          p := 0;
          for k := 1 to High(FRzad) - 1 do if FRzad[k] > FRzad[k + 1] then
            begin
              t := FRzad[k];
              FRzad[k] := FRzad[k + 1];
              FRzad[k + 1] := t;
              p := p + 1;
            end;
          until p = 0;
          repeat //���������� ������� �����
          p := 0;
          for k := 1 to High(FBLzad) - 1 do if FBLzad[k] > FBLzad[k + 1] then
            begin
              t := FBLzad[k];
              FBLzad[k] := FBLzad[k + 1];
              FBLzad[k + 1] := t;
              p := p + 1;
            end;
          until p = 0;
          if (High(FRzad) > 20) or (High(FBLzad) > 12) then
            begin
              FZadanieErr := True;
              FZadanieStatus := '������� ����� ����� ��� �������';
            end else FZadanieStatus := '������ ������� �������';
        end else FZadanieStatus := '������������ ������� � ������ �������';
      FDistributeRErr := True;
      FDistributeBLErr := True;
      // ������������� ��������
      for n := 1 to 10 do
        begin
          FST1_R_ManSet[n] := False;
          FST1_R_Work[n] := False;
          FST2_R_ManSet[n] := False;
          FST2_R_Work[n] := False;
        end;
      for n := 1 to 6 do
        begin
          FST1_BL_ManSet[n] := False;
          FST1_BL_Work[n] := False;
          FST2_BL_ManSet[n] := False;
          FST2_BL_Work[n] := False;
        end;
      // ��������� ������� - ����� �������
//      if Assigned(FOnZadanieChange) then FOnZadanieChange(Self);
    end;
  if Assigned(FOnZadanieChange) then FOnZadanieChange(Self);    
  FActiveST := 0;
end;

// ����� ������� �� �������� ������� ������ - ����������� ����� ���������� �������������
procedure TZadanie.ResetPosR1(Max : boolean);
var
  i : byte;
begin
  for i := 1 to 10 do
    begin
      if (not FST1_R_ManSet[i]) and (not FST1_R_Down[i]) then
        begin
          FST1_R_Work[i] := False;
          if Max then FST1_R_Xzad[i] := FST1_R_Xmax[i] else FST1_R_Xzad[i] := (11 - i) * 250;
          if FST1_R_Xzad[i] > FST1_R_Xmax[i] then FST1_R_Xzad[i] := FST1_R_Xmax[i];
          if FST1_R_Xzad[i] < FST1_R_Xmin[i] then FST1_R_Xzad[i] := FST1_R_Xmin[i];
        end;
    end;
end;

// ����� ������� �� �������� ������� ������ - ����������� ����� ���������� �������������
procedure TZadanie.ResetPosR2(Max : boolean);
var
  i : byte;
begin
  for i := 1 to 10 do
    begin
      if (not FST2_R_ManSet[i]) and (not FST2_R_Down[i]) then
        begin
          FST2_R_Work[i] := False;
          if Max then FST2_R_Xzad[i] := FST2_R_Xmax[i] else FST2_R_Xzad[i] := (11 - i) * 250;
          if FST2_R_Xzad[i] > FST2_R_Xmax[i] then FST2_R_Xzad[i] := FST2_R_Xmax[i];
          if FST2_R_Xzad[i] < FST2_R_Xmin[i] then FST2_R_Xzad[i] := FST2_R_Xmin[i];
        end;
    end;
end;

// ����� ������� �� ����� ������� ������ - ����������� ����� ���������� �������������
procedure TZadanie.ResetPosBL1(Max : boolean);
var
  i : byte;
begin
  for i := 1 to 6 do
    begin
      if (not FST1_BL_ManSet[i]) and (not FST1_BL_Down[i]) then
        begin
          FST1_BL_Work[i] := False;
          if Max then FST1_BL_Xzad[i] := FST1_BL_Xmax[i] else FST1_BL_Xzad[i] := (7 - i) * 400;
          if FST1_BL_Xzad[i] > FST1_BL_Xmax[i] then FST1_BL_Xzad[i] := FST1_BL_Xmax[i];
          if FST1_BL_Xzad[i] < FST1_BL_Xmin[i] then FST1_BL_Xzad[i] := FST1_BL_Xmin[i];
        end;
    end;
end;

// ����� ������� �� ����� ������� ������ - ����������� ����� ���������� �������������
procedure TZadanie.ResetPosBL2(Max : boolean);
var
  i : byte;
begin
  for i := 1 to 6 do
    begin
      if (not FST2_BL_ManSet[i]) and (not FST2_BL_Down[i]) then
        begin
          FST2_BL_Work[i] := False;
          if Max then FST2_BL_Xzad[i] := FST2_BL_Xmax[i] else FST2_BL_Xzad[i] := (7 - i) * 400;
          if FST2_BL_Xzad[i] > FST2_BL_Xmax[i] then FST2_BL_Xzad[i] := FST2_BL_Xmax[i];
          if FST2_BL_Xzad[i] < FST2_BL_Xmin[i] then FST2_BL_Xzad[i] := FST2_BL_Xmin[i];
        end;
    end;
end;

// ������ ��������
procedure TZadanie.ReloadIni;
var
  i : integer;
  RezkaIni: TIniFile;
  ProgramPath : string;
begin
  ProgramPath := ExtractFilePath(Application.EXEName);
  RezkaIni := TIniFile.Create(ProgramPath + 'Rezka.ini');
    for i := 1 to 10 do
    begin
      FST1_R_Ready[i] := RezkaIni.ReadString('Ready', 'ST1_R' + IntToStr(i), '1') <> '0';
      FST2_R_Ready[i] := RezkaIni.ReadString('Ready', 'ST2_R' + IntToStr(i), '1') <> '0';
      FST1_R_dxLInv[i] := RezkaIni.ReadString('dxLInv', 'ST1_R' + IntToStr(i), '0') <> '0';
      FST2_R_dxLInv[i] := RezkaIni.ReadString('dxLInv', 'ST2_R' + IntToStr(i), '0') <> '0';
      FST1_R_Xmin[i] := 0;
      FST1_R_Xmax[i] := 0;
      try FST1_R_Xmin[i] := StrToFloat(RezkaIni.ReadString('Min', 'ST1_R' + IntToStr(i), '0')); except end;
      try FST1_R_Xmax[i] := StrToFloat(RezkaIni.ReadString('Max', 'ST1_R' + IntToStr(i), '0')); except end;
      FST1_R_AltXmax[i] := 0;
      FST1_R_AltXmin[i] := 0;
      try FST1_R_AltXmax[i] := StrToFloat(RezkaIni.ReadString('AltMax', 'ST1_R' + IntToStr(i), '0')); except end;
      try FST1_R_AltXmin[i] := StrToFloat(RezkaIni.ReadString('AltMin', 'ST1_R' + IntToStr(i), '0')); except end;
      FST2_R_Xmin[i] := 0;
      FST2_R_Xmax[i] := 0;
      try FST2_R_Xmin[i] := StrToFloat(RezkaIni.ReadString('Min', 'ST2_R' + IntToStr(i), '0')); except end;
      try FST2_R_Xmax[i] := StrToFloat(RezkaIni.ReadString('Max', 'ST2_R' + IntToStr(i), '0')); except end;
      FST2_R_AltXmax[i] := 0;
      FST2_R_AltXmin[i] := 0;
      try FST2_R_AltXmax[i] := StrToFloat(RezkaIni.ReadString('AltMax', 'ST2_R' + IntToStr(i), '0')); except end;
      try FST2_R_AltXmin[i] := StrToFloat(RezkaIni.ReadString('AltMin', 'ST2_R' + IntToStr(i), '0')); except end;
      try FST1_R_dxL[i] := StrToFloat(RezkaIni.ReadString('dxL', 'ST1_R' + IntToStr(i), '0')); except end;
      try FST2_R_dxL[i] := StrToFloat(RezkaIni.ReadString('dxL', 'ST2_R' + IntToStr(i), '0')); except end;
      FST1_R_Impuls[i] := 0;
      try FST1_R_Impuls[i] := StrToFloat(RezkaIni.ReadString('Impuls', 'ST1_R' + IntToStr(i), '0')); except end;
      FST2_R_Impuls[i] := 0;
      try FST2_R_Impuls[i] := StrToFloat(RezkaIni.ReadString('Impuls', 'ST2_R' + IntToStr(i), '0')); except end;
    end;
    for i := 1 to 6 do
    begin
      FST1_BL_Ready[i] := RezkaIni.ReadString('Ready', 'ST1_BL' + IntToStr(i), '1') <> '0';
      FST2_BL_Ready[i] := RezkaIni.ReadString('Ready', 'ST2_BL' + IntToStr(i), '1') <> '0';
      FST1_BL_dxLInv[i] := RezkaIni.ReadString('dxLInv', 'ST1_BL' + IntToStr(i), '0') <> '0';
      FST2_BL_dxLInv[i] := RezkaIni.ReadString('dxLInv', 'ST2_BL' + IntToStr(i), '0') <> '0';
      FST1_BL_Xmin[i] := 0;
      FST1_BL_Xmax[i] := 0;
      try FST1_BL_Xmin[i] := StrToFloat(RezkaIni.ReadString('Min', 'ST1_BL' + IntToStr(i), '0')); except end;
      try FST1_BL_Xmax[i] := StrToFloat(RezkaIni.ReadString('Max', 'ST1_BL' + IntToStr(i), '0')); except end;
      FST1_BL_AltXmax[i] := 0;
      FST1_BL_AltXmin[i] := 0;
      try FST1_BL_AltXmax[i] := StrToFloat(RezkaIni.ReadString('AltMax', 'ST1_BL' + IntToStr(i), '0')); except end;
      try FST1_BL_AltXmin[i] := StrToFloat(RezkaIni.ReadString('AltMin', 'ST1_BL' + IntToStr(i), '0')); except end;
      FST2_BL_Xmin[i] := 0;
      FST2_BL_Xmax[i] := 0;
      try FST2_BL_Xmin[i] := StrToFloat(RezkaIni.ReadString('Min', 'ST2_BL' + IntToStr(i), '0')); except end;
      try FST2_BL_Xmax[i] := StrToFloat(RezkaIni.ReadString('Max', 'ST2_BL' + IntToStr(i), '0')); except end;
      FST2_BL_AltXmax[i] := 0;
      FST2_BL_AltXmin[i] := 0;
      try FST2_BL_AltXmax[i] := StrToFloat(RezkaIni.ReadString('AltMax', 'ST2_BL' + IntToStr(i), '0')); except end;
      try FST2_BL_AltXmin[i] := StrToFloat(RezkaIni.ReadString('AltMin', 'ST2_BL' + IntToStr(i), '0')); except end;
      try FST1_BL_dxL[i] := StrToFloat(RezkaIni.ReadString('dxL', 'ST1_BL' + IntToStr(i), '0')); except end;
      try FST2_BL_dxL[i] := StrToFloat(RezkaIni.ReadString('dxL', 'ST2_BL' + IntToStr(i), '0')); except end;
      FST1_BL_Impuls[i] := 0;
      try FST1_BL_Impuls[i] := StrToFloat(RezkaIni.ReadString('Impuls', 'ST1_BL' + IntToStr(i), '0')); except end;
      FST2_BL_Impuls[i] := 0;
      try FST2_BL_Impuls[i] := StrToFloat(RezkaIni.ReadString('Impuls', 'ST2_BL' + IntToStr(i), '0')); except end;
    end;
  RezkaIni.Free;
end;

// ��������� �������������, ������������� ��� ����� � �������
function TZadanie.Distribute(var ZAD : s_array; var ST1Xmin, ST1Xmax, ST1AltXmax, ST1AltXmin, ST1Xzad, ST1dxL : s_array; var ST1Ready, ST1Work, ST1dxLInv, ST1ManSet, ST1Down : b_array;
                                                var ST2Xmin, ST2Xmax, ST2AltXmax, ST2AltXmin, ST2Xzad, ST2dxL : s_array; var ST2Ready, ST2Work, ST2dxLInv, ST2ManSet, ST2Down : b_array; var STCount : byte; AltSize : boolean) : boolean;
var
  i, j1, j2, Max, NeighbDist : integer;
  ZadSet : boolean;
  Cond1, Cond2, Cond3, CondJ1, CondJMax, CondMaxMove, Neighbour : boolean;
begin
  if High(ZAD) < 1 then
    begin
      Result := False;
      Exit;
    end;
  Max := High(ST1Xmin);
  // ������� ��������, ��������������� �������� ��������� �����, �������
  if Max = 10 then NeighbDist := 240 else NeighbDist := 300;
  // ��� ������������� ����� ������� ������� ������� ������������ ������� � ������� ����������
  if Max = 6 then
    begin
      if (High(ZAD) > 0) and (ZAD[1] <= ST1Xmax[6]) and (ZAD[1] >= ST1Xmin[6]) then
        begin
          ST1Xzad[6] := ZAD[1];
          ST1ManSet[6] := True;
        end;
      if (High(ZAD) > 0) and (ZAD[1] <= ST1Xmax[1]) and (ZAD[1] >= ST1Xmin[1]) then
        begin
          ST1Xzad[1] := ZAD[1];
          ST1ManSet[1] := True;
        end;
      if (High(ZAD) > 1) and (ZAD[High(ZAD)] <= ST1Xmax[1]) and (ZAD[High(ZAD)] >= ST1Xmin[1]) then
        begin
          ST1Xzad[1] := ZAD[High(ZAD)];
          ST1ManSet[1] := True;
        end;
    end;
  ZadSet := False;
  // �������� ���� ��������� �������������
  for i := 1 to High(ZAD) do
    begin
      ZadSet := False;
      if (High(ZAD) > 1) and (i <= High(ZAD) - 1) and (ZAD[i + 1] - ZAD[i] < NeighbDist) then Neighbour := True else Neighbour := False;
      for j1 := Max downto 1 do if (ST1ManSet[j1] or ST1Down[j1]) and (ST1Xzad[j1] = ZAD[i]) then
        begin
          ST1Work[j1] := True;
          ZadSet := True;
        end;
      if not ZadSet then for j1 := Max downto 1 do if (not ZadSet) and (not ST1Down[j1]) and ST1Ready[j1] and (not ST1Work[j1]) and (not ST1ManSet[j1]) then
        begin
          if not AltSize then Cond1 := ((ZAD[i] <= ST1Xmax[j1]) and (ZAD[i] >= ST1Xmin[j1])) else Cond1 := ((ZAD[i] <= ST1AltXmax[j1]) and (ZAD[i] >= ST1AltXmin[j1]));
          if not AltSize then Cond2 := ((ZAD[i + 1] <= ST1Xmax[j1 - 1]) and (ZAD[i + 1] >= ST1Xmin[j1 - 1])) else Cond2 := ((ZAD[i + 1] <= ST1AltXmax[j1 - 1]) and (ZAD[i + 1] >= ST1AltXmin[j1 - 1]));
          CondJ1 := (j1 = 1);
          CondJMax := (j1 = Max);
          CondMaxMove := (ZAD[i] <= (ST1Xmin[j1] + ST1Xmax[j1]) / 2 + 400) and (ZAD[i] >= (ST1Xmin[j1] + ST1Xmax[j1]) / 2 - 400);
          if ST1dxLInv[j1 + 1] then Cond3 := (ZAD[i] >= (ST1Xzad[j1 + 1] + ST1dxL[j1 + 1] + ST1dxL[j1])) else Cond3 := (ZAD[i] >= (ST1Xzad[j1 + 1] + ST1dxL[j1]));
          if (((not CondJMax) and Cond3) or CondJMax) and ((CondJ1 and Cond1) or ((not CondJ1) and Cond1) and (Neighbour and Cond2 or (not Neighbour))) and CondMaxMove then
            begin
              ST1Xzad[j1] := ZAD[i];
              ST1Work[j1] := True;
              ZadSet := True;
            end else
            begin
              if j1 = Max then ST1Xzad[j1] := ST1Xmin[j1];
              if (j1 > 1) and (j1 < Max) then
                begin
                  if (ST1Xzad[j1 + 1] = ST1Xmin[j1 + 1]) then ST1Xzad[j1] := ST1Xmin[j1] else
                    if ST1dxLInv[j1 + 1] then ST1Xzad[j1] := ST1Xzad[j1 + 1] + ST1dxL[j1 + 1] + ST1dxL[j1] else ST1Xzad[j1] := ST1Xzad[j1 + 1] + ST1dxL[j1];
                  if ST1Xzad[j1] < ST1Xmin[j1] then ST1Xzad[j1] := ST1Xmin[j1];
                  if ST1Xzad[j1] > ST1Xmax[j1] then ST1Xzad[j1] := ST1Xmax[j1];
                end;
            end;
        end;
      // ���� �� ������� ������������ �� ���� ������, �������� ������������ �� ������
      if not ZadSet then for j2 := Max downto 1 do
        if (not ZadSet) and (not ST2Down[j2]) and ST2Ready[j2] and (not ST2Work[j2]) and (not ST2ManSet[j2]) and (ZAD[i] <= ST2Xmax[j2]) and (ZAD[i] >= ST2Xmin[j2]) and (ZAD[i] <= (ST2Xmin[j2] + ST2Xmax[j2]) /2 + 400) and (ZAD[i] >= (ST2Xmin[j2] + ST2Xmax[j2]) /2 - 400) then
          begin
            ST2Xzad[j2] := ZAD[i];
            ST2Work[j2] := True;
            STCount := 2;
            ZadSet := True;
          end;
    end;
  // �������������� ��������� ������ � ������������� ���������
  for i := 2 to Max - 1 do if (not ST1Work[i]) and (not ST1Down[i]) then
    begin
      if ST1dxLInv[i + 1] then ST1Xzad[i] := (ST1Xzad[i - 1] + ST1Xzad[i + 1] + ST1dxL[i + 1]) / 2 else  ST1Xzad[i] := (ST1Xzad[i - 1] + ST1Xzad[i + 1]) / 2;
      if ST1Xzad[i] > ST1Xzad[i - 1] - ST1dxL[i - 1] then ST1Xzad[i] := ST1Xzad[i - 1] - ST1dxL[i - 1];
      if ST1Xzad[i] < ST1Xmin[i] then ST1Xzad[i] := ST1Xmin[i];
      if ST1Xzad[i] > ST1Xmax[i] then ST1Xzad[i] := ST1Xmax[i];
    end;
  for i := 2 to Max - 1 do if (not ST2Work[i]) and (not ST2Down[i]) then
    begin
      if ST2dxLInv[i + 1] then ST2Xzad[i] := (ST2Xzad[i - 1] + ST2Xzad[i + 1] + ST2dxL[i + 1]) / 2 else  ST2Xzad[i] := (ST2Xzad[i - 1] + ST2Xzad[i + 1]) / 2;
      if ST2Xzad[i] > ST2Xzad[i - 1] - ST2dxL[i - 1] then ST2Xzad[i] := ST2Xzad[i - 1] - ST2dxL[i - 1];
      if ST2Xzad[i] < ST2Xmin[i] then ST2Xzad[i] := ST2Xmin[i];
      if ST2Xzad[i] > ST2Xmax[i] then ST2Xzad[i] := ST2Xmax[i];
    end;
  Result := not ZadSet;
end;

// ������������ ������� �� ������ ������
procedure TZadanie.DistributeST1R;
begin
  if not FZadanieErr then
    begin
      FSTCountR := 1;
      ResetPosR1(True);
//      ResetPosR1(False);
      ResetPosR2(False);
      FDistributeRErr := Distribute(FRzad, FST1_R_Xmin, FST1_R_Xmax, FST1_R_AltXmax, FST1_R_AltXmin, FST1_R_Xzad, FST1_R_dxL, FST1_R_Ready, FST1_R_Work, FST1_R_dxLInv, FST1_R_ManSet, FST1_R_Down,
                                           FST2_R_Xmin, FST2_R_Xmax, FST2_R_AltXmax, FST2_R_AltXmin, FST2_R_Xzad, FST2_R_dxL, FST2_R_Ready, FST2_R_Work, FST2_R_dxLInv, FST2_R_ManSet, FST2_R_Down, FSTCountR, False);
      if FDistributeRErr or (FSTCountR > 1) then
        begin
          FSTCountR := 1;
          ResetPosR1(True);
//          ResetPosR1(False);
          ResetPosR2(False);
          FDistributeRErr := Distribute(FRzad, FST1_R_Xmin, FST1_R_Xmax, FST1_R_AltXmax, FST1_R_AltXmin, FST1_R_Xzad, FST1_R_dxL, FST1_R_Ready, FST1_R_Work, FST1_R_dxLInv, FST1_R_ManSet, FST1_R_Down,
                                               FST2_R_Xmin, FST2_R_Xmax, FST2_R_AltXmax, FST2_R_AltXmin, FST2_R_Xzad, FST2_R_dxL, FST2_R_Ready, FST2_R_Work, FST2_R_dxLInv, FST2_R_ManSet, FST2_R_Down, FSTCountR, True);
        end;
      if FDistributeRErr then FDistributeRStatus := '������� ������������ �� �������' else FDistributeRStatus := '������� ������������ �������';
    end;
  FActiveST := 1;
end;

// ������������ ���� �� ������ ������
procedure TZadanie.DistributeST1BL;
begin
  if not FZadanieErr then
    begin
      FSTCountBL := 1;
      ResetPosBL1(True);
//      ResetPosBL1(False);
      ResetPosBL2(False);
      FDistributeBLErr := Distribute(FBLzad, FST1_BL_Xmin, FST1_BL_Xmax, FST1_BL_AltXmax, FST1_BL_AltXmin, FST1_BL_Xzad, FST1_BL_dxL, FST1_BL_Ready, FST1_BL_Work, FST1_BL_dxLInv, FST1_BL_ManSet, FST1_BL_Down,
                                             FST2_BL_Xmin, FST2_BL_Xmax, FST2_BL_AltXmax, FST2_BL_AltXmin, FST2_BL_Xzad, FST2_BL_dxL, FST2_BL_Ready, FST2_BL_Work, FST2_BL_dxLInv, FST2_BL_ManSet, FST2_BL_Down, FSTCountBL, False);
      if FDistributeBLErr or (FSTCountBL > 1) then
        begin
          FSTCountBL := 1;
          ResetPosBL1(True);
//          ResetPosBL1(False);
          ResetPosBL2(False);
          FDistributeBLErr := Distribute(FBLzad, FST1_BL_Xmin, FST1_BL_Xmax, FST1_BL_AltXmax, FST1_BL_AltXmin, FST1_BL_Xzad, FST1_BL_dxL, FST1_BL_Ready, FST1_BL_Work, FST1_BL_dxLInv, FST1_BL_ManSet, FST1_BL_Down,
                                                 FST2_BL_Xmin, FST2_BL_Xmax, FST2_BL_AltXmax, FST2_BL_AltXmin, FST2_BL_Xzad, FST2_BL_dxL, FST2_BL_Ready, FST2_BL_Work, FST2_BL_dxLInv, FST2_BL_ManSet, FST2_BL_Down, FSTCountBL, True);
        end;
      if FDistributeBLErr then FDistributeBLStatus := '���� ������������ �� �������' else FDistributeBLStatus := '���� ������������ �������';
    end;
  FActiveST := 1;
end;

// ������������ ������� �� ������ ������
procedure TZadanie.DistributeST2R;
begin
  if not FZadanieErr then
    begin
      FSTCountR := 1;
      ResetPosR2(True);
//      ResetPosR2(False);
      ResetPosR1(False);
      FDistributeRErr := Distribute(FRzad, FST2_R_Xmin, FST2_R_Xmax, FST2_R_AltXmax, FST2_R_AltXmin, FST2_R_Xzad, FST2_R_dxL, FST2_R_Ready, FST2_R_Work, FST2_R_dxLInv, FST2_R_ManSet, FST2_R_Down,
                                           FST1_R_Xmin, FST1_R_Xmax, FST1_R_AltXmax, FST1_R_AltXmin, FST1_R_Xzad, FST1_R_dxL, FST1_R_Ready, FST1_R_Work, FST1_R_dxLInv, FST1_R_ManSet, FST1_R_Down, FSTCountR, False);
      if FDistributeRErr or (FSTCountR > 1) then
        begin
          FSTCountR := 1;
          ResetPosR2(True);
//          ResetPosR2(False);
          ResetPosR1(False);
          FDistributeRErr := Distribute(FRzad, FST2_R_Xmin, FST2_R_Xmax, FST2_R_AltXmax, FST2_R_AltXmin, FST2_R_Xzad, FST2_R_dxL, FST2_R_Ready, FST2_R_Work, FST2_R_dxLInv, FST2_R_ManSet, FST2_R_Down,
                                               FST1_R_Xmin, FST1_R_Xmax, FST1_R_AltXmax, FST1_R_AltXmin, FST1_R_Xzad, FST1_R_dxL, FST1_R_Ready, FST1_R_Work, FST1_R_dxLInv, FST1_R_ManSet, FST1_R_Down, FSTCountR, True);
        end;
      if FDistributeRErr then FDistributeRStatus := '������� ������������ �� �������' else FDistributeRStatus := '������� ������������ �������';
    end;
  FActiveST := 2;
end;

// ������������ ���� �� ������ ������
procedure TZadanie.DistributeST2BL;
begin
  if not FZadanieErr then
    begin
      FSTCountBL := 1;
      ResetPosBL2(True);
//      ResetPosBL2(False);
      ResetPosBL1(False);
      FDistributeBLErr := Distribute(FBLzad, FST2_BL_Xmin, FST2_BL_Xmax, FST2_BL_AltXmax, FST2_BL_AltXmin, FST2_BL_Xzad, FST2_BL_dxL, FST2_BL_Ready, FST2_BL_Work, FST2_BL_dxLInv, FST2_BL_ManSet, FST2_BL_Down,
                                             FST1_BL_Xmin, FST1_BL_Xmax, FST1_BL_AltXmax, FST1_BL_AltXmin, FST1_BL_Xzad, FST1_BL_dxL, FST1_BL_Ready, FST1_BL_Work, FST1_BL_dxLInv, FST1_BL_ManSet, FST1_BL_Down, FSTCountBL, False);
      if FDistributeBLErr or (FSTCountBL > 1) then
        begin
          FSTCountBL := 1;
          ResetPosBL2(True);
//          ResetPosBL2(False);
          ResetPosBL1(False);
          FDistributeBLErr := Distribute(FBLzad, FST2_BL_Xmin, FST2_BL_Xmax, FST2_BL_AltXmax, FST2_BL_AltXmin, FST2_BL_Xzad, FST2_BL_dxL, FST2_BL_Ready, FST2_BL_Work, FST2_BL_dxLInv, FST2_BL_ManSet, FST2_BL_Down,
                                                 FST1_BL_Xmin, FST1_BL_Xmax, FST1_BL_AltXmax, FST1_BL_AltXmin, FST1_BL_Xzad, FST1_BL_dxL, FST1_BL_Ready, FST1_BL_Work, FST1_BL_dxLInv, FST1_BL_ManSet, FST1_BL_Down, FSTCountBL, True);
        end;
      if FDistributeBLErr then FDistributeBLStatus := '���� ������������ �� �������' else FDistributeBLStatus := '���� ������������ �������';
    end;
  FActiveST := 2;
end;

function TZadanie.GetDistributeStatus : string;
begin
  if FDistributeRErr or FDistributeBLErr then Result := '������� ������������ �� �������' else Result :='������� ������������ �������';
end;

// ��������� ������� � �������
function TZadanie.GetRzadCount : byte;
begin
  if not FZadanieErr then Result := High(FRzad) else Result := 0;
end;

// ��������� ����� � �������
function TZadanie.GetBLzadCount : byte;
begin
  if not FZadanieErr then Result := High(FBLzad) else Result := 0;
end;

// ������ ������ ���������
procedure TZadanie.SetDetailsStr(Value : string);
var
  i, j, n : byte;
  Z, TempString : string;
  RepF : TReplaceFlags;
begin
  FDetailsStr := Value;
  for i := 1 to 8 do FDetails[i] := '';
  RepF := [rfReplaceAll, rfIgnoreCase];
  while Pos('  ', FDetailsStr) <> 0 do FDetailsStr := StringReplace(FDetailsStr, '  ', ' ', RepF);
  FDetailsStr := Trim(FDetailsStr);
  Z := FDetailsStr + ' ';
  j := 1;
  while (Length(Z) > 0) and (Pos(' ', Z) > 0) do
    begin
      n := Pos(' ', Z);
      TempString := LeftStr(Z, n - 1);
      Delete(Z, 1, n);
      if j in [1..8] then
        begin
          FDetails[j] := TempString;
          j := j + 1;
        end;
    end;
end;

// �������� ������� ������� ������� ���������, ��������������� �������
function TZadanie.GetDetails(Index : byte) : string;
begin
  if Index in [1..8] then Result := FDetails[Index] else Result := '';
end;

// �������� ������� ������� ������� ���������, ��������������� �������
procedure TZadanie.SetDetails(Index : byte; Value : string);  begin  FDetails[Index] := Value;     end;

// "������" � "������" ��� ������� - ��������� ��������
function TZadanie.GetST1_BL_Xmin(Index : byte) : single;            begin  Result := FST1_BL_Xmin[Index];     end;
procedure TZadanie.SetST1_BL_Xmin(Index : byte; Value : single);    begin  FST1_BL_Xmin[Index] := Value;      end;
function TZadanie.GetST1_BL_Xmax(Index : byte) : single;            begin  Result := FST1_BL_Xmax[Index];     end;
procedure TZadanie.SetST1_BL_Xmax(Index : byte; Value : single);    begin  FST1_BL_Xmax[Index] := Value;      end;
function TZadanie.GetST1_BL_Xzad(Index : byte) : single;            begin  Result := FST1_BL_Xzad[Index];     end;
procedure TZadanie.SetST1_BL_Xzad(Index : byte; Value : single);    begin  FST1_BL_Xzad[Index] := Value;      end;
function TZadanie.GetST1_BL_dxL(Index : byte) : single;             begin  Result := FST1_BL_dxL[Index];      end;
procedure TZadanie.SetST1_BL_dxL(Index : byte; Value : single);     begin  FST1_BL_dxL[Index] := Value;       end;
function TZadanie.GetST1_BL_dxLInv(Index : byte) : boolean;         begin  Result := FST1_BL_dxLInv[Index];   end;
procedure TZadanie.SetST1_BL_dxLInv(Index : byte; Value : boolean); begin  FST1_BL_dxLInv[Index] := Value;    end;
function TZadanie.GetST1_BL_Ready(Index : byte) : boolean;          begin  Result := FST1_BL_Ready[Index];    end;
procedure TZadanie.SetST1_BL_Ready(Index : byte; Value : boolean);  begin  FST1_BL_Ready[Index] := Value;     end;
function TZadanie.GetST1_BL_Work(Index : byte) : boolean;           begin  Result := FST1_BL_Work[Index];     end;
procedure TZadanie.SetST1_BL_Work(Index : byte; Value : boolean);   begin  FST1_BL_Work[Index] := Value;      end;
function TZadanie.GetST1_BL_AltXmax(Index : byte) : single;         begin  Result := FST1_BL_AltXmax[Index];  end;
procedure TZadanie.SetST1_BL_AltXmax(Index : byte; Value : single); begin  FST1_BL_AltXmax[Index] := Value;   end;
function TZadanie.GetST1_BL_AltXmin(Index : byte) : single;         begin  Result := FST1_BL_AltXmin[Index];  end;
procedure TZadanie.SetST1_BL_AltXmin(Index : byte; Value : single); begin  FST1_BL_AltXmin[Index] := Value;   end;
function TZadanie.GetST1_BL_Impuls(Index : byte) : single;          begin  Result := FST1_BL_Impuls[Index];   end;
procedure TZadanie.SetST1_BL_Impuls(Index : byte; Value : single);  begin  FST1_BL_Impuls[Index] := Value;    end;

function TZadanie.GetST2_BL_Xmin(Index : byte) : single;            begin  Result := FST2_BL_Xmin[Index];     end;
procedure TZadanie.SetST2_BL_Xmin(Index : byte; Value : single);    begin  FST2_BL_Xmin[Index] := Value;      end;
function TZadanie.GetST2_BL_Xmax(Index : byte) : single;            begin  Result := FST2_BL_Xmax[Index];     end;
procedure TZadanie.SetST2_BL_Xmax(Index : byte; Value : single);    begin  FST2_BL_Xmax[Index] := Value;      end;
function TZadanie.GetST2_BL_Xzad(Index : byte) : single;            begin  Result := FST2_BL_Xzad[Index];     end;
procedure TZadanie.SetST2_BL_Xzad(Index : byte; Value : single);    begin  FST2_BL_Xzad[Index] := Value;      end;
function TZadanie.GetST2_BL_dxL(Index : byte) : single;             begin  Result := FST2_BL_dxL[Index];      end;
procedure TZadanie.SetST2_BL_dxL(Index : byte; Value : single);     begin  FST2_BL_dxL[Index] := Value;       end;
function TZadanie.GetST2_BL_dxLInv(Index : byte) : boolean;         begin  Result := FST2_BL_dxLInv[Index];   end;
procedure TZadanie.SetST2_BL_dxLInv(Index : byte; Value : boolean); begin  FST2_BL_dxLInv[Index] := Value;    end;
function TZadanie.GetST2_BL_Ready(Index : byte) : boolean;          begin  Result := FST2_BL_Ready[Index];    end;
procedure TZadanie.SetST2_BL_Ready(Index : byte; Value : boolean);  begin  FST2_BL_Ready[Index] := Value;     end;
function TZadanie.GetST2_BL_Work(Index : byte) : boolean;           begin  Result := FST2_BL_Work[Index];     end;
procedure TZadanie.SetST2_BL_Work(Index : byte; Value : boolean);   begin  FST2_BL_Work[Index] := Value;      end;
function TZadanie.GetST2_BL_AltXmax(Index : byte) : single;         begin  Result := FST2_BL_AltXmax[Index];  end;
procedure TZadanie.SetST2_BL_AltXmax(Index : byte; Value : single); begin  FST2_BL_AltXmax[Index] := Value;   end;
function TZadanie.GetST2_BL_AltXmin(Index : byte) : single;         begin  Result := FST2_BL_AltXmin[Index];  end;
procedure TZadanie.SetST2_BL_AltXmin(Index : byte; Value : single); begin  FST2_BL_AltXmin[Index] := Value;   end;
function TZadanie.GetST2_BL_Impuls(Index : byte) : single;          begin  Result := FST2_BL_Impuls[Index];   end;
procedure TZadanie.SetST2_BL_Impuls(Index : byte; Value : single);  begin  FST2_BL_Impuls[Index] := Value;    end;

function TZadanie.GetST1_R_Xmin(Index : byte) : single;             begin  Result := FST1_R_Xmin[Index];      end;
procedure TZadanie.SetST1_R_Xmin(Index : byte; Value : single);     begin  FST1_R_Xmin[Index] := Value;       end;
function TZadanie.GetST1_R_Xmax(Index : byte) : single;             begin  Result := FST1_R_Xmax[Index];      end;
procedure TZadanie.SetST1_R_Xmax(Index : byte; Value : single);     begin  FST1_R_Xmax[Index] := Value;       end;
function TZadanie.GetST1_R_Xzad(Index : byte) : single;             begin  Result := FST1_R_Xzad[Index];      end;
procedure TZadanie.SetST1_R_Xzad(Index : byte; Value : single);     begin  FST1_R_Xzad[Index] := Value;       end;
function TZadanie.GetST1_R_dxL(Index : byte) : single;              begin  Result := FST1_R_dxL[Index];       end;
procedure TZadanie.SetST1_R_dxL(Index : byte; Value : single);      begin  FST1_R_dxL[Index] := Value;        end;
function TZadanie.GetST1_R_dxLInv(Index : byte) : boolean;          begin  Result := FST1_R_dxLInv[Index];    end;
procedure TZadanie.SetST1_R_dxLInv(Index : byte; Value : boolean);  begin  FST1_R_dxLInv[Index] := Value;     end;
function TZadanie.GetST1_R_Ready(Index : byte) : boolean;           begin  Result := FST1_R_Ready[Index];     end;
procedure TZadanie.SetST1_R_Ready(Index : byte; Value : boolean);   begin  FST1_R_Ready[Index] := Value;      end;
function TZadanie.GetST1_R_Work(Index : byte) : boolean;            begin  Result := FST1_R_Work[Index];      end;
procedure TZadanie.SetST1_R_Work(Index : byte; Value : boolean);    begin  FST1_R_Work[Index] := Value;       end;
function TZadanie.GetST1_R_AltXmax(Index : byte) : single;          begin  Result := FST1_R_AltXmax[Index];   end;
procedure TZadanie.SetST1_R_AltXmax(Index : byte; Value : single);  begin  FST1_R_AltXmax[Index] := Value;    end;
function TZadanie.GetST1_R_AltXmin(Index : byte) : single;          begin  Result := FST1_R_AltXmin[Index];   end;
procedure TZadanie.SetST1_R_AltXmin(Index : byte; Value : single);  begin  FST1_R_AltXmin[Index] := Value;    end;
function TZadanie.GetST1_R_Impuls(Index : byte) : single;           begin  Result := FST1_R_Impuls[Index];    end;
procedure TZadanie.SetST1_R_Impuls(Index : byte; Value : single);   begin  FST1_R_Impuls[Index] := Value;     end;

function TZadanie.GetST2_R_Xmin(Index : byte) : single;             begin  Result := FST2_R_Xmin[Index];      end;
procedure TZadanie.SetST2_R_Xmin(Index : byte; Value : single);     begin  FST2_R_Xmin[Index] := Value;       end;
function TZadanie.GetST2_R_Xmax(Index : byte) : single;             begin  Result := FST2_R_Xmax[Index];      end;
procedure TZadanie.SetST2_R_Xmax(Index : byte; Value : single);     begin  FST2_R_Xmax[Index] := Value;       end;
function TZadanie.GetST2_R_Xzad(Index : byte) : single;             begin  Result := FST2_R_Xzad[Index];      end;
procedure TZadanie.SetST2_R_Xzad(Index : byte; Value : single);     begin  FST2_R_Xzad[Index] := Value;       end;
function TZadanie.GetST2_R_dxL(Index : byte) : single;              begin  Result := FST2_R_dxL[Index];       end;
procedure TZadanie.SetST2_R_dxL(Index : byte; Value : single);      begin  FST2_R_dxL[Index] := Value;        end;
function TZadanie.GetST2_R_dxLInv(Index : byte) : boolean;          begin  Result := FST2_R_dxLInv[Index];    end;
procedure TZadanie.SetST2_R_dxLInv(Index : byte; Value : boolean);  begin  FST2_R_dxLInv[Index] := Value;     end;
function TZadanie.GetST2_R_Ready(Index : byte) : boolean;           begin  Result := FST2_R_Ready[Index];     end;
procedure TZadanie.SetST2_R_Ready(Index : byte; Value : boolean);   begin  FST2_R_Ready[Index] := Value;      end;
function TZadanie.GetST2_R_Work(Index : byte) : boolean;            begin  Result := FST2_R_Work[Index];      end;
procedure TZadanie.SetST2_R_Work(Index : byte; Value : boolean);    begin  FST2_R_Work[Index] := Value;       end;
function TZadanie.GetST2_R_AltXmax(Index : byte) : single;          begin  Result := FST2_R_AltXmax[Index];   end;
procedure TZadanie.SetST2_R_AltXmax(Index : byte; Value : single);  begin  FST2_R_AltXmax[Index] := Value;    end;
function TZadanie.GetST2_R_AltXmin(Index : byte) : single;          begin  Result := FST2_R_AltXmin[Index];   end;
procedure TZadanie.SetST2_R_AltXmin(Index : byte; Value : single);  begin  FST2_R_AltXmin[Index] := Value;    end;
function TZadanie.GetST2_R_Impuls(Index : byte) : single;           begin  Result := FST2_R_Impuls[Index];    end;
procedure TZadanie.SetST2_R_Impuls(Index : byte; Value : single);   begin  FST2_R_Impuls[Index] := Value;     end;

function TZadanie.GetRzad(Index : byte) : single;                   begin  Result := FRzad[Index];            end;
function TZadanie.GetBLzad(Index : byte) : single;                  begin  Result := FBLzad[Index];           end;
function TZadanie.GetST1_BL_Down(Index : byte) : boolean;           begin  Result := FST1_BL_Down[Index];     end;
procedure TZadanie.SetST1_BL_Down(Index : byte; Value : boolean);   begin  FST1_BL_Down[Index] := Value;      end;
function TZadanie.GetST1_BL_ManSet(Index : byte) : boolean;         begin  Result := FST1_BL_ManSet[Index];   end;
procedure TZadanie.SetST1_BL_ManSet(Index : byte; Value : boolean); begin  FST1_BL_ManSet[Index] := Value;    end;
function TZadanie.GetST2_BL_Down(Index : byte) : boolean;           begin  Result := FST2_BL_Down[Index];     end;
procedure TZadanie.SetST2_BL_Down(Index : byte; Value : boolean);   begin  FST2_BL_Down[Index] := Value;      end;
function TZadanie.GetST2_BL_ManSet(Index : byte) : boolean;         begin  Result := FST2_BL_ManSet[Index];   end;
procedure TZadanie.SetST2_BL_ManSet(Index : byte; Value : boolean); begin  FST2_BL_ManSet[Index] := Value;    end;
function TZadanie.GetST1_R_Down(Index : byte) : boolean;            begin  Result := FST1_R_Down[Index];      end;
procedure TZadanie.SetST1_R_Down(Index : byte; Value : boolean);    begin  FST1_R_Down[Index] := Value;       end;
function TZadanie.GetST1_R_ManSet(Index : byte) : boolean;          begin  Result := FST1_R_ManSet[Index];    end;
procedure TZadanie.SetST1_R_ManSet(Index : byte; Value : boolean);  begin  FST1_R_ManSet[Index] := Value;     end;
function TZadanie.GetST2_R_Down(Index : byte) : boolean;            begin  Result := FST2_R_Down[Index];      end;
procedure TZadanie.SetST2_R_Down(Index : byte; Value : boolean);    begin  FST2_R_Down[Index] := Value;       end;
function TZadanie.GetST2_R_ManSet(Index : byte) : boolean;          begin  Result := FST2_R_ManSet[Index];    end;
procedure TZadanie.SetST2_R_ManSet(Index : byte; Value : boolean);  begin  FST2_R_ManSet[Index] := Value;     end;

end.
