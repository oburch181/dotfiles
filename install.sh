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

# 5. Ensure zsh is set as the default shell if available
ZSH_PATH="$(command -v zsh || true)"
if [ -n "$ZSH_PATH" ] && [ "$SHELL" != "$ZSH_PATH" ]; then
  echo "Setting zsh as default login shell..."
  if grep -q "$ZSH_PATH" /etc/shells 2>/dev/null; then
    chsh -s "$ZSH_PATH" || echo "Note: Could not automatically change default shell to zsh. You can run: chsh -s $ZSH_PATH"
  else
    echo "Note: $ZSH_PATH not found in /etc/shells. Skipping automatic chsh."
  fi
fi

# 6. Install non-Nix packages
if [ -x "${SCRIPT_DIR}/nonixpackages/install.sh" ]; then
  "${SCRIPT_DIR}/nonixpackages/install.sh"
fi

echo "Done! Restart your terminal to load the new environment."
