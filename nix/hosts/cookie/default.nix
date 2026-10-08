{
  inputs,
  self,
  ...
}: {
  flake.nixosConfigurations.cookie = inputs.nixpkgs.lib.nixosSystem {
    modules = with self.nixosModules; [
      aude
      connor-graphical
      cookie-config
      cookie-disko
      cookie-hardware
      cookie-hjem
      hyprland
      kyla
      laptops
      limine
      lix
      mesa
      preservation
    ];
  };
}
