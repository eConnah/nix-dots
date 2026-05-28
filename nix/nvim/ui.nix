{ ... }:
{
  flake.nvfModules.ui =
    { ... }:
    {
      vim = {
        ui = {
          borders.enable = true;
          colorizer.enable = true;
          noice.enable = true;
        };

        notify.nvim-notify.enable = true;
      };
    };
}
