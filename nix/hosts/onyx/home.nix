{
  inputs,
  self,
  ...
}:
{
  flake.nixosModules.onyx-home = { pkgs, ... }: {
    imports = [ inputs.home-manager.nixosModules.default ];
    home-manager = {
      backupFileExtension = "backup";
      sharedModules = with self.homeModules; [
        defaults
      ];
      useGlobalPkgs = true;
      useUserPackages = true;
      users.connor = {
        imports = with self.homeModules; [
          nyx-hyprland
          swaybg
        ];
        home = {
          packages = with pkgs; [
            davinci-resolve
            plezy
            spotify
          ];

          sessionVariables = {
            PROTON_ENABLE_WAYLAND = "1";
          };
        };
        programs.obs-studio = {
          enable = true;

          package = pkgs.obs-studio.override {
            cudaSupport = true;
          };

          plugins = with pkgs.obs-studio-plugins; [
            obs-pipewire-audio-capture
          ];
        };
        theme.wallpaper = "86-01.png";
      };
    };
  };
}
