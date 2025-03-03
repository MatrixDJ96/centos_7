@echo off

cd /d "%~dp0"

set SKIP_PAUSE=1

title Updating RHEL9...
echo Updating RHEL9...
wsl -d RHEL9 -u root ./init.sh --centos

title Done
echo Done

pause
exit /b %errorlevel%
