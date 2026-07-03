{ ... }: {
  flake.nvfModules.defaults = { pkgs, ... }: {
    vim = {
      # Core Editor
      viAlias = true;
      vimAlias = true;

      # Tab indents
      options = {
        shiftwidth = 4;
        tabstop = 4;
        expandtab = true;
      };

      # Visuals & UI
      theme = {
        enable = true;
        name = "catppuccin";
        style = "mocha";
        transparent = true;
      };
      tabline.nvimBufferline.enable = true;
      statusline.lualine.enable = true;

      # Navigation & Menus
      filetree.neo-tree.enable = true;
      telescope.enable = true;
      binds.whichKey.enable = true;

      # Coding & Completion
      autocomplete.blink-cmp.enable = true; # The modern, faster completion engine
      snippets.luasnip.enable = true;

      # Extras
      clipboard.providers.wl-copy.enable = true;
      searchCase = "smart";
      preventJunkFiles = true;
      undoFile.enable = true;

      # Language Support
      languages = {
        enableFormat = true;
        enableTreesitter = true;
        enableExtraDiagnostics = true;

        bash.enable = true;
        csharp.enable = true;
        fish.enable = true;
        java.enable = true;
        lua.enable = true;
        markdown.enable = true;
        nix.enable = true;
        python.enable = true;
        rust.enable = true;
        xml.enable = true;
      };

      # LSP UI integrations
      lsp = {
        enable = true;
        formatOnSave = true;
        trouble.enable = true;
        lightbulb.enable = true;
      };

      # Git integration
      git = {
        enable = true;
        gitsigns.enable = true;
      };
      extraPlugins = {
        kitty-scrollback = {
          package = pkgs.vimPlugins.kitty-scrollback-nvim;

          # The setup function as required by the plugin
          setup = ''
            require('kitty-scrollback').setup({
            })
          '';
        };
      };
    };
  };
}
