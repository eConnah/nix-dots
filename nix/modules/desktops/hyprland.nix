{ self, ... }: {
  flake = {
    hjemModules.hyprland =
      {
        config,
        lib,
        pkgs,
        ...
      }:
      let
        inherit (lib) mkOption types;
      in
      {
        options.custom.hyprland.extraLuaConfig = mkOption {
          default = "";
          description = "Lua snippets that will be merged into hyprland.lua";
          type = types.lines;
        };

        config = {
          custom.hyprland.extraLuaConfig = lib.mkBefore ''
            mod = "SUPER"
            browser = "firefox"
            terminal = "kitty"

            hl.env("XCURSOR_SIZE", "24")
            hl.env("HYPRCURSOR_SIZE", "24")
            hl.env("QT_QPA_PLATFORM", "wayland;xcb")
          '';
          packages = with pkgs; [
            hyprcursor
            hyprpicker
            hyprshot
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
