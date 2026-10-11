# Orion's Development Environment

Cross-platform reproducible dotfiles using Nix, Flakes, and Home Manager.

## Bootstrapping a New Machine
1. Open a terminal on a fresh Ubuntu install.
2. Clone this repo: `git clone https://github.com/orion/dotfiles.git ~/dotfiles`
3. Enter the directory: `cd ~/dotfiles`
4. Run the bootstrap script: `./install.sh`
5. Restart your terminal and run `gh auth login` to authenticate Git.