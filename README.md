### Requisiti

- [Vagrant][1]
- [VirtualBox][2]

### Configurazione

Seguire le info presenti nel file **settings.yaml.example** per le configurare _Vagrant_

### Installazione

- Creare il file **settings.yaml** nella root del progetto
- Impostare la chiave _**synced_folder.map**_ nel file appena creato con il path desiderato
- Eseguire `init.(bat/sh) virtualbox` per installare/aggiornare la macchina virtuale con _VirtualBox_

### Post-Installazione

Per mappare i _Virtual Host_ di _Apache_ eseguire `install_virtualhosts.(bat/sh)` come admin\
Questo script aggiorna il file hosts di sistema mappando in _localhost_ i _Virtual Host_ di _Apache_

Per poter connettersi tramite `ssh vagrant.local` senza password eseguire `install_ssh_key.(bat/sh)`\
Questo script genera una nuova coppia di chiavi ssh e configura ssh per permette la connessione remota

Per ottimizzare le risorse attribuite alla macchima virtuale installare questo plugin tramite il comando
- vagrant plugin install vagrant-vagrant-faster
avi ssh e configura ssh per permette la connessione remota

Per usare la condivisione **NFS** delle cartelle su _Windows_ installare questo plugin tramite il comando
- vagrant plugin install vagrant-winnfsd

### Apache

Per usare _Apache_ è necessario creare i _Virtual Host_ all'interno della cartella **config/apache**\
I _Virtual Host_ creati dovranno avere la **DocumentRoot** nella sotto cartella **/vagrant/projects**

### Password

Tutte le password di sistema sono `vagrant`

[1]: https://www.vagrantup.com/downloads.html
[2]: https://www.virtualbox.org/wiki/Downloads

### Risoluzioni problemi

- Problema configurazione scheda di rete VirtualBox\
  Rimuovere tutte le schede di tipo Host-Only tramite VirtualBox
