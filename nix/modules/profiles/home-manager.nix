{ self, ... }: {
  flake.homeModules.defaults =
    {
      config,
      lib,
      pkgs,
      ...
    }:
    {
      imports = [
        self.homeModules.remote-assets
      ];
      home.stateVersion = "25.11";
      programs = {
        direnv = {
          enable = true;
          enableFishIntegration = true;
          nix-direnv.enable = true;
        };
        eza = {
          enable = true;
          colors = "always";
          enableFishIntegration = true;
          git = true;
          icons = "always";
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
        fish.enable = true;
        git.enable = true;
        kitty = {
          enable = true;
          extraConfig = ''
            action_alias kitty_scrollback_nvim kitten ${pkgs.vimPlugins.kitty-scrollback-nvim}/python/kitty_scrollback_nvim.py
            scrollback_lines 10000
          '';
          keybindings = {
            "kitty_mod+g" = "kitty_scrollback_nvim --config ksb_builtin_last_cmd_output";
            "kitty_mod+h" = "kitty_scrollback_nvim";
          };
          mouseBindings = {
            "ctrl+shift+right press ungrabbed" =
              "mouse_select_command_output : kitty_scrollback_nvim --config ksb_builtin_last_visited_cmd_output";
          };
          settings = {
            allow_remote_control = "socket-only";
            listen_on = "unix:/tmp/kitty";
            shell_integration = "enabled";
          };
        };
        ssh = {
          enable = true;
          enableDefaultConfig = lib.mkDefault false;
          settings = {
            "*" = {
              AddKeysToAgent = "yes";
              HashKnownHosts = false;
              ServerAliveCountMax = 3;
              ServerAliveInterval = 30;
              UserKnownHostsFile = "~/.ssh/known_hosts";
            };
          };
        };
      };
      services.easyeffects.enable = lib.mkDefault true;
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
          "application/x-desktop" = "nvim.desktop";
          "text/html" = "firefox.desktop";
          "text/markdown" = "nvim.desktop";
          "text/plain" = "nvim.desktop";
          "x-scheme-handler/about" = "firefox.desktop";
          "x-scheme-handler/http" = "firefox.desktop";
          "x-scheme-handler/https" = "firefox.desktop";
          "x-scheme-handler/terminal" = "kitty.desktop";
          "x-scheme-handler/unknown" = "firefox.desktop";
        };
      };
      xdg.terminal-exec = {
        enable = true;
        settings.default = [ "kitty.desktop" ];
      };
    };
}
