{ self, ... }: {
  flake.nixosModules.nyx-config = { pkgs, ... }: {
    networking = {
      hostName = "nyx";
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

    zramSwap = {
      enable = true;
      memoryPercent = 25;
    };

    users = {
      mutableUsers = false;
      users = {
        connor.hashedPasswordFile = "/persistent/passwords/connor/linux";
        ewan.initialPassword = "tacobell";
      };
    };

    programs = {
      nh.flake = "/persistent/dotfiles";

      gamescope = {
        enable = true;
        capSysNice = true;
      };
      steam = {
        enable = true;
        extraCompatPackages = with pkgs; [
          proton-ge-bin
        ];
      };
    };

    services.pipewire.extraConfig.pipewire."92-custom-quantum" = {
      "context.properties" = {
        "default.clock.rate" = 48000;
        "default.clock.quantum" = 512;
        "default.clock.min-quantum" = 512;
        "default.clock.max-quantum" = 8192;
      };
    };

    environment.systemPackages = [
      self.packages.${pkgs.stdenv.hostPlatform.system}.nvim-qwerty
    ];

    nix.settings = {
      cores = 4;
      http-connections = 100;
      max-jobs = 4;
      #secret-key-files = "/persistent/nix-keys/secret-key.pem";
    };

    time.timeZone = "Europe/London";

    boot.kernelPackages = pkgs.linuxPackages_latest;
    system.stateVersion = "25.11"; # NEVER CHANGE
  };
}
