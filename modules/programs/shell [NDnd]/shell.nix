{
  inputs,
  lib,
  ...
}:
{
  options.flake.shell = lib.mkOption {
    type = lib.types.attrsOf lib.types.unspecified;
    default = { };
  };

  config.flake.shell = {
    fish =
      name:
      { pkgs, ... }:
      {
        programs.fish.enable = true;
        users.users.${name}.shell = pkgs.fish;
        home-manager.users.${name} = {
          programs.fish.enable = true;
        };
      };
  };
}
