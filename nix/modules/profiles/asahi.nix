{ inputs, self, ... }:
{
  flake.nixosModules.asahi =
    { pkgs, lib, ... }:
    {
      imports = [ inputs.apple-silicon.nixosModules.apple-silicon-support ];
      boot.loader.efi.canTouchEfiVariables = lib.mkForce false;
      services.logind.settings.Login.HandleLidSwitch = lib.mkForce "ignore";

      environment.systemPackages = with pkgs; [
        asahi-bless
      ];

      home-manager.sharedModules = [
        self.homeModules.asahi
      ];
    };

  flake.homeModules.asahi =
    { pkgs, ... }:
    {
      programs.fish.functions = {
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
}
