{
  inputs,
  self,
  ...
}:
{
  flake.nixosModules.phoenix-home = { pkgs, ... }: {
    imports = [ inputs.home-manager.nixosModules.default ];
    home-manager = {
      backupFileExtension = "backup";
      sharedModules = [
        self.homeModules.defaults
      ];
      useGlobalPkgs = true;
      useUserPackages = true;
      users = {
        connor = {
          imports = [
            self.homeModules.phoenix-hyprland
            self.homeModules.swaybg
          ];
          home.packages = with pkgs; [
            plezy
            spotify
          ];
          theme.wallpaper = "86-02.png";
        };

        ewan = {
          imports = [
            self.homeModules.phoenix-hyprland
            self.homeModules.swaybg
          ];
          home.packages = with pkgs; [
            plezy
          ];
          theme.wallpaper = "frieren-03.png";
        };
      };
    };
  };
}
