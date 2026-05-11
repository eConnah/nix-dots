{ inputs, self, ... }:
{
  flake.homeModules.vicinae =
    { ... }:
    {
      imports = [ inputs.vicinae.homeManagerModules.default ];
      services.vicinae = {
        enable = true;
        systemd.enable = true;
      };
    };
}
