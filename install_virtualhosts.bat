@echo off

set "params=%*"

cd /d "%~dp0"

title Installing virtual hosts...
echo Installing virtual hosts...

type C:\Windows\System32\drivers\etc\hosts>config\hosts\tmp

vagrant ssh -c "sudo bash /vagrant/config/hosts/install_virtualhosts.sh"
if %errorlevel% neq 0 (
	goto :custom_exit
)

type config\hosts\tmp>C:\Windows\System32\drivers\etc\hosts
del config\hosts\tmp

:custom_exit
	if %errorlevel% neq 0 (
		echo Error code: %errorlevel%
	)

pause
exit /b %errorlevel%
