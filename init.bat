@echo off

cd /d "%~dp0"

set SKIP_PAUSE=1

title Cleaning system...
echo Cleaning system...
wsl --unregister RHEL9
wsl --unregister Ubuntu

title Installing Ubuntu...
echo Installing Ubuntu...
wsl --install Ubuntu -n
wsl -d Ubuntu -u root ./init.sh --ubuntu

call import.bat RHEL9.tar --clean

title Installing RHEL9...
echo Installing RHEL9...
wsl -d RHEL9 -u root ./init.sh --centos

title Done
echo Done

pause
exit /b %errorlevel%
