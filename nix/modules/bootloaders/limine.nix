{ inputs, self, ... }:
{
  flake.nixosModules.limine =
    { pkgs, ... }:
    {
      imports = [ self.nixosModules.bootloader ];
      boot.loader.limine.enable = true;
    };
}
