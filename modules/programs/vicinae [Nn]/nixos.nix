{ inputs, ... }:
{
  flake.modules.nixos.program-vicinae = {
    nix.settings = {
      extra-substituters = [ "https://vicinae.cachix.org" ];
      extra-trusted-public-keys = [ "vicinae.cachix.org-1:1kDrfienkGHPYbkpNj1mWTr7Fm1+zcenzgTizIcI3oc=" ];
    };

    home-manager.sharedModules = [
      inputs.self.modules.homeManager.program-vicinae
    ];
  };
}