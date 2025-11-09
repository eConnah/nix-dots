{ config, lib, pkgs, flakeRoot, ... }:

with lib;

let
  cfg = config.userLeo;
in 
{
  options.userLeo = {
    hostDir = mkOption {
      type = types.path;
      description = "Path for Leo's files.";
    };
  };

  config = {
    assertions = [
      {
        assertion = cfg.hostDir != null;
        message = "userLeo.hostDir must be set.";
      }
    ];
    users.users.leo = {
      isNormalUser = true;
      description = "Leo Chittock";
      shell = pkgs.fish;
      extraGroups = [ "wheel" "networkmanager" ];
    };

    home-manager.users.leo = import "${cfg.hostDir}/home.nix";
    home-manager.extraSpecialArgs = { inherit flakeRoot; };

    services.displayManager.autoLogin.user = "leo";

    time.timeZone = "Europe/London";
  };
}