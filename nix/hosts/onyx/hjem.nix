{ self, ... }: {
  flake.nixosModules.onyx-hjem = { pkgs, ... }: {
    hjem.users.connor = {
      imports = with self.hjemModules; [
        onyx-hyprland
      ];
      environment.sessionVariables = {
        PROTON_ENABLE_WAYLAND = "1";
      };
      packages = with pkgs; [
        davinci-resolve
        plezy
        spotify
      ];
      rum.programs.obs-studio = {
        enable = true;

        package =
          (pkgs.wrapOBS.override {
            obs-studio = pkgs.obs-studio.override { cudaSupport = true; };
          })
            {
              plugins = with pkgs.obs-studio-plugins; [
                obs-pipewire-audio-capture
                obs-vkcapture
                wlrobs
              ];
            };
      };
      theme.wallpaper = "86-01.png";
    };
  };
}
