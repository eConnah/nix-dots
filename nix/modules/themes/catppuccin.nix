{ self, ... }:
{
  flake.nixosModules.catppuccin =
    {
      pkgs,
      config,
      lib,
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
