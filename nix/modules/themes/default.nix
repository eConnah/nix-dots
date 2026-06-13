{ self, ... }:
{
  flake.nixosModules.themes =
    { lib, ... }:
    {
      stylix = {
        enable = true;
      };

      home-manager.sharedModules = [
        self.homeModules.themes
      ];
    };

  flake.homeModules.themes =
    { lib, ... }:
    {
      stylix = {
        targets.firefox = {
          colorTheme.enable = true;
          profileNames = [ "default" ];
        };
      };
    };
}
