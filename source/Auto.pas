unit Auto;
// Модуль с некоторыми функциями автоматического режима, не вошедшими ни в один класс


interface

uses
  SysUtils, Forms, StrUtils, IniFiles, Classes, ContrAuto, ContrMan, FormMan, ClassZadanie, OPCClient;

// Передать задание в компоненты ручного режима - готовность к командам Установить/Опустить рабочие
procedure SetAuto(Value : boolean; Zadanie : TZadanie);
// Установить все (поднятые) механизмы станка 1 по заданию (см. SetAuto)
procedure AutoStartUP1;
// Установить все (поднятые) механизмы станка 2 по заданию (см. SetAuto)
procedure AutoStartUP2;
// Установить все механизмы станка 1 по заданию (см. SetAuto)
procedure AutoStartAll1;
// Установить все механизмы станка 2 по заданию (см. SetAuto)
procedure AutoStartAll2;
// Прочитать настройки
procedure ReloadIni;
// Сохранить графические файлы из ресурсов во временную папку
procedure SaveFilesFromResource;
// Отобразить текущее задание на форме автоматического режима
procedure SetCtrlAutoWidth(Zadanie : TZadanie);
// Получить номер текущей ревизии
function GetRevN : string;

const
  OneSecond = 1 / (24 * 60 * 60);
  RezkaTempPath = '.\rezkatemp\';

var
  CtrlMan : TControlMan;
  CtrlAuto : TControlAuto;
  ST1CtrlAutoRList : TList;
  ST1CtrlAutoBLList : TList;
  ST2CtrlAutoRList : TList;
  ST2CtrlAutoBLList : TList;
  CurrZad, NextZad : TZadanie;
  RevN : string;
  RezkaStatusPath : string;
  CounterHost : string;
  Counter, CounterConst1, CounterConst2, CounterConst3, CounterConst4 : integer;
  AutoReDist, ReDistNow : boolean;

implementation

// Передать задание в компоненты ручного режима - готовность к командам Установить/Опустить рабочие
procedure SetAuto(Value : boolean; Zadanie : TZadanie);
var
  j : integer;
  t : boolean;
begin
  if not Value then
    begin
      for j := 1 to 10 do
        begin
          CtrlMan := ST1RList.Items[j - 1];
          CtrlMan.Work := False;
          CtrlMan.AutoZad := CtrlMan.Pos;
          CtrlMan := ST2RList.Items[j - 1];
          CtrlMan.Work := False;
          CtrlMan.AutoZad := CtrlMan.Pos;
        end;
      for j := 1 to 6 do
        begin
          CtrlMan := ST1BLList.Items[j - 1];
          CtrlMan.Work := False;
          CtrlMan.AutoZad := CtrlMan.Pos;
          CtrlMan := ST2BLList.Items[j - 1];
          CtrlMan.Work := False;
          CtrlMan.AutoZad := CtrlMan.Pos;
        end;
    end else
    begin
      t := False;
      for j := 1 to 10 do if Zadanie.ST1_R_Work[j] then t := True;
      if t then for j := 1 to 10 do
        begin
          CtrlMan := ST1RList.Items[j - 1];
          CtrlMan.Work := Zadanie.ST1_R_Work[j];
          CtrlMan.AutoZad := Zadanie.ST1_R_Xzad[j];
        end;
      t := False;
      for j := 1 to 10 do if Zadanie.ST2_R_Work[j] then t := True;
      if t then for j := 1 to 10 do
        begin
          CtrlMan := ST2RList.Items[j - 1];
          CtrlMan.Work := Zadanie.ST2_R_Work[j];
          CtrlMan.AutoZad := Zadanie.ST2_R_Xzad[j];
        end;
      t := False;
      for j := 1 to 6 do if Zadanie.ST1_BL_Work[j] then t := True;
      if t then for j := 1 to 6 do
        begin
          CtrlMan := ST1BLList.Items[j - 1];
          CtrlMan.Work := Zadanie.ST1_BL_Work[j];
          CtrlMan.AutoZad := Zadanie.ST1_BL_Xzad[j];
        end;
      t := False;
      for j := 1 to 6 do if Zadanie.ST2_BL_Work[j] then t := True;
      if t then for j := 1 to 6 do
        begin
          CtrlMan := ST2BLList.Items[j - 1];
          CtrlMan.Work := Zadanie.ST2_BL_Work[j];
          CtrlMan.AutoZad := Zadanie.ST2_BL_Xzad[j];
        end;
    end;
end;

// Установить все (поднятые) механизмы станка 1 по заданию (см. SetAuto)
procedure AutoStartUP1;
var
  j1 : integer;
