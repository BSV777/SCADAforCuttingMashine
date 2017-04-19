@echo off
del *.~*
del *.dcu
del .\OPC\*.dcu
del .\Classes\*.dcu
del .\OPC\*.~*
del .\Classes\*.~*
del *.ddp
del *.log
del *.emf
del *.exe
del SubWCRev.txt
TortoiseProc.exe /command:commit /path:"..\Rezka_source" /closeonend:1