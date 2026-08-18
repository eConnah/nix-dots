{ self, ... }: {
  flake.nixosModules.murtle-config = { pkgs, ... }: {
    environment.systemPackages = [ self.packages.${pkgs.stdenv.hostPlatform.system}.nvim-qwerty ];
    # iio stuff
    hardware.sensor.iio.enable = true;
    networking = {
      hostName = "murtle";
      networkmanager.enable = false;
      useDHCP = false;
    };
    nix.settings = {
      cores = 8;
      http-connections = 100;
      max-jobs = 1;
      secret-key-files = "/persistent/nix-keys/secret-key.pem";
    };
    programs.iio-hyprland.enable = true;
    # NH root
    programs.nh.flake = "/persistent/dotfiles";
    services.resolved = {
      enable = true;
    };
    systemd.network = {
      enable = true;
      networks."10-ethernet" = {
        linkConfig = {
          RequiredForOnline = "routable";
        };
        matchConfig.Name = "en*";
        networkConfig = {
          DHCP = "ipv4";
          IPv6AcceptRA = false;
        };
      };
    };
    time.timeZone = "Europe/London";
    users = {
      mutableUsers = false;
      users = {
        connor.hashedPasswordFile = "/persistent/passwords/connor/linux";
        ewan.hashedPasswordFile = "/persistent/passwords/ewan/linux";
      };
    };
  };
}
