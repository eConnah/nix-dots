{
  description = "Connors NixOS Flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    apple-silicon = {
      url = "github:nix-community/nixos-apple-silicon";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    
    vicinae.url = "github:vicinaehq/vicinae"; # To use cache do NOT follow nixpkgs
  };

  outputs =
    {
      self,
      nixpkgs,
      home-manager,
      ...
    }@inputs:
    let
  # Create a helper for the x86_64 package set
  pkgs-x86 = import nixpkgs {
    system = "x86_64-linux";
    config.allowUnfree = true; # Useful if your x64 pkg is unfree
  };
in
    {
      nixosConfigurations = {
        # connor-macbook
        le-nix = nixpkgs.lib.nixosSystem rec {
          system = "aarch64-linux";
          specialArgs = {
            inherit inputs pkgs-x86;
            vars = {
              user = "connor";
              host = "le-nix";
              dir = "/home/connor/Documents/dotfiles";
            };
          };

          modules = [
            inputs.apple-silicon.nixosModules.default
            ./modules/nixos/asahi.nix
            ./modules/nixos/defaults.nix
            home-manager.nixosModules.default
            { home-manager.extraSpecialArgs = specialArgs; }
          ];
        };
        # leo-macbook
        escapepod3 = nixpkgs.lib.nixosSystem rec {
          system = "aarch64-linux";
          specialArgs = {
            inherit inputs;
            vars = {
              user = "leo";
              host = "escapepod3";
              dir = "/home/leo/Documents/dotfiles";
            };
          };

          modules = [
            inputs.apple-silicon.nixosModules.default
            ./modules/nixos/asahi.nix
            ./modules/nixos/defaults.nix
            home-manager.nixosModules.default
            { home-manager.extraSpecialArgs = specialArgs; }
          ];
        };

      };
    };
}
