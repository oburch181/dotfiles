#!/usr/bin/env bash
set -euo pipefail

echo "Installing non-Nix packages..."

# Pi coding agent harness (https://pi.dev)
if ! command -v pi >/dev/null 2>&1; then
  echo "Installing pi..."
  curl -fsSL https://pi.dev/install.sh | sh
else
  echo "pi is already installed ($(pi --version)). Skipping."
fi

# Ensure ~/.local/bin is in PATH for the current session so pi (and other tools) can be used immediately
case ":$PATH:" in
  *":$HOME/.local/bin:"*) ;;
  *) export PATH="$HOME/.local/bin:$PATH" ;;
esac

# Pi extensions
if command -v pi >/dev/null 2>&1; then
  PI_INSTALLED="$(pi list 2>/dev/null || true)"
  for pkg in "npm:pi-web-access" "npm:pi-subagents"; do
    if printf '%s\n' "$PI_INSTALLED" | grep -qF "$pkg"; then
      echo "pi extension $pkg is already installed. Skipping."
    else
      echo "Installing pi extension $pkg..."
      pi install "$pkg"
    fi
  done
fi

# Herdr (https://herdr.dev)
if ! command -v herdr >/dev/null 2>&1; then
  echo "Installing herdr..."
  curl -fsSL https://herdr.dev/install.sh | sh
else
  echo "herdr is already installed. Skipping."
fi

echo "Non-Nix packages complete."
