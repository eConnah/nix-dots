{self, ...}: {
  flake.nixosModules.murtle-hjem = {pkgs, ...}: {
    hjem.users = {
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
