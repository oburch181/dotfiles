{ pkgs, username, homeDirectory, ... }:

{
  home.username = username;
  home.homeDirectory = homeDirectory;
  home.stateVersion = "25.11";

  # Let Home Manager manage itself
  programs.home-manager.enable = true;

  # Ensure ~/.local/bin is in PATH for non-Nix binaries (herdr, pi, etc.)
  home.sessionPath = [
    "$HOME/.local/bin"
  ];

  # Enable font discovery for Nix-installed fonts
  fonts.fontconfig.enable = true;

  # Standalone CLI tools and fonts
  home.packages = with pkgs; [
    uv
    glow
    nodejs
    bun
    wezterm
    cmake
    nerd-fonts.jetbrains-mono
  ];

  # Shells (required so starship/fzf integrations inject into rc files)
  programs.zsh = {
    enable = true;
    syntaxHighlighting.enable = true;
  };
  programs.bash.enable = true;

  # Git
  programs.git = {
    enable = true;
    settings = {
      user = {
        name = "orion"; # Update with your name
        email = "you@example.com"; # Update with your email
      };
      init.defaultBranch = "main";
      pull.rebase = true;
    };
  };

  # Helix text editor
  programs.helix = {
    enable = true;
    defaultEditor = true;
    settings = {
      theme = "tokyonight";
      editor = {
        line-number = "relative";
        mouse = true;
        cursor-shape = {
          insert = "bar";
          normal = "block";
          select = "underline";
        };
      };
    };
  };

  # Micro text editor
  programs.micro = {
    enable = true;
    settings = {
      colorscheme = "darcula";
      softwrap = true;
    };
  };

  # WezTerm
  programs.wezterm = {
    enable = true;
    extraConfig = ''
      local wezterm = require 'wezterm'
      local config = wezterm.config_builder()

      config.color_scheme = 'Tokyo Night'
      config.font = wezterm.font 'JetBrains Mono'
      config.font_size = 13.0
      config.hide_tab_bar_if_only_one_tab = true
      config.window_decorations = "TITLE | RESIZE"

      return config
    '';
  };

  # Tmux (escapeTime = 0 prevents Esc lag in Helix)
  programs.tmux = {
    enable = true;
    mouse = true;
    baseIndex = 1;
    escapeTime = 0;
    terminal = "screen-256color";
    extraConfig = ''
      set -ga terminal-overrides ",*256col*:Tc"
    '';
  };

  # Starship prompt
  programs.starship = {
    enable = true;
    enableZshIntegration = true;
    enableBashIntegration = true;
  };

  # Fuzzy finder
  programs.fzf = {
    enable = true;
    enableZshIntegration = true;
    enableBashIntegration = true;
  };
}
