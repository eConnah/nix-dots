{
  inputs,
  self,
  ...
}:
{
  flake.nixosConfigurations.phoenix = inputs.nixpkgs.lib.nixosSystem {
    modules = [
      self.nixosModules.catppuccin
      self.nixosModules.connor
      self.nixosModules.defaults
      self.nixosModules.ewan
      self.nixosModules.hyprland
      self.nixosModules.limine
      self.nixosModules.mesa
      self.nixosModules.phoenix-config
      self.nixosModules.phoenix-disko
      self.nixosModules.phoenix-hardware
      self.nixosModules.phoenix-home
    ];
  };
}
