{ vars, ... }:

{
  programs.fish = {
    enable = true;
    functions = {
      # simplifies nixos-rebuild
      nswitch = ''
                argparse "b/boot" -- $argv

                set boot 0

        	      if set -q _flag_boot
        	        set boot 1
        	      end
                
        	      set flakePath "${vars.dir}"
                
        	      if test $boot -eq 1
        	        sudo nixos-rebuild boot --flake $flakePath --impure
        	      else
        	        sudo nixos-rebuild switch --flake $flakePath --impure
        	      end
      '';

      nclean = ''
        nix-collect-garbage -d
        sudo nix-collect-garbage -d
        sudo nix-env --delete-generations old
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

  home.file.".config/fish/themes/catppuccin-mocha.theme".source = ./theme-fish.theme;
}
