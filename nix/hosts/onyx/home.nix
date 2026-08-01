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
      sharedModules = [
        self.homeModules.defaults
      ];
      useGlobalPkgs = true;
      useUserPackages = true;
      users.connor = {
        imports = [
          self.homeModules.onyx-hyprland
          self.homeModules.swaybg
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
