#!/bin/bash
set -e

SSH_DIR=/home/developer/.ssh
AZURE_KEY="$SSH_DIR/azure"
AUTHORIZED_KEYS="$SSH_DIR/authorized_keys"

mkdir -p "$SSH_DIR"
chmod 700 "$SSH_DIR"

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

echo
echo "============================================================"
echo "Azure DevOps public key"
echo "============================================================"
cat "$AZURE_KEY.pub"
echo "============================================================"
echo

exec "$@"
