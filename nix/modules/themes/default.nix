{ self, ... }: {
  flake = {
    homeModules.themes = {
      stylix = {
        targets.firefox = {
          colorTheme.enable = true;
          profileNames = [ "default" ];
        };
      };
    };
    nixosModules.themes = { pkgs, ... }: {
      home-manager.sharedModules = [
        self.homeModules.themes
      ];
      stylix = {
        enable = true;

        fonts = {
          emoji = {
            package = pkgs.noto-fonts-color-emoji;
            name = "Noto Color Emoji";
          };
          monospace = {
            package = pkgs.atkinson-hyperlegible-mono;
            name = "Atkinson Hyperlegible Mono";
          };
          sansSerif = {
            package = pkgs.atkinson-hyperlegible-next;
            name = "Atkinson Hyperlegible Next";
          };
          serif = {
            package = pkgs.merriweather;
            name = "Merriweather";
          };
          sizes = {
            applications = 12;
            terminal = 12;
          };
        };
      };
    };
  };
}
