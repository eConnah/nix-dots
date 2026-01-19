{ inputs, ... }:
{

  flake.modules.homeManager.program-vicinae = {
    imports = [ inputs.vicinae.homeManagerModules.default ];
    services.vicinae = {
      enable = true;
      autoStart = true;
    };
  };
}