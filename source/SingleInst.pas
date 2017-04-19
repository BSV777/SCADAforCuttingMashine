unit SingleInst;

interface

uses SysUtils, Windows;

function ActivatePrevInstance(const MainFormClass, ATitle: string): Boolean;
function FindPrevInstance(const MainFormClass, ATitle: string): HWnd;
function WindowsEnum(Handle: HWnd; Param: Longint): Bool; export; stdcall;
function WindowClassName(Wnd: HWnd): string;
function StrPAlloc(const S: string): PChar;

implementation

function ActivatePrevInstance(const MainFormClass, ATitle: string): Boolean;
var
  PrevWnd, ParentWnd: HWnd;
  IsDelphi: Longint;
begin
  Result := False;
  PrevWnd := FindPrevInstance(MainFormClass, ATitle);
  if PrevWnd <> 0 then
    begin
      ParentWnd := GetWindowLong(PrevWnd, GWL_HWNDPARENT);
      while (ParentWnd <> GetDesktopWindow) and (ParentWnd <> 0) do begin
        PrevWnd := ParentWnd;
        ParentWnd := GetWindowLong(PrevWnd, GWL_HWNDPARENT);
      end;
      if WindowClassName(PrevWnd) = 'TApplication' then
        begin
          IsDelphi := 0;
          EnumThreadWindows(GetWindowTask(PrevWnd), @WindowsEnum, LPARAM(@IsDelphi));
          if Boolean(IsDelphi) then Exit;
        end;
    Result := True;
  end;
end;

function FindPrevInstance(const MainFormClass, ATitle: string): HWnd;
var
  BufClass, BufTitle: PChar;
begin
  Result := 0;
  if (MainFormClass = '') and (ATitle = '') then Exit;
  BufClass := nil; BufTitle := nil;
  if (MainFormClass <> '') then BufClass := StrPAlloc(MainFormClass);
  if (ATitle <> '') then BufTitle := StrPAlloc(ATitle);
  try
    Result := FindWindow(BufClass, BufTitle);
  finally
    StrDispose(BufTitle);
    StrDispose(BufClass);
  end;
end;

function WindowsEnum(Handle: HWnd; Param: Longint): Bool; export; stdcall;
begin
  if WindowClassName(Handle) = 'TAppBuilder' then begin
    Result := False;
    PLongint(Param)^ := 1;
  end
  else Result := True;
end;

function WindowClassName(Wnd: HWnd): string;
var
  Buffer: array[0..255] of Char;
begin
  SetString(Result, Buffer, GetClassName(Wnd, Buffer, SizeOf(Buffer) - 1));
end;

function StrPAlloc(const S: string): PChar;
begin
  Result := StrPCopy(StrAlloc(Length(S) + 1), S);
end;

end.










