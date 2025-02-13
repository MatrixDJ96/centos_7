@echo off

cd /d "%~dp0"

set "WSL_IMPORT_DIR=%APPDATA%/WSL/CentOS"
if not exist "%WSL_IMPORT_DIR%" (
    mkdir "%WSL_IMPORT_DIR%"
)

title Cleaning system...
echo Cleaning system...
wsl --unregister CentOS
wsl --unregister Ubuntu

title Installing Ubuntu...
echo Installing Ubuntu...
wsl --install Ubuntu -n
wsl -d Ubuntu -u root ./init.sh --ubuntu

title Installing CentOS...
echo Installing CentOS...
wsl --import CentOS "%WSL_IMPORT_DIR%" CentOS.tar
del /q /f CentOS.tar; del /q /f CentOS.tar.gz
wsl -d CentOS -u root ./init.sh --centos

title Done
echo Done

pause
exit /b %errorlevel%
