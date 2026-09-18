{self, ...}: {
  flake.hjemModules.defaults = {pkgs, ...}: {
    imports = with self.hjemModules; [
      easyeffects
      remote-assets
      swaybg
    ];
    rum.programs = {
      direnv = {
        enable = true;
        integrations = {
          fish.enable = true;
          nix-direnv.enable = true;
        };
      };
      fish.enable = true;
      git = {
        enable = true;
        ignore = ''
          .direnv
        '';
      };
      kitty = {
        enable = true;
        integrations.fish.enable = true;
        settings = {
          action_alias = "kitty_scrollback_nvim kitten ${pkgs.vimPlugins.kitty-scrollback-nvim}/python/kitty_scrollback_nvim.py";
          allow_remote_control = "socket-only";
          listen_on = "unix:/tmp/kitty";
          map = [
            "kitty_mod+g kitty_scrollback_nvim --config ksb_builtin_last_cmd_output"
            "kitty_mod+h kitty_scrollback_nvim"
          ];
          mouse_map = "ctrl+shift+right press ungrabbed mouse_select_command_output : kitty_scrollback_nvim --config ksb_builtin_last_visited_cmd_output";
          scrollback_lines = 10000;
        };
      };
    };
    xdg.config.files = {
      "fish/conf.d/eza.fish".text = ''
        abbr -a --position command l "eza --color=always --icons=always --no-time --git -lahg"
        abbr -a --position command la "eza --color=always --icons=always --git -a"
        abbr -a --position command ll "eza --color=always --icons=always --no-time --git -lg"
        abbr -a --position command lla "eza --color=always --icons=always --no-time --git -lag"
        abbr -a --position command ls "eza --color=always --icons=always --git"
        abbr -a --position command lt "eza --color=always --icons=always --git --tree"
      '';
      "fish/conf.d/rexies_prompt.fish".source = "${self}/not-nix/presets/fish/rexies_prompt.fish";
      "xdg-terminals.list".text = ''
        kitty.desktop
      '';
    };
  };
}
