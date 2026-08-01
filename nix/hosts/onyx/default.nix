{
  inputs,
  self,
  ...
}:
{
  flake.nixosConfigurations.onyx = inputs.nixpkgs.lib.nixosSystem {
    modules = [
      self.nixosModules.catppuccin
      self.nixosModules.connor
      self.nixosModules.defaults
      self.nixosModules.hyprland
      self.nixosModules.insecure
      self.nixosModules.limine
      self.nixosModules.nvidia
      self.nixosModules.onyx-config
      self.nixosModules.onyx-disko
      self.nixosModules.onyx-hardware
      self.nixosModules.onyx-home
    ];
  };
}
