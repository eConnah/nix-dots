{ inputs, pkgs, ... }:
{
  flake.modules.homeManager.user-connor = { pkgs, ... }: {
    imports = [
      inputs.vicinae.homeManagerModules.default
    ];

    home.packages = with pkgs; [
      atool
      httpie
      vesktop
      waypaper
      hyprpaper
      hyprcursor
      rose-pine-hyprcursor
      hy
      nerd-fonts.jetbrains-mono
      vscode
      hyprshot
      hyprpicker
      libinput
      moonlight-qt
      gimp
      zulu
    ];

    home.username = "connor";
    home.stateVersion = "25.11";
  };
}
