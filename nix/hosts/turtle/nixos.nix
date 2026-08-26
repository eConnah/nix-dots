{ self, ... }: {
  flake.nixosModules.turtle-config =
    {
      lib,
      pkgs,
      ...
    }:
    {
      boot.kernelPackages = pkgs.linuxPackages_latest;
      environment.systemPackages = [
        self.packages.${pkgs.stdenv.hostPlatform.system}.nvim-qwerty
      ];
      networking = {
        hostName = "turtle";
        networkmanager.enable = false;
        useDHCP = false;
      };
      nix.settings = {
        cores = 4;
        http-connections = 100;
        max-jobs = 4;
      };
      programs = {
        gamescope = {
          enable = true;
          capSysNice = true;
        };
        nh.flake = "/persistent/dotfiles";
        steam = {
          enable = true;
          extraCompatPackages = with pkgs; [
            proton-ge-bin
          ];
        };
      };
      security.nix-secrets.enable = lib.mkForce false;
      services.pipewire.extraConfig.pipewire."92-custom-quantum" = {
        "context.properties" = {
          "default.clock.max-quantum" = 8192;
          "default.clock.min-quantum" = 512;
          "default.clock.quantum" = 512;
          "default.clock.rate" = 48000;
        };
      };
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
        users.connor.password = "tacobell";
      };
      zramSwap = {
        enable = true;
        memoryPercent = 25;
      };
    };
}
