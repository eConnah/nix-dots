{ inputs, self, ... }:
{
  flake.homeModules.lenixPanel =
    { ... }:
    {
      imports = [ self.homeModules.hyprpanel ];
      programs.hyprpanel = {
        enable = true;
        settings = {
          menus.dashboard.powermenu.avatar.image = "${self}/pictures/profile-pics/connor.png";
          menus.clock = {
            weather.location = "Eindhoven";
          };
          bar.customModules = {
            worldclock.tz = [
              "Europe/Amsterdam"
            ];
          };
          bar = {
            layouts = {
              "*" = {
                "right" = [
                  "network"
                  "bluetooth"
                  "notifications"
                  "volume"
                  "custom/mac-battery"
                ];
              };
            };
          };
          scalingPriority = "hyprland";
        };
      };
      home.file.".config/hyprpanel/modules.json".text = ''
        {
          "custom/mac-battery": {
            "icon": {
              "Full100": "󰚥",
              "Discharging100": "󰁹",
              "Discharging90": "󰂂",
              "Discharging80": "󰂁",
              "Discharging70": "󰂀",
              "Discharging60": "󰁿",
              "Discharging50": "󰁾",
              "Discharging40": "󰁽",
              "Discharging30": "󰁼",
              "Discharging20": "󰁺",
              "Discharging10": "󰁺",
              "Discharging0": "󰂎",
              "Charging100": "󰂅",
              "Charging90": "󰂋",
              "Charging80": "󰂊",
              "Charging70": "󰢞",
              "Charging60": "󰂉",
              "Charging50": "󰢝",
              "Charging40": "󰂈",
              "Charging30": "󰂇",
              "Charging20": "󰂆",
              "Charging10": "󰢜",
              "Charging0": "󰢟",
              "default": "󰂑"
            },
            "label": "{charge}%",
            "tooltip": "{charge}% - {state}",
            "execute": "fish -c hyprbattery",
            "executeOnAction": "",
            "interval": 10000
          }
        }
      '';
    };
}
