{self, ...}: {
  flake.hjemModules.cookie-hyprland = {lib, ...}: {
    imports = with self.hjemModules; [
      presets-hyprland
      hyprland
    ];
    custom.hyprland.extraLuaConfig =
      lib.mkOrder 501
      /*
      lua
      */
      ''
        hl.monitor({
            output = "eDP-1",
            mode = "1920x1080@60",
            position = "0x0",
            scale = 1,
        })
        hl.monitor({
          output = "",
          mode = "preferred",
          position = "auto",
          scale = "auto"
        })

        hl.on("hyprland.start", function()
          hl.exec_cmd("xrandr --output eDP-1 --primary")
        end)

        hl.config({
            input = {
              follow_mouse = 1,
              sensitivity = 0.3,
              kb_layout = "gb",
              touchpad = {
                natural_scroll = true,
                clickfinger_behavior = true,
                disable_while_typing = true,
              },
            }
          })

        menu = "vicinae toggle"
      '';
    presets.hyprland = [
      "animations"
      "keybinds"
      "rules"
      "settings"
    ];
  };
}