begin
  for j1 := 1 to 5 do
    begin
      if CurrZad.ST1_R_Ready[j1] and not CurrZad.ST1_R_Down[j1] then
        begin
          CtrlMan := ST1RList.Items[j1 - 1];
          if CtrlMan.AutoZad > 0 then
            begin
              CtrlMan.Zad := CtrlMan.AutoZad;
              CtrlMan.NewZad := True;
            end;
        end;
      if CurrZad.ST1_R_Ready[j1 + 5] and not CurrZad.ST1_R_Down[j1 + 5] then
        begin
          CtrlMan := ST1RList.Items[j1 - 1 + 5];
          if CtrlMan.AutoZad > 0 then
            begin
              CtrlMan.Zad := CtrlMan.AutoZad;
              CtrlMan.NewZad := True;
            end;
        end;
    end;
  for j1 := 1 to 3 do
    begin
      if CurrZad.ST1_BL_Ready[j1] and not CurrZad.ST1_BL_Down[j1] then
        begin
          CtrlMan := ST1BLList.Items[j1 - 1];
          if CtrlMan.AutoZad > 0 then
            begin
              CtrlMan.Zad := CtrlMan.AutoZad;
              CtrlMan.NewZad := True;
            end;
        end;
      if CurrZad.ST1_BL_Ready[j1 + 3] and not CurrZad.ST1_BL_Down[j1 + 3] then
        begin
          CtrlMan := ST1BLList.Items[j1 - 1 + 3];
          if CtrlMan.AutoZad > 0 then
            begin
              CtrlMan.Zad := CtrlMan.AutoZad;
              CtrlMan.NewZad := True;
            end;
        end;
    end;
end;

// Установить все (поднятые) механизмы станка 2 по заданию (см. SetAuto)
procedure AutoStartUP2;
var
  j1 : integer;
begin
  for j1 := 1 to 5 do
    begin
      if CurrZad.ST2_R_Ready[j1] and not CurrZad.ST2_R_Down[j1] then
        begin
          CtrlMan := ST2RList.Items[j1 - 1];
          if CtrlMan.AutoZad > 0 then
            begin
              CtrlMan.Zad := CtrlMan.AutoZad;
              CtrlMan.NewZad := True;
            end;
        end;
      if CurrZad.ST2_R_Ready[j1 + 5] and not CurrZad.ST2_R_Down[j1 + 5] then
        begin
          CtrlMan := ST2RList.Items[j1 - 1 + 5];
          if CtrlMan.AutoZad > 0 then
            begin
              CtrlMan.Zad := CtrlMan.AutoZad;
              CtrlMan.NewZad := True;
            end;
        end;
    end;
  for j1 := 1 to 3 do
    begin
      if CurrZad.ST2_BL_Ready[j1] and not CurrZad.ST2_BL_Down[j1] then
        begin
          CtrlMan := ST2BLList.Items[j1 - 1];
          if CtrlMan.AutoZad > 0 then
            begin
              CtrlMan.Zad := CtrlMan.AutoZad;
              CtrlMan.NewZad := True;
            end;
        end;
      if CurrZad.ST2_BL_Ready[j1 + 3] and not CurrZad.ST2_BL_Down[j1 + 3] then
        begin
          CtrlMan := ST2BLList.Items[j1 - 1 + 3];
          if CtrlMan.AutoZad > 0 then
            begin
              CtrlMan.Zad := CtrlMan.AutoZad;
              CtrlMan.NewZad := True;
            end;
        end;
    end;
end;

// Установить все механизмы станка 1 по заданию (см. SetAuto)
procedure AutoStartAll1;
var
  j1 : integer;
begin
  for j1 := 1 to 10 do
    if CurrZad.ST1_R_Ready[j1] then
      begin
        CtrlMan := ST1RList.Items[j1 - 1];
        if CtrlMan.AutoZad > 0 then
          begin
            CtrlMan.Zad := CtrlMan.AutoZad;
            CtrlMan.NewZad := True;
          end;
      end;
  for j1 := 1 to 6 do
    if CurrZad.ST1_BL_Ready[j1] then
      begin
        CtrlMan := ST1BLList.Items[j1 - 1];
        if CtrlMan.AutoZad > 0 then
          begin
            CtrlMan.Zad := CtrlMan.AutoZad;
            CtrlMan.NewZad := True;
          end;
      end;
end;

// Установить все механизмы станка 2 по заданию (см. SetAuto)
procedure AutoStartAll2;
var
  j1 : integer;
