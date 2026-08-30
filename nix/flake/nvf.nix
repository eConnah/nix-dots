{
  lib,
  flake-parts-lib,
  moduleLocation,
  ...
}: let
  inherit
    (lib)
    mapAttrs
    mkOption
    types
    ;
in {
  options = {
    flake = flake-parts-lib.mkSubmoduleOptions {
      nvfModules = mkOption {
        apply = mapAttrs (
          k: v: {
            imports = [v];
            _class = "nvf";
            _file = "${toString moduleLocation}#nvfModules.${k}";
          }
        );
        default = {};
        description = ''
          NVF configuration modules.

          You may use this for reusable pieces of Neovim configuration, plugins,
          and themes so that they can be referenced across different host configurations.
        '';
        type = types.lazyAttrsOf types.deferredModule;
      };
    };
  };
}
