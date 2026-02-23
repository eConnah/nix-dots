{ inputs, ... }: {
  flake.nixosModules.testModule = { pkgs, ... }: {
    programs.firefox.enable = true;
  };
}
