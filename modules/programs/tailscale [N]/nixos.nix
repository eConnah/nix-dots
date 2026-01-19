{ inputs, ... }:
{
  flake.modules.nixos.tool-tailscale = {
    services.tailscale = {
      enable = true;
      useRoutingFeatures = "client";
    };
    
    networking.firewall.checkReversePath = "loose";
  };
}