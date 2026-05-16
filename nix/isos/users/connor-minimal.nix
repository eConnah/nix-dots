{ inputs, self, ... }:
{
  flake.nixosModules.connorMinimal =
    { pkgs, ... }:
    {
      home-manager.users.connor = self.homeModules.connorMinimal;

      users.users.connor = {
        description = "Connor Alecks";
        initialPassword = "PineappleOnPizza";
        isNormalUser = true;
        shell = pkgs.fish;
        extraGroups = [
          "wheel"
          "networkmanager"
        ];
      };

      services.displayManager.autoLogin.user = "connor";

      services.tailscale = {
        enable = true;
        useRoutingFeatures = "client";
      };

      time.timeZone = "Europe/Amsterdam";
    };

  flake.homeModules.connorMinimal =
    { pkgs, ... }:
    {
      home.username = "connor";
      home.homeDirectory = "/home/connor";
      home.stateVersion = "25.05";
    };
}
