{
  inputs,
  self,
  ...
}:
{
  flake.nixosConfigurations.nyx = inputs.nixpkgs.lib.nixosSystem {
    modules = with self.nixosModules; [
      connor
      defaults
      ewan
      hyprland
      limine
      nvidia
      nyx-config
      nyx-disko
      nyx-hardware
      nyx-hjem
    ];
  };
}
