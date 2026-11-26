# Dotfiles

A cross-platform developer environment configuration managed by **Nix Flakes** and **Home Manager**, supporting Ubuntu Linux and macOS.

## 🚀 Included Tools & Configuration

- **Package Management**: [Nix Flakes](https://nixos.wiki/wiki/Flakes) + [Home Manager](https://github.com/nix-community/home-manager)
- **Shells**: Zsh (set as default login shell) & Bash configured with [Starship prompt](https://starship.rs/) and [Fzf](https://github.com/junegunn/fzf).
- **Editors**:
  - [Helix](https://helix-editor.com/) (default editor with Tokyo Night theme and relative line numbers).
  - [Micro](https://github.com/zyedidia/micro) (modern terminal text editor).
- **Terminal & Multiplexer**:
  - [WezTerm](https://wezfurlong.org/wezterm/) (GPU-accelerated terminal emulator installed via Nix and configured with Tokyo Night & JetBrainsMono Nerd Font).
  - [Tmux](https://github.com/tmux/tmux) (terminal multiplexer optimized with zero escape delay for editing).
- **Languages & Runtimes**:
  - `nodejs` (Node.js runtime with `npm`, required for `pi`).
  - `bun` (JavaScript and TypeScript runtime, bundler, and package manager).
- **CLI Utilities & AI Tools**:
  - `uv` (fast Python package installer/resolver).
  - `glow` (Markdown renderer for the terminal).
  - `pi` (Pi coding agent harness, configured with `pi-web-access` and `pi-subagents` extensions).
  - `herdr` (terminal workspace manager for AI coding agents, installed via `nonixpackages/`).
- **Git**: Pre-configured with default branch `main` and rebase on pull.

---

## 📦 Repository Structure

```text
├── flake.nix             # Nix Flake defining outputs for Ubuntu & macOS
├── flake.lock            # Locked dependency versions
├── home.nix              # Home Manager configuration (packages, tools, dotfiles)
├── install.sh            # Automated installation script
└── nonixpackages/
    └── install.sh        # Script for installing non-Nix tools (e.g., pi)
```

---

## 🛠️ Installation & Usage

### Automated Installation

You can bootstrap your entire environment with a single command. The installer will automatically install Nix (if not already installed), apply the Home Manager configuration for your operating system, and install any auxiliary non-Nix packages.

```bash
git clone https://github.com/YOUR_USERNAME/dotfiles.git ~/.dotfiles
cd ~/.dotfiles
./install.sh
```

### Manual Installation

1. **Install Nix** (if not already installed):
   ```bash
   curl --proto '=https' --tlsv1.2 -sSf -L https://install.determinate.systems/nix | sh -s -- install
   ```
2. **Apply Home Manager Configuration**:
   ```bash
   nix run home-manager/master -- switch --flake ".#ubuntu" # or .#macos
   ```
3. **Install Non-Nix Packages**:
   ```bash
   ./nonixpackages/install.sh
   ```

---

## ⚙️ Customization

1. **Personal Information**:
   Update your Git name and email in `home.nix`:
   ```nix
   programs.git = {
     enable = true;
     settings = {
       user = {
         name = "Your Name";
         email = "your.email@example.com";
       };
     };
   };
   ```

2. **Usernames & System Targets**:
   If your system username or architecture differs from the defaults (`orion` on `x86_64-linux` or `aarch64-darwin`), update `flake.nix`:
   ```nix
   "ubuntu" = mkHome {
     system = "x86_64-linux";
     username = "your-username";
     homeDirectory = "/home/orion";
   };
   ```

3. **Adding Packages**:
   Add desired Nix packages to `home.packages` in `home.nix`:
   ```nix
   home.packages = with pkgs; [
     uv
     glow
     nerd-fonts.jetbrains-mono
     ripgrep
     fd
     jq
   ];
   ```

4. **Updating the Environment**:
   To update flake inputs (nixpkgs, home-manager) to their latest versions:
   ```bash
   nix flake update
   nix run home-manager/master -- switch --flake ".#ubuntu"
   ```
