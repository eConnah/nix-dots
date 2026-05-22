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

      services.easyeffects.enable = lib.mkDefault true;
    };
}
