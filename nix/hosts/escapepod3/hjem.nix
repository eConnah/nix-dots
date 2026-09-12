{self, ...}: {
  flake.nixosModules.escapepod3-hjem = {pkgs, ...}: {
    hjem.users.leo = {
      imports = with self.hjemModules; [
        escapepod3-hyprland
        modprobed-db
      ];
      packages = with pkgs; [
        plezy
      ];
      theme.wallpaper = "ultrakill-01.png";
    };
  };
}
