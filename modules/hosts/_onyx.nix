{ inputs, self, ... }:
{
  flake.nixosConfigurations.onyx = inputs.nixpkgs.lib.nixosSystem {
    modules = [
      self.nixosModules.onyxConfig
      self.nixosModules.limine
      self.nixosModules.catppuccin
      self.nixosModules.nvidia
    ];
  };

  flake.nixosModules.onyxConfig =
    { pkgs, ... }:
    {
      nixpkgs.hostPlatform = "x86_64-linux";
    };
}
