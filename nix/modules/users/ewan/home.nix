{ self, ... }: {
  flake = {
    homeModules.ewan = { pkgs, ... }: {
      imports = [ self.homeModules.vicinae ];
      home = {
        homeDirectory = if pkgs.stdenv.isDarwin then "/Users/ewan" else "/home/ewan";
        stateVersion = "25.05";
        username = "ewan";
      };
      home.packages = with pkgs; [
        hyprcursor
        hyprpicker
        hyprshot
        libreoffice
        prismlauncher
        rose-pine-hyprcursor
        signal-desktop
        vesktop
        vscode
      ];
      programs = {
        git = {
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

        jujutsu = {
          enable = true;

          settings = {
            signing = {
              sign-all = false;
            };
            ui = {
              default-command = "log";
              diff-editor = "vimdiff";
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
      stylix.targets.halloy.enable = false;
    };
  };
}
