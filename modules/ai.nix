{ config, pkgs, pi, herdr, ... }:

{
  home.packages = [
    pi.packages.${pkgs.system}.default
    herdr.packages.${pkgs.system}.default
  ];
}