{ inputs, self, ... }:
{
  flake.homeModules.swaybg =
    { pkgs, ... }:
    {
      home.packages = [ pkgs.swaybg ];

      systemd.user.services.swaybg = {
        Unit = {
          Description = "Wayland wallpaper daemon";
          PartOf = [ "graphical-session.target" ];
          After = [ "graphical-session.target" ];
        };
        Service = {
          ExecStart = "${pkgs.swaybg}/bin/swaybg -i ${self}/pictures/wallpapers/frieren-01.png -m fill";
          Restart = "always";
        };
        Install = {
          WantedBy = [ "graphical-session.target" ];
        };
      };
    };
}
