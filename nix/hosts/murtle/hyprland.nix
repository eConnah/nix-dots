{ self, ... }: {
  flake.hjemModules.murtle-hyprland = { lib, ... }: {
    imports = with self.hjemModules; [
      presets-hyprland
      hyprland
    ];
    custom.hyprland.extraLuaConfig = lib.mkOrder 501 /* lua */ ''
      hl.monitor({
          output = "DP-1",
          mode = "1920x1080@60",
          position = "0x0",
          scale = 1,
      })
      hl.monitor({
          output = "DP-2",
          mode = "1920x1080@60",
          position = "1920x0",
          scale = 1,
      })
      hl.monitor({
        output = "",
        mode = "preferred",
        position = "auto",
        scale = "auto"
      })

      hl.on("hyprland.start", function()
        hl.exec_cmd("xrandr --output DP-1 --primary")
      end)

      hl.config({
        input = {
          accel_profile = "flat",
          follow_mouse = 1,
          kb_layout = "gb",
          sensitivity = 0,
        }
      })

      menu = "vicinae toggle"

      hl.bind("F1", hl.dsp.exec_cmd("${self}/not-nix/ewan/autoclicker.sh"))
    '';
    presets.hyprland = [
      "animations"
      "keybinds"
      "rules"
      "settings"
    ];
  };
}
