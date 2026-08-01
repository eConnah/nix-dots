{
  inputs,
  self,
  ...
}:
{
  flake = {
    homeModules.asahi = { lib, ... }: {
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

      services.easyeffects.enable = lib.mkForce false;
    };
    nixosModules.asahi =
      {
        lib,
        pkgs,
        ...
      }:
      {
        imports = [ inputs.apple-silicon.nixosModules.apple-silicon-support ];
        boot = {
          kexec.enable = false;
          loader.efi.canTouchEfiVariables = lib.mkForce false;
        };
        environment.systemPackages = with pkgs; [
          asahi-bless
          muvm
        ];
        hardware.asahi.enable = true;
        home-manager.sharedModules = [
          self.homeModules.asahi
        ];
        services.logind.settings.Login.HandleLidSwitch = lib.mkForce "ignore";
      };
  };
}
