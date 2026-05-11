{ inputs, self, ... }:
{
  flake.homeModules.hyprpanel =
    { pkgs, ... }:
    {
      programs.hyprpanel = {
        enable = true;
        settings = {
          theme = {
            font = {
              name = "JetBrainsMono Nerd Font";
              label = "JetBrainsMono Nerd Font Medium";
              size = "16px";
            };
            bar = {
              floating = true;
              transparent = true;
              menus.monochrome = true;
              buttons.monochrome = true;
            };
          };
          menus.clock = {
            weather.unit = "metric";
            time.military = true;
          };
          bar.customModules = {
            storage.paths = [ "/" ];
            weather.unit = "metric";
            worldclock.format = "%H:%M:%S %Z";
            worldclock.formatDiffDate = "%a %b %d %H:%M:%S %Z";
          };
          bar = {
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
            launcher.autoDetectIcon = true;
            bluetooth.label = false;
            clock.format = "%a %b %d  %H:%M:%S";
          };
        };
      };
    };
}
