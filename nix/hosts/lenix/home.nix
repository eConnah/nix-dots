{
  inputs,
  self,
  ...
}:
{
  flake.nixosModules.lenix-home = { pkgs, ... }: {
    imports = [ inputs.home-manager.nixosModules.default ];
    home-manager = {
      backupFileExtension = "backup";
      sharedModules = [
        self.homeModules.defaults
      ];
      useGlobalPkgs = true;
      useUserPackages = true;
      users.connor = {
        imports = [
          self.homeModules.lenix-hyprland
          self.homeModules.swaybg
        ];
        home.packages = with pkgs; [
          (plezy.override { use16kPagesizeWorkaround = true; })
          (chromium.override { enableWideVine = true; })
          moonlight-qt
        ];
        theme.wallpaper = "frieren-01.png";
      };
    };
  };
}
