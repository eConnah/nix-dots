{self, ...}: {
  flake.nixosModules.turtle-hjem = {pkgs, ...}: {
    hjem.users = {
      aude = {
        imports = with self.hjemModules; [
          turtle-hyprland
        ];
        packages = with pkgs; [
          plezy
          spotify
        ];
        theme.wallpaper = "your_name-01.png";
      };
      connor = {
        imports = with self.hjemModules; [
          turtle-hyprland
        ];
        packages = with pkgs; [
          #davinci-resolve
          heroic
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
        theme.wallpaper = "tensura-02.png";
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
      ewan = {
        imports = with self.hjemModules; [
          turtle-hyprland
        ];
        packages = with pkgs; [
          plezy
          spotify
        ];
        theme.wallpapers = {
          "DP-1" = "jjk-02.png";
          "HDMI-A-1" = "jjk-03.png";
        };
      };
      kyla = {
        imports = with self.hjemModules; [
          turtle-hyprland
        ];
        packages = with pkgs; [
          mixxx
          plezy
          spotify
        ];
        theme.wallpaper = "point_break-01.png";
      };
    };
  };
}
