{
  inputs,
  self,
  ...
}:
{
  flake.nixosModules.onyx-home = { pkgs, ... }: {
    imports = [ inputs.home-manager.nixosModules.default ];

    home-manager = {
      useGlobalPkgs = true;
      useUserPackages = true;
      backupFileExtension = "backup";

      sharedModules = [
        self.homeModules.defaults
      ];

      users.connor = {
        imports = [
          self.homeModules.onyx-hyprland
          self.homeModules.swaybg
        ];

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
      };
    };
  };
}
