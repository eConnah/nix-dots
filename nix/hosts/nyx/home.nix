{
  inputs,
  self,
  ...
}:
{
  flake.nixosModules.nyx-home = { pkgs, ... }: {
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
          theme.wallpaper = "mountains-01.jpg";
        };

        ewan = {
          imports = with self.homeModules; [
            nyx-hyprland
            swaybg
          ];
          home = {
            packages = with pkgs; [
              plezy
              spotify
            ];

            sessionVariables = {
              PROTON_ENABLE_WAYLAND = "1";
            };
          };
          theme.wallpaper = "mountains-01.jpg";
        };
      };
    };
  };
}
