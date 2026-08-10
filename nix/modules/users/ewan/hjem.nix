{ self, ... }: {
  flake.hjemModules.ewan = { pkgs, ... }: {
    imports = with self.hjemModules; [
      vicinae
      defaults
    ];
    environment.sessionVariables.EDITOR = "nvim";
    packages = with pkgs; [
      libreoffice
      prismlauncher
      signal-desktop
      vesktop
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
          email = "ewan.alecks@gmail.com";
          name = "Ewan Alecks";
        };
      };
    };
    xdg.config.files = {
      "jj/config.toml" = {
        generator = (pkgs.formats.toml { }).generate "config.toml";
        value = {
          ui = {
            default-command = "log";
            diff-editor = ":builtin";
            editor = "nvim";
            merge-editor = "vimdiff";
          };
          user = {
            email = "ewan.alecks@gmail.com";
            name = "Ewan Alecks";
          };
        };
      };
    };
  };
}
