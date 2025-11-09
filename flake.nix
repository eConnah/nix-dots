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
  };

  outputs = { self, nixpkgs, home-manager, ... }@inputs:
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
    };
  };
}
