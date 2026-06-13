{ ... }:
{
  flake.nixosModules.catppuccin =
    {
      pkgs,
      config,
      lib,
      ...
    }:
    {
      stylix = {
        enable = true;
        base16Scheme = "${pkgs.base16-schemes}/share/themes/catppuccin-mocha.yaml";
        override.base00 = "000000";
      };
    };
}
