{ pkgs, username, homeDirectory, ... }:

{
  home.username = username;
  home.homeDirectory = homeDirectory;
  home.stateVersion = "25.11";

  # Let Home Manager manage itself
  programs.home-manager.enable = true;

  # Standalone CLI tools
  home.packages = with pkgs; [
    uv
    glow
  ];

  # Shells (required so starship/fzf integrations inject into rc files)
  programs.zsh.enable = true;
  programs.bash.enable = true;

  # Git
  programs.git = {
    enable = true;
    userName = "orion"; # Update with your name
    userEmail = "you@example.com"; # Update with your email
    extraConfig = {
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
