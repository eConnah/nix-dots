# General laptop settings

{ pkgs, ... }:

{
  powerManagement.enable = true;
  services.logind.settings.Login.HandleLidSwitch = "ignore";
  services.power-profiles-daemon.enable = true;
  hardware.bluetooth.enable = true;

  environment.systemPackages = with pkgs; [
    libreoffice
  ];
}
