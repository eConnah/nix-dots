{ self, ... }:
{
  flake.nixosModules.catppuccin =
    {
      config,
      lib,
      pkgs,
      ...
    }:
    {
      imports = [ self.nixosModules.themes ];
      stylix = {
        base16Scheme = "${pkgs.base16-schemes}/share/themes/catppuccin-mocha.yaml";
        override.base00 = "000000";
      };
    };
}
