@ECHO off
ECHO Setting batch variables..

REM User
REM ===========================================================
SET falloutDirectory=D:\Games\Steam\SteamApps\common\Fallout 4\

REM Location Paths
REM ===========================================================
SET ppj01=Mods\UserWasteland\Character\Character.ppj
SET compilePPJ="%falloutDirectory%%ppj01%"

REM Start the papyrus compiler
REM ===========================================================
ECHO Compiling papyrus with %compilePPJ%
"%falloutDirectory%Papyrus compiler\PapyrusCompiler.exe" %compilePPJ%
