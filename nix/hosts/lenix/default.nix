{
  inputs,
  self,
  ...
}: {
  flake.nixosConfigurations.lenix = inputs.nixpkgs.lib.nixosSystem {
    modules = with self.nixosModules; [
      asahi
      clementine-graphical
      hyprland
      lenix-config
      lenix-hardware
      lenix-hjem
      limine
      lix
      preservation
      self.secretModules.clementine-eduroam
    ];
  };
}
