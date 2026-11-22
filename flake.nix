{
  description = "Cross-platform dev environment (Ubuntu & macOS)";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { nixpkgs, home-manager, ... }:
    let
      mkHome = { system, username, homeDirectory }:
        home-manager.lib.homeManagerConfiguration {
          pkgs = nixpkgs.legacyPackages.${system};
          extraSpecialArgs = { inherit username homeDirectory; };
          modules = [ ./home.nix ];
        };
    in {
      homeConfigurations = {
        "ubuntu" = mkHome {
          system = "x86_64-linux";
          username = "orion"; # Update if your Linux username differs
          homeDirectory = "/home/orion";
        };
        "macos" = mkHome {
          system = "aarch64-darwin";
          username = "orion"; # Update if your macOS username differs
          homeDirectory = "/Users/orion";
        };
      };
    };
}
