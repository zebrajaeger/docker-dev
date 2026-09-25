@echo off
set "SSH_DIR=%USERPROFILE%\.ssh"

if not exist "%SSH_DIR%" mkdir "%SSH_DIR%"

if not exist "%SSH_DIR%\docker-dev" type nul > "%SSH_DIR%\docker-dev"

if not exist "%SSH_DIR%\config" (
    > "%SSH_DIR%\config" echo Host d
    >> "%SSH_DIR%\config" echo     HostName 127.0.0.1
    >> "%SSH_DIR%\config" echo     Port 2222
    >> "%SSH_DIR%\config" echo     User developer
    >> "%SSH_DIR%\config" echo     IdentityFile ~/.ssh/docker-dev
    >> "%SSH_DIR%\config" echo     IdentitiesOnly yes
)
