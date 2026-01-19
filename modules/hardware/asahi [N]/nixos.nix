{ inputs, ... }:
{
  flake.modules.nixos.hardware-asahi = {
    imports = [ inputs.nixos-apple-silicon.nixosModules.default ];

    # Basic Asahi Hardware Config
    hardware.asahi.enable = true;
    hardware.asahi.useExperimentalGPUDriver = true;
    hardware.asahi.peripheralFirmwareDirectory = ./firmware;
    
    # Bootloader tweaks are mandatory for Asahi
    boot.loader.systemd-boot.enable = true;
    boot.loader.efi.canTouchEfiVariables = false;
  };
}
