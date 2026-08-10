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
      hjemModules = mkOption {
        apply = mapAttrs (
          k: v: {
            imports = [ v ];
            _class = "hjem";
            _file = "${toString moduleLocation}#hjemModules.${k}";
          }
        );
        default = { };
        description = ''
          hjem configuration modules.
          You may use this for reusable pieces of hjem configuration so that they can be referenced across different host configurations.
        '';
        type = types.lazyAttrsOf types.deferredModule;
      };
    };
  };
}