begin
  for j1 := 1 to 10 do
    if CurrZad.ST2_R_Ready[j1] then
      begin
        CtrlMan := ST2RList.Items[j1 - 1];
        if CtrlMan.AutoZad > 0 then
          begin
            CtrlMan.Zad := CtrlMan.AutoZad;
            CtrlMan.NewZad := True;
          end;
      end;
  for j1 := 1 to 6 do
    if CurrZad.ST2_BL_Ready[j1] then
      begin
        CtrlMan := ST2BLList.Items[j1 - 1];
        if CtrlMan.AutoZad > 0 then
          begin
            CtrlMan.Zad := CtrlMan.AutoZad;
            CtrlMan.NewZad := True;
          end;
      end;
end;

// Прочитать настройки
procedure ReloadIni;
var
  i : integer;
begin
  CurrZad.ReloadIni;
  NextZad.ReloadIni;
    for i := 1 to 10 do
    begin
      CtrlMan := ST1RList.Items[i - 1];
      CtrlMan.Ready := CurrZad.ST1_R_Ready[i];
      CtrlMan.Impuls := CurrZad.ST1_R_Impuls[i];
      CtrlMan := ST2RList.Items[i - 1];
      CtrlMan.Ready := CurrZad.ST2_R_Ready[i];
      CtrlMan.Impuls := CurrZad.ST2_R_Impuls[i];
    end;
    for i := 1 to 6 do
    begin
      CtrlMan := ST1BLList.Items[i - 1];
      CtrlMan.Ready := CurrZad.ST1_BL_Ready[i];
      CtrlMan.Impuls := CurrZad.ST1_BL_Impuls[i];
      CtrlMan := ST2BLList.Items[i - 1];
      CtrlMan.Ready := CurrZad.ST2_BL_Ready[i];
      CtrlMan.Impuls := CurrZad.ST2_BL_Impuls[i];      
    end;
end;

// Отобразить текущее задание на форме автоматического режима
procedure SetCtrlAutoWidth(Zadanie : TZadanie);
var
  CtrlAuto : TControlAuto;
  i : byte;
begin
  for i := 1 to 10 do
    begin
      CtrlAuto := ST1CtrlAutoRList.Items[i - 1];
      CtrlAuto.RealWidth := Zadanie.ST1_R_dxL[i];
      CtrlAuto.Ready :=  Zadanie.ST1_R_Ready[i];
      CtrlAuto.dxLInv := Zadanie.ST1_R_dxLInv[i];
      CtrlAuto := ST2CtrlAutoRList.Items[i - 1];
      CtrlAuto.RealWidth := Zadanie.ST2_R_dxL[i];
      CtrlAuto.Ready :=  Zadanie.ST2_R_Ready[i];
      CtrlAuto.dxLInv := Zadanie.ST2_R_dxLInv[i];
    end;
  for i := 1 to 6 do
    begin
      CtrlAuto := ST1CtrlAutoBLList.Items[i - 1];
      CtrlAuto.RealWidth := Zadanie.ST1_BL_dxL[i];
      CtrlAuto.Ready :=  Zadanie.ST1_BL_Ready[i];
      CtrlAuto.dxLInv := Zadanie.ST1_BL_dxLInv[i];
      CtrlAuto := ST2CtrlAutoBLList.Items[i - 1];
      CtrlAuto.RealWidth := Zadanie.ST2_BL_dxL[i];
      CtrlAuto.Ready :=  Zadanie.ST2_BL_Ready[i];
      CtrlAuto.dxLInv := Zadanie.ST2_BL_dxLInv[i];
    end;
end;

// Сохранить графические файлы из ресурсов во временную папку
procedure SaveFilesFromResource;
var
  Res : TResourceStream;
  RezkaIni: TIniFile;
  ProgramPath : string;
