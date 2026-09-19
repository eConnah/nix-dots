{
  inputs,
  self,
  ...
}: {
  flake.nixosConfigurations.evilix = inputs.nixpkgs.lib.nixosSystem {
    modules = with self.nixosModules; [
      inputs.wsl.nixosModules.default
      connor
      defaults
      evilix-config
      evilix-hjem
    ];
  };
}
