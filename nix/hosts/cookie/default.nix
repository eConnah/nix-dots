{
  inputs,
  self,
  ...
}: {
  flake.nixosConfigurations.cookie = inputs.nixpkgs.lib.nixosSystem {
    modules = with self.nixosModules; [
      aude
      connor
      cookie-config
      cookie-disko
      cookie-hardware
      cookie-hjem
      defaults
      hyprland
      kyla
      laptops
      limine
      mesa
    ];
  };
}
