{ self, ... }: {
  flake.nixosModules.onyx-config = { pkgs, ... }: {
    boot.kernelPackages = pkgs.linuxPackages_latest;
    environment.systemPackages = [
      pkgs.efibootmgr
      self.packages.${pkgs.stdenv.hostPlatform.system}.nvim-qwerty
    ];
    networking = {
      hostName = "onyx";
      networkmanager.enable = false;
      useDHCP = false;
    };
    nix.settings = {
      cores = 4;
      http-connections = 100;
      max-jobs = 4;
      secret-key-files = "/persistent/nix-keys/secret-key.pem";
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
    system.stateVersion = "25.11"; # NEVER CHANGE
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
    time.timeZone = "Europe/Amsterdam";
    users = {
      mutableUsers = false;
      users.connor.hashedPasswordFile = "/persistent/passwords/connor/linux";
    };
    zramSwap = {
      enable = true;
      memoryPercent = 25;
    };
  };
}
