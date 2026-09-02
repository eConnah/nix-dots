{
  self,
  lib,
  ...
}: {
  perSystem = {
    config,
    pkgs,
    ...
  }: {
    packages =
      lib.filterAttrs (
        _: pkg:
          lib.meta.availableOn pkgs.stdenv.hostPlatform pkg
      ) (lib.filesystem.packagesFromDirectoryRecursive {
        inherit (pkgs) newScope;
        callPackage = lib.callPackageWith (pkgs // config.packages);
        directory = self + "/pkgs";
      });
  };
}
