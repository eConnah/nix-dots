{ inputs, ... }: {
  imports = [
    inputs.treefmt-nix.flakeModule
    inputs.pedantix.flakeModules.default
  ];
  perSystem = {
    treefmt.programs.pedantix = {
      enable = true;
      settings = {
        preset = "nixos-module";
      };
    };
  };
}
