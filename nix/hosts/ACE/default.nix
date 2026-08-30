{
  inputs,
  self,
  ...
}: {
  flake.nixosConfigurations.ACE = inputs.nixpkgs.lib.nixosSystem {
    modules = with self.nixosModules; [
      ACE-config
      ACE-disko
      ACE-hardware
      ACE-hjem
      connor
      defaults
      hyprland
      kyla
      laptops
      limine
      mesa
    ];
  };
}
