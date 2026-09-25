# Windows Easy Start

## Docker Umgebung einrichten
[Rancher Desktop](https://rancherdesktop.io/) installieren und Moby als Container Engine auswählen.
Kubernetes kann deaktiviert werden.

Alternativ: 
- Docker Desktop (ab 250 Mitarbeiter oder 10Mio Jahresumsatz Lizenzpflichtig)
- Docker in WSL2

## Projekt clonen

Es wird davon ausgegangen, dass es einen Ordner gibt, in dem alle Projekte liegen.
Angenommen, es ist `C:\workspace`:

```powershell
cd C:\workspace
git clone https://github.com/zebrajaeger/docker-dev.git
cd docker-dev
```

## Container starten
```powershell
C:\workspace\docker-dev
rebuild.cmd
```

## SSH
Der SSH Key wird automatisch generiert und in `%USERPROFILE%\.ssh\docker-dev` abgelegt. Das Startskript legt `%USERPROFILE%\.ssh` und die SSH-Konfiguration bei Bedarf an.

Die automatisch erstellte `%USERPROFILE%\.ssh\config` enthält:

```
Host d
    HostName 127.0.0.1
    Port 2222
    User developer
    IdentityFile ~/.ssh/docker-dev
    IdentitiesOnly yes
```

Dann kann per `ssh d` auf den Container zugegriffen werden.
