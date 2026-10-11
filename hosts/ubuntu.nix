{ config, pkgs, ... }:

{
  imports = [
    ../modules/core.nix
    ../modules/ai.nix
  ];

  home.username = "orion";
  home.homeDirectory = "/home/orion";

  # Do not change this version even when you upgrade Nixpkgs. 
  # It defines the first version of Home Manager you used, ensuring backwards compatibility for stateful files.
  home.stateVersion = "24.05"; 

  # Let Home Manager install and manage itself
  programs.home-manager.enable = true;
}