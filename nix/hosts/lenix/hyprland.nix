{ self, ... }: {
  flake.homeModules.lenix-hyprland = { ... }: {
    imports = [
      self.homeModules.hyprland
    ];

    wayland.windowManager.hyprland = {
      configType = "lua";
      extraConfig = ''
        ---------------------- DISPLAY TOPOLOGY AND MONITORS ----------------------
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

        ------------------------- VARIABLE NAMESPACES -------------------------
        local terminal = "kitty"
        local menu = "vicinae toggle"
        local browser = "firefox"

        ----------------------- ASYNCHRONOUS AUTOSTART -----------------------
        hl.on("hyprland.start", function()
            hl.exec_cmd("xrandr --output eDP-1 --primary")
        end)

        --------------------------- ENVIRONMENT INJECTION ---------------------------
        hl.env("XCURSOR_SIZE", "24")
        hl.env("HYPRCURSOR_SIZE", "24")
        hl.env("QT_QPA_PLATFORM", "wayland;xcb")

        --------------------------- AESTHETICS AND RENDER PIPELINE ---------------------------
        hl.config({
            general = {
                gaps_in = 5,
                gaps_out = 20,
                border_size = 2,
                resize_on_border = false,
                allow_tearing = false,
                layout = "dwindle",
            },
            decoration = {
                rounding = 10,
                rounding_power = 2,
                active_opacity = 1.0,
                inactive_opacity = 1.0,
                shadow = {
                    enabled = true,
                    range = 4,
                    render_power = 3,
                },
                blur = {
                    enabled = true,
                    size = 3,
                    passes = 1,
                    vibrancy = 0.1696,
                },
            },
            dwindle = {
                preserve_split = true,
                smart_split = true,
                precise_mouse_move = true,
            },
            master = {
                new_status = "master",
            },
            misc = {
                force_default_wallpaper = 0,
                disable_hyprland_logo = true,
            },
            input = {
                follow_mouse = 1,
                sensitivity = 0.3,
                touchpad = {
                  natural_scroll = true,
                  clickfinger_behavior = true,
                  disable_while_typing = false,
                },
            },
            animations = {
                enabled = true,
            }
        })

        --------------------------- KINEMATICS AND ANIMATION GRAPHS ---------------------------
        hl.curve("easeOutQuint", { type = "bezier", points = { {0.23, 1}, {0.32, 1} } })
        hl.curve("easeInOutCubic", { type = "bezier", points = { {0.65, 0.05}, {0.36, 1} } })
        hl.curve("linear", { type = "bezier", points = { {0, 0}, {1, 1} } })
        hl.curve("almostLinear", { type = "bezier", points = { {0.5, 0.5}, {0.75, 1.0} } })
        hl.curve("quick", { type = "bezier", points = { {0.15, 0}, {0.1, 1} } })

        hl.animation({ leaf = "global", enabled = true, speed = 10, bezier = "default" })
        hl.animation({ leaf = "border", enabled = true, speed = 5.39, bezier = "easeOutQuint" })
        hl.animation({ leaf = "windows", enabled = true, speed = 4.79, bezier = "easeOutQuint" })
        hl.animation({ leaf = "windowsIn", enabled = true, speed = 4.1, bezier = "easeOutQuint", style = "popin 87%" })
        hl.animation({ leaf = "windowsOut", enabled = true, speed = 1.49, bezier = "linear", style = "popin 87%" })
        hl.animation({ leaf = "fadeIn", enabled = true, speed = 1.73, bezier = "almostLinear" })
        hl.animation({ leaf = "fadeOut", enabled = true, speed = 1.46, bezier = "almostLinear" })
        hl.animation({ leaf = "fade", enabled = true, speed = 3.03, bezier = "quick" })
        hl.animation({ leaf = "layers", enabled = true, speed = 3.81, bezier = "easeOutQuint" })
        hl.animation({ leaf = "layersIn", enabled = true, speed = 4, bezier = "easeOutQuint", style = "fade" })
        hl.animation({ leaf = "layersOut", enabled = true, speed = 1.5, bezier = "linear", style = "fade" })
        hl.animation({ leaf = "fadeLayersIn", enabled = true, speed = 1.79, bezier = "almostLinear" })
        hl.animation({ leaf = "fadeLayersOut", enabled = true, speed = 1.39, bezier = "almostLinear" })
        hl.animation({ leaf = "workspaces", enabled = true, speed = 1.94, bezier = "almostLinear", style = "fade" })
        hl.animation({ leaf = "workspacesIn", enabled = true, speed = 1.21, bezier = "almostLinear", style = "fade" })
        hl.animation({ leaf = "workspacesOut", enabled = true, speed = 1.94, bezier = "almostLinear", style = "fade" })

        ------------------------- INPUT EVENT DISPATCHERS -------------------------
        local mod = "SUPER"

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

        ------------------------------ CONDITIONAL LAYER AND WINDOW PROTOCOLS ------------------------------
        hl.window_rule({
            name = "suppress-maximize-events",
            match = { class = ".*" },
            suppress_event = "maximize"
        })

        hl.window_rule({
            name = "fix-xwayland-drags",
            match = {
                class = "^$",
                title = "^$",
                xwayland = true,
                float = true,
                fullscreen = false,
                pin = false
            },
            no_focus = true
        })

        hl.window_rule({
            name = "move-hyprland-run",
            match = { class = "hyprland-run" },
            move = "20 monitor_h-120",
            float = true
        })

        hl.layer_rule({
            name = "vicinae",
            match = { namespace = "vicinae" },
            blur = true,
            ignore_alpha = 0,
            no_anim = true
        })
      '';
    };
  };
}
