{ self, ... }: {
  flake.homeModules.defaults =
    {
      pkgs,
      lib,
      config,
      ...
    }:
    {
      imports = [
        self.homeModules.remote-assets
      ];

      programs = {
        fish.enable = true;
        git.enable = true;

        direnv = {
          enable = true;
          enableFishIntegration = true;
          nix-direnv.enable = true;
        };
        eza = {
          enable = true;
          git = true;
          icons = "always";
          enableFishIntegration = true;
          colors = "always";
        };

        firefox = {
          enable = true;
          configPath = "${config.xdg.configHome}/mozilla/firefox";
          profiles.default = {
            extensions.force = true;

            settings = {
              "app.shield.optoutstudies.enabled" = false;

              "browser.discovery.enabled" = false;
              "browser.ml.chat.enabled" = false;
              "browser.ml.chat.shortcuts" = false;
              "browser.ml.enable" = false;

              "sidebar.revamp" = true;
              "sidebar.verticalTabs" = true;

              "toolkit.telemetry.enabled" = false;
            };
          };
        };

        kitty = {
          enable = true;

          settings = {
            allow_remote_control = "socket-only";
            listen_on = "unix:/tmp/kitty";
            shell_integration = "enabled";
          };

          keybindings = {
            "kitty_mod+h" = "kitty_scrollback_nvim";
            "kitty_mod+g" = "kitty_scrollback_nvim --config ksb_builtin_last_cmd_output";
          };

          mouseBindings = {
            "ctrl+shift+right press ungrabbed" =
              "mouse_select_command_output : kitty_scrollback_nvim --config ksb_builtin_last_visited_cmd_output";
          };

          extraConfig = ''
            action_alias kitty_scrollback_nvim kitten ${pkgs.vimPlugins.kitty-scrollback-nvim}/python/kitty_scrollback_nvim.py
            scrollback_lines 10000
          '';
        };
        ssh = {
          enable = true;
          enableDefaultConfig = lib.mkDefault false;
          settings = {
            "*" = {
              AddKeysToAgent = "yes";
              ServerAliveInterval = 30;
              ServerAliveCountMax = 3;
              HashKnownHosts = false;
              UserKnownHostsFile = "~/.ssh/known_hosts";
            };
          };
        };
      };

      services.gnome-keyring = {
        enable = true;
        components = [
          "pkcs11"
          "secrets"
        ];
      };

      xdg.mimeApps = {
        enable = pkgs.stdenv.isLinux;

        defaultApplications = {
          "application/pdf" = "firefox.desktop";
          "text/html" = "firefox.desktop";
          "x-scheme-handler/about" = "firefox.desktop";
          "x-scheme-handler/http" = "firefox.desktop";
          "x-scheme-handler/https" = "firefox.desktop";
          "x-scheme-handler/terminal" = "kitty.desktop";
          "x-scheme-handler/unknown" = "firefox.desktop";
        };
      };

      services.easyeffects.enable = lib.mkDefault true;
    };
}
