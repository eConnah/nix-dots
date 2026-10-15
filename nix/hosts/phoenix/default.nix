{
  inputs,
  self,
  ...
}: {
  flake.nixosConfigurations.phoenix = inputs.nixpkgs.lib.nixosSystem {
    modules = with self.nixosModules; [
      connor-headless
      headless
      limine
      phoenix-config
      phoenix-disko
      phoenix-hardware
      preservation
    ];
  };
}
