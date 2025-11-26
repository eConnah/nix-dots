# Home Manger Setup For le-nix
{ config, pkgs, inputs, ... }:

{
  imports = [
    ../../modules/home-manager/defaults.nix
    ./hyprpanel.nix
    inputs.vicinae.homeManagerModules.default
  ];

  home.packages = with pkgs; [
    atool
    httpie
    vesktop
    spotify-player
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
    eduvpn-client
  ];

  programs.kitty.enable = true;
  # this does not exist
  #xdg.mimeApps = {
  #  "x-scheme-handler/terminal" = "kitty.desktop";
  #};

  home.sessionVariables.NIXOS_OZONE_WL = "1";
  wayland.windowManager.hyprland = {
    enable = true;
    package = null;
    portalPackage = null;
    extraConfig = import ./hyprland.nix;
    systemd.enable = false;
  };

  services.hypridle.enable = true;
  services.vicinae = {
    enable = true;
    autoStart = true;
  };


  home.file.".config/hypr/hypridle.conf".source = ../../modules/home-manager/hypridle.conf;
  home.file.".config/hyprpanel/modules.json".source = ../../modules/home-manager/hyprpanel.json;
  home.file.".config/spotify-player/theme.toml".source = ../../modules/home-manager/spotify-player.toml;

  home.stateVersion = "25.05";
}
