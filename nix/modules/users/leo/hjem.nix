{self, ...}: {
  flake.hjemModules.leo = {pkgs, ...}: {
    imports = with self.hjemModules; [
      defaults
      oledppuccin
      vicinae
    ];
    environment.sessionVariables.EDITOR = "nvim";
    packages = with pkgs; [
      (chromium.override {enableWideVine = true;})
      eduvpn-client
      jetbrains.idea
      jetbrains.rider
      libreoffice
      obsidian
      prismlauncher
      signal-desktop
      spotifyd
      vesktop
      vscode
    ];
    rum.programs.git = {
      settings = {
        core = {
          editor = "nvim";
        };
        diff = {
          tool = "vimdiff";
        };
        init = {
          defaultBranch = "main";
        };
        pull = {
          ff = "only";
        };
        push = {
          autoSetupRemote = true;
        };
        user = {
          name = "Leo Chittock";
        };
      };
    };
    xdg.config.files = {
      "jj/config.toml" = {
        generator = (pkgs.formats.toml {}).generate "config.toml";
        value = {
          ui = {
            default-command = "log";
            diff-editor = ":builtin";
            editor = "nvim";
            merge-editor = "vimdiff";
          };
          user = {
            name = "Leo Chittock";
          };
        };
      };
    };
  };
}
