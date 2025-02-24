@echo off

cd /d "%~dp0"

title Exporting RHEL9...
echo Exporting RHEL9...
wsl -d RHEL9 -u root ./export.sh
wsl --export RHEL9 RHEL9.tar.gz --format tar.gz

if defined SKIP_PAUSE goto :end

title Done
echo Done

pause
exit /b %errorlevel%

:end
