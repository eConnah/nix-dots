{ self, ... }: {
  flake = {
    nixosModules.ewan = { pkgs, ... }: {
      imports = [ self.nixosModules.ewan-preservation ];

      home-manager.users.ewan = self.homeModules.ewan;

      users.users.ewan = {
        description = "Ewan Alecks";
        isNormalUser = true;
        shell = pkgs.fish;
        extraGroups = [
          "wheel"
          "networkmanager"
          "dialout"
          "uucp"
        ];
      };
    };

    homeModules.ewan = { pkgs, ... }: {
      imports = [ self.homeModules.vicinae ];
      home = {
        username = "ewan";
        homeDirectory = if pkgs.stdenv.isDarwin then "/Users/ewan" else "/home/ewan";
        stateVersion = "25.05";
      };

      stylix.targets.halloy.enable = false;
      programs = {
        git = {
          settings = {
            user = {
              name = "Ewan Alecks";
              email = "ewan.alecks@gmail.com";
            };
            pull = {
              ff = "only";
            };
            init = {
              defaultBranch = "main";
            };
            diff = {
              tool = "vimdiff";
            };
            core = {
              editor = "vim";
            };
            push = {
              autoSetupRemote = true;
            };
          };
        };
      };

      home.packages = with pkgs; [
        hyprcursor
        hyprpicker
        hyprshot
        libreoffice
        prismlauncher
        rose-pine-hyprcursor
        vesktop
        vscode
      ];
    };
  };
}
