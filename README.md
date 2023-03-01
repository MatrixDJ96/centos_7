### Requisiti
- [Vagrant][1]
- [VirtualBox][2]

### Configurazione VM
Per configurare la macchina virtuale è necessario creare il file **settings.yaml** (usare il file **settings.yaml.example** come riferimento)\
Nel file di configurazione è ***necessario*** impostare il percorso relativo dello share dei progetti fra *guest* e *host*\
Inoltre è possibile impostare il tipo di share fra *guest* e *host*, modificare la quantità di *ram* e cambiare il numero di *core* della **VM**

### Installazione VM
- Eseguire **plugins.(bat/sh)** per installare/aggiornare i plugin di *Vagrant* necessari
- Eseguire **init.(bat/sh)** per installare/aggiornare la macchina virtuale con *VirtualBox*
- Eseguire **install_virtualhosts.(bat/sh)** per aggiornare il file host della macchina *guest* e *host*

### Utilizzo VM
Per usare correttamente la macchina virtuale è necessario clonare i progetti *Web* all'interno della cartella **/vagrant/projects**

[1]: https://www.vagrantup.com/downloads.html
[2]: https://www.virtualbox.org/wiki/Downloads
