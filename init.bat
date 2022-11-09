@echo off

cd /d "%~dp0"

title Installing vagrant machine...
echo Installing vagrant machine...
vagrant up --provision --provider=%1
if %errorlevel% neq 0 (
	goto :custom_exit
)

if /I "%1" == "virtualbox" (
	echo.
	title Installing Virtualbox Guest Additions...
	echo Installing Virtualbox Guest Additions...
	vagrant vbguest --auto-reboot --no-provision
)

echo.
vagrant reload
if %errorlevel% neq 0 (
	goto :custom_exit
)

echo.
title Done
echo Now you should install virtual hosts running 'install_virtualhosts.bat' as admin
echo.

:custom_exit
	if %errorlevel% neq 0 (
		echo Error code: %errorlevel%
	)
	
pause
exit /b %errorlevel%
