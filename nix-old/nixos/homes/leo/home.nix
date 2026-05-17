# Home Manger Setup For Leo
{ pkgs, ... }: {

  nixpkgs.config.allowUnfree = true;
  home.packages = with pkgs; [ 
    atool
    httpie
    vicinae
    vesktop
    ncspot
    waypaper
    hyprpaper
    hyprcursor
    rose-pine-hyprcursor
    hy
    vscode
    eduvpn-client
    jetbrains.rider
  ];
  
  programs.kitty.enable = true;
  programs.fish = {
    enable = true;
    functions = {
      # simplifies nixos-rebuild
      nswitch = ''
        argparse "u/upgrade" "t/trace" "b/boot" -- $argv
        
	set upgrade 0
	set trace 0
	set boot 0

	if set -q _flag_upgrade
	  set upgrade 1
	end
	if set -q _flag_trace
	  set trace 1
	end

	if test $boot -eq 1
	  sudo nixos-rebuild boot -I nixos-config=/home/leo/Documents/dotfiles/nixos/configuration.nix
	else if test $upgrade -eq 0 -a $trace -eq 0
	  sudo nixos-rebuild switch -I nixos-config=/home/leo/Documents/dotfiles/nixos/configuration.nix
	else if test $upgrade -eq 1 -a $trace -eq 0
	  sudo nixos-rebuild switch -I nixos-config=/home/leo/Documents/dotfiles/nixos/configuration.nix --upgrade
	else if test $upgrade -eq 0 -a $trace -eq 1
	  sudo nixos-rebuild switch -I nixos-config=/home/leo/Documents/dotfiles/nixos/configuration.nix --show-trace
	else if test $upgrade -eq 1 -a $trace -eq 1
	  sudo nixos-rebuild switch -I nixos-config=/home/leo/Documents/dotfiles/nixos/configuration.nix --upgrade --show-trace
	end
      '';

      nclean = ''
      sudo nix-env --delete-generations old
      sudo nix-collect-garbage -d
      '';

      hyprbattery = ''
	set realCharge (cat /sys/class/power_supply/macsmc-battery/capacity)
	set charge (math "10 * round($realCharge / 10)")
	set state (cat /sys/class/power_supply/macsmc-battery/status)
	set iconKey "$state$charge"
	echo "{ 
	\"charge\": \"$realCharge\",
	\"state\": \"$state\",
	\"alt\": \"$iconKey\" 
}"
      '';

      ifdischarging = ''
        set state (cat /sys/class/power_supply/macsmc-battery/status)
        if test "$state" = "Discharging"
	  eval $argv
	end
      '';
    };
  };
  
  wayland.windowManager.hyprland = {
    enable = true;
    package = null;
    portalPackage = null;
  };

  home.sessionVariables.NIXOS_OZONE_WL = "1";
  wayland.windowManager.hyprland = {
    extraConfig = import ./hyprland.nix; 
    systemd.enable = false;
  };
  services.hypridle.enable = true;
  programs.hyprpanel = import ./hyprpanel.nix;
  home.file.".config/hypr/hypridle.conf".text = ''
  general {
    after_sleep_cmd = hyprctl dispatch dpms on # to avoid having to press a key twice to turn on the display.
  }

  listener {
    timeout = 150                                                # 2.5min.
    on-timeout = fish -c "ifdischarging 'brightnessctl -s set 10'" # set monitor backlight to minimum, avoid 0 on OLED monitor.
    on-resume = brightnessctl -r                                 # monitor backlight restore.
  }

  # turn off keyboard backlight, comment out this section if you dont have a keyboard backlight.
  listener { 
    timeout = 150                                                              # 2.5min.
    on-timeout = fish -c "ifdischarging 'brightnessctl -sd kbd_backlight set 0'" # turn off keyboard backlight.
    on-resume = brightnessctl -rd kbd_backlight                                # turn on keyboard backlight.
  }

  listener {
    timeout = 330                                                  # 5.5min
    on-timeout = fish -c "ifdischarging 'hyprctl dispatch dpms off'" # screen off when timeout has passed
    on-resume = hyprctl dispatch dpms on && brightnessctl -r       # screen on when activity is detected after timeout has fired.
  }

  listener {
    timeout = 1800                                           # 30min
    on-timeout = fish -c "ifdischarging 'systemctl suspend'" # suspend pc
  }
  '';

  home.file.".config/hyprpanel/modules.json".text = ''
  {
    "custom/mac-battery": {
      "icon": {
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
  }'';
  
  home.file.".config/ncspot/config.toml".text = ''
  [theme]
  background = "#1e1e2e"
  primary = "#cdd6f4"
  secondary = "#94e2d5"
  title = "#b4befe"
  playing = "#a6e3a1"
  playing_bg = "#1e1e2e"
  highlight = "#cdd6f4"
  highlight_bg = "#696e96"
  playing_selected = "#a6e3a1"
  error = "#1e1e2e"
  error_bg = "#f38ba8"
  statusbar = "#b4befe"
  statusbar_bg = "#313244"
  statusbar_progress = "#b4befe"
  cmdline = "#b4befe"
  cmdline_bg = "#181825"
  '';

  home.stateVersion = "25.05";
}
