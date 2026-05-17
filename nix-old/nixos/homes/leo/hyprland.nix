''

  ################
  ### MONITORS ###
  ################
  
  # See https://wiki.hypr.land/Configuring/Monitors/
  monitor = eDP-1, 2560x1600@60, 0x0, 1.25
  monitor=,preferred,auto,auto
  
  #################
  ### AUTOSTART ###
  #################
  
  # Autostart necessary processes (like notifications daemons, status bars, etc.)
  # Or execute your favorite apps at launch like this:
  
  exec-once = uwsm app -- vicinae server
  exec-once = uwsm app -- waypaper --restore
  
  #############################
  ### ENVIRONMENT VARIABLES ###
  #############################
  
  # See https://wiki.hypr.land/Configuring/Environment-variables/
  
  env = XCURSOR_SIZE,24
  env = HYPRCURSOR_SIZE,24
  
  
  ###################
  ### PERMISSIONS ###
  ###################
  
  # See https://wiki.hypr.land/Configuring/Permissions/
  # Please note permission changes here require a Hyprland restart and are not applied on-the-fly
  # for security reasons
  
  # ecosystem {
  #   enforce_permissions = 1
  # }
  
  # permission = /usr/(bin|local/bin)/grim, screencopy, allow
  # permission = /usr/(lib|libexec|lib64)/xdg-desktop-portal-hyprland, screencopy, allow
  # permission = /usr/(bin|local/bin)/hyprpm, plugin, allow
  
  
  #####################
  ### LOOK AND FEEL ###
  #####################
  
  # Refer to https://wiki.hypr.land/Configuring/Variables/
  
  # https://wiki.hypr.land/Configuring/Variables/#general
  general {
      gaps_in = 5
      gaps_out = 20
  
      border_size = 2
  
      # https://wiki.hypr.land/Configuring/Variables/#variable-types for info about colors
      col.active_border = rgba(ff2600ee) rgba(ff7433ee) 45deg
      col.inactive_border = rgba(595959aa)
  
      # Set to true enable resizing windows by clicking and dragging on borders and gaps
      resize_on_border = false
  
      # Please see https://wiki.hypr.land/Configuring/Tearing/ before you turn this on
      allow_tearing = false
  
      layout = dwindle
  }
  
  # https://wiki.hypr.land/Configuring/Variables/#decoration
  decoration {
      rounding = 10
      rounding_power = 2
  
      # Change transparency of focused and unfocused windows
      active_opacity = 1.0
      inactive_opacity = 1.0
  
      shadow {
          enabled = true
          range = 4
          render_power = 3
          color = rgba(1a1a1aee)
      }
  
      # https://wiki.hypr.land/Configuring/Variables/#blur
      blur {
          enabled = true
          size = 3
          passes = 1
  
          vibrancy = 0.1696
      }
  }
  
  # https://wiki.hypr.land/Configuring/Variables/#animations
  animations {
      enabled = yes, please :)
  
      # Default animations, see https://wiki.hypr.land/Configuring/Animations/ for more
  
      bezier = easeOutQuint,0.23,1,0.32,1
      bezier = easeInOutCubic,0.65,0.05,0.36,1
      bezier = linear,0,0,1,1
      bezier = almostLinear,0.5,0.5,0.75,1.0
      bezier = quick,0.15,0,0.1,1
  
      animation = global, 1, 10, default
      animation = border, 1, 5.39, easeOutQuint
      animation = windows, 1, 4.79, easeOutQuint
      animation = windowsIn, 1, 4.1, easeOutQuint, popin 87%
      animation = windowsOut, 1, 1.49, linear, popin 87%
      animation = fadeIn, 1, 1.73, almostLinear
      animation = fadeOut, 1, 1.46, almostLinear
      animation = fade, 1, 3.03, quick
      animation = layers, 1, 3.81, easeOutQuint
      animation = layersIn, 1, 4, easeOutQuint, fade
      animation = layersOut, 1, 1.5, linear, fade
      animation = fadeLayersIn, 1, 1.79, almostLinear
      animation = fadeLayersOut, 1, 1.39, almostLinear
      animation = workspaces, 1, 1.94, almostLinear, fade
      animation = workspacesIn, 1, 1.21, almostLinear, fade
      animation = workspacesOut, 1, 1.94, almostLinear, fade
  }
  
  # Ref https://wiki.hypr.land/Configuring/Workspace-Rules/
  # "Smart gaps" / "No gaps when only"
  # uncomment all if you wish to use that.
  # workspace = w[tv1], gapsout:0, gapsin:0
  # workspace = f[1], gapsout:0, gapsin:0
  # windowrule = bordersize 0, floating:0, onworkspace:w[tv1]
  # windowrule = rounding 0, floating:0, onworkspace:w[tv1]
  # windowrule = bordersize 0, floating:0, onworkspace:f[1]
  # windowrule = rounding 0, floating:0, onworkspace:f[1]
  
  # See https://wiki.hypr.land/Configuring/Dwindle-Layout/ for more
  dwindle {
      pseudotile = true # Master switch for pseudotiling. Enabling is bound to mainMod + P in the keybinds section below
      preserve_split = true # You probably want this
      smart_split = true
      precise_mouse_move = true
  }
  
  # See https://wiki.hypr.land/Configuring/Master-Layout/ for more
  master {
      new_status = master
  }
  
  # https://wiki.hypr.land/Configuring/Variables/#misc
  misc {
      force_default_wallpaper = 0
      disable_hyprland_logo = true 
  }
  
  
  #############
  ### INPUT ###
  #############
  
  # https://wiki.hypr.land/Configuring/Variables/#input
  input {
      sensitivity = 0.3;
      follow_mouse = 1

      touchpad {
        natural_scroll = true
	clickfinger_behavior = true;
	disable_while_typing = false;
      }
  }
  
  ###################
  ### Variables ###
  ###################
  
  # See https://wiki.hypr.land/Configuring/Keywords/
  $mod = SUPER
  $terminal = kitty
  $menu = vicinae toggle
  $browser = firefox
  
  ###################
  ### KEYBINDINGS ###
  ###################
  
  # Example binds, see https://wiki.hypr.land/Configuring/Binds/ for more
  bind = $mod, T, exec, uwsm app -- $terminal
  bind = $mod, Q, killactive,
  bind = $mod, M, exit,
  bind = $mod, E, exec, uwsm app -- $fileManager
  bind = $mod, V, togglefloating,
  bind = $mod, SPACE, exec, uwsm app -- $menu
  bind = $mod, F, fullscreen
  bind = $mod, B, exec, uwsm app -- $browser
  
  # Move focus with mainMod + arrow keys
  bind = $mod, left, movefocus, l
  bind = $mod, right, movefocus, r
  bind = $mod, up, movefocus, u
  bind = $mod, down, movefocus, d
  
  # Move window with mainMod + arrow keys
  bind = $mod SHIFT, left, movewindow, l
  bind = $mod SHIFT, right, movewindow, r
  bind = $mod SHIFT, up, movewindow, u
  bind = $mod SHIFT, down, movewindow, d
  
  
  # Switch workspaces with mainMod + [0-9]
  bind = $mod, 1, workspace, 1
  bind = $mod, 2, workspace, 2
  bind = $mod, 3, workspace, 3
  bind = $mod, 4, workspace, 4
  bind = $mod, 5, workspace, 5
  bind = $mod, 6, workspace, 6
  bind = $mod, 7, workspace, 7
  bind = $mod, 8, workspace, 8
  bind = $mod, 9, workspace, 9
  bind = $mod, 0, workspace, 10
  
  # Move active window to a workspace with mainMod + SHIFT + [0-9]
  bind = $mod SHIFT, 1, movetoworkspace, 1
  bind = $mod SHIFT, 2, movetoworkspace, 2
  bind = $mod SHIFT, 3, movetoworkspace, 3
  bind = $mod SHIFT, 4, movetoworkspace, 4
  bind = $mod SHIFT, 5, movetoworkspace, 5
  bind = $mod SHIFT, 6, movetoworkspace, 6
  bind = $mod SHIFT, 7, movetoworkspace, 7
  bind = $mod SHIFT, 8, movetoworkspace, 8
  bind = $mod SHIFT, 9, movetoworkspace, 9
  bind = $mod SHIFT, 0, movetoworkspace, 10
  
  # Example special workspace (scratchpad)
  bind = $mod, S, togglespecialworkspace, magic
  bind = $mod SHIFT, S, movetoworkspace, special:magic
  
  # Scroll through existing workspaces with mainMod + scroll
  bind = $mod, mouse_down, workspace, e+1
  bind = $mod, mouse_up, workspace, e-1
  
  # Move/resize windows with mainMod + LMB/RMB and dragging
  bindm = $mod, mouse:272, movewindow
  bindm = $mod, mouse:273, resizewindow
  
  # Laptop multimedia keys for volume and LCD brightness
  bindel = ,XF86AudioRaiseVolume, exec, wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+
  bindel = ,XF86AudioLowerVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-
  bindel = ,XF86AudioMute, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle
  bindel = ,XF86AudioMicMute, exec, wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle
  bindel = ,XF86MonBrightnessUp, exec, brightnessctl -e4 -n2 set 5%+
  bindel = ,XF86MonBrightnessDown, exec, brightnessctl -e4 -n2 set 5%-
  
  # Requires playerctl
  bindl = , XF86AudioNext, exec, playerctl next
  bindl = , XF86AudioPause, exec, playerctl play-pause
  bindl = , XF86AudioPlay, exec, playerctl play-pause
  bindl = , XF86AudioPrev, exec, playerctl previous
  
  ##############################
  ### WINDOWS AND WORKSPACES ###
  ##############################
  
  # See https://wiki.hypr.land/Configuring/Window-Rules/ for more
  # See https://wiki.hypr.land/Configuring/Workspace-Rules/ for workspace rules
  
  # Example windowrule
  # windowrule = float,class:^(kitty)$,title:^(kitty)$
  
  # Ignore maximize requests from apps. You'll probably like this.
  windowrule = suppressevent maximize, class:.*
  
  # Fix some dragging issues with XWayland
  windowrule = nofocus,class:^$,title:^$,xwayland:1,floating:1,fullscreen:0,pinned:0
  
  windowrule = float,class:steam
  windowrule = tile,class:steam,title:Steam
''
