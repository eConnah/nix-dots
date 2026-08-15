{ self, ... }: {
  flake.hjemModules.connor = { pkgs, ... }: {
    imports = with self.hjemModules; [
      vicinae
      defaults
    ];
    environment.sessionVariables.EDITOR = "nvim";
    files.".ssh/config" = {
      permissions = "0600";
      source = "${self}/not-nix/connor/ssh/config";
      type = "copy";
    };
    packages = with pkgs; [
      halloy
      lazyspotify
      libreoffice
      obsidian
      prismlauncher
      signal-desktop
      spotifyd
      vesktop
      vscode
    ];
    rum.programs.git = {
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
    xdg.config.files = {
      "halloy/config.toml" = {
        generator = (pkgs.formats.toml { }).generate "config.toml";
        value = {
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
              channels = [ "#nixos" ];
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
      "jj/config.toml" = {
        generator = (pkgs.formats.toml { }).generate "config.toml";
        value = {
          signing = {
            backend = "ssh";
            key = "~/.ssh/id_ed25519_sk_rk.pub";
            sign-all = false;
          };
          ui = {
            default-command = "log";
            diff-editor = ":builtin";
            editor = "nvim";
            merge-editor = "vimdiff";
          };
          user = {
            email = "git@econnah.uk";
            name = "Connor Alecks";
          };
        };
      };
      "vesktop/settings/settings.json".source = "${self}/not-nix/connor/vesktop/settings.json";
    };
  };
}
