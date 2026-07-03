{ ... }: {
  perSystem =
    {
      pkgs,
      lib,
      ...
    }:
    let
      allPackages = {
        robius-packaging-commands = pkgs.callPackage ./_robius-packaging-commands/package.nix { };
        robrix = pkgs.callPackage ./_robrix/package.nix { };
      };
    in
    {
      packages = lib.filterAttrs (
        _name: pkg: lib.meta.availableOn pkgs.stdenv.hostPlatform pkg
      ) allPackages;
    };
}
