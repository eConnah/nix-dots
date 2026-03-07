{ inputs, self, ... }:
{
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

  flake.homeModules.hyprland =
    { ... }:
    {
      wayland.windowManager.hyprland = {
        enable = true;
        package = null;
        portalPackage = null;
        extraConfig = import ./hyprland.nix;
        systemd.enable = false;
      };
    };
}
