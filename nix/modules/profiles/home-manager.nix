{ inputs, self, ... }:
{
  flake.homeModules.defaults =
    { pkgs, ... }:
    {
      programs.kitty.enable = true;

      programs.fish = {
        enable = true;
        functions = {
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

      programs.eza = {
        enable = true;
        git = true;
        icons = "always";
        enableFishIntegration = true;
        colors = "always";
      };
    };
}
