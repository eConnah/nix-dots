{ inputs, self, ... }: {
  flake.nixosConfigurations.lenix = inputs.nixpkgs.lib.nixosSystem {
    modules = [
      self.nixosModules.testModule
    ];
  };
}
