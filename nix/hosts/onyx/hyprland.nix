{self, ...}: {
  flake.hjemModules.onyx-hyprland = {lib, ...}: {
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
          output = "DP-3",
          mode = "2560x1440@240",
          position = "0x0",
          scale = 1,
          bitdepth = 10,
          cm = "srgb",
          vrr = 2
        })

        hl.monitor({
          output = "",
          mode = "preferred",
          position = "auto",
          scale = "auto"
        })

        hl.on("hyprland.start", function()
          hl.exec_cmd("xrandr --output DP-3 --primary")
        end)

        hl.config({
          input = {
            accel_profile = "flat",
            follow_mouse = 1,
            kb_layout = "us",
            sensitivity = 0,
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
