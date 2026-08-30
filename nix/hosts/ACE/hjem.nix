{self, ...}: {
  flake.nixosModules.ACE-hjem = {pkgs, ...}: {
    hjem.users = {
      connor = {
        imports = with self.hjemModules; [
          ACE-hyprland
        ];
        packages = with pkgs; [
          plezy
          spotify
        ];
        theme.wallpaper = "darling_in_the_franxx-01.png";
      };

      kyla = {
        imports = with self.hjemModules; [
          ACE-hyprland
        ];
        packages = with pkgs; [
          mixxx
          plezy
          spotify
        ];
        theme.wallpaper = "point_break-01.png";
      };
    };
  };
}
