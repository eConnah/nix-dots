{
  inputs,
  self,
  ...
}:
{
  flake.nixosConfigurations.lenix = inputs.nixpkgs.lib.nixosSystem {
    modules = with self.nixosModules; [
      asahi
      catppuccin
      connor
      defaults
      hyprland
      laptops
      lenix-config
      lenix-hardware
      lenix-home
      limine
    ];
  };
}
