@echo off

cd /d "%~dp0"

title Exporting CentOS...
echo Exporting CentOS...
wsl -d CentOS -u root ./export.sh
wsl --export CentOS CentOS.tar.gz --format tar.gz

title Done
echo Done

pause
exit /b %errorlevel%
