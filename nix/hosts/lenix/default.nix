{
  inputs,
  self,
  ...
}:
{
  flake.nixosConfigurations.lenix = inputs.nixpkgs.lib.nixosSystem {
    modules = [
      self.nixosModules.asahi
      self.nixosModules.catppuccin
      self.nixosModules.connor
      self.nixosModules.defaults
      self.nixosModules.hyprland
      self.nixosModules.laptops
      self.nixosModules.lenix-config
      self.nixosModules.lenix-hardware
      self.nixosModules.lenix-home
      self.nixosModules.limine
    ];
  };
}
