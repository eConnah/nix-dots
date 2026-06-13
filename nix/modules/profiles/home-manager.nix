{ ... }:
{
  flake.homeModules.defaults =
    {
      pkgs,
      lib,
      ...
    }:
    {
      programs.fish.enable = true;
      programs.git.enable = true;

      programs.eza = {
        enable = true;
        git = true;
        icons = "always";
        enableFishIntegration = true;
        colors = "always";
      };

      programs.kitty = {
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
      programs.ssh = {
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
          "x-scheme-handler/terminal" = "kitty.desktop";
        };
      };

      services.easyeffects.enable = lib.mkDefault true;
    };
}
