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

        package = pkgs.wrapOBS {
          plugins = with pkgs.obs-studio-plugins; [
            obs-pipewire-audio-capture
            obs-vkcapture
            wlrobs
          ];
        };
      };
      theme.wallpaper = "86-01.png";
      xdg.config.files."mpv/mpv.conf".text = ''
        profile=high-quality
        vo=gpu-next
        gpu-api=vulkan
        hwdec=nvdec-copy
        video-sync=display-resample
        interpolation=yes
        tscale=oversample
        deband-iterations=4
        deband-threshold=48
        deband-range=16
        deband-grain=48
        target-colorspace-hint=yes
      '';
    };
  };
}
