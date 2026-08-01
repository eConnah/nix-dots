{ self, ... }: {
  flake = {
    homeModules.connor = { pkgs, ... }: {
      imports = [ self.homeModules.vicinae ];
      home = {
        # home files
        file.".config/lazyspotify/config.yml".text = ''
          auth:
            client_id: a05e9b38cd3e420a87ca1d09b26b7179
        '';
        homeDirectory = if pkgs.stdenv.isDarwin then "/Users/connor" else "/home/connor";
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
        stateVersion = "25.05";
        username = "connor";
      };
      # yubikey git setup
      programs = {
        git = {
          settings = {
            commit = {
              gpgSign = true;
            };
            core = {
              editor = "nvim";
            };
            diff = {
              tool = "vimdiff";
            };
            gpg = {
              format = "ssh";
            };
            init = {
              defaultBranch = "main";
            };
            pull = {
              ff = "only";
            };
            push = {
              autoSetupRemote = true;
            };
            user = {
              email = "git@econnah.uk";
              name = "Connor Alecks";
              signingkey = "~/.ssh/id_ed25519_sk_rk.pub";
            };
          };
        };
        halloy = {
          enable = true;

          settings = {
            servers = {
              asahi = {
                channels = [
                  "#asahi"
                  "#asahi-dev"
                  "#asahi-alt"
                ];
                nickname = "eConnah";
                server = "irc.oftc.net";
              };

              nixos = {
                channels = [
                  "#nixos"
                ];
                nickname = "eConnah";
                sasl.plain = {
                  password_file = "/persistent/passwords/connor/halloy";
                  username = "eConnah";
                };
                server = "irc.libera.chat";
              };
            };
          };
        };
        jujutsu = {
          enable = true;

          settings = {
            signing = {
              backend = "ssh";
              key = "~/.ssh/id_ed25519_sk_rk.pub";
              sign-all = false;
            };
            ui = {
              default-command = "log";
              diff-editor = "vimdiff";
              editor = "nvim";
              merge-editor = "vimdiff";
            };
            user = {
              email = "git@econnah.uk";
              name = "Connor Alecks";
            };
          };
        };
        ssh = {
          settings = {
            "github.com" = {
              IdentitiesOnly = true;
              IdentityFile = "~/.ssh/id_ed25519_sk_rk";
              User = "git";
            };
          };
        };
      };
      stylix.targets.halloy.enable = false;
    };
  };
}
