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

# Herdr (https://herdr.dev)
if ! command -v herdr >/dev/null 2>&1; then
  echo "Installing herdr..."
  curl -fsSL https://herdr.dev/install.sh | sh
else
  echo "herdr is already installed. Skipping."
fi

echo "Non-Nix packages complete."
