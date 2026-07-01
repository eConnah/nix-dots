{ inputs, ... }: {
  flake.homeModules.vicinae = { ... }: {
    imports = [ inputs.vicinae.homeManagerModules.default ];
    programs.vicinae = {
      enable = true;
      systemd.enable = true;
    };
  };
}
