@echo off

cd /d "%~dp0"

set "WSL_IMPORT_DIR=%APPDATA%/WSL/CentOS"
if not exist "%WSL_IMPORT_DIR%" (
    mkdir "%WSL_IMPORT_DIR%"
)

set "WSL_FILE=%~1"
if "%WSL_FILE%" == "" (
    set "WSL_FILE=CentOS.tar.gz"
)

title Cleaning system...
echo Cleaning system...
wsl --unregister CentOS

title Importing CentOS...
echo Importing CentOS...
wsl --import CentOS "%WSL_IMPORT_DIR%" "%WSL_FILE%"

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
