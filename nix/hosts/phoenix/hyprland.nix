{ self, ... }: {
  flake.homeModules.phoenix-hyprland = { lib, ... }: {
    imports = [
      self.homeModules.hyprland
      self.homeModules.preset-hyprland-animations
      self.homeModules.preset-hyprland-keybinds
      self.homeModules.preset-hyprland-rules
      self.homeModules.preset-hyprland-settings
    ];

    wayland.windowManager.hyprland = {
      configType = "lua";
      extraConfig = lib.mkOrder 501 ''
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
            accel_profile = "flat",
            follow_mouse = 1,
            kb_layout = "uk",
            sensitivity = 0,
          }
        })
      '';
    };
  };
}
