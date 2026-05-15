{ inputs, self, ... }:
{
  flake.homeModules.defaults =
    { pkgs, ... }:
    {
      programs.fish.enable = true;
      programs.kitty.enable = true;

      programs.eza = {
        enable = true;
        git = true;
        icons = "always";
        enableFishIntegration = true;
        colors = "always";
      };
    };
}
