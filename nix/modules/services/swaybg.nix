{
  flake.hjemModules.swaybg =
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
        packages = with pkgs; [ swaybg ];

        systemd.services.swaybg = {
          enable = true;
          after = [ "graphical-session.target" ];
          description = "Wayland wallpaper daemon";
          partOf = [ "graphical-session.target" ];
          serviceConfig = {
            ExecStart = "${pkgs.swaybg}/bin/swaybg -i ${remoteAssets.wallpapers.${wallpaperName}} -m fill";
            Restart = "always";
          };
          wantedBy = [ "graphical-session.target" ];
        };
      };
    };
}
