{
  flake.nixosModules.laptops = {
    lib,
    pkgs,
    ...
  }: {
    environment.systemPackages = with pkgs; [
      brightnessctl
      jolt-tui
    ];
    hardware.bluetooth.enable = true;
    networking = {
      networkmanager.enable = false;
      dhcpcd = {
        enable = true;
        wait = "background";
      };
      wireless = {
        enable = false;
        iwd = {
          enable = true;
          settings = {
            General = {
              AddressRandomization = "network";
            };
          };
        };
      };
    };
    powerManagement.enable = true;
    preservation.preserveAt."/persistent" = {
      directories = [
        "/etc/iwd"
        "/var/lib/bluetooth"
        "/var/lib/dhcpcd/"
        "/var/lib/iwd"
      ];
    };
    services.logind.settings.Login.HandleLidSwitch = lib.mkDefault "suspend-then-hibernate";
    services.power-profiles-daemon.enable = true;
  };
}
