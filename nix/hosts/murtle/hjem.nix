{ self, ... }: {
  flake.nixosModules.murtle-hjem = { pkgs, ... }: {
    hjem.users = {
      connor = {
        imports = with self.hjemModules; [
          murtle-hyprland
        ];
        packages = with pkgs; [
          plezy
          spotify
        ];
        theme.wallpaper = "86-02.png";
      };

      ewan = {
        imports = with self.hjemModules; [
          murtle-hyprland
        ];
        packages = with pkgs; [
          plezy
        ];
        theme.wallpaper = "frieren-03.png";
      };
    };
  };
}
