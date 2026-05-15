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

      time.timeZone = "Europe/Amsterdam";
    };

  flake.homeModules.connor =
    { pkgs, ... }:
    {
      imports = [ self.homeModules.vicinae ];
      home.username = "connor";
      home.homeDirectory = if pkgs.stdenv.isDarwin then "/Users/connor" else "/home/connor";
      home.stateVersion = "25.05";

      home.packages = with pkgs; [
        (chromium.override { enableWideVine = true; })
        halloy
        hyprcursor
        hyprpicker
        hyprshot
        jetbrains.idea
        libreoffice
        obsidian
        prismlauncher
        rose-pine-hyprcursor
        signal-desktop
        spotifyd
        vesktop
        vscode
      ];
    };
}
