#!/usr/bin/env bash
set -euo pipefail

# 1. Install Nix if not present
if ! command -v nix >/dev/null 2>&1; then
  echo "Installing Nix..."
  curl --proto '=https' --tlsv1.2 -sSf -L https://install.determinate.systems/nix | sh -s -- install
fi

# 2. Load Nix into the current shell session
if [ -e '/nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh' ]; then
  # shellcheck disable=SC1091
  . '/nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh'
fi

# 3. Detect OS target
OS="$(uname -s)"
case "$OS" in
  Linux)  TARGET="ubuntu" ;;
  Darwin) TARGET="macos" ;;
  *)
    echo "Unsupported OS: $OS"
    exit 1
    ;;
esac

# 4. Launch Home Manager from the flake
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
echo "Applying Home Manager configuration for '${TARGET}'..."
nix run home-manager/master -- switch --flake "${SCRIPT_DIR}#${TARGET}" -b backup

# 5. Install non-Nix packages
if [ -x "${SCRIPT_DIR}/nonixpackages/install.sh" ]; then
  "${SCRIPT_DIR}/nonixpackages/install.sh"
fi

echo "Done! Restart your terminal to load the new environment."
