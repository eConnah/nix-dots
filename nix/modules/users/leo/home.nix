{ self, ... }: {
  flake.homeModules.leo = { pkgs, ... }: {
    imports = [ self.homeModules.vicinae ];
    home.homeDirectory = if pkgs.stdenv.isDarwin then "/Users/leo" else "/home/leo";
    home.packages = with pkgs; [
      (chromium.override { enableWideVine = true; })
      eduvpn-client
      hyprcursor
      hyprpicker
      hyprshot
      jetbrains.idea
      jetbrains.rider
      libreoffice
      obsidian
      prismlauncher
      rose-pine-hyprcursor
      signal-desktop
      vesktop
      vscode
    ];
    home.stateVersion = "25.05";
    home.username = "leo";
  };
}
