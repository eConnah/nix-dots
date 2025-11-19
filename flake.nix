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

    fix.url = "github:nixos/nixpkgs/c8d4dabc4357a22d1c249a9363998bdb00122544";
  };

  outputs =
    {
      self,
      nixpkgs,
      home-manager,
      ...
    }@inputs:
    {
      nixosConfigurations = {
        # connor-macbook
        le-nix = nixpkgs.lib.nixosSystem rec {
          system = "aarch64-linux";
          specialArgs = {
            inherit inputs;
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
