{ inputs, self, ... }:
{
  flake.nixosModules.bootloader =
    { lib, ... }:
    {
      boot.loader.efi.canTouchEfiVariables = lib.mkDefault true;
      boot.initrd.systemd.enable = true;
    };
}
