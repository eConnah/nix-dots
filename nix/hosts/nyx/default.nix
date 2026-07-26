{
  inputs,
  self,
  ...
}:
{
  flake.nixosConfigurations.nyx = inputs.nixpkgs.lib.nixosSystem {
    modules = [
      self.nixosModules.catppuccin
      self.nixosModules.connor
      self.nixosModules.defaults
      self.nixosModules.ewan
      self.nixosModules.hyprland
      self.nixosModules.insecure
      self.nixosModules.limine
      self.nixosModules.lix
      self.nixosModules.nvidia
      self.nixosModules.nyx-config
      self.nixosModules.nyx-disko
      self.nixosModules.nyx-hardware
      self.nixosModules.nyx-home
    ];
  };
}
