{ inputs, self, ... }:
{
  flake.homeModules.hyprland =
    { ... }:
    {
      home.file.".config/uwsm/default-id".text = ''
        hyprland-uwsm.desktop
      '';
      wayland.windowManager.hyprland = {
        enable = true;
        package = null;
        portalPackage = null;
        systemd.enable = false;
      };
    };
  flake.nixosModules.hyprland =
    { ... }:
    {
      programs.hyprland = {
        enable = true;
        withUWSM = true;
        xwayland.enable = true;
      };

      programs.uwsm.enable = true;
    };
}
