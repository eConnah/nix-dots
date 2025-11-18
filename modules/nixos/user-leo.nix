{ pkgs, vars, home-manager, ... }:

{
  users.users.leo = {
    isNormalUser = true;
    description = "Leo Chittock";
    shell = pkgs.fish;
    extraGroups = [ "wheel" "networkmanager" ];
  };

  home-manager.users.leo = import ../../hosts/${vars.host}/home.nix;

  services.displayManager.autoLogin.user = "leo";

  time.timeZone = "Europe/London";
}
