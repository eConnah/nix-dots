{
  inputs,
  self,
  ...
}: {
  flake.nixosConfigurations.onyx = inputs.nixpkgs.lib.nixosSystem {
    modules = with self.nixosModules; [
      connor
      defaults
      hyprland
      limine
      nvidia
      onyx-config
      onyx-disko
      onyx-hardware
      onyx-hjem
    ];
  };
}
