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
      catppuccin-nvim
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
    extraConfig = ''
      colorscheme catppuccin-mocha
      set expandtab
      set tabstop=4
      set shiftwidth=4
      set softtabstop=4
    '';
  };

  home.file.".config/nvim/ftplugin/python.vim".text = ''
    setlocal expandtab
    setlocal tabstop=4
    setlocal shiftwidth=4
    setlocal softtabstop=4
  '';

  home.file.".config/nvim/ftplugin/nix.vim".text = ''
    setlocal expandtab
    setlocal tabstop=2
    setlocal shiftwidth=2
    setlocal softtabstop=2
  '';

  programs.eza = {
    enable = true;
    git = true;
    icons = "always";
    enableFishIntegration = true;
    colors = "always";
    theme = builtins.fromJSON (builtins.readFile ./theme-eza.json);
  };
}
