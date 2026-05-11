{ inputs, self, ... }:
{
  flake.nixosModules.bootloader =
    { lib, ... }:
    {
      boot.initrd.systemd.enable = true;
      boot.loader.efi.canTouchEfiVariables = lib.mkDefault true;
    };
}
