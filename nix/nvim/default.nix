{ inputs, self, ... }:
{
  perSystem =
    { pkgs, system, ... }:
    {
      packages.nvim-qwerty =
        (inputs.nvf.lib.neovimConfiguration {
          inherit pkgs;

          modules = [
            self.nvfModules.default
          ];
        }).neovim;

    };

  flake.nvfModules.default =
    { config, ... }:
    {
      config.vim = {
        theme.enable = true;
      };
    };
}
