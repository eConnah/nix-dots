{ inputs, self, ... }:
{
  flake.homeModules.optioned =
    {
      pkgs,
      lib,
      config,
      ...
    }:
    {
      options.programs.ncspot = {
        enable = lib.mkEnableOption "ncspot Spotify client";
      };

      config = lib.mkIf config.programs.ncspot.enable {
        home.packages = [ pkgs.ncspot ];
      };
    };
}
