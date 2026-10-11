{
  description = "Cross-platform Nix configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    pi.url = "github:earendil-works/pi/stable";
    herdr.url = "github:herdrdev/herdr";
  };

  outputs = { self, nixpkgs, home-manager, pi, herdr, ... }:
  let
    system = "x86_64-linux";
    pkgs = nixpkgs.legacyPackages.${system};
  in {
    homeConfigurations."orion@ubuntu" = home-manager.lib.homeManagerConfiguration {
      inherit pkgs;
      extraSpecialArgs = { inherit pi herdr; };
      modules = [
        ./hosts/ubuntu.nix
      ];
    };
  };
}