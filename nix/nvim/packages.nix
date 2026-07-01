{
  inputs,
  self,
  ...
}:
{
  perSystem = { pkgs, ... }: {
    packages = {
      nvim-qwerty =
        (inputs.nvf.lib.neovimConfiguration {
          inherit pkgs;
          modules = [
            self.nvfModules.defaults
            self.nvfModules.notes
            self.nvfModules.ui
            self.nvfModules.workflow
          ];
        }).neovim;
    };
  };
}
