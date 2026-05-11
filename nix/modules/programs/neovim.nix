{ inputs, self, ... }:
{
  flake.homeModules.neovim =
    { pkgs, ... }:
    {
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

      home.file.".config/nvim/ftdetect/rtl.vim".text = ''
        autocmd BufRead,BufNewFile *.rtl set filetype=rtl
      '';

      home.file.".config/nvim/syntax/rtl.vim".text = ''
        if exists("b:current_syntax")
          finish
        endif

        syntax match rtlComment /{[^}]*}/
        syntax match rtlRegister /\b\(IP\|IR\|SigmaA\|SigmaR\|SigmaW\|CC\|RA\|RB\|ALU\|RAM\)\b/
        syntax match rtlBus /(\(Abus\|Bbus\|Cbus\))/
        syntax match rtlOperator /<-\|+\|\[\|\]/
        syntax match rtlHex /0x[0-9A-Fa-f]\+/

        highlight default link rtlComment Comment
        highlight default link rtlRegister Function
        highlight default link rtlBus Type
        highlight default link rtlOperator Operator
        highlight default link rtlHex Constant

        " Custom Catppuccin-matching neon overrides
        highlight rtlHex guifg=#a6e3a1 gui=bold
        highlight rtlBus guifg=#fab387 gui=bold
        highlight rtlOperator guifg=#f5c2e7

        let b:current_syntax = "rtl"
      '';
    };
}
