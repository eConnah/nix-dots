{
  lib,
  flake-parts-lib,
  moduleLocation,
  ...
}:
let
  inherit (lib)
    mapAttrs
    mkOption
    types
    ;
in
{
  options = {
    flake = flake-parts-lib.mkSubmoduleOptions {
      nvfModules = mkOption {
        type = types.lazyAttrsOf types.deferredModule;
        default = { };
        apply = mapAttrs (
          k: v: {
            _class = "nvf";
            _file = "${toString moduleLocation}#nvfModules.${k}";
            imports = [ v ];
          }
        );
        description = ''
          NVF configuration modules.

          You may use this for reusable pieces of Neovim configuration, plugins,
          and themes so that they can be referenced across different host configurations.
        '';
      };
    };
  };
}
