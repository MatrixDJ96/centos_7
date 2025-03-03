@echo off

cd /d "%~dp0"

set SKIP_PAUSE=1

title Cleaning system...
echo Cleaning system...
wsl --unregister CentOS
wsl --unregister Ubuntu

title Installing Ubuntu...
echo Installing Ubuntu...
wsl --install Ubuntu -n
wsl -d Ubuntu -u root ./init.sh --ubuntu

call import.bat CentOS.tar --clean

title Installing CentOS...
echo Installing CentOS...
wsl -d CentOS -u root ./init.sh --centos

title Done
echo Done

pause
exit /b %errorlevel%
