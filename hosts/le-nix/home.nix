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
    spotifyd
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
    gimp
    zulu 
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

  services.vicinae = {
    enable = true;
    autoStart = true;
  };


  home.file.".config/hyprpanel/modules.json".source = ../../modules/home-manager/hyprpanel.json;

  home.stateVersion = "25.05";
}
