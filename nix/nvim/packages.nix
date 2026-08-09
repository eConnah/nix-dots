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
          modules = with self.nvfModules; [
            defaults
            notes
            ui
            workflow
          ];
        }).neovim;
    };
  };
}
