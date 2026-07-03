{ self, ... }: {
  flake = {
    nixosModules.connor = { pkgs, ... }: {
      home-manager.users.connor = self.homeModules.connor;

      users.users.connor = {
        description = "Connor Alecks";
        isNormalUser = true;
        shell = pkgs.fish;
        extraGroups = [
          "wheel"
          "networkmanager"
          "dialout"
          "uucp"
        ];
      };

      services = {
        displayManager.autoLogin.user = "connor";

        pcscd.enable = true;

        tailscale = {
          enable = true;
          useRoutingFeatures = "client";
        };
        udev.packages = with pkgs; [
          yubikey-personalization
        ];
      };

      environment.systemPackages = with pkgs; [
        yubikey-manager
      ];

      time.timeZone = "Europe/Amsterdam";
    };

    homeModules.connor = { pkgs, ... }: {
      imports = [ self.homeModules.vicinae ];
      home = {
        username = "connor";
        homeDirectory = if pkgs.stdenv.isDarwin then "/Users/connor" else "/home/connor";
        stateVersion = "25.05";
      };

      stylix.targets.halloy.enable = false;
      # yubikey git setup
      programs = {
        halloy = {
          enable = true;

          settings = {
            servers = {
              asahi = {
                nickname = "eConnah";
                server = "irc.oftc.net";
                channels = [
                  "#asahi"
                  "#asahi-dev"
                  "#asahi-alt"
                ];
              };

              nixos = {
                nickname = "eConnah";
                server = "irc.libera.chat";
                channels = [
                  "#nixos"
                ];
                sasl.plain = {
                  username = "eConnah";
                  password_file = "/persistent/passwords/connor/halloy";
                };
              };
            };
          };
        };

        git = {
          settings = {
            user = {
              name = "Connor Alecks";
              email = "git@econnah.uk";
              signingkey = "~/.ssh/id_ed25519_sk_rk.pub";
            };
            commit = {
              gpgSign = true;
            };
            gpg = {
              format = "ssh";
            };
            pull = {
              ff = "only";
            };
            init = {
              defaultBranch = "main";
            };
            diff = {
              tool = "vimdiff";
            };
            core = {
              editor = "nvim";
            };
            push = {
              autoSetupRemote = true;
            };
          };
        };

        ssh = {
          settings = {
            "github.com" = {
              User = "git";
              IdentityFile = "~/.ssh/id_ed25519_sk_rk";
              IdentitiesOnly = true;
            };
          };
        };
      };

      home.packages =
        with pkgs;
        [
          hyprcursor
          hyprpicker
          hyprshot
          jetbrains.idea
          lazyspotify
          libreoffice
          obsidian
          prismlauncher
          rose-pine-hyprcursor
          signal-desktop
          spotifyd
          vesktop
          vscode
        ]
        ++ [
          self.packages.${pkgs.stdenv.hostPlatform.system}.robrix
        ];
    };
  };
}
