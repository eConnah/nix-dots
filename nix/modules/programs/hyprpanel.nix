{ inputs, self, ... }:
{
  flake.homeModules.hyprpanel =
    { pkgs, ... }:
    {
      programs.hyprpanel = {
        enable = true;
        settings = {
          bar = {
            bluetooth.label = false;
            clock.format = "%a %b %d  %H:%M:%S";
            launcher.autoDetectIcon = true;
            layouts = {
              "*" = {
                "left" = [
                  "dashboard"
                  "workspaces"
                  "windowtitle"
                ];
                "middle" = [
                  "media"
                  "clock"
                ];
              };
            };
            network = {
              showWifiInfo = true;
              truncation = false;
            };
          };
          bar.customModules = {
            storage.paths = [ "/" ];
            weather.unit = "metric";
            worldclock.format = "%H:%M:%S %Z";
            worldclock.formatDiffDate = "%a %b %d %H:%M:%S %Z";
          };
          menus.clock = {
            time.military = true;
            weather.unit = "metric";
          };
          theme = {
            bar = {
              buttons.monochrome = true;
              floating = true;
              menus.monochrome = true;
              transparent = true;
            };
            font = {
              label = "JetBrainsMono Nerd Font Medium";
              name = "JetBrainsMono Nerd Font";
              size = "16px";
            };
          };
        };
      };
    };
}
