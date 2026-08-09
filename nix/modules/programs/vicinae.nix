{
  flake.homeModules.vicinae = {
    programs.vicinae = {
      enable = true;
      systemd.enable = true;
    };
  };
}
