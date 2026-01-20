{ inputs, ... }:
{
  flake.modules.homeManager.desktop-hyprland = {
    home.sessionVariables.NIXOS_OZONE_WL = "1";
    wayland.windowManager.hyprland = {
      enable = true;
      package = null;
      portalPackage = null;
      systemd.enable = false;
    };

    programs.kitty.enable = true;
  };
}
