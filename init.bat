@echo off

cd /d "%~dp0"

title Installing vagrant machine...
echo Installing vagrant machine...
vagrant up --provision --provider=%1

install_virtualhosts.bat
install_ssh_key.bat

vagrant reload

title Done
echo Done

pause
exit /b %errorlevel%
