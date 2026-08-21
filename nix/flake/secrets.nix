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
      secretModules = mkOption {
        apply = mapAttrs (
          k: v: {
            imports = [ v ];
            _class = "nixos";
            _file = "${toString moduleLocation}#secretModules.${k}";
          }
        );
        default = { };
        description = ''
          Optional per-host `nix-secrets` declarations. `nix-secrets`
          attempts to decrypt every secret declared for a host's
          evaluated config, regardless of `recipients` — a host that
          isn't a recipient still fails activation rather than
          skipping it. Put secrets that only some hosts should even
          attempt here, and only import the relevant ones on the
          hosts that are actual recipients, instead of declaring
          them unconditionally in a shared module.
        '';
        type = types.lazyAttrsOf types.deferredModule;
      };
    };
  };
}
