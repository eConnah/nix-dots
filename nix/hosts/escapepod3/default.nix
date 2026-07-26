{
  inputs,
  self,
  ...
}:
{
  flake.nixosConfigurations.escapepod3 = inputs.nixpkgs.lib.nixosSystem {
    modules = [
      self.nixosModules.asahi
      self.nixosModules.catppuccin
      self.nixosModules.defaults
      self.nixosModules.escapepod3-config
      self.nixosModules.escapepod3-hardware
      self.nixosModules.escapepod3-home
      self.nixosModules.hyprland
      self.nixosModules.laptops
      self.nixosModules.leo
      self.nixosModules.limine
    ];
  };
}
