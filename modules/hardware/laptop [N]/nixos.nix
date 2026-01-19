{ inputs, ... }:
{
  flake.modules.nixos.hardware-laptop = {
    powerManagement.enable = true;
    services.logind.settings.Login.HandleLidSwitch = "ignore";
    services.power-profiles-daemon.enable = true;
    hardware.bluetooth.enable = true;
  };
}
