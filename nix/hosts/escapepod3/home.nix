{
  inputs,
  self,
  ...
}:
{
  flake.nixosModules.escapepod3-home = { pkgs, ... }: {
    imports = [ inputs.home-manager.nixosModules.default ];
    home-manager = {
      backupFileExtension = "backup";
      sharedModules = with self.homeModules; [
        defaults
      ];
      useGlobalPkgs = true;
      useUserPackages = true;
      users.leo = {
        imports = with self.homeModules; [
          escapepod3-hyprland
          swaybg
        ];
        home.packages = with pkgs; [
          (plezy.override { use16kPagesizeWorkaround = true; })
          lazyspotify
        ];
        programs.ncspot.enable = true;
        theme.wallpaper = "ultrakill-01.png";
      };
    };
  };
}