begin
  ProgramPath := ExtractFilePath(Application.EXEName);
  RezkaIni := TIniFile.Create(ProgramPath + 'Rezka.ini');
  CounterHost := RezkaIni.ReadString('Counter', 'Host', '192.168.3.5');
  try CounterConst1 := StrToInt(RezkaIni.ReadString('Counter', 'Const1', '35')); except CounterConst1 := 0 end;
  try CounterConst2 := StrToInt(RezkaIni.ReadString('Counter', 'Const2', '2')); except CounterConst2 := 0 end;
  try CounterConst3 := StrToInt(RezkaIni.ReadString('Counter', 'Const3', '4')); except CounterConst3 := 0 end;
  try CounterConst4 := StrToInt(RezkaIni.ReadString('Counter', 'Const4', '45')); except CounterConst4 := 0 end;
  RezkaIni.WriteString('Counter', 'Host', CounterHost);
  RezkaIni.WriteString('Counter', 'Const1', IntToStr(CounterConst1));
  RezkaIni.WriteString('Counter', 'Const2', IntToStr(CounterConst2));
  RezkaIni.WriteString('Counter', 'Const3', IntToStr(CounterConst3));
  RezkaIni.WriteString('Counter', 'Const4', IntToStr(CounterConst4));
  RezkaStatusPath := ProgramPath + RezkaIni.ReadString('Path', 'Status', '..\Doc\');
  if not DirectoryExists(RezkaTempPath) then MkDir(RezkaTempPath);
  if not DirectoryExists(RezkaStatusPath) then RezkaStatusPath := '';
  RezkaIni.Free;
  if not FileExists(RezkaTempPath + 'BL_WP.emf') then
    begin
      Res := TResourceStream.Create(Hinstance, 'BL_WP', Pchar('EMF'));
      Res.SaveToFile(RezkaTempPath + 'BL_WP.emf');
      Res.Free;
    end;
  if not FileExists(RezkaTempPath + 'R_WP.emf') then
    begin
      Res := TResourceStream.Create(Hinstance, 'R_WP', Pchar('EMF'));
      Res.SaveToFile(RezkaTempPath + 'R_WP.emf');
      Res.Free;
    end;
  if not FileExists(RezkaTempPath + 'BL_W.emf') then
    begin
      Res := TResourceStream.Create(Hinstance, 'BL_W', Pchar('EMF'));
      Res.SaveToFile(RezkaTempPath + 'BL_W.emf');
      Res.Free;
    end;
  if not FileExists(RezkaTempPath + 'R_W.emf') then
    begin
      Res := TResourceStream.Create(Hinstance, 'R_W', Pchar('EMF'));
      Res.SaveToFile(RezkaTempPath + 'R_W.emf');
      Res.Free;
    end;
  if not FileExists(RezkaTempPath + 'BL_D.emf') then
    begin
      Res := TResourceStream.Create(Hinstance, 'BL_D', Pchar('EMF'));
      Res.SaveToFile(RezkaTempPath + 'BL_D.emf');
      Res.Free;
    end;
  if not FileExists(RezkaTempPath + 'R_D.emf') then
    begin
      Res := TResourceStream.Create(Hinstance, 'R_D', Pchar('EMF'));
      Res.SaveToFile(RezkaTempPath + 'R_D.emf');
      Res.Free;
    end;
  if not FileExists(RezkaTempPath + 'BL_DW.emf') then
    begin
      Res := TResourceStream.Create(Hinstance, 'BL_DW', Pchar('EMF'));
      Res.SaveToFile(RezkaTempPath + 'BL_DW.emf');
      Res.Free;
    end;
  if not FileExists(RezkaTempPath + 'R_DW.emf') then
    begin
      Res := TResourceStream.Create(Hinstance, 'R_DW', Pchar('EMF'));
      Res.SaveToFile(RezkaTempPath + 'R_DW.emf');
      Res.Free;
    end;
  if not FileExists(RezkaTempPath + 'BL_nU.emf') then
    begin
      Res := TResourceStream.Create(Hinstance, 'BL_nU', Pchar('EMF'));
      Res.SaveToFile(RezkaTempPath + 'BL_nU.emf');
      Res.Free;
    end;
  if not FileExists(RezkaTempPath + 'R_nU.emf') then
    begin
      Res := TResourceStream.Create(Hinstance, 'R_nU', Pchar('EMF'));
      Res.SaveToFile(RezkaTempPath + 'R_nU.emf');
      Res.Free;
    end;
  Res := TResourceStream.Create(Hinstance, 'SubWCRev', Pchar('txt'));
  Res.SaveToFile(RezkaTempPath + 'SubWCRev.txt');
  Res.Free;
end;

// Получить номер текущей ревизии
function GetRevN : string;
var
  SubWCRev : TextFile;
  RepF : TReplaceFlags;
  Line1, Rstr, D : string;
  R : integer;
begin
  Result := '';
  R := 0;
  RepF := [rfReplaceAll, rfIgnoreCase];
  AssignFile(SubWCRev, RezkaTempPath + 'SubWCRev.txt');
  Reset(SubWCRev);
  while not EOF(SubWCRev) do
    begin
      ReadLn(SubWCRev, Line1);
      if Pos('Last committed at revision', Line1) <> 0 then Rstr := StringReplace(Line1, 'Last committed at revision ', '', RepF);
      try R := StrToInt(Rstr) + 1; except end;
      if Pos('.20', Line1) <> 0 then D := Line1;
    end;
  Result := IntToStr(R) + ' - ' + D;
  CloseFile(SubWCRev);
end;


end.
