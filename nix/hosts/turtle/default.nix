{
  inputs,
  self,
  ...
}: {
  flake.nixosConfigurations.turtle = inputs.nixpkgs.lib.nixosSystem {
    modules = with self.nixosModules; [
      connor
      defaults
      ewan
      hyprland
      limine
      nvidia
      turtle-config
      turtle-disko
      turtle-hardware
      turtle-hjem
    ];
  };
}
