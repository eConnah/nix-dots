{ inputs, self, ... }:
{
  flake.nixosConfigurations.lenix = inputs.nixpkgs.lib.nixosSystem {
    modules = [
      self.nixosModules.lenixConfig
      self.nixosModules.limine
      self.nixosModules.catppuccin
      self.nixosModules.asahi
    ];
  };

  flake.nixosModules.lenixConfig =
    { pkgs, ... }:
    {
      nixpkgs.hostPlatform = "aarch64-linux";
    };
}
