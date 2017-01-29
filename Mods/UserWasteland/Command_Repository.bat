@ECHO off
ECHO Setting batch variables..

REM User
REM ===========================================================
SET falloutDirectory=D:\Games\Steam\SteamApps\common\Fallout 4\
SET repositoryDirectory=E:\Lab\Bethesda\FO4\Wasteland\Repository\

REM File Paths
REM ===========================================================
SET file01=Data\WastelandCharacter.esp
SET file02=Data\WastelandOverlays.esp
SET file03=CreationKitCustom.ini
SET file04=Data\Layouts\ObjectWindow\WastelandCharacter.owl
SET file05=Data\Layouts\QuestDialog\WastelandCharacter.owl

REM Location Paths
REM ===========================================================
SET modLocation=Mods\UserWasteland
SET f4seLocation=Data\F4SE\UserWasteland
SET flashLocation=Data\Interface\Source\UserWasteland
SET papyrusLocation=Data\Scripts\Source\UserWasteland

REM Copy to the repository location
REM ===========================================================
ECHO Copying mod files from the game directory to the project directory..
ECHO From Fallout %falloutDirectory%
ECHO To Repository %repositoryDirectory%
ECHO.
ECHO F | xcopy "%falloutDirectory%%file01%" "%repositoryDirectory%%file01%" /y
ECHO F | xcopy "%falloutDirectory%%file02%" "%repositoryDirectory%%file02%" /y
ECHO F | xcopy "%falloutDirectory%%file03%" "%repositoryDirectory%%file03%" /y
ECHO F | xcopy "%falloutDirectory%%file04%" "%repositoryDirectory%%file04%" /y
ECHO F | xcopy "%falloutDirectory%%file05%" "%repositoryDirectory%%file05%" /y
xcopy "%falloutDirectory%%modLocation%" "%repositoryDirectory%%modLocation%" /i /s /y
xcopy "%falloutDirectory%%f4seLocation%" "%repositoryDirectory%%f4seLocation%" /i /s /y
xcopy "%falloutDirectory%%flashLocation%" "%repositoryDirectory%%flashLocation%" /i /s /y
xcopy "%falloutDirectory%%papyrusLocation%" "%repositoryDirectory%%papyrusLocation%" /i /s /y
ECHO.
ECHO Batch is finished.
PAUSE
