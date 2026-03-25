#!/bin/bash
# Run this ONCE on the Ubuntu server to prepare it for deployments.
# Usage: bash server-setup.sh <YOUR_GITHUB_REPO_URL>
#
# Example: bash server-setup.sh https://github.com/yourname/my-app.git

set -e

REPO_URL="${1:?Usage: $0 <github-repo-url>}"
APP_DIR="$HOME/my-app"

echo "=== 1. Install Docker ==="
if ! command -v docker &>/dev/null; then
  curl -fsSL https://get.docker.com | sh
  sudo usermod -aG docker "$USER"
  echo "Docker installed. NOTE: Log out and back in for group membership to take effect."
  echo "Then re-run this script."
  exit 0
fi

echo "=== 2. Clone repository ==="
if [ -d "$APP_DIR" ]; then
  echo "  Directory $APP_DIR already exists, skipping clone."
else
  git clone "$REPO_URL" "$APP_DIR"
fi

echo "=== 3. Create production .env ==="
if [ ! -f "$APP_DIR/.env" ]; then
  cat > "$APP_DIR/.env" <<'EOF'
NODE_ENV=production

# Postgres
POSTGRES_USER=myapp
POSTGRES_PASSWORD=CHANGE_ME
POSTGRES_DB=myapp

# Ports (optional – defaults match docker-compose.yml)
PORT_API=8000
PORT_WEB=3000
PORT_DOCS=3030
EOF
  echo "  Created $APP_DIR/.env — EDIT IT before first deploy!"
else
  echo "  $APP_DIR/.env already exists, skipping."
fi

echo "=== 4. Generate SSH key for GitHub Actions ==="
KEY_FILE="$HOME/.ssh/github_deploy_key"
if [ ! -f "$KEY_FILE" ]; then
  ssh-keygen -t ed25519 -C "github-actions-deploy" -f "$KEY_FILE" -N ""
  echo ""
  echo "  ✅ Public key (add to ~/.ssh/authorized_keys on THIS server):"
  cat "${KEY_FILE}.pub"
  cat "${KEY_FILE}.pub" >> "$HOME/.ssh/authorized_keys"
  chmod 600 "$HOME/.ssh/authorized_keys"
  echo ""
  echo "  ✅ Private key (add as SSH_PRIVATE_KEY secret in GitHub):"
  cat "$KEY_FILE"
else
  echo "  Key $KEY_FILE already exists."
  echo "  Private key (SSH_PRIVATE_KEY secret):"
  cat "$KEY_FILE"
fi

echo ""
echo "=== Done ==="
echo ""
echo "Next steps:"
echo "  1. Edit $APP_DIR/.env with real secrets"
echo "  2. Add the private key above as GitHub secret SSH_PRIVATE_KEY"
echo "  3. Add GitHub secrets: SSH_HOST=100.88.70.112, SSH_USER=dan"
echo "  4. Add GitHub secret TAILSCALE_AUTHKEY (from tailscale.com/settings/keys)"
echo "  5. Push to main branch → auto-deploy!"
