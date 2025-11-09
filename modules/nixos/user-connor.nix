{ pkgs, vars, home-manager, ... }:

{
  users.users.connor = {
    isNormalUser = true;
    description = "Connor Alecks";
    shell = pkgs.fish;
    extraGroups = [ "wheel" "networkmanager" ];
  };

  home-manager.users.connor = import ../../hosts/${vars.host}/home.nix;

  services.displayManager.autoLogin.user = "connor";

  services.tailscale = {
    enable = true;
    useRoutingFeatures = "client";
  };
  
  time.timeZone = "Europe/Amsterdam";
}
