{
  flake = {
    hjemModules.hyprland = {
      config,
      lib,
      pkgs,
      ...
    }: let
      inherit (lib) mkOption types;
    in {
      options.custom.hyprland.extraLuaConfig = mkOption {
        default = "";
        description = "Lua snippets that will be merged into hyprland.lua";
        type = types.lines;
      };

      config = {
        custom.hyprland.extraLuaConfig =
          lib.mkBefore
          /*
          lua
          */
          ''
            mod = "SUPER"
            browser = "firefox"
            terminal = "kitty"

            hl.env("QT_QPA_PLATFORM", "wayland;xcb")
          '';
        environment.sessionVariables = {
          HYPRCURSOR_SIZE = "24";
          HYPRCURSOR_THEME = "rose-pine-hyprcursor";
          XCURSOR_SIZE = "24";
          XCURSOR_THEME = "BreezeX-RosePine-Linux";
        };
        packages = with pkgs; [
          hyprpicker
          hyprshot
          rose-pine-cursor
          rose-pine-hyprcursor
        ];
        rum.desktops.hyprland.enable = true;
        xdg.config.files = {
          "hypr/hyprland.lua".text = config.custom.hyprland.extraLuaConfig;
          "uwsm/default-id".text = ''
            hyprland-uwsm.desktop
          '';
        };
      };
    };
    nixosModules.hyprland = {
      programs.hyprland = {
        enable = true;
        withUWSM = true;
        xwayland.enable = true;
      };
      programs.uwsm.enable = true;
    };
  };
}
