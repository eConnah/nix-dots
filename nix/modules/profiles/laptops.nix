{ inputs, self, ... }:
{
  flake.nixosModules.laptops =
    { pkgs, lib, ... }:
    {
      hardware.bluetooth.enable = true;
      powerManagement.enable = true;
      services.logind.settings.Login.HandleLidSwitch = lib.mkDefault "suspend-then-hibernate";
      services.power-profiles-daemon.enable = true;

      networking = {
        networkmanager = {
          enable = true;
          wifi.backend = "iwd";
        };

        wireless = {
          enable = false;
          iwd.settings = {
            General = {
              AddressRandomization = "network";
            };
          };
        };
      };

      environment.systemPackages = with pkgs; [
        brightnessctl
      ];
    };
}
