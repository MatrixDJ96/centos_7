@echo off

cd /d "%~dp0"

set skip_pause=%1

title Installing vagrant plugins
echo Installing vagrant plugins
vagrant plugin install vagrant-vbguest

if "%skip_pause%" neq "1" (
	pause
)

exit /b %errorlevel%
