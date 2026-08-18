{
  inputs,
  self,
  ...
}:
{
  flake.nixosConfigurations.phoenix = inputs.nixpkgs.lib.nixosSystem {
    modules = with self.nixosModules; [
      connor
      defaults
      ewan
      hyprland
      limine
      mesa
      phoenix-config
      phoenix-disko
      phoenix-hardware
      phoenix-hjem
    ];
  };
}
