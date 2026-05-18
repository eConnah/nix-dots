{ inputs, self, ... }:
{
  flake.homeModules.defaults =
    { pkgs, ... }:
    {
      programs.fish.enable = true;
      programs.git.enable = true;
      programs.kitty.enable = true;
      programs.ssh.enable = true;

      programs.eza = {
        enable = true;
        git = true;
        icons = "always";
        enableFishIntegration = true;
        colors = "always";
      };
    };
}
