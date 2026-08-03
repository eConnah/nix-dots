{ ... }: {
  flake.homeModules.preset-hyprland-keybinds = { ... }: {
    wayland.windowManager.hyprland = {
      extraConfig = ''
        require("keybinds")
      '';
      extraLuaFiles.keybinds = {
        autoLoad = false;
        content = ''
          ------------------------- INPUT EVENT DISPATCHERS -------------------------
          -- Core System Execution Wrappers
          hl.bind(mod.. " + T", hl.dsp.exec_cmd("uwsm app -- ".. terminal))
          hl.bind(mod.. " + Q", hl.dsp.window.close())
          hl.bind(mod.. " + M", hl.dsp.exit())
          hl.bind(mod.. " + V", hl.dsp.window.float({ action = "toggle" }))
          hl.bind(mod.. " + SPACE", hl.dsp.exec_cmd("uwsm app -- ".. menu))
          hl.bind(mod.. " + F", hl.dsp.window.fullscreen({ action = "toggle" }))
          hl.bind(mod.. " + B", hl.dsp.exec_cmd("uwsm app -- ".. browser))
          hl.bind(mod.. " + P", hl.dsp.exec_cmd("uwsm app -- hyprshot -m region --clipboard-only"))
          hl.bind(mod.. " + SHIFT + P", hl.dsp.exec_cmd("uwsm app -- hyprshot -m region --clipboard-only -z"))

          -- Spatial Tiling Navigation
          hl.bind(mod.. " + left", hl.dsp.focus({ direction = "l" }))
          hl.bind(mod.. " + right", hl.dsp.focus({ direction = "r" }))
          hl.bind(mod.. " + up", hl.dsp.focus({ direction = "u" }))
          hl.bind(mod.. " + down", hl.dsp.focus({ direction = "d" }))

          hl.bind(mod.. " + SHIFT + left", hl.dsp.window.move({ direction = "l" }))
          hl.bind(mod.. " + SHIFT + right", hl.dsp.window.move({ direction = "r" }))
          hl.bind(mod.. " + SHIFT + up", hl.dsp.window.move({ direction = "u" }))
          hl.bind(mod.. " + SHIFT + down", hl.dsp.window.move({ direction = "d" }))

          -- Procedural Workspace Graph Generation
          for i = 1, 10 do
              local key = i % 10
              hl.bind(mod.. " + ".. key, hl.dsp.focus({ workspace = i }))
              hl.bind(mod.. " + SHIFT + ".. key, hl.dsp.window.move({ workspace = i }))
          end

          hl.bind(mod.. " + S", hl.dsp.workspace.toggle_special("magic"))
          hl.bind(mod.. " + SHIFT + S", hl.dsp.window.move({ workspace = "special:magic" }))

          hl.bind(mod.. " + mouse_down", hl.dsp.focus({ workspace = "e+1" }))
          hl.bind(mod.. " + mouse_up", hl.dsp.focus({ workspace = "e-1" }))

          -- Hardware Pointer Overrides
          hl.bind(mod.. " + mouse:272", hl.dsp.window.drag(), { mouse = true })
          hl.bind(mod.. " + mouse:273", hl.dsp.window.resize(), { mouse = true })

          -- Locked State Hardware Interrupts
          hl.bind("XF86AudioRaiseVolume", hl.dsp.exec_cmd("wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+"), { locked = true, repeating = true })
          hl.bind("XF86AudioLowerVolume", hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"), { locked = true, repeating = true })
          hl.bind("XF86AudioMute", hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"), { locked = true })
          hl.bind("XF86AudioMicMute", hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"), { locked = true })

          hl.bind("XF86AudioNext", hl.dsp.exec_cmd("playerctl next"), { locked = true })
          hl.bind("XF86AudioPause", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
          hl.bind("XF86AudioPlay", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
          hl.bind("XF86AudioPrev", hl.dsp.exec_cmd("playerctl previous"), { locked = true })
        '';
      };
    };
  };
}
