{ self, ... }: {
  flake.nixosModules.lenix-hjem = { pkgs, ... }: {
    hjem.users.connor = {
      imports = with self.hjemModules; [
        lenix-hyprland
        asahi
      ];
      packages = with pkgs; [
        (plezy.override { use16kPagesizeWorkaround = true; })
        (chromium.override { enableWideVine = true; })
        moonlight-qt
      ];
      theme.wallpaper = "frieren-01.png";
    };
  };
}
