{self, ...}: {
  flake.nixosModules.lenix-hjem = {pkgs, ...}: {
    hjem.users.connor = {
      imports = with self.hjemModules; [
        lenix-hyprland
        modprobed-db
      ];
      packages = with pkgs; [
        (chromium.override {enableWideVine = true;})
        moonlight-qt
        plezy
      ];
      theme.wallpaper = "frieren-01.png";
    };
  };
}
