{ inputs, self, ... }:
{
  flake.homeModules.defaults =
    { pkgs, lib, ... }:
    {
      programs.fish.enable = true;
      programs.git.enable = true;
      programs.kitty.enable = true;

      programs.eza = {
        enable = true;
        git = true;
        icons = "always";
        enableFishIntegration = true;
        colors = "always";
      };
      programs.ssh = {
        enable = true;
        enableDefaultConfig = lib.mkDefault false;
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
