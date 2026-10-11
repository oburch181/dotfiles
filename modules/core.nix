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
  ];

  # Manage Zsh so Home Manager can inject Nix paths automatically
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;
    initExtra = ''
      eval "$(starship init zsh)"
    '';
  };

  # Symlink native config files into ~/.config/
  xdg.configFile."wezterm/wezterm.lua".source = ../dotconfig/wezterm/wezterm.lua;
  xdg.configFile."starship.toml".source = ../dotconfig/starship.toml;
  xdg.configFile."micro/settings.json".source = ../dotconfig/micro/settings.json;
}