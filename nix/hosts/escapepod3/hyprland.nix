{self, ...}: {
  flake.hjemModules.escapepod3-hyprland = {lib, ...}: {
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
            mode = "2560x1600@60",
            position = "0x0",
            scale = 1.25
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
            touchpad = {
              natural_scroll = true,
              clickfinger_behavior = true,
              disable_while_typing = false,
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
