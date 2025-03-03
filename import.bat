@echo off

cd /d "%~dp0"

set "WSL_IMPORT_DIR=%APPDATA%/WSL/RHEL9"
if not exist "%WSL_IMPORT_DIR%" (
    mkdir "%WSL_IMPORT_DIR%"
)

set "WSL_FILE=%~1"
if "%WSL_FILE%" == "" (
    set "WSL_FILE=RHEL9.tar.gz"
)

title Cleaning system...
echo Cleaning system...
wsl --unregister RHEL9

title Importing RHEL9...
echo Importing RHEL9...
wsl --import RHEL9 "%WSL_IMPORT_DIR%" "%WSL_FILE%"

if "%~2" == "--clean" (
    title Cleaning file...
    echo Cleaning file...
    del /q /f "%WSL_FILE%"
)

if defined SKIP_PAUSE goto :end

title Done
echo Done

pause
exit /b %errorlevel%

:end
