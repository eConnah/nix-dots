{
  inputs,
  self,
  ...
}: {
  flake.nixosConfigurations.turtle = inputs.nixpkgs.lib.nixosSystem {
    modules = with self.nixosModules; [
      aude
      ewan
      graphical
      hyprland
      kyla
      limine
      lix
      nvidia
      preservation
      turtle-config
      turtle-disko
      turtle-hardware
      turtle-hjem
    ];
  };
}
