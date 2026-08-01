{ ... }: {
  flake.nvfModules.defaults = { pkgs, ... }: {
    vim = {
      # Tab indents
      options = {
        expandtab = true;
        shiftwidth = 4;
        tabstop = 4;
      };
      # Coding & Completion
      autocomplete.blink-cmp.enable = true; # The modern, faster completion engine
      binds.whichKey.enable = true;
      # Extras
      clipboard.providers.wl-copy.enable = true;
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
      # Navigation & Menus
      filetree.neo-tree.enable = true;
      # Git integration
      git = {
        enable = true;
        gitsigns.enable = true;
      };
      # Language Support
      languages = {
        bash.enable = true;
        csharp.enable = true;
        enableExtraDiagnostics = true;
        enableFormat = true;
        enableTreesitter = true;
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
        lightbulb.enable = true;
        trouble.enable = true;
      };
      preventJunkFiles = true;
      searchCase = "smart";
      snippets.luasnip.enable = true;
      statusline.lualine.enable = true;
      tabline.nvimBufferline.enable = true;
      telescope.enable = true;
      # Visuals & UI
      theme = {
        enable = true;
        name = "catppuccin";
        style = "mocha";
        transparent = true;
      };
      undoFile.enable = true;
      # Core Editor
      viAlias = true;
      vimAlias = true;
    };
  };
}
