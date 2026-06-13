{
  inputs,
  self,
  ...
}:
{
  flake.nixosModules.limine =
    {
      pkgs,
      lib,
      ...
    }:
    {
      imports = [ self.nixosModules.bootloader ];
      boot.loader.limine = {
        enable = true;
        style.wallpapers = [ ];
      };
    };
}
