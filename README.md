# RHEL9 Dev Environment — Docker / WSL2

Ambiente di sviluppo basato su **RHEL9** pensato per lavorare localmente con stack web completi in modo riproducibile.

Stack incluso:
- Apache (VirtualHost da file di configurazione)
- MySQL
- PHP + Composer
- Node.js
- Java + Tomcat
- Keycloak
- Mercure
- Tool di supporto installati via provisioning

Il progetto nasce inizialmente per **Vagrant/VirtualBox**, ma oggi il flusso principale è:

- **Linux / macOS:** Docker
- **Windows:** WSL2 (distro RHEL9 importata)

---

## Requisiti

### Linux / macOS
- Docker Engine o Docker Desktop
- Permessi per eseguire Docker

### Windows
- Windows 10/11 con **WSL2**
- Possibilità di installare la distro **Ubuntu** (usata come ambiente di bootstrap)
- Privilegi admin per aggiornare il file `hosts`

---

## Quick start

### Linux / macOS (Docker)

```bash
./init.sh
```

Lo script:
- scarica l’immagine `matrixdj96/rhel9:latest`
- avvia il container `rhel9`
- configura i VirtualHost nel file `hosts`
- imposta accesso SSH tramite chiave

---

### Windows (WSL2)

```bat
init.bat
```

Lo script:
- prepara Ubuntu WSL (Docker / Podman)
- scarica ed esporta l’immagine RHEL9
- importa la distro `RHEL9` in WSL
- configura VirtualHost e SSH lato Windows

Accesso alla distro:
```bat
wsl -d RHEL9
```

---

## Progetti e volumi

### Codice sorgente
All’interno dell’ambiente:
```
/vagrant/projects
```

### Persistenza (Docker)
Sul sistema host:
```
~/.rhel9/
├── home        → /root
├── mysql       → /var/lib/mysql
└── projects    → /vagrant/projects
```

---

## Apache VirtualHost

- Configurazioni in:
  ```
  config/apache/*.conf
  ```
- Gli script leggono i `ServerName` e li mappano automaticamente nel file `hosts`
- I VirtualHost puntano a:
  ```
  /vagrant/projects
  ```

---

## Porte esposte (Docker)

- 80   → HTTP
- 443  → HTTPS
- 2222 → SSH
- 3306 → MySQL

---

## SSH

Gli script `install_ssh_key.sh / .bat`:
- generano `~/.ssh/id_vagrant` (se assente)
- configurano `~/.ssh/config`
- installano la chiave nell’ambiente

Accesso:
```bash
ssh vagrant.local
```

Nota:
- In Docker l’accesso avviene come **root** (via chiave).
- In WSL viene creato l’utente **vagrant** e impostato come default.

---

## VirtualHost mapping (hosts)

### Linux / macOS
```bash
./install_virtualhosts.sh
```
(Richiede privilegi per modificare `/etc/hosts`)

### Windows
```bat
install_virtualhosts.bat
```
(Viene richiesto l’accesso come amministratore)

---

## Build e push immagine (opzionale)

Build locale:
```bash
./build.sh
```

Push (usa podman):
```bash
./push.sh
```

---

## Legacy: Vagrant / VirtualBox

Nel repository sono ancora presenti:
- `Vagrantfile`
- `settings.yaml.example`

Questa modalità è **deprecata** e non più mantenuta attivamente.  
Il flusso consigliato è **Docker / WSL2**.

---

## Note

- L’ambiente è pensato per uso **locale**.
- Tutta la configurazione applicativa avviene tramite script.
- Nessuna dipendenza da VirtualBox nel flusso attuale.
