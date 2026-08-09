{
  flake = {
    homeModules.hyprland = { lib, ... }: {
      home.file.".config/uwsm/default-id".text = ''
        hyprland-uwsm.desktop
      '';
      wayland.windowManager.hyprland = {
        enable = true;
        package = null;
        configType = "lua";
        extraConfig = lib.mkBefore ''
          terminal = "kitty"
          menu = "vicinae toggle"
          browser = "firefox"
          mod = "SUPER"

          hl.env("XCURSOR_SIZE", "24")
          hl.env("HYPRCURSOR_SIZE", "24")
          hl.env("QT_QPA_PLATFORM", "wayland;xcb")

        '';
        portalPackage = null;
        systemd.enable = false;
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
