{
  inputs,
  self,
  ...
}:
{
  flake.nixosConfigurations.lenix = inputs.nixpkgs.lib.nixosSystem {
    modules = with self.nixosModules; [
      asahi
      connor
      defaults
      hyprland
      laptops
      lenix-config
      lenix-hardware
      lenix-hjem
      limine
    ];
  };
}
