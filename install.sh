#!/usr/bin/env bash
set -e

echo "=> Updating apt and installing prerequisites..."
sudo apt update && sudo apt install -y curl git zsh

if ! command -v nix &> /dev/null; then
    echo "=> Installing Nix via Determinate Systems..."
    curl --proto '=https' --tlsv1.2 -sSf -L https://install.determinate.systems/nix | sh -s -- install
    . /nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh
else
    echo "=> Nix is already installed."
fi

echo "=> Bootstrapping Home Manager..."
# Runs Home Manager directly from the flake in your current directory
nix run home-manager/master -- switch --flake .#orion@ubuntu-laptop

echo "=> Setting Zsh as default shell..."
sudo chsh -s $(which zsh) orion

echo "=> Setup complete. Close and reopen your terminal."