{
  inputs,
  self,
  ...
}:
{
  flake.nixosModules.nyx-home = { pkgs, ... }: {
    imports = [ inputs.home-manager.nixosModules.default ];

    home-manager = {
      useGlobalPkgs = true;
      useUserPackages = true;
      backupFileExtension = "backup";

      sharedModules = [
        self.homeModules.defaults
      ];

      users = {
        connor = {
          imports = [
            self.homeModules.nyx-hyprland
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

          theme.wallpaper = "mountains-01.jpg";

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

        ewan = {
          imports = [
            self.homeModules.nyx-hyprland
            self.homeModules.swaybg
          ];

          theme.wallpaper = "mountains-01.jpg";

          home = {
            packages = with pkgs; [
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
  };
}
