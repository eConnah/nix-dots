{ ... }: {
  flake.homeModules.swaybg =
    {
      pkgs,
      lib,
      config,
      remoteAssets,
      ...
    }:
    let
      wallpaperName = config.theme.wallpaper;
    in
    {
      options.theme.wallpaper = lib.mkOption {
        type = lib.types.nullOr lib.types.str;
        default = null;
        description = "Filename of the wallpaper located in pictures/wallpapers.";
      };

      config = lib.mkIf (wallpaperName != null) {
        home.packages = [ pkgs.swaybg ];

        systemd.user.services.swaybg = {
          Unit = {
            Description = "Wayland wallpaper daemon";
            PartOf = [ "graphical-session.target" ];
            After = [ "graphical-session.target" ];
          };
          Service = {
            ExecStart = "${pkgs.swaybg}/bin/swaybg -i ${remoteAssets.wallpapers.${wallpaperName}} -m fill";
            Restart = "always";
          };
          Install = {
            WantedBy = [ "graphical-session.target" ];
          };
        };
      };
    };
}
