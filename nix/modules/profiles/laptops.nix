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
      dhcpcd = {
        enable = true;
        wait = "background";
        extraConfig = ''
          clientid
        '';
      };
      wireless = {
        enable = false;
        iwd = {
          enable = true;
          settings = {
            General = {
              AddressRandomization = "none";
            };
            Network = {
              EnableIPv6 = true;
            };
            Settings = {
              AutoConnect = true;
            };
          };
        };
      };
    };
    powerManagement.enable = true;
    system.nixos-core.persistence.stores."/persistent".directories = [
      "/var/lib/bluetooth"
      "/var/lib/dhcpcd/"
      "/var/lib/iwd"
    ];
    services.logind.settings.Login.HandleLidSwitch = lib.mkDefault "suspend-then-hibernate";
    services.power-profiles-daemon.enable = true;
  };
}
