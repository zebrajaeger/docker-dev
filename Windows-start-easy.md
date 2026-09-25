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
Für einen SSH Zugang zum Container muss ein SSH key hinterlegt werden.
Typischerweise ungefähr so:

```powershell
ssh-keygen -t ed25519 -f %USERPROFILE%\.ssh\docker-dev
```
