{ pkgs, ... }:

{
  imports = [
    ./fish.nix
  ];

  programs.neovim = {
    enable = true;
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;
    vimdiffAlias = true;
    plugins = with pkgs.vimPlugins; [
      diffview-nvim
      neogit
      {
        plugin = oil-nvim;
        config = ''
          packadd! oil.nvim
          lua << EOF
require("oil").setup()
EOF
        '';
      }
    ];
  };
}
