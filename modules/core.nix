{ config, pkgs, ... }:

{
  home.packages = with pkgs; [
    wezterm
    starship
    micro
    uv
    cargo
    tmux
    gh
    eza
    nerd-fonts.jetbrains-mono
  ];

  fonts.fontconfig.enable = true;
  
  # Manage Zsh so Home Manager can inject Nix paths automatically
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;
    shellAliases = {
      ls = "eza --icons --group-directories-first";
      ll = "eza -al --icons --group-directories-first";
    };
    initExtra = ''
      eval "$(starship init zsh)"
    '';
  };

  # Symlink native config files into ~/.config/
  xdg.configFile."wezterm/wezterm.lua".source = ../dotconfig/wezterm/wezterm.lua;
  xdg.configFile."starship.toml".source = ../dotconfig/starship.toml;
  xdg.configFile."micro/settings.json".source = ../dotconfig/micro/settings.json;
}