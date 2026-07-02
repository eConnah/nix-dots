{ self, ... }: {
  flake = {
    nixosModules.themes = { pkgs, ... }: {
      stylix = {
        enable = true;

        fonts = {
          sansSerif = {
            package = pkgs.atkinson-hyperlegible-next;
            name = "Atkinson Hyperlegible Next";
          };

          monospace = {
            package = pkgs.atkinson-hyperlegible-mono;
            name = "Atkinson Hyperlegible Mono";
          };

          serif = {
            package = pkgs.merriweather;
            name = "Merriweather";
          };

          emoji = {
            package = pkgs.noto-fonts-color-emoji;
            name = "Noto Color Emoji";
          };

          sizes = {
            terminal = 12;
            applications = 12;
          };
        };
      };

      home-manager.sharedModules = [
        self.homeModules.themes
      ];
    };

    homeModules.themes = { ... }: {
      stylix = {
        targets.firefox = {
          colorTheme.enable = true;
          profileNames = [ "default" ];
        };
      };
    };
  };
}
