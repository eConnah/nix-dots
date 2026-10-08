{inputs, ...}: {
  flake.nixosModules.lix = {
    imports = [inputs.lix-module.nixosModules.default];
    nix.settings.experimental-features = [
      "pipe-operator"
    ];
  };
}
