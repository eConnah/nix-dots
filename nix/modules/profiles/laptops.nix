{ ... }: {
  flake.nixosModules.laptops =
    {
      pkgs,
      lib,
      ...
    }:
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

      preservation.preserveAt."/persistent" = {
        # System-level persistence
        directories = [
          "/etc/NetworkManager"
          "/etc/iwd"
          "/var/lib/bluetooth"
          "/var/lib/iwd"
        ];
      };

      environment.systemPackages = with pkgs; [
        brightnessctl
      ];
    };
}
