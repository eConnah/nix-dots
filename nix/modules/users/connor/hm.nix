{ self, ... }: {
  flake = {
    homeModules.connor = { pkgs, ... }: {
      imports = [ self.homeModules.vicinae ];
      home = {
        username = "connor";
        homeDirectory = if pkgs.stdenv.isDarwin then "/Users/connor" else "/home/connor";
        stateVersion = "25.05";

        # home files
        file.".config/lazyspotify/config.yml".text = ''
          auth:
            client_id: a05e9b38cd3e420a87ca1d09b26b7179
        '';

        packages =
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

        jujutsu = {
          enable = true;

          settings = {
            user = {
              name = "Connor Alecks";
              email = "git@econnah.uk";
            };

            ui = {
              editor = "nvim";
              diff-editor = "vimdiff";
              merge-editor = "vimdiff";
              default-command = "log";
            };

            signing = {
              sign-all = false;
              backend = "ssh";
              key = "~/.ssh/id_ed25519_sk_rk.pub";
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
    };
  };
}
