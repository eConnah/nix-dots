{
  inputs,
  self,
  ...
}: {
  flake.nixosModules.limine = {
    lib,
    pkgs,
    ...
  }: {
    imports = [self.nixosModules.bootloader];
    boot.loader.limine = {
      enable = true;
      style.wallpapers = [];
    };
  };
}
