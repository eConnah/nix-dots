{ inputs, self, ... }:
{
  flake.nixosConfigurations.x86 = inputs.nixpkgs.lib.nixosSystem {
    system = "x86_64-linux";
    modules = [
      "${inputs.nixpkgs}/nixos/modules/installer/cd-dvd/installation-cd-minimal.nix"
      self.nixosModules.connorMinimal
      self.nixosModules.defaults
      self.nixosModules.x86Config
      self.nixosModules.x86Home
    ];
  };

  flake.nixosModules.x86Home =
    { pkgs, ... }:
    {
      imports = [ inputs.home-manager.nixosModules.default ];

      home-manager = {
        useGlobalPkgs = true;
        useUserPackages = true;

        sharedModules = [
          self.homeModules.defaults
          self.homeModules.neovim
        ];
      };
    };

  flake.nixosModules.x86Config =
    { pkgs, lib, ... }:
    {
      networking.hostName = "x86";

      # NH root
      programs.nh.flake = "/home/connor/Documents/dotfiles";

      system.stateVersion = "25.11"; # NEVER CHANGE

      services.flatpak.enable = lib.mkForce false;
    };
}
