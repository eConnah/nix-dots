{ lib, ... }:
{
  options.flake.nvfModules = lib.mkOption {
    type = lib.types.lazyAttrsOf lib.types.anything;
    default = { };
    description = "custom dendritic nvf module namespace";
  };
}
