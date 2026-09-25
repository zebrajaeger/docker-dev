#!/bin/bash
set -e

SSH_DIR=/home/developer/.ssh
AZURE_KEY="$SSH_DIR/azure"
AUTHORIZED_KEYS="$SSH_DIR/authorized_keys"
NVM_DIR=/home/developer/.nvm
CONFIG_DIRS=(
    /home/developer/.omniroute
    /home/developer/.config/opencode
    /home/developer/.codex
    /home/developer/.claude
)

start_as_developer() {
    sudo -u developer -H env NVM_DIR="$NVM_DIR" bash -c "$1" &
}

mkdir -p "$SSH_DIR"
chmod 700 "$SSH_DIR"

for config_dir in "${CONFIG_DIRS[@]}"; do
    mkdir -p "$config_dir"
    chown -R developer:developer "$config_dir"
done

if [ ! -f "$AZURE_KEY" ]; then
    echo "Generating Azure DevOps SSH key..."

    ssh-keygen \
        -t rsa \
        -b 4096 \
        -f "$AZURE_KEY" \
        -N ""

    chown developer:developer "$AZURE_KEY" "$AZURE_KEY.pub"
    chmod 600 "$AZURE_KEY"
    chmod 644 "$AZURE_KEY.pub"
fi

cat > "$SSH_DIR/config" <<'EOF'
Host azure
    HostName ssh.dev.azure.com
    User git
    IdentityFile ~/.ssh/azure
    IdentitiesOnly yes
EOF

chmod 600 "$SSH_DIR/config"
chown developer:developer "$SSH_DIR/config"

if [ -f /ssh-host-key/authorized_key.pub ]; then
    cp /ssh-host-key/authorized_key.pub "$AUTHORIZED_KEYS"
    chmod 600 "$AUTHORIZED_KEYS"
    chown developer:developer "$AUTHORIZED_KEYS"
fi

if [ "$START_OMNIROUTE" = "true" ]; then
    echo "Starting OmniRoute on port 20128..."
    start_as_developer 'source "$NVM_DIR/nvm.sh" && exec omniroute serve'
fi

if [ "$START_OPENCODE" = "true" ]; then
    echo "Starting OpenCode on port 4096..."
    start_as_developer 'source "$NVM_DIR/nvm.sh" && exec opencode serve --hostname 0.0.0.0 --port 4096'
fi

if [ "$START_CODEX" = "true" ]; then
    echo "Starting Codex terminal on port 7682..."
    start_as_developer 'source "$NVM_DIR/nvm.sh" && exec ttyd -p 7682 bash -lc "source \"$NVM_DIR/nvm.sh\" && exec codex"'
fi

if [ "$START_CLAUDE" = "true" ]; then
    echo "Starting Claude Code terminal on port 7683..."
    start_as_developer 'exec ttyd -p 7683 bash -lc "exec claude"'
fi

echo
echo "============================================================"
echo "Azure DevOps public key"
echo "============================================================"
cat "$AZURE_KEY.pub"
echo "============================================================"
echo

exec "$@"
