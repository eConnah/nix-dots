{ inputs, self, ... }:
{
  flake.nixosModules.leo =
    { pkgs, ... }:
    {
      home-manager.users.leo = self.homeModules.leo;

      users.users.leo = {
        isNormalUser = true;
        description = "Leo Chittock";
        shell = pkgs.fish;
        extraGroups = [
          "wheel"
          "networkmanager"
        ];
      };

      services.displayManager.autoLogin.user = "leo";

      time.timeZone = "Europe/London";
    };

  flake.homeModules.leo =
    { pkgs, ... }:
    {
      imports = [ self.homeModules.vicinae ];
      home.username = "leo";
      home.homeDirectory = if pkgs.stdenv.isDarwin then "/Users/leo" else "/home/leo";
      home.stateVersion = "25.05";

      home.packages = with pkgs; [
        (chromium.override { enableWideVine = true; })
        hyprcursor
        hyprpicker
        hyprshot
        jetbrains.idea
        libreoffice
        obsidian
        prismlauncher
        rose-pine-hyprcursor
        signal-desktop
        vesktop
        vscode
      ];
    };
}
