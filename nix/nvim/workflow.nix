{ ... }:
{
  flake.nvfModules.workflow =
    { ... }:
    {
      vim = {
        utility = {
          oil-nvim.enable = true;
          surround.enable = true;
        };

        terminal = {
          toggleterm = {
            enable = true;
            setupOpts.direction = "float";

            lazygit.enable = true;
          };
        };

        navigation.harpoon.enable = true;
      };
    };
}
