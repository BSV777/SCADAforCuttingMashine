@echo off
del SubWCRev.txt
del ..\Rezka\bin\*.emf
SubWCRev ..\Rezka > .\RES\SubWCRev.txt
date /T >> .\RES\SubWCRev.txt
BRCC32 .\RES\RezkaEMF.rc
"D:\Program Files\Borland\Delphi7\Bin\dcc32.exe" Rezka.dpr
"C:\Program Files\Borland\Delphi7\Bin\dcc32.exe" Rezka.dpr
del *.~*
del *.dcu
del .\OPC\*.dcu
del .\Classes\*.dcu
del .\OPC\*.~*
del .\Classes\*.~*
del *.ddp
del *.log
del *.emf
upx Rezka.exe
move /Y *.exe ..\Rezka\bin
mkdir ..\src
XCopy . ..\src /EXCLUDE:No.SVN.txt /E /C /I /F /R /Y
del /Q ..\Rezka\source\source.zip
7z a ..\Rezka\source\source.zip ..\src\*
RMDir /S /Q ..\src
TortoiseProc.exe /command:commit /path:"..\Rezka" /closeonend:1
!_Commit.bat
