{self, ...}: {
  flake = let
    theme = self + "/not-nix/themes/oledppuccin/";
  in {
    hjemModules.oledppuccin = {pkgs, ...}: {
      imports = [self.hjemModules.themes-shared];
      rum.programs.kitty.settings.include = "oledppuccin.conf";
      xdg.config.files = {
        "bat/config".text = "--theme='oledppuccin'";
        "bat/themes/oledppuccin.tmTheme".source = theme + "bat.tmTheme";
        "eza/theme.yml".source = theme + "eza.yml";
        "fish/conf.d/00-theme.fish".text = ''
          fish_config theme choose oledppuccin
        '';
        "fish/themes/oledppuccin.theme".source = theme + "fish.theme";
        "kitty/diff.conf".source = theme + "kitty/diff.conf";
        "kitty/oledppuccin.conf".source = theme + "kitty/oledppuccin.conf";
        "jolt/config.toml" = {
          generator = (pkgs.formats.toml {}).generate "config.toml";
          value = {
            appearance = "dark";
            theme = "oledppuccin";
            refresh_ms = 2000;
            show_graph = true;
            graph_metric = "merged";
            process_count = 50;
            energy_threshold = 0.5;
            merge_mode = true;
            transparent_background = false;
            forecast_window_secs = 300;
            excluded_processes = [];
            log_level = "info";
            history = {
              background_recording = false;
              sample_interval_secs = 60;
              retention_raw_days = 30;
              retention_hourly_days = 180;
              retention_daily_days = 0;
              retention_sessions_days = 90;
              max_database_mb = 500;
            };
            units = {
              energy = "wh";
              temperature = "celsius";
              data_size = "si";
            };
          };
        };
        "jolt/themes/oledppuccin.toml" = {
          generator = (pkgs.formats.toml {}).generate "config.toml";
          value = {
            name = "oledppuccin";

            dark = {
              bg = "#000000";
              dialog_bg = "#313244";
              fg = "#cdd6f4";
              accent = "#89b4fa";
              accent_secondary = "#cba6f7";
              highlight = "#f9e2af";
              muted = "#9399b2";
              success = "#a6e3a1";
              warning = "#fab387";
              danger = "#f38ba8";
              border = "#45475a";
              selection_bg = "#585b70";
              selection_fg = "#cdd6f4";
              graph_line = "#89b4fa";
            };
          };
        };
      };
    };
    nixosModules.oledppuccin = {
      boot = {
        kernelParams = [
          "vt.default_red=0,243,166,249,137,245,148,186,88,243,166,249,137,245,148,166"
          "vt.default_grn=0,139,227,226,180,194,226,194,91,139,227,226,180,194,226,173"
          "vt.default_blu=0,168,161,175,250,231,213,222,112,168,161,175,250,231,213,200"
        ];
        loader.limine = {
          extraConfig = builtins.readFile (theme + "limine.conf");
          style.interface.branding = "";
        };
      };
    };
  };
}
