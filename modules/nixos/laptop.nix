# General laptop settings

{ ... }:

{
  powerManagement.enable = true;
  services.logind.settings.Login.HandleLidSwitch = "suspend";
  services.power-profiles-daemon.enable = true;
  hardware.bluetooth.enable = true;
  networking.wireless.iwd.enable = true;
  networking.networkmanager.wifi.backend = "iwd";
}

