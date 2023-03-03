@echo off

cd /d "%~dp0"

title Installing ssh key...
echo Installing ssh key...

type NUL>>"%USERPROFILE%\.ssh\config"
if not exist "%USERPROFILE%\.ssh\id_vagrant" (
    ssh-keygen -q -t rsa -b 4096 -C "vagrant" -P "" -f "%USERPROFILE%\.ssh\id_vagrant"
)

type "%USERPROFILE%\.ssh\config">config\tmp_ssh_config
type "%USERPROFILE%\.ssh\id_vagrant.pub">config\tmp_ssh_pub

vagrant ssh -c "sudo bash /vagrant/config/extra/install_ssh_key.sh"

type config\tmp_ssh_config>"%USERPROFILE%\.ssh\config"

del /f config\tmp_ssh_config>NUL 2>&1
del /f config\tmp_ssh_pub>NUL 2>&1

title Done
echo Done

pause
exit /b %errorlevel%
