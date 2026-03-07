{ inputs, self, ... }:
{
  flake.nixosModules.connor =
    { pkgs, ... }:
    {
      home-manager.users.connor = self.homeModules.connor;
      users.users.connor = {
        isNormalUser = true;
        description = "Connor Alecks";
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

      environment.systemPackages = with pkgs; [
        prismlauncher
      ];

      time.timeZone = "Europe/Amsterdam";
    };

  flake.homeModules.connor =
    { pkgs, ... }:
    {
      home.username = "connor";
      home.homeDirectory = "/home/connor";
      home.stateVersion = "25.05";

      home.packages = with pkgs; [
        vesktop
        spotifyd
        hyprpaper
        hyprcursor
        rose-pine-hyprcursor
        vscode
        hyprshot
        hyprpicker
        moonlight-qt
      ];
    };
}
