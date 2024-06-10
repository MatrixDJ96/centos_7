# -*- mode: ruby -*-
# vi: set ft=ruby :

require 'yaml'

def GetPath(file)
    return File.expand_path(File.dirname(__FILE__)) + "/" + file
end

# Set right settings file
if Vagrant::Util::Platform.windows? then
    settingsFile = "settings.windows.yaml"
elsif Vagrant::Util::Platform.darwin?
    settingsFile = "settings.darwin.yaml"
else
    settingsFile = "settings.linux.yaml"
end

if !File.exist?(GetPath(settingsFile)) then
    settingsFile = "settings.yaml"
end

settings = $settings ||= YAML::load(File.read(GetPath(settingsFile)))

settings['synced_folder'] = settings['synced_folder'] || {}
settings['synced_folder']['map'] = (settings['synced_folder']['map'] || "").strip

if settings['synced_folder']['map'].empty? then
    abort 'Missing/wrong synced folder map configuration!'
end

settings['synced_folder']['opts'] = settings['synced_folder']['opts'] || {}
settings['synced_folder']['opts']['type'] = settings['synced_folder'].delete('type')
settings['synced_folder']['opts'] = settings['synced_folder']['opts'].transform_keys(&:to_sym)

settings['forwarded_ports'] = settings['forwarded_ports'] || {}
settings['forwarded_ports']['ftp'] = settings['forwarded_ports']['ftp'] || 2221
settings['forwarded_ports']['ssh'] = settings['forwarded_ports']['ssh'] || 2222
settings['forwarded_ports']['http'] = settings['forwarded_ports']['http'] || 80
settings['forwarded_ports']['https'] = settings['forwarded_ports']['https'] || 443
settings['forwarded_ports']['mysql'] = settings['forwarded_ports']['mysql'] || 3306

settings['vm'] = settings['vm'] || {}
settings['vm']['gui'] = settings['vm']['gui'] || false
settings['vm']['cpus'] = settings['vm']['cpus'] || 2
settings['vm']['memory'] = settings['vm']['memory'] || 4096
settings['vm']['name'] = settings['vm']['name'] || ""

settings['ssh'] = settings['ssh'] || {}
settings['ssh']['insert_key'] = settings['ssh'].has_key?('insert_key') ? settings['ssh']['insert_key'] : false
settings['ssh']['forward_agent'] = settings['ssh'].has_key?('forward_agent') ? settings['ssh']['forward_agent'] : false
settings['ssh']['private_key_path'] = settings['ssh'].has_key?('private_key_path') ? settings['ssh']['private_key_path'] : ""

Vagrant.configure("2") do |config|
    # Use Centos 7 has base machine
    config.vm.box = "generic/centos7"

    # Hostname
    config.vm.hostname = "vagrant.local"

    # Forwarded ports
    config.vm.network :forwarded_port, auto_correct:true, guest: 21, host: settings['forwarded_ports']['ftp']               # FTP
    config.vm.network :forwarded_port, auto_correct:true, guest: 22, host: settings['forwarded_ports']['ssh'], id: "ssh"    # SSH
    config.vm.network :forwarded_port, auto_correct:true, guest: 80, host: settings['forwarded_ports']['http']              # Apache (HTTP)
    config.vm.network :forwarded_port, auto_correct:true, guest: 443, host: settings['forwarded_ports']['https']            # Apache (HTTPS)
    config.vm.network :forwarded_port, auto_correct:true, guest: 3306, host: settings['forwarded_ports']['mysql']           # MySQL

    # Private network
    config.vm.network :private_network, type: "dhcp"

    # Provision
    config.vm.provision :shell, :path => "config/provision.sh"

    # Virtualbox plugin
    if Vagrant.has_plugin?("vagrant-vbguest")
        config.vbguest.auto_update = false
    end

    # WinFSD plugin
    if Vagrant::Util::Platform.windows? then
        if Vagrant.has_plugin?("vagrant-winnfsd") then
            config.winnfsd.uid = 1
            config.winnfsd.gid = 1
        end
    end

    # Apache trigger
    config.trigger.after [:up, :reload] do |trigger|
        trigger.run_remote = {inline: "systemctl start httpd"}
    end

    # Synced folders
    config.vm.synced_folder ".", "/vagrant", disabled: true
    config.vm.synced_folder "config", "/vagrant/config", create: true, owner: "root", group: "root"
    config.vm.synced_folder settings['synced_folder']['map'], "/vagrant/projects", settings['synced_folder']['opts']

    # VirtualBox settings
    config.vm.provider "virtualbox" do |vm|
        vm.gui = settings['vm']['gui']
        vm.cpus = settings['vm']['cpus']
        vm.memory = settings['vm']['memory']
        if !settings['vm']['name'].empty? then
            vm.name = settings['vm']['name']
        end
    end

    # VMWare settings
    ["vmware_workstation", "vmware_desktop"].each do |provider|
        config.vm.provider provider do |vm|
        vm.gui = settings['vm']['gui']
        vm.cpus = settings['vm']['cpus']
        vm.memory = settings['vm']['memory']
        vm.linked_clone = false
        end
    end

    # SSH settings
    config.ssh.insert_key = settings['ssh']['insert_key']
    config.ssh.forward_agent = settings['ssh']['forward_agent']
    if (!settings['ssh']['private_key_path'].nil? && !settings['ssh']['private_key_path'].empty?)
        config.ssh.private_key_path = settings['ssh']['private_key_path']
    end
end
