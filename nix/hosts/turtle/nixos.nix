{moduleWithSystem, ...}: {
  flake.nixosModules.turtle-config = moduleWithSystem ({self', ...}: {
    config,
    pkgs,
    ...
  }: {
    boot = {
      kernelPackages = pkgs.linuxPackages_zen;
      loader.limine = {
        resolution = "1920x1080x32";
        style.interface.resolution = "1920x1080";
      };
    };
    environment.systemPackages = [
      self'.packages.nvim-qwerty
    ];
    networking = {
      hostName = "turtle";
      useDHCP = false;
    };
    nix.settings = {
      cores = 0;
      http-connections = 100;
      max-jobs = 2;
      secret-key-files = [config.security.nix-secrets.secrets."nix-cache-key".path];
    };
    programs = {
      gamescope = {
        enable = true;
        capSysNice = true;
      };
    };
    security.nix-secrets = {
      identityPaths = ["/persistent/nix-keys/age-identity.txt"];
    };
    services.pipewire.extraConfig.pipewire."92-custom-quantum" = {
      "context.properties" = {
        "default.clock.max-quantum" = 8192;
        "default.clock.min-quantum" = 512;
        "default.clock.quantum" = 512;
        "default.clock.rate" = 48000;
      };
    };
    services.resolved.enable = true;
    systemd.network = {
      enable = true;
      links."10-ethernet" = {
        matchConfig.Name = "en*";
        linkConfig.WakeOnLan = "magic";
      };
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
        aude.hashedPasswordFile = config.security.nix-secrets.secrets."aude/linux".path;
        connor.hashedPasswordFile = config.security.nix-secrets.secrets."connor/linux".path;
        ewan.hashedPasswordFile = config.security.nix-secrets.secrets."ewan/linux".path;
        kyla.hashedPasswordFile = config.security.nix-secrets.secrets."kyla/linux".path;
      };
    };
    zramSwap = {
      enable = true;
      memoryPercent = 25;
    };
  });
}
