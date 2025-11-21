# Home Manger Setup For le-nix
{ config, pkgs, inputs, ... }:

{
  imports = [
    ../../modules/home-manager/defaults.nix
    ./hyprpanel.nix
    inputs.vicinae.homeManagerModules.default
  ];

  nixpkgs.config.allowUnfree = true;

  home.packages = with pkgs; [
    atool
    httpie
    vesktop
    ncspot
    waypaper
    hyprpaper
    hyprcursor
    rose-pine-hyprcursor
    hy
    nerd-fonts.jetbrains-mono
    vscode
    hyprshot
    hyprpicker
    eduvpn-client
  ];

  programs.kitty.enable = true;

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
  home.file.".config/ncspot/config.toml".source = ../../modules/home-manager/ncspot.toml;

  home.stateVersion = "25.05";
}
