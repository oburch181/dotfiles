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

echo "Non-Nix packages complete."
