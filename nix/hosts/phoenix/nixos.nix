{ self, ... }: {
  flake.nixosModules.phoenix-config = { pkgs, ... }: {
    networking = {
      hostName = "phoenix";
      useDHCP = false;
      networkmanager.enable = false;
    };

    systemd.network = {
      enable = true;
      networks."10-ethernet" = {
        matchConfig.Name = "en*";
        networkConfig = {
          DHCP = "ipv4";
          IPv6AcceptRA = false;
        };
        linkConfig = {
          RequiredForOnline = "routable";
        };
      };
    };

    services.resolved = {
      enable = true;
    };

    # iio stuff
    hardware.sensor.iio.enable = true;
    programs.iio-hyprland.enable = true;

    # NH root
    programs.nh.flake = "/persistent/dotfiles";

    users = {
      mutableUsers = false;
      users = {
        ewan.hashedPasswordFile = "/persistent/passwords/ewan/linux";
        connor.hashedPasswordFile = "/persistent/passwords/connor/linux";
      };
    };

    environment.systemPackages = [ self.packages.${pkgs.stdenv.hostPlatform.system}.nvim-qwerty ];

    nix.settings = {
      cores = 8;
      http-connections = 100;
      max-jobs = 1;
      secret-key-files = "/persistent/nix-keys/secret-key.pem";
    };

    time.timeZone = "Europe/London";

    system.stateVersion = "25.11"; # NEVER CHANGE
  };
}
