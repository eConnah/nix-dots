{
  inputs,
  self,
  ...
}: {
  flake.nixosConfigurations.murtle = inputs.nixpkgs.lib.nixosSystem {
    modules = with self.nixosModules; [
      murtle-config
      murtle-disko
      murtle-hardware
      murtle-hjem
      connor
      defaults
      ewan
      hyprland
      limine
      mesa
    ];
  };
}
