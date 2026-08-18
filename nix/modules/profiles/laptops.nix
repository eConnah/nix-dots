{
  flake.nixosModules.laptops =
    {
      lib,
      pkgs,
      ...
    }:
    {
      environment.systemPackages = with pkgs; [
        brightnessctl
      ];
      hardware.bluetooth.enable = true;
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
      powerManagement.enable = true;
      preservation.preserveAt."/persistent" = {
        directories = [
          "/etc/NetworkManager"
          "/etc/iwd"
          "/var/lib/bluetooth"
          "/var/lib/iwd"
        ];
      };
      services.logind.settings.Login.HandleLidSwitch = lib.mkDefault "suspend-then-hibernate";
      services.power-profiles-daemon.enable = true;
    };
}
