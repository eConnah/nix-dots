# Home Manger Setup For Leo
{ config, pkgs, flakeRoot, ... }: 

{
  imports = [ ./hyprpanel.nix ];

  nixpkgs.config.allowUnfree = true;

  home.packages = with pkgs; [ 
    atool
    httpie
    vicinae
    vesktop
    ncspot
    waypaper
    hyprpaper
    hyprcursor
    rose-pine-hyprcursor
    hy
    nerd-fonts.jetbrains-mono
    vscode
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

  home.file.".config/hypr/hypridle.conf".source = "${flakeRoot}/modules/home-manager/hypridle.conf";
  home.file.".config/hyprpanel/modules.json".source = "${flakeRoot}/modules/home-manager/hyprpanel.json";
  home.file.".config/ncspot/config.toml".source = "${flakeRoot}/modules/home-manager/ncspot.toml";

  home.stateVersion = "25.05";
}
