{
  inputs,
  self,
  ...
}:
{
  flake = {
    nixosConfigurations.onyx = inputs.nixpkgs.lib.nixosSystem {
      modules = [
        self.nixosModules.catppuccin
        self.nixosModules.connor
        self.nixosModules.defaults
        self.nixosModules.hyprland
        self.nixosModules.insecure
        self.nixosModules.limine
        self.nixosModules.lix
        self.nixosModules.nvidia
        self.nixosModules.onyx-config
        self.nixosModules.onyx-disko
        self.nixosModules.onyx-hardware
        self.nixosModules.onyx-home
      ];
    };

    nixosModules.onyx-home = { pkgs, ... }: {
      imports = [ inputs.home-manager.nixosModules.default ];

      home-manager = {
        useGlobalPkgs = true;
        useUserPackages = true;
        backupFileExtension = "backup";

        sharedModules = [
          self.homeModules.defaults
        ];

        users.connor = {
          imports = [
            self.homeModules.onyx-hyprland
            self.homeModules.swaybg
          ];

          programs.obs-studio = {
            enable = true;

            package = pkgs.obs-studio.override {
              cudaSupport = true;
            };

            plugins = with pkgs.obs-studio-plugins; [
              obs-pipewire-audio-capture
            ];
          };

          theme.wallpaper = "86-01.png";

          home = {
            packages = with pkgs; [
              davinci-resolve
              plezy
              spotify
            ];

            sessionVariables = {
              PROTON_ENABLE_WAYLAND = "1";
            };

            file.".config/lazyspotify/config.yml".text = ''
              auth:
                client_id: a05e9b38cd3e420a87ca1d09b26b7179
            '';
          };
        };
      };
    };

    nixosModules.onyx-config = { pkgs, ... }: {
      networking = {
        hostName = "onyx";
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
        users.connor.hashedPasswordFile = "/persistent/passwords/connor/linux";
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
        pkgs.efibootmgr
        self.packages.${pkgs.stdenv.hostPlatform.system}.nvim-qwerty
      ];

      nix.settings = {
        cores = 4;
        http-connections = 100;
        max-jobs = 4;
        secret-key-files = "/persistent/nix-keys/secret-key.pem";
      };

      time.timeZone = "Europe/Amsterdam";

      boot.kernelPackages = pkgs.linuxPackages_latest;
      system.stateVersion = "25.11"; # NEVER CHANGE
    };
  };
}
