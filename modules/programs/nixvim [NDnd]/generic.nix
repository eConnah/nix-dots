{ pkgs, ... }:
{
  flake.modules.generic.nixvim-config = {
    programs.nixvim = {
      enable = true;
      
      colorschemes.catppuccin.enable = true;
      
      plugins = {
        neogit.enable = true;
        oil.enable = true;
        mini-icons.enable = true;
        mini-icons.mockDevIcons = true;
        diffview.enable = true;
      };
    };
  };
}