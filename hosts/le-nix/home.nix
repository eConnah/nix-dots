# Home Manger Setup For le-nix
{
  config,
  pkgs,
  inputs,
  ...
}:

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
    hyprcursor
    rose-pine-hyprcursor
    hy
    vscode
    hyprshot
    hyprpicker
    libinput
    moonlight-qt
    eduvpn-client
    gimp
    swaybg
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
    systemd.enable = true;
  };

systemd.user.services.swaybg = {
  Unit = {
    Description = "Wayland wallpaper daemon";
    PartOf = [ "graphical-session.target" ];
    After = [ "graphical-session.target" ];
  };
  Service = {
    ExecStart = "${pkgs.swaybg}/bin/swaybg -i /home/connor/Pictures/backgrounds/frieren01.png -m fill";
    Restart = "always";
  };
  Install = {
    WantedBy = [ "graphical-session.target" ];
  };
};

  home.file.".config/hyprpanel/modules.json".source = ../../modules/home-manager/hyprpanel.json;

  home.stateVersion = "25.05";
}
