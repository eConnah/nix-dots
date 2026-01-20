{ inputs, ... }:
{
  flake.modules.homeManager.program-vicinae = {
    programs.vicinae = {
      enable = true;
      systemd = {
        enable = true;
        autoStart = true;
      };
    };
  };
}
