{ self, ... }: {
  flake.nixosModules.onyx-config =
    {
      config,
      pkgs,
      ...
    }:
    {
      boot = {
        kernelPackages = pkgs.linuxPackages_latest;
        loader.limine = {
          extraEntries = ''
            /+Other
            //Windows 11
              protocol: efi_chainload
              image_path: guid(8fef2ca3-6a98-445a-80a0-0e94b8ea8ba6):/EFI/Microsoft/Boot/bootmgfw.efi
          '';
          resolution = "2560x1440x32";
          style.interface.resolution = "2560x1440";
        };
      };
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
        cores = 0;
        http-connections = 100;
        max-jobs = 2;
        secret-key-files = [ config.security.nix-secrets.secrets."nix-cache-key".path ];
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
      security.nix-secrets = {
        identityPaths = [ "/persistent/nix-keys/age-identity.txt" ];
        storagePath = "/persistent/dotfiles/secrets";
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
        users.connor.hashedPasswordFile = config.security.nix-secrets.secrets."connor/linux".path;
      };
      zramSwap = {
        enable = true;
        memoryPercent = 25;
      };
    };
}
