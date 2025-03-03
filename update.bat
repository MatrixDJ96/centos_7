@echo off

cd /d "%~dp0"

set SKIP_PAUSE=1

title Updating CentOS...
echo Updating CentOS...
wsl -d CentOS -u root ./init.sh --centos

title Done
echo Done

pause
exit /b %errorlevel%
