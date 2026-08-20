{ self, ... }: {
  flake.hjemModules.connor = { pkgs, ... }: {
    imports = with self.hjemModules; [
      defaults
      oledppuccin
      vicinae
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
      librespot
      obsidian
      prismlauncher
      signal-desktop
      vesktop
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
        git = {
          sign-on-push = true;
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
          alias = {
            pull-pr = {
              definition = [
                "util"
                "exec"
                "--"
                "bash"
                "-c"
                "set -euo pipefail; git fetch $0 pull/$1/head:$2"
              ];
              doc = "A convenient alias to pull a pr $1 from remote $0 into branch $2";
            };
          };
          signing = {
            backend = "ssh";
            key = "~/.ssh/id_ed25519_sk_rk.pub";
            sign-all = false;
          };
          template-aliases = {
            "format_short_signature(signature)" = ''
              coalesce(signature.name(), name_placeholder)
            '';
          };
          ui = {
            default-command = "log";
            diff-editor = ":builtin";
            diff-formatter = [
              "kitten"
              "diff"
              "$left"
              "$right"
            ];
            editor = "nvim";
            merge-editor = ":builtin";
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
