{
  flake.homeModules.swaybg =
    {
      config,
      lib,
      pkgs,
      remoteAssets,
      ...
    }:
    let
      wallpaperName = config.theme.wallpaper;
    in
    {
      options.theme.wallpaper = lib.mkOption {
        default = null;
        description = "Filename of the wallpaper located in pictures/wallpapers.";
        type = lib.types.nullOr lib.types.str;
      };
      config = lib.mkIf (wallpaperName != null) {
        home.packages = [ pkgs.swaybg ];

        systemd.user.services.swaybg = {
          Install = {
            WantedBy = [ "graphical-session.target" ];
          };
          Service = {
            ExecStart = "${pkgs.swaybg}/bin/swaybg -i ${remoteAssets.wallpapers.${wallpaperName}} -m fill";
            Restart = "always";
          };
          Unit = {
            After = [ "graphical-session.target" ];
            Description = "Wayland wallpaper daemon";
            PartOf = [ "graphical-session.target" ];
          };
        };
      };
    };
}
