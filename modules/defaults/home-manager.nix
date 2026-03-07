{ inputs, self, ... }:
{
  flake.homeModules.defaults =
    { pkgs, ... }:
    {
      programs.eza = {
        enable = true;
        git = true;
        icons = "always";
        enableFishIntegration = true;
        colors = "always";
      };
    };
}
