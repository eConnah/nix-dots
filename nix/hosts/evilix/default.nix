{
  inputs,
  self,
  ...
}: {
  flake.nixosConfigurations.evilix = inputs.nixpkgs.lib.nixosSystem {
    modules = with self.nixosModules; [
      inputs.wsl.nixosModules.default
      clementine-headless
      evilix-config
      evilix-hjem
      headless
      lix
      mesa
    ];
  };
}
