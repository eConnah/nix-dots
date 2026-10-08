{
  inputs,
  self,
  ...
}: {
  flake.nixosConfigurations.murtle = inputs.nixpkgs.lib.nixosSystem {
    modules = with self.nixosModules; [
      connor
      defaults
      ewan
      hyprland
      limine
      lix
      mesa
      murtle-config
      murtle-disko
      murtle-hardware
      murtle-hjem
      preservation
    ];
  };
}
